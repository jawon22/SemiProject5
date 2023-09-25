package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.vo.PaginationVO;

public interface QnaNoticeDao {
	
	int sequence();
	void insert(QnaNoticeDto qnaNoticeDto);	
	void connect(int attachmentNo, int qnaNoticeNo);
	QnaNoticeDto selectOne(int qnaNoticeNo);
	boolean delete(int qnaNoticeNo);
	AttachmentDto findImage(int qnaNoticeNo);

	int countList(PaginationVO vo);
	List<QnaNoticeDto> selectNoticeListTop5();
	List<QnaNoticeDto> selectNoticeListByPage(PaginationVO vo);
	List<QnaNoticeDto> selectQnaListByPage(PaginationVO vo);

	
}
