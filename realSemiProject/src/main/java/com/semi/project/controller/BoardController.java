package com.semi.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.semi.project.dao.BoardDao;
import com.semi.project.dto.BoardListDto;
import com.semi.project.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping("/list") // 정보게시판 리스트
	public String list(@ModelAttribute(name="vo") PaginationVO vo, Model model) {
		
//		int count = vo.isSearch() ? boardDao.countList(vo) : boardDao.countList();
//		vo.setCount(count);
		
		List<BoardListDto> list =boardDao.selectListByPage(vo);
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/board/list.jsp";
		
	}

}

















