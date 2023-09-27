package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.BoardReportDto;

@Component
public class BoardReportMapper implements RowMapper<BoardReportDto> {

	@Override
	public BoardReportDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardReportDto boardReportDto = new BoardReportDto();
		boardReportDto.setReportNo(rs.getInt("report_no"));
		boardReportDto.setBoardNo(rs.getInt("board_no"));
		boardReportDto.setMemberId(rs.getString("member_id"));
		return boardReportDto;
	}

}
