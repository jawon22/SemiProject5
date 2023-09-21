package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.StatDto;
import com.semi.project.mapper.BoardListMapper;
import com.semi.project.mapper.MemberMapper;
import com.semi.project.mapper.StatMapper;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private BoardListMapper boardListMapper;
	
	@Autowired
	private StatMapper statMapper;
	
	@Override
	public void insert(MemberDto memberDto) {
		String sql = "insert into member("
				+ "member_id, member_pw, member_nickname, "
				+ "member_email, member_birth, member_area) "
				+ "values( ?, ?, ?, ?, ?, ? )";
		Object[] data = {
			memberDto.getMemberId(), memberDto.getMemberPw(),
			memberDto.getMemberNickname(), memberDto.getMemberEmail(),
			memberDto.getMemberBirth(), memberDto.getMemberArea()
		};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}


	@Override
	public boolean updateMemberInfo(MemberDto memberDto) {
		String sql = "update member set member_nickname = ?, member_email = ?, "
				+ "member_birth = ?, member_area = ? where member_id = ?";
		Object[] data = {
				memberDto.getMemberNickname(), memberDto.getMemberEmail(),
				memberDto.getMemberBirth(), memberDto.getMemberArea(),
				memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean updateMemberPw(String memberId, String changePw) {
		String sql = "update member set member_pw = ?, "
				+ "member_pwchange = sysdate "
				+ "where member_id = ?";
		Object[] data = {
				changePw, memberId
		};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean delete(String memberId) {
		String sql = "delete member where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data)> 0 ;
	}

	@Override
	public MemberDto selectIdByMemberEmail(String inputEmail) {
		String sql = "select * from member where member_email = ?";
		Object[] data = {inputEmail};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public List<BoardListDto> findWriteListByMemberId(String memberId) {
		String sql = "select board_list.* from board_list left outer join member "
				+ "on board_list.board_writer = member.member_id "
				+ "where member.member_id = ? "
				+ "order by board_no desc";
		Object[] data = {memberId};
		return  jdbcTemplate.query(sql, boardListMapper, data);
	}
	
	@Override
	public List<BoardListDto> findLikeListByMemberId(String memberId) {
		String sql = "select board_list.* from board_list left outer join board_like "
				+ "on board_list.board_no = board_like.board_no "
				+ "where board_like.member_id = ? "
				+ "order by board_list.board_no desc";
		Object[] data = {memberId};
		return jdbcTemplate.query(sql, boardListMapper, data);
	}
	
	@Override
	public void insertProfile(String memberId, int attachNo) {
		String sql = "insert into member_profile values(? ,?)";
		Object[] data = {memberId, attachNo};
		jdbcTemplate.update(sql, data);
	}
	@Override
	public boolean deleteProfile(String memberId) {
		String sql = "delete member_profile where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	@Override
	public Integer findProfile(String memberId) {
		String sql = "select * from member_profile where member_id = ?";
		Object[] data = {memberId};
		try {
			return jdbcTemplate.queryForObject(sql, Integer.class, data);
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public List<StatDto> selectGroupByMemberBirth() {
		String sql = "SELECT CASE WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) > TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 19 THEN '청소년' "
							+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 34 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 20 THEN '청년' "
							+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 49 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 35 THEN '중년' "
							+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 64 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 50 THEN '장년' "
						+ "ELSE '노인' "
						+ "END AS age_group, "
						+ "COUNT(*) AS total_cnt "
						+ "FROM member GROUP BY CASE "
							+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) > TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 19 THEN '청소년' "
							+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 34 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 20 THEN '청년' "
							+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 49 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 35 THEN '중년' "
							+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 64 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 50 THEN '장년' "
							+ "ELSE '노인' "
						+ "END ORDER BY age_group";
		return jdbcTemplate.query(sql, statMapper);
	}

	@Override
	public List<StatDto> selectGroupByMemberArea() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<StatDto> selectGroupByMemberJoin() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<StatDto> selectGroupByMemberLevel() {
		// TODO Auto-generated method stub
		return null;
	}
}
