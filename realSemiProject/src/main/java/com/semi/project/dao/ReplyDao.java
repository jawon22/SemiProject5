package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.ReplyDto;

public interface ReplyDao {
	int sequence();
	void insert(ReplyDto replyDto);
	List<ReplyDto> selectList(int replyOrigin);
	ReplyDto selectOne(int replyNo);
	boolean delete(int replyNo);
	boolean update(ReplyDto replyDto);
	ReplyDto selectOneByRlplyOrigin(int replyOrigin);
}
