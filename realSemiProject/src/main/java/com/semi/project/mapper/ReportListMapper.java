package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.ReportListDto;

@Component
public class ReportListMapper implements RowMapper<ReportListDto>{

	@Override
	public ReportListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReportListDto reportListDto = new ReportListDto();
		reportListDto.setBoardCategory(rs.getInt("board_category"));
		reportListDto.setBoardWriter(rs.getString("board_writer"));
		reportListDto.setBoardTitle(rs.getString("board_title"));
		reportListDto.setBoardContent(rs.getString("board_content"));
		reportListDto.setReportNo(rs.getInt("report_no"));
		reportListDto.setBoardNo(rs.getInt("board_no"));
		reportListDto.setMemberId(rs.getString("member_id"));
		reportListDto.setReportReason(rs.getString("report_reason"));
		return reportListDto;
	}

}
