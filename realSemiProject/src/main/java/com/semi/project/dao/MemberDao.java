package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.MemberDto;

import com.semi.project.vo.PaginationVO;
import com.semi.project.dto.StatDto;

public interface MemberDao {
	void insert(MemberDto memberDto); //회원가입
	boolean updateMemberLogin(String memberId);
	MemberDto selectOne(String memberId); //상세조회(마이페이지)
	boolean updateMemberInfo(MemberDto memberDto); //회원정보변경(마이페이지)
	boolean updateMemberPw(String memberId, String changePw); //비밀번호변경(마이페이지)
	boolean delete(String memberId); //탈퇴(마이페이지)
	List<BoardListDto> findWriteListByMemberId(String memberId); //내가 쓴 글 조회
	List<BoardListDto> findLikeListByMemberId(String memberId); //내가 좋아요 한 글 조회
	
	//프로필 관련 기능
	void insertProfile(String memberId, int attachNo); //프로필등록
	boolean deleteProfile(String memberId); //프로필삭제
	Integer findProfile(String memberId); //프로필찾기
	
	//관리자기능
	int countList(PaginationVO vo);//회원목록
	List<MemberDto> selectMemberListByPage(PaginationVO vo); //회원목록
	boolean updateMemberLevel(String memberId); //회원정보수정
	
	MemberDto selectIdByMemberEmail(String inputEmail);//아이디찾기
	
	//통계 기능
	List<StatDto> selectGroupByMemberBirth();//나이
	List<StatDto> selectGroupByMemberArea();//지역
	List<StatDto> selectGroupByMemberJoin();//가입일
	List<StatDto> selectGroupByMemberLevel();//등급
}
