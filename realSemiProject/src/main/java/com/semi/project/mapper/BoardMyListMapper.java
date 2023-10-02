package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.BoardListDto;

@Component
public class BoardMyListMapper implements RowMapper<BoardListDto> {

	@Override
	public BoardListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardListDto boardListDto = new BoardListDto();
		boardListDto.setMemberNickname(rs.getString("member_nickname"));
		boardListDto.setBoardNo(rs.getInt("board_no"));
		boardListDto.setBoardCategoryWeather(rs.getString("board_categoryweather"));
		boardListDto.setBoardArea(rs.getString("board_area"));
		boardListDto.setBoardReadcount(rs.getLong("board_readcount"));
		boardListDto.setBoardReplycount(rs.getLong("board_replycount"));
		boardListDto.setBoardWriter(rs.getString("board_writer"));
		boardListDto.setBoardTitle(rs.getString("board_title"));
		boardListDto.setBoardCtime(rs.getDate("board_ctime"));
		return boardListDto;
	}
	
}
