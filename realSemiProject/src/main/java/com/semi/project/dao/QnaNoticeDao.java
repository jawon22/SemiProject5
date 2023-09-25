package com.semi.project.dao;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.QnaNoticeDto;

public interface QnaNoticeDao {
	
	int sequence();
	void insert(QnaNoticeDto qnaNoticeDto);	
	void connect(int attachmentNo, int qnaNoticeNo);
	QnaNoticeDto selectOne(int qnaNoticeNo);
	AttachmentDto findImage(int qnaNoticeNo);
}
