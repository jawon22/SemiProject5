package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.BoardLikeDto;

@Component
public class BoardLikeMapper implements RowMapper<BoardLikeDto>{

	@Override
	public BoardLikeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardLikeDto boardLikeDto = new BoardLikeDto();
		boardLikeDto.setBoardNo(rs.getInt("board_no"));
		boardLikeDto.setMemberId(rs.getString("member_id"));
		return boardLikeDto;
	}

}
