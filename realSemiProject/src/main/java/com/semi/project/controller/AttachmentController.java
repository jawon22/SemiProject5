package com.semi.project.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.semi.project.dao.AttachmentDao;
import com.semi.project.dto.AttachmentDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/file")
public class AttachmentController {
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	@PostMapping("/upload")
	public String upload(@RequestParam("file") MultipartFile attachment) throws IllegalStateException, IOException {
		log.info("name = {}", attachment.getName());//전송된이름(파일명x)
		log.info("origin = {}", attachment.getOriginalFilename());//파일명
		log.info("size = {}", attachment.getSize());//파일크기(byte)
		log.info("contentType = {}", attachment.getContentType());//파일유형
		
		//절대규칙 - 파일은 하드디스크에, 정보는 DB에!
		
		//[1] 시퀀스 번호를 생성한다
		int attachmentNo = attachmentDao.sequence();
		
		//[2] 시퀀스 번호를 파일명으로 하여 실제 파일을 저장한다
		//- 같은 이름에 대한 충돌을 방지하기 위해
		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");//저장할디렉터리
		dir.mkdirs();//디렉터리 생성
		
		File target = new File(dir, String.valueOf(attachmentNo));//저장할파일
		attachment.transferTo(target);//저장
		
		//[3] DB에 저장한 파일의 정보를 모아서 INSERT
		AttachmentDto attachmentDto = new AttachmentDto();
		attachmentDto.setAttachmentNo(attachmentNo);
		attachmentDto.setAttachmentName(attachment.getOriginalFilename());
		attachmentDto.setAttachmentSize(attachment.getSize());
		attachmentDto.setAttachmentType(attachment.getContentType());
		attachmentDao.insert(attachmentDto);
		
		return "페이지정보";
	}
	
}