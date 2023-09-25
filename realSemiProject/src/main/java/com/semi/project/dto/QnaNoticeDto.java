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
	private int qnaNoticeGroup, qnaNoticeDepth;
	private Integer qnaNoticeParent;
	private String memberNickname;
	
	//이미지 유무(DB아님)
	private boolean image;
	
	
}
