package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.AttachmentDto;

@Component
public class AttachmentMapper implements RowMapper<AttachmentDto> {
@Override
public AttachmentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	AttachmentDto attachDto = new AttachmentDto();
	attachDto.setAttachmentNo(rs.getInt("attachment_no"));
	attachDto.setAttachmentName(rs.getString("attachment_name"));
	attachDto.setAttachmentType(rs.getString("attachment_type"));
	attachDto.setAttachmentSize(rs.getInt("attachment_size"));
	return attachDto;
}
}
