package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.BoardDto;
import com.semi.project.vo.PaginationVO;

public interface BoardDao {
	int sequence();
	
	void insert(BoardDto boardDto);
	BoardDto selectOne(int boardNo);
	List<BoardDto> selectList();
	boolean delete(int boardNo);
	boolean edit(BoardDto boardDto);
	
	List<BoardDto> selectListByPage(int page);
	List<BoardDto> selectListByPage(String type, String keyword, int page);
	List<BoardDto> selectListByPage(PaginationVO vo);
	
	
}
