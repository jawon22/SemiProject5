package com.semi.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.semi.project.dao.BoardDao;
import com.semi.project.dto.BoardDto;
import com.semi.project.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boardDao;
	
	@RequestMapping("/list") // 정보게시판 리스트
	public String list(Model model, BoardDto boardDto) {
		List<BoardDto> list = boardDao.selectList();
		model.addAttribute("list", list);
		return "/WEB-INF/views/board/list.jsp";
	}
	
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int boardNo, Model model) {
		
		return "/WEB-INF/views/board/detail.jsp";
	}

}

















