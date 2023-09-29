package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.vo.PaginationVO;

public interface QnaNoticeDao {
	
	int sequence();
	void insert(QnaNoticeDto qnaNoticeDto);	
	QnaNoticeDto selectOne(int qnaNoticeNo);
	boolean delete(int qnaNoticeNo);
	boolean edit(QnaNoticeDto qnaNoticeDto);
	
	
	//썸머노트 파일연결
	void connect(int qnaNoticeNo, int attachmentNo);
	

	//qna 게시글을 카운트
	int countQnaList(PaginationVO vo);
	// 공지글을 카운트
	int countNoticeList(PaginationVO vo);
//	//qna+공지글을 카운트
//	int countQnaNoticeList(PaginationVO vo);
	//상단에 보여주는 공지 5개
	List<QnaNoticeDto> selectNoticeListTop5();
	//공지목록조회
	List<QnaNoticeDto> selectNoticeListByPage(PaginationVO vo);
	//qna목록조회
	List<QnaNoticeDto> selectQnaListByPage(PaginationVO vo);
	

	
}
