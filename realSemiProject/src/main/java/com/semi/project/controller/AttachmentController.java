package com.semi.project.controller;

import java.io.File;
import java.io.IOException;
import java.net.http.HttpHeaders;
import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;
import javax.mail.internet.ContentDisposition;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.configuration.CustomFileuploadProperties;
import com.semi.project.dao.AttachmentDao;
import com.semi.project.dto.AttachmentDto;

//첨부파일의 다운로드를 처리하는 컨트롤러
@RestController//=@Controller + @ResponseBody
@RequestMapping("/attachment")
public class AttachmentController {

	@Autowired
	private CustomFileuploadProperties fileuploadProperties;

	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(fileuploadProperties.getPath());
	}
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	@GetMapping("/download")
	public ResponseEntity<ByteArrayResource> download(
			@RequestParam int attachmentNo) throws IOException {
		//DB 조회
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		if(attachmentDto == null) {//없으면 404
			return ResponseEntity.notFound().build();
		}	
		
		//파일 찾기
		File target = new File(dir, String.valueOf(attachmentNo));
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//헤더와 바디를 설정하며 ResponseEntity를 만들어 반환
		return ResponseEntity.ok()
			.contentType(MediaType.APPLICATION_OCTET_STREAM)
			.contentLength(attachmentDto.getAttachmentSize())
			.header(HttpHeaders.CONTENT_ENCODING, 
										StandardCharsets.UTF_8.name())
			.header(HttpHeaders.CONTENT_DISPOSITION,
				ContentDisposition.attachment()
							.filename(
									attachmentDto.getAttachmentName(), 
									StandardCharsets.UTF_8
							).build().toString()
			)
			.body(resource);
	}
	
}
