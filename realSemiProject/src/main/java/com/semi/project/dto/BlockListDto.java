package com.semi.project.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BlockListDto {
	private String memberId;
	private Date BlockTime;
	private String memberNickname;
	private String memberLevel;
}
