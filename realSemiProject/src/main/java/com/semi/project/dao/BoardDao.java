package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.BoardDto;

public interface BoardDao {
	int sequence();
	
	void insert(BoardDto boardDto);
	BoardDto selectOne(int boardNo);
	List<BoardDto> selectList();
	boolean delete(int boardNo);
	boolean edit(BoardDto boardDto);
}
