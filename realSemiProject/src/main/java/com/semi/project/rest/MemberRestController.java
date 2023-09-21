package com.semi.project.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.semi.project.configuration.FileUploadProperties;
import com.semi.project.dao.AttachmentDao;
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.AttachmentDto;


@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private FileUploadProperties props;
	
	@Autowired
	private AttachmentDao attachDao;
	
	private File dir;
	
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
	
	@PostMapping("/delete")
	public void delete(HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		memberDao.deleteProfile(memberId);
	}
	
}