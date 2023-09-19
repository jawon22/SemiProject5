package com.semi.project.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class BoardDto {
	int boardNo;
	int boardCategory;
	String memberId;
	String boardTitle;
	String boardContent;
	Date boardCtime;
	long boardReadcount;
	long boardReplycount;
	long boardLikecount;
	
	
	
	//날짜에 따라 다른 값을 반환하는 메소드
		public String getBoardCtimeString() {
			LocalDate curent = LocalDate.now(); // 현재날짜
			LocalDate ctime = boardCtime.toLocalDate();// 작성일
			
			if(ctime.equals(curent)) { //작성일 == 오늘
				Timestamp stamp = new Timestamp(boardCtime.getTime());
				LocalDateTime time = stamp.toLocalDateTime();
				LocalTime result = time.toLocalTime();
				return result.format(DateTimeFormatter.ofPattern("HH:mm"));
			}
			else {
				return ctime.toString();
			}
			
		}
	
}
