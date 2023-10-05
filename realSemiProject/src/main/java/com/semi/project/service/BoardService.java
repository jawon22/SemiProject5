package com.semi.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.semi.project.dao.BoardDao;
import com.semi.project.dto.BoardDto;

@Service
public class BoardService {
	
	@Autowired
	BoardDao boardDao;
	
	public int write(BoardDto boardDto, List<Integer> attachmentNo) {
		int boardNo = boardDao.sequence();
		
		boardDto.setBoardNo(boardNo);
		
		boardDao.insert(boardDto);
		
		if(attachmentNo != null) {
			for(int no : attachmentNo) {
				boardDao.connect(boardNo, no);
			}			
		}
		return boardNo;
	}
}
