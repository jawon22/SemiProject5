package com.semi.project.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.semi.project.dao.AttachmentDao;
import com.semi.project.dao.QnaNoticeDao;
import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/qnaNotice")
public class QnaNoticeController {

	@Autowired
	private QnaNoticeDao qnaNoticeDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	//등록 답글
	@GetMapping("/write")
	public String write(Model model, 
				@RequestParam(required = false) Integer qnaNoticeParent) {

		//답글이면
		if(qnaNoticeParent != null) {

			QnaNoticeDto originDto = qnaNoticeDao.selectOne(qnaNoticeParent);
			model.addAttribute("originDto", originDto); 
			model.addAttribute("isReply", true);
		}
		else {//새글이면
			model.addAttribute("isReply", false);
		}
		
		return "/WEB-INF/views/qnaNotice/write.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute QnaNoticeDto qnaNoticeDto,
			/* @RequestParam MultipartFile attach, */
			@RequestParam(defaultValue = "N") String qnaNoticeSecret,
			HttpSession session) {
		
		//회원아이디
		String memberId = (String) session.getAttribute("name");
		qnaNoticeDto.setMemberId(memberId);
		//글번호		
		int qnaNoticeNo = qnaNoticeDao.sequence();
		qnaNoticeDto.setQnaNoticeNo(qnaNoticeNo);
		System.out.println(qnaNoticeNo);
		System.out.println(qnaNoticeSecret);

	    // 글 작성 시 qnaNoticeSecret 값을 업데이트
	    qnaNoticeDto.setQnaNoticeSecret(qnaNoticeSecret);
	    
	    
		/*
		 * if(!attach.isEmpty()) { //첨부파일 있을 때 int attachmentNo =
		 * attachmentDao.sequence();
		 * 
		 * String home = System.getProperty("user.home"); File dir = new File(home,
		 * "upload"); dir.mkdirs(); File target = new File(dir,
		 * String.valueOf(attachmentNo));
		 * 
		 * AttachmentDto attachDto = new AttachmentDto();
		 * attachDto.setAttachmentNo(attachmentNo);
		 * attachDto.setAttachmentName(attach.getOriginalFilename());
		 * attachDto.setAttachmentSize(attach.getSize());
		 * attachDto.setAttachmentType(attach.getContentType());
		 * attachmentDao.insert(attachDto);
		 * 
		 * // 파일이 있을 때, 먼저 게시글 삽입 qnaNoticeDto.setQnaNoticeNo(qnaNoticeNo);
		 * qnaNoticeDao.insert(qnaNoticeDto);
		 * 
		 * // 연결(파일이 있을때만) qnaNoticeDao.connect(attachmentNo, qnaNoticeNo);
		 * log.info("글번호: {}", qnaNoticeNo); }
		 */

		
		//글 등록 전에 새글/답글에 따른 그룹,상위글,차수를 계산
		if(qnaNoticeDto.getQnaNoticeParent() == null) {//새글이라면 그룹번호는 글번호 상위글번호 null 차수0
			qnaNoticeDto.setQnaNoticeGroup(qnaNoticeNo);
			//qnaNoticeDto.setQnaNoticeParent(null);

		}
		else { //그룹번호 원본글 그룹번호, 상위글 그룹번호, 차수 원본글차수+1
			QnaNoticeDto originDto = qnaNoticeDao.selectOne(qnaNoticeDto.getQnaNoticeParent()); //상위글 정보
			qnaNoticeDto.setQnaNoticeGroup(originDto.getQnaNoticeGroup());//그룹번호는 원본글 그룹번호와 동일
			qnaNoticeDto.setQnaNoticeDepth(originDto.getQnaNoticeDepth() + 1); //차수 원본글차수 + 1
		}

		qnaNoticeDao.insert(qnaNoticeDto);
			
		return "redirect:detail?qnaNoticeNo="+qnaNoticeNo;
		

	}

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping("/image") public ResponseEntity<ByteArrayResource> //바이트[]을
	 * 클래스화 / 랩핑클래스 image(@RequestParam int qnaNoticeNo) throws IOException {
	 * 
	 * int attachmentNo = attachmentDao.sequence();
	 * 
	 * AttachmentDto attachmentDto = qnaNoticeDao.findImage(qnaNoticeNo);
	 * if(attachmentDto == null) { return ResponseEntity.notFound().build(); //404
	 * 반환 }
	 * 
	 * // File target = new File(dir, String.valueOf(attachmentNo)); //저장할파일 //
	 * attach.transferTo(target); //저장
	 * 
	 * String home = System.getProperty("user.home"); File dir = new File(home,
	 * "upload"); File target = new File(dir,
	 * String.valueOf(attachmentDto.getAttachmentNo()));
	 * 
	 * byte[] data = FileUtils.readFileToByteArray(target); //실제파일정보 불러오기
	 * ByteArrayResource resource = new ByteArrayResource(data);
	 * 
	 * return ResponseEntity.ok() .header(HttpHeaders.CONTENT_ENCODING,
	 * StandardCharsets.UTF_8.name())
	 * .contentLength(attachmentDto.getAttachmentSize())
	 * .header(HttpHeaders.CONTENT_TYPE, attachmentDto.getAttachmentType())
	 * .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
	 * .filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8)
	 * .build().toString() ) .body(resource); }
	 */
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int qnaNoticeNo, Model model) {
		QnaNoticeDto qnaNoticeDto = qnaNoticeDao.selectOne(qnaNoticeNo);
		model.addAttribute("qnaNoticeDto", qnaNoticeDto);
		AttachmentDto attachmentDto = qnaNoticeDao.findImage(qnaNoticeNo);
		model.addAttribute("attachmentDto", attachmentDto);
		return "/WEB-INF/views/qnaNotice/detail.jsp";
	}
	

	@RequestMapping("/list")
	public String list(@ModelAttribute(name="vo") PaginationVO vo,
			Model model) {
		
	    int count = qnaNoticeDao.countList(vo);
	    vo.setCount(count);

		
		//첫번째페이지에 공지글 5개만 보여줌
		List<QnaNoticeDto> noticeListTop5 = qnaNoticeDao.selectNoticeListTop5();
		model.addAttribute("noticeListTop5", noticeListTop5);

		//첫번째페이지부터 목록을 보여줌(공지글 5개 밑에)
		List<QnaNoticeDto> qnaList = qnaNoticeDao.selectQnaListByPage(vo);
		model.addAttribute("qnaList", qnaList);
		
		return "/WEB-INF/views/qnaNotice/list.jsp";
	}
	
	@RequestMapping("/noticeList")
	public String noticeList(@ModelAttribute(name="vo") PaginationVO vo,
			Model model) {
		//공지보기 선택했을 때 공지 전체목록을 보여줌
		List<QnaNoticeDto> noticeList = qnaNoticeDao.selectNoticeListByPage(vo);
		model.addAttribute("noticeList", noticeList);
		
		return "/WEB-INF/views/qnaNotice/noticeList.jsp";

	@RequestMapping("/delete")
	public String delete(@RequestParam int qnaNoticeNo) {
		boolean result = qnaNoticeDao.delete(qnaNoticeNo);
		if(result) {
			return "redirect:list";
		}
		else {
			return "redirect:에러페이지";
			//throw new NoTargetException("없는 게시글 번호");
		}

	}
}
