package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.ReplyDto;
import com.semi.project.mapper.ReplyMapper;

@Repository
public class ReplyDaoImpl implements ReplyDao{
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	ReplyMapper replyMapper;

	@Override
	public int sequence() {
		String sql = "select reply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(ReplyDto replyDto) {
		String sql = "insert into reply(reply_no, reply_writer, reply_origin, reply_content) "
							+ "values(?, ?, ?, ?)";
		Object[] data = {replyDto.getReplyNo(), replyDto.getReplyWriter(), replyDto.getReplyOrigin(), replyDto.getReplyContent()};
		jdbcTemplate.update(sql, data);
		
	}

	@Override
	public List<ReplyDto> selectList(int replyOrigin) {
		String sql = "select * from reply "
				+ "where reply_origin=?"
				+ " order by reply_no desc";
		Object[] data = {replyOrigin}; 
		return jdbcTemplate.query(sql, replyMapper, data);
	}
	
	@Override
	public ReplyDto selectOne(int replyNo) {
		String sql = "select * from reply "
				+ "where reply_no=?";
		Object[] data= {replyNo};
		List<ReplyDto> list = jdbcTemplate.query(sql, replyMapper, data);
		return list.isEmpty()? null: list.get(0);
	}

	@Override
	public boolean delete(int replyNo) {
		String sql = "delete reply where reply_no=?";
		Object[] data = {replyNo};
		return jdbcTemplate.update(sql, data)>0;
	}

	
	
	
}
