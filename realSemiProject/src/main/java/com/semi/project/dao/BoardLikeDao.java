package com.semi.project.dao;

import com.semi.project.dto.BoardLikeDto;

public interface BoardLikeDao {
	void insert(BoardLikeDto boardLikeDto);
	boolean delete(BoardLikeDto boardLikeDto);
	boolean check(BoardLikeDto boardLikeDto);
	int count(int boardNo);
}
