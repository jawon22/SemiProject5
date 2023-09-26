package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.vo.PaginationVO;

public interface QnaNoticeDao {
	
	int sequence();
	void insert(QnaNoticeDto qnaNoticeDto);	
	QnaNoticeDto selectOne(int qnaNoticeNo);
	boolean delete(int qnaNoticeNo);
	
	//썸머노트 파일연결
	void connect(int qnaNoticeNo, int attachmentNo);
	

	int countList(PaginationVO vo);
	List<QnaNoticeDto> selectNoticeListTop5();
	List<QnaNoticeDto> selectNoticeListByPage(PaginationVO vo);
	List<QnaNoticeDto> selectQnaListByPage(PaginationVO vo);

	
}
