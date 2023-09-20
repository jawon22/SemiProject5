package com.semi.project.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.mapper.AttachmentMapper;

@Repository
public class AttachmentDaoImpl implements AttachmentDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AttachmentMapper attachMapper;
	
	@Override
	public int sequence() {
		String sql = "select attachment_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	@Override
	public void insert(AttachmentDto attachDto) {
//		String sql = "insert into "
		
	}
	@Override
	public boolean delete(int attachment_no) {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public AttachmentDto selectOne(int attachment_no) {
		// TODO Auto-generated method stub
		return null;
	}
}
