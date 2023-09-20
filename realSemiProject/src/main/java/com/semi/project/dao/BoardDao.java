package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.vo.PaginationVO;

public interface BoardDao {
	int sequence();
	
	void insert(BoardDto boardDto);
	BoardDto selectOne(int boardNo);
	List<BoardListDto> selectList();
	boolean delete(int boardNo);
	boolean edit(BoardDto boardDto);
	
	//정보게시판 목록(검색 페이징 처리)
	List<BoardListDto> selectListByPage(int page);
	List<BoardListDto> selectListByPage(String type, String keyword, int page);
	List<BoardListDto> selectListByPage(PaginationVO vo);
	
	//정보게시판 갯수 세기
	int countList(PaginationVO vo);
	
}
