package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.MemberDto;

@Component
public class MemberMapper implements RowMapper<MemberDto> {

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(rs.getString("member_id"));
		memberDto.setMemberPw(rs.getString("member_pw"));
		memberDto.setMemberNickname(rs.getString("member_nickname"));
		memberDto.setMemberEmail(rs.getString("member_email"));
		memberDto.setMemberBirth(rs.getString("member_birth"));
		memberDto.setMemberArea(rs.getString("member_area"));
		memberDto.setMemberPoint(rs.getInt("member_point"));
		memberDto.setMemberLevel(rs.getString("member_level"));
		memberDto.setMemberLogin(rs.getDate("member_login"));
		memberDto.setMemberJoin(rs.getDate("member_join"));
		memberDto.setMemberPwChange(rs.getDate("member_pwchange"));
		return memberDto;
	}

}
