package com.semi.project.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private String memberId, memberPw, memberNickname;
	private String memberEmail;
	private Date memberBirth;
	private String memberArea;
	private int memberPoint;
	private String memberLevel;
	private Date memberJoin, memberLogin, memberPwChange;
}
