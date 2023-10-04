package com.semi.project.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyDto {
	int replyNo;
	String replyWriter;
	int replyOrigin;
	String replyContent;
	Date replyTime;
	int replyGroup;
	Integer replyParent;
	int replyDepth;
}
