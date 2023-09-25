package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.ReportDto;

@Component
public class ReportMapper implements RowMapper<ReportDto> {

	@Override
	public ReportDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReportDto reportDto = new ReportDto();
		reportDto.setReportNo(rs.getInt("report_no"));
		reportDto.setReportReason(rs.getString("report_reason"));
		return reportDto;
	}

}
