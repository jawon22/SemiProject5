package com.semi.project.dao;

import com.semi.project.dto.QnaNoticeDto;

public interface QnaNoticeDao {
	
	int sequence();
	void insert(QnaNoticeDto qnaNoticeDto);	
	
}
