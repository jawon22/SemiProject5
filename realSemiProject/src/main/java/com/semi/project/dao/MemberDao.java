package com.semi.project.dao;

import java.util.List;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.BlockDetailDto;
import com.semi.project.dto.BlockListDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.ExpiredListDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.MemberProfileDto;
import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.dto.StatDto;
import com.semi.project.vo.PaginationVO;

public interface MemberDao {
	void insert(MemberDto memberDto); //회원가입
	boolean updateMemberLogin(String memberId);
	MemberDto selectOne(String memberId); //상세조회(마이페이지)
	boolean updateMemberInfo(MemberDto memberDto); //회원정보변경(마이페이지)
	boolean updateMemberPw(String memberId, String changePw); //비밀번호변경(마이페이지)
	boolean delete(String memberId); //탈퇴(마이페이지)
	void updateMemberLevelUp(); //멤버등업
	void updateMemberLevelDown(); //멤버강등
	ExpiredListDto findMemberExpiredList(String memberId); //비밀번호 변경 90일 경과 멤버조회
	boolean updateMemberPwDelay(String memberId); //비밀번호 변경일 90일 미루기
	List<String> selectListByMemberNick(int boardNo);//댓글 닉네임 표기 리스트
	
	
	int countMyList(PaginationVO vo, String memberId, String listType);
	int countListMyQnaList(PaginationVO vo, String memberId); //내 문의글 카운트
	
	List<BoardListDto> findWriteListByMemberId(PaginationVO vo, String memberId); //내가 쓴 글 조회
	List<BoardListDto> findLikeListByMemberId(PaginationVO vo, String memberId); //내가 좋아요 한 글 조회
	List<BoardListDto> findReplyListByMemberId(PaginationVO vo, String memberId); //내가 댓글 단 글 조회
	List<QnaNoticeDto> findQnaListByMemberId(PaginationVO vo, String memberId); //내가 쓴 문의글 조회
	//이메일 중복체크
	MemberDto checkEmail(String memberEmail);
	
	//글작성시 포인트 증가
	boolean increaseMemberPoint(String memberId, int memberPoint);
	
	
	//프로필 관련 기능
	void insertProfile(String memberId, int attachNo); //프로필등록
	boolean deleteProfile(String memberId); //프로필삭제
	Integer findProfile(String memberId); //프로필찾기
	List<MemberProfileDto> findProfileList(String memberId, String replyWriter);//프로필 전체 조회
	
	//관리자기능
	int countList(PaginationVO vo);//회원목록
	List<MemberDto> selectMemberListByPage(PaginationVO vo); //회원목록
	boolean updateMemberInfoByAdmin(MemberDto memberDto); //회원정보수정
	
	int countBlockList(PaginationVO vo);//차단 회원 목록
	List<BlockListDto> selectBlockListByPage(PaginationVO vo); //차단 회원목록
	MemberDto selectIdByMemberEmail(String inputEmail);//아이디찾기
	
	//통계 기능
	List<StatDto> selectGroupByMemberBirth();//나이
	List<StatDto> selectGroupByMemberArea();//지역
	List<StatDto> selectGroupByMemberJoin();//가입일
	List<StatDto> selectGroupByMemberLevel();//등급
	
	//차단+해제 기능
	void insertBlock(String memberId);
	boolean deleteBlock(String memberId);
	List<BlockDetailDto> findBlock(String memberId);//차단 여부 찾기
	
}
