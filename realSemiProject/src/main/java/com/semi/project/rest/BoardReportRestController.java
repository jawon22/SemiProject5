package com.semi.project.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.BoardReportDao;
import com.semi.project.dto.BoardReportDto;

@RestController
@RequestMapping("/rest/boardReport")
public class BoardReportRestController {
	@Autowired
	BoardReportDao boardReportDao;
	
	@RequestMapping("/insert")
	public void  insert(@ModelAttribute BoardReportDto boardReportDto) {
		boardReportDao.insert(boardReportDto);
	}
	
	@RequestMapping("/delete")
	public void delete(@RequestParam int reportNo) {
		boardReportDao.delete(reportNo);
	}
}
