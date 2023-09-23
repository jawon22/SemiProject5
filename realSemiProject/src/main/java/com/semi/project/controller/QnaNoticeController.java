package com.semi.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.semi.project.dao.QnaNoticeDao;
import com.semi.project.dto.QnaNoticeDto;

@Controller
@RequestMapping("/qnaNotice")
public class QnaNoticeController {

	@Autowired
	private QnaNoticeDao qnaNoticeDao;
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/qnaNotice/write.jsp";
	}
	
}
