package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.BoardReportDto;
import com.semi.project.dto.ReportDto;
import com.semi.project.dto.ReportListDto;
import com.semi.project.vo.PaginationVO;

public interface BoardDao {
	int sequence();
	
	void insert(BoardDto boardDto);
	BoardDto selectOne(int boardNo);
	List<BoardListDto> selectList();
	List<BoardListDto> selectCommunityList();
	boolean delete(int boardNo);
	boolean edit(BoardDto boardDto);
	void connect(int boardNo, int attachmentNo);
	Integer selectMax(String boardWriter);
	
	List<BoardListDto> selectFreeTop10();
	List<BoardListDto> selectReviewTop10();
	
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
	
//커뮤니티게시판(후기) 목록 조회(검색 및 페이징 처리)
	List<BoardListDto> selectReviewListByPage(int page);
	List<BoardListDto> selectReviewListSearchByPage(int page, String type, String keyword);
	List<BoardListDto> selectReviewListSearchByPage(PaginationVO vo);
	
//커뮤니티게시판(자유) 목록 조회(검색 및 페이징 처리)
	List<BoardListDto> selectFreeListByPage(int page);
	List<BoardListDto> selectFreeListSearchByPage(int page, String type, String keyword);
	List<BoardListDto> selectFreeListSearchByPage(PaginationVO vo);
	
	
	//정보게시판 갯수 세기
	int countList(PaginationVO vo);
	//커뮤니티 게시판 갯수 세기
	int countCommunityReviewList(PaginationVO vo);
	int countCommunityFreeList(PaginationVO vo);
	
	//조회수 업데이트
	boolean readcountEdit(long boardReadcount, int boardNo);
	//신고 관련 기능
	int reportSequence();//신고 번호 시퀀스
	void insertReport(ReportDto reportDto);//신고 등록
	void insertBoardReport(BoardReportDto boardReportDto);//게시글 신고 등록
	boolean deleteReport(int ReportNo);//신고 삭제
	int countReportList(PaginationVO vo);//신고 목록 개수 세기
	List<ReportListDto> selectReportList(PaginationVO vo);//신고 목록
	
	   // 첨부 파일 갯수(count) 조회
	 int getAttachmentCount(int boardNo);
	
	 // 첫 번째 첨부 파일 번호(firstAttachmentNo) 조회
	 int getFirstAttachmentNo(int boardNo);
	 
	 //일단 5개만 찍어봄
	 List<BoardListDto> selectListTop5();
	 
	 boolean updateBoardReplyCount(int boardNo);
}



















