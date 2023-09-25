package com.semi.project.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BlockDetailDto {
	private String memberId, memberPw, memberNickname;
	private String memberEmail;
	private String memberBirth;
	private String memberArea;
	private int memberPoint;
	private String memberLevel;
	private Date memberJoin, memberLogin, memberPwChange;
	
	private String block;//차단 여부
}
