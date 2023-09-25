package com.semi.project.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class QnaNoticeDto {

	private int qnaNoticeNo;
	private String memberId, qnaNoticeTitle, qnaNoticeContent;
	private int qnaNoticeType;
	private String qnaNoticeSecret;
	private Date qnaNoticeTime;
	private int qnaNoticeGroup, qnaNoticeParent, qnaNoticeDepth;
	
}
