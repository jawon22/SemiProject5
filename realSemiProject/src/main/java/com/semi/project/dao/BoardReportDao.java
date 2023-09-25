package com.semi.project.dao;

import com.semi.project.dto.BoardReportDto;

public interface BoardReportDao {
	void insert(BoardReportDto boardReportDto);
	boolean delete(int reportNo);
}
