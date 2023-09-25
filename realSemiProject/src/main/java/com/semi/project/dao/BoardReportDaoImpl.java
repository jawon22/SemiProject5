package com.semi.project.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BoardReportDto;
import com.semi.project.mapper.BoardReportMapper;

@Repository
public class BoardReportDaoImpl implements BoardReportDao{
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	BoardReportMapper boardReportMapper;
	
	@Override
	public void insert(BoardReportDto boardReportDto) {
		String sql = "insert into board_report(report_no, board_no, board_writer) values(?, ?, ?)";
		Object[] data = {boardReportDto.getReportNo(), boardReportDto.getBoardNo(), boardReportDto.getBoardWriter()};
		jdbcTemplate.update(sql, data);
	}
	@Override
	public boolean delete(int reportNo) {
		String sql = "delete board_report where report_no=?";
		Object[] data = {reportNo};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	
}
