 package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.BoardDto;

@Component
public class BoardDetailMapper implements RowMapper<BoardDto>{

	@Override
	public BoardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardDto boardDto = new BoardDto();
		boardDto.setBoardNo(rs.getInt("board_no"));
		boardDto.setBoardCategory(rs.getInt("board_category"));
		boardDto.setBoardWriter(rs.getString("board_writer"));
		boardDto.setBoardTitle(rs.getString("board_title"));
		boardDto.setBoardContent(rs.getString("board_content"));
		boardDto.setBoardCtime(rs.getDate("board_ctime"));
		boardDto.setBoardReadcount(rs.getLong("board_readcount"));
		boardDto.setBoardReplycount(rs.getLong("board_replycount"));
		boardDto.setBoardLikecount(rs.getLong("board_likecount"));
		return boardDto;
	}

}
