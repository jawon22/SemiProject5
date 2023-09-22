package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.MemberBlockDto;

@Component
public class MemberBlockMapper implements RowMapper<MemberBlockDto> {

	@Override
	public MemberBlockDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberBlockDto memberBlockDto = new MemberBlockDto();
		memberBlockDto.setMemberId(rs.getString("member_id"));
		memberBlockDto.setBlockTime(rs.getDate("block_time"));
		return memberBlockDto;
	}

}
