package com.semi.project.dao;

import com.semi.project.dto.AttachmentDto;

public interface AttachmentDao {
	
	int sequence();
	void insert(AttachmentDto attachDto);
	boolean delete(int attachment_no);
	AttachmentDto selectOne(int attachment_no);
	
}
