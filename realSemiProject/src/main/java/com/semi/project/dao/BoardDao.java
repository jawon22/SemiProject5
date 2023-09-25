package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.BoardReportDto;
import com.semi.project.dto.ReportDto;
import com.semi.project.vo.PaginationVO;

public interface BoardDao {
	int sequence();
	
	void insert(BoardDto boardDto);
	BoardDto selectOne(int boardNo);
	List<BoardListDto> selectList();
	boolean delete(int boardNo);
	boolean edit(BoardDto boardDto);
	void connect(int boardNo, int attachmentNo);
	Integer selectMax(String boardWriter);
	
	//정보게시판 목록(검색 페이징 처리)
	List<BoardListDto> selectListByPage(int page);
	//검색을 안하고 계절만 선택했을때
	List<BoardListDto> selectListByPageAndWeather(int page, String weather);
	//검색을 안하고 지역만 선택했을때
	List<BoardListDto> selectListByPageAndArea(int page, String area);
	//검색을 안하고 계절과 지역을 선택했을때
	List<BoardListDto> selectListByPageAndCategory(int page, String weather, String area);
	// 검색을 포함한 조회
	List<BoardListDto> selectListByPage(String type, String keyword, String weather, String area, int page);
	List<BoardListDto> selectListByPage(PaginationVO vo);
	
	//조회수정렬
	List<BoardListDto> selectListByReadcount(int page);
	List<BoardListDto> selectListByReadcountWeather(int page, String weather);
	List<BoardListDto> selectListByReadcountArea(int page, String area);
	List<BoardListDto> selectListByReadcountCategory(int page, String weather, String area);
	List<BoardListDto> selectListByReadcountAll(String type, String keyword, String weather, String area, int page);
	List<BoardListDto> selectListByReadcount(PaginationVO vo);
	
	//좋아요정렬
	List<BoardListDto> selectListByLikecount(int page);
	List<BoardListDto> selectListByLikecountWeather(int page, String weather);
	List<BoardListDto> selectListByLikecountArea(int page, String area);
	List<BoardListDto> selectListByLikecountCategory(int page, String weather, String area);
	List<BoardListDto> selectListByLikecount(String type, String keyword, String weather, String area, int page);
	List<BoardListDto> selectListByLikecount(PaginationVO vo);
	
	//정보게시판 갯수 세기
	int countList(PaginationVO vo);
	
	//신고 관련 기능
	int reportSequence();//신고 번호 시퀀스
	void insertReport(ReportDto reportDto);//신고 등록
	void insertBoardReport(BoardReportDto boardReportDto);//게시글 신고 등록
	
}



















