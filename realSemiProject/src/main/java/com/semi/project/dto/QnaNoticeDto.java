package com.semi.project.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

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
	
	
	//작성자 출력용 메소드
		public String getQnaNoticeWriterString() {
			if(memberNickname ==null) return "(탈퇴한사용자)";
			return memberNickname;
		}
		
		//날짜에 따라 다른 값을 반환하는 메소드
		public String getQnaNoticeTimeString() {
			LocalDate curent = LocalDate.now(); // 현재날짜
			LocalDate ctime = qnaNoticeTime.toLocalDate();// 작성일
			
			if(ctime.equals(curent)) { //작성일 == 오늘
				Timestamp stamp = new Timestamp(qnaNoticeTime.getTime());
				LocalDateTime time = stamp.toLocalDateTime();
				LocalTime result = time.toLocalTime();
				return result.format(DateTimeFormatter.ofPattern("HH:mm"));
			}
			else {
				return ctime.toString();
			}
		}
	
}
