package com.semi.project.mapper;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.BlockDetailDto;

@Component
public class BlockDetailMapper implements RowMapper<BlockDetailDto> {

	@Override
	public BlockDetailDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BlockDetailDto blockDetailDto = new BlockDetailDto();
		blockDetailDto.setMemberId(rs.getString("member_id"));
		blockDetailDto.setMemberPw(rs.getString("member_pw"));
		blockDetailDto.setMemberNickname(rs.getString("member_nickname"));
		blockDetailDto.setMemberEmail(rs.getString("member_email"));
		blockDetailDto.setMemberBirth(rs.getString("member_birth"));
		blockDetailDto.setMemberArea(rs.getString("member_area"));
		blockDetailDto.setMemberPoint(rs.getInt("member_point"));
		blockDetailDto.setMemberLevel(rs.getString("member_level"));
		blockDetailDto.setMemberJoin(rs.getDate("member_join"));
		blockDetailDto.setMemberLogin(rs.getDate("member_login"));
		blockDetailDto.setMemberPwChange(rs.getDate("member_pwchange"));
		blockDetailDto.setBlock(rs.getString("block"));
		return blockDetailDto;
	}
	
}
