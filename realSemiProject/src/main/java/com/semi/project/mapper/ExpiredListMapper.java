package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.ExpiredListDto;

@Component
public class ExpiredListMapper implements RowMapper<ExpiredListDto> {
@Override
public ExpiredListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	ExpiredListDto expiredListDto = new ExpiredListDto();
	expiredListDto.setMemberId(rs.getString("member_id"));
	expiredListDto.setIsExpired(rs.getString("is_expired"));
	
	return expiredListDto;
}
}
