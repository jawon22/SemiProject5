package com.semi.project.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.BoardLikeDao;
import com.semi.project.dto.BoardLikeDto;

@RestController
@RequestMapping("/rest/boardLike")
public class BoardLikeRestController {
	@Autowired
	BoardLikeDao boardLikeDao;
	
	@RequestMapping("/check")
	public String check(@ModelAttribute BoardLikeDto boardLikeDto, HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		boardLikeDto.setMemberId(memberId);
		
		boolean isCheck = boardLikeDao.check(boardLikeDto);
		return isCheck ? "Y" : "N";
	}
	
	@RequestMapping("/action")
	public String action(@ModelAttribute BoardLikeDto boardLikeDto, HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		boardLikeDto.setMemberId(memberId);
		
		boolean isCheck=boardLikeDao.check(boardLikeDto);
		if(isCheck) {
			boardLikeDao.delete(boardLikeDto);
			return "N";
		}
		else {
			boardLikeDao.insert(boardLikeDto);
			return "Y";
		}
	}
	
}
