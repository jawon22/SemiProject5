package com.semi.project.vo;

import java.util.List;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.MemberProfileDto;
import com.semi.project.dto.ReplyDto;

import lombok.Data;

@Data
public class ReplyProfileVo {
	private List<ReplyDto> list;
	private List<MemberProfileDto> attachNo;
//	private List<MemberDto> memberNickname;
}
