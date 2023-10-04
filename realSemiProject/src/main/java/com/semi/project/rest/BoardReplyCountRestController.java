package com.semi.project.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.BoardDao;
import com.semi.project.dto.BoardDto;

@RestController
@RequestMapping("/rest/board")
public class BoardReplyCountRestController {
	@Autowired
	BoardDao boardDao;
	
	@RequestMapping("/boardReplyCount")
	public long boardReplyCount(int boardNo){
		BoardDto boardDto = boardDao.selectOne(boardNo);
		
		return boardDto.getBoardReplycount();
	}
}
