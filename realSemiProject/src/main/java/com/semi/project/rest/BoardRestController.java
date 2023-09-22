package com.semi.project.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.BoardDao;
import com.semi.project.dto.BoardListDto;
import com.semi.project.vo.PaginationVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	@Autowired
	private BoardDao boardDao;
	
	
	// 정보게시판 최신순 정렬
	@PostMapping("/sort")
	public List<BoardListDto> boardCtimeDesc(@ModelAttribute(name="vo") PaginationVO vo){
		
		List<BoardListDto> list =  boardDao.selectListByPage(vo);
		return list;
	}
	

}