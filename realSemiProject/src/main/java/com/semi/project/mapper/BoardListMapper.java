package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.BoardListDto;

@Component
public class BoardListMapper implements RowMapper<BoardListDto>{

	@Override
	public BoardListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardListDto boardListDto = new BoardListDto();
		boardListDto.setMemberNickname(rs.getString("member_nickname"));
		boardListDto.setBoardCategory(rs.getInt("board_category"));
		boardListDto.setBoardCategoryWeather(rs.getString("board_categoryweather"));
		boardListDto.setBoardArea(rs.getString("board_area"));
		boardListDto.setBoardNo(rs.getInt("board_no"));
		boardListDto.setBoardWriter(rs.getString("board_writer"));
		boardListDto.setBoardTitle(rs.getString("board_title"));
		boardListDto.setBoardCtime(rs.getDate("board_ctime"));
		boardListDto.setBoardReadcount(rs.getLong("board_readcount"));
		boardListDto.setBoardReplycount(rs.getLong("board_replycount"));
		boardListDto.setBoardLikecount(rs.getLong("board_likecount"));
		boardListDto.setReportCount(rs.getInt("report_count"));
		return boardListDto;
	}
}
