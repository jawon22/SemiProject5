package com.semi.project.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.semi.project.configuration.FileUploadProperties;
import com.semi.project.dao.AttachmentDao;
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.StatDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AttachmentDao attachDao;
	
	//미리 작성해둔 커스텀 속성을 불러와서 디렉터리 객체까지 생성
	@Autowired
	private FileUploadProperties props;

	private File dir;
	
	//모든 로딩이 끝나면 자동으로 실행되는 메소드
	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	@PostMapping("/upload")
	public Map<String, Object> upload(HttpSession session,
				@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		
		int attachNo = attachDao.sequence();
		
		File target = new File(dir, String.valueOf(attachNo)); //저장할 파일
		attach.transferTo(target);
		
		AttachmentDto attachDto = new AttachmentDto();
		attachDto.setAttachmentNo(attachNo);
		attachDto.setAttachmentName(attach.getOriginalFilename());
		attachDto.setAttachmentSize(attach.getSize());
		attachDto.setAttachmentType(attach.getContentType());
		attachDao.insert(attachDto);
		
		String memberId = (String)session.getAttribute("name");
		memberDao.deleteProfile(memberId); //기존 이미지 제거
		memberDao.insertProfile(memberId, attachNo); //신규 이미지 추가
		
		return Map.of("attachNo", attachNo);
	}
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> 
							download(@RequestParam int attachNo) throws IOException {
		AttachmentDto attachDto = attachDao.selectOne(attachNo);
		
		if(attachDto == null) {
			return ResponseEntity.notFound().build(); //404반환
		}
		
		File target = new File(dir, String.valueOf(attachDto.getAttachmentNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachmentSize())
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachmentType())
				.header(HttpHeaders.CONTENT_DISPOSITION, 
					ContentDisposition.attachment()
					.filename(attachDto.getAttachmentName(), StandardCharsets.UTF_8)
					.build().toString()
				)
				.body(resource);
	}
	
	@RequestMapping("checkProfile")
	public int checkProfile(HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		Integer profileNo = memberDao.findProfile(memberId);
		if(profileNo != null) {
			return profileNo;
		}else {
			return 0;
		}
	}
	
	
	@PostMapping("/delete")
	public void delete(HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		memberDao.deleteProfile(memberId);
	}
	
	@PostMapping("/deleteByAdmin")
	public void deleteByAdmin(@RequestParam String memberId) {
		memberDao.deleteProfile(memberId);
	}
	
	//회원 통계 - 나이
	@PostMapping("/stat/birth")
	public List<StatDto> statBirthCount(){
		return memberDao.selectGroupByMemberBirth();
	}
	//회원 통계 - 지역
	@PostMapping("/stat/area")
	public List<StatDto> statAreaCount(){
		return memberDao.selectGroupByMemberArea();
	}
	//회원 통계 - 가입월
	@PostMapping("/stat/join")
	public List<StatDto> statJoinCount(){
		return memberDao.selectGroupByMemberJoin();
	}
	//회원 통계 - 등급
	@PostMapping("/stat/level")
	public List<StatDto> statLevelCount(){
		return memberDao.selectGroupByMemberLevel();
	}
	
	//아이디 체크
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto != null) { //아이디가 있으면
			return "Y";
		}
		else { //아이디가 없으면
			return "N";
		}
	}

	
	//비밀번호 체크
	@PostMapping("/pwCheck")
	public String pwCheck(@RequestParam String memberPw,
								HttpSession session) {
		
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		//변경하려는 비밀번호와 기존 비밀번호가 같음
		if(memberDto.getMemberPw().equals(memberPw)) {
			return "N"; //변경 전 비밀번호와 동일함
		}
		else { //변경 전 비밀번호와 다르고 형식에 맞음
			return "Y";
		}
		
	}
	
	//비밀번호 일치 여부 체크
	@PostMapping("/pwCorrect")
	public String pwCorrect(@RequestParam String inputPw,
											HttpSession session) {
		
		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		//입력한 비밀번호와 회원 비밀번호가 일치하다면
		if(memberDto.getMemberPw().equals(inputPw)) {
			return "Y";
		}else {
			return "N";
		}
	}
	
	//이메일체크
	@PostMapping("/emailCheck")
	public String emailCheck(@RequestParam(required = false) String memberEmail,
			HttpSession session) {
		
		MemberDto findEmailDto = memberDao.checkEmail(memberEmail);
		//변경하려는 이메일과 기존 이메일이 같음
		if(findEmailDto != null) {
			return "N"; //등록 된 이메일이 있을 때
		}
		else { 
			return "Y";
		}
		
	}

}