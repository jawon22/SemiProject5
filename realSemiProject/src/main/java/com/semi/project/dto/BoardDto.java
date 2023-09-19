package com.semi.project.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDto {
int boardNo;
int boardCategory;
String memberId;
String boardTitle;
String boardContent;
Date boardCtime;
int boardReadcount;
int boardReplycount;
int boardLikecount;
}
