package com.semi.project.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.mapper.AttachmentMapper;

@Repository
public class AttachmentDaoImpl implements AttachmentDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AttachmentMapper attachMapper;
	
	   private RowMapper<AttachmentDto> mapper = new RowMapper<AttachmentDto>() {
		      
		      @Override
		      public AttachmentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		         
		         //Builder Pattern(Lombok 제공)
		         return AttachmentDto.builder()
		                     .attachmentNo(rs.getInt("attachment_no"))
		                     .attachmentName(rs.getString("attachment_name"))
		                     .attachmentType(rs.getString("attachment_type"))
		                     .attachmentSize(rs.getLong("attachment_size"))
		                  .build();
		      }
		   };
		   
	@Override
	public int sequence() {
		String sql = "select attachment_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	@Override
	public void insert(AttachmentDto attachDto) {
		String sql = "insert into attachment("
				+ "attachment_no, attachment_name, attachment_type, attachment_size"
				+ ") values(?, ?, ?, ?)";
		Object[] data = {
				attachDto.getAttachmentNo(), attachDto.getAttachmentName(),
				attachDto.getAttachmentType(), attachDto.getAttachmentSize()
		};
		jdbcTemplate.update(sql, data);
	}
	@Override
	public boolean delete(int attachment_no) {
		String sql = "delete attachment where attachment_no = ?";
		Object[] data = {attachment_no};
		return jdbcTemplate.update(sql, data) > 0;
	}
	@Override
	public AttachmentDto selectOne(int attachment_no) {
		String sql = "select * from attachment where attachment_no = ?";
		Object[] data = {attachment_no};
		List<AttachmentDto> list = jdbcTemplate.query(sql, attachMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
