package com.semi.project.dao;

import com.semi.project.dto.MemberDto;

public interface MemberDao {
	void insert(MemberDto memberDto); //회원가입
	MemberDto selectOne(String memberId); //상세조회(마이페이지)
	boolean updateMemberInfo(MemberDto memberDto); //회원정보변경(마이페이지)
	boolean updateMemberPw(String memberId, String changePw); //비밀번호변경(마이페이지)
	boolean delete(String memberId); //탈퇴(마이페이지)
	
	MemberDto selectEmailByMemberId(String memberId);
}
