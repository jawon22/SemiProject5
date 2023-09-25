package com.semi.project.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.BoardLikeDao;
import com.semi.project.dto.BoardLikeDto;
import com.semi.project.vo.BoardLikeVo;

@RestController
@RequestMapping("/rest/boardLike")
public class BoardLikeRestController {
	@Autowired
	BoardLikeDao boardLikeDao;
	
	@RequestMapping("/check")
	public BoardLikeVo check(@ModelAttribute BoardLikeDto boardLikeDto, HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		boardLikeDto.setMemberId(memberId);
		
		boolean isCheck = boardLikeDao.check(boardLikeDto);
		int count = boardLikeDao.count(boardLikeDto.getBoardNo());
		
		BoardLikeVo vo = new BoardLikeVo();
		vo.setCheck(isCheck);
		vo.setCount(count);
		return vo;
	}
	
	@RequestMapping("/action")
	public BoardLikeVo action(@ModelAttribute BoardLikeDto boardLikeDto, HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		boardLikeDto.setMemberId(memberId);
		
		boolean isCheck=boardLikeDao.check(boardLikeDto);
		if(isCheck) {
			boardLikeDao.delete(boardLikeDto);
		}
		else {
			boardLikeDao.insert(boardLikeDto);
		}
		int count = boardLikeDao.count(boardLikeDto.getBoardNo());
		
		BoardLikeVo vo = new BoardLikeVo();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		
		return vo;
	}
	
}
