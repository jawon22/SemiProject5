package com.semi.project.dto;

import lombok.Data;

@Data
public class ReportListDto {
	private int boardCategory;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private int reportNo;
	private int boardNo;
	private String memberId;
	private String reportReason;
}
