package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.MemberProfileDto;

@Component
public class MemberProfileMapper implements RowMapper<MemberProfileDto>{

	@Override
	public MemberProfileDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberProfileDto profileDto = new MemberProfileDto();
		profileDto.setAttachmentNo(rs.getObject("attachment_no", Integer.class));
	
		return profileDto;
	}

}
