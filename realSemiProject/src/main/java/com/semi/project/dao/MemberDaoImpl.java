package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BlockDetailDto;
import com.semi.project.dto.BlockListDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.BoardReportDto;
import com.semi.project.dto.ExpiredListDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.ReportDto;
import com.semi.project.dto.ReportListDto;
import com.semi.project.dto.StatDto;
import com.semi.project.mapper.BlockDetailMapper;
import com.semi.project.mapper.BlockListMapper;
import com.semi.project.mapper.BoardListMapper;
import com.semi.project.mapper.BoardReportMapper;
import com.semi.project.mapper.ExpiredListMapper;
import com.semi.project.mapper.MemberBlockMapper;
import com.semi.project.mapper.MemberMapper;
import com.semi.project.mapper.ReportListMapper;
import com.semi.project.mapper.ReportMapper;
import com.semi.project.mapper.StatMapper;
import com.semi.project.vo.PaginationVO;


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
	
	@Autowired
	private MemberBlockMapper memberblockMapper;
	
	@Autowired
	private BlockListMapper blockListMapper;
	
	@Autowired
	private BlockDetailMapper blockDetailMapper;
	
	@Autowired
	private ReportMapper reportMapper;
	
	@Autowired
	private BoardReportMapper boardReportMapper;
	
	@Autowired
	private ReportListMapper reportListMapper;
	
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
		String sql = "select attachment_no from member_profile where member_id = ?";
		Object[] data = {memberId};
		try {
			return jdbcTemplate.queryForObject(sql, Integer.class, data);
		}
		catch(Exception e) {
			return null;
		}
	}
	
	//회원목록 페이지 계산
	@Override
	public int countList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from member "
					+ "where instr("+vo.getType()+", ?) > 0 "
					+ "and member_level != '관리자'";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from member "
					+ "where member_level != '관리자'";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//회원목록 보여주기 (관리자제외, 검색기능 유무 따져서, 페이지 기능)
	@Override
	public List<MemberDto> selectMemberListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from member "
					+ "where instr("+vo.getType()+", ?) > 0 "
					+ "and member_level != '관리자' "
					+ "order by "+vo.getType()+ " asc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = { 
					vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()
			};
			return jdbcTemplate.query(sql, memberMapper, data);
		}
		else {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from member "
					+ "where member_level != '관리자' "
					+ "order by member_join desc "
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberMapper, data);
		}
	}


	@Override
	public List<StatDto> selectGroupByMemberBirth() {
		String sql = "SELECT age_group name, count(*) cnt FROM ( "
							+ "SELECT "
								+ "CASE "
									+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) > TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 19 THEN '청소년' "
									+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 34 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 20 THEN '청년' "
									+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 49 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 35 THEN '중년' "
									+ "WHEN TO_NUMBER(SUBSTR(member_birth, 1, 4)) BETWEEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 64 AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 50 THEN '장년' "
									+ "ELSE '노인' "
								+ "END AS age_group "
							+ "FROM MEMBER "
						+ ") GROUP BY age_group";
		return jdbcTemplate.query(sql, statMapper);
	}

	@Override
	public List<StatDto> selectGroupByMemberArea() {
		String sql = "SELECT member_area name, count(*) cnt FROM MEMBER GROUP by member_area";
		return jdbcTemplate.query(sql, statMapper);
	}

	@Override
	public List<StatDto> selectGroupByMemberJoin() {
		String sql = "SELECT TO_CHAR(member_join, 'MM') AS name, COUNT(*) AS cnt FROM MEMBER GROUP BY TO_CHAR(member_join, 'MM')";
		return jdbcTemplate.query(sql, statMapper);
	}

	@Override
	public List<StatDto> selectGroupByMemberLevel() {
		String sql = "select member_level name, count(*) cnt from member group by member_level";
		return jdbcTemplate.query(sql, statMapper);
	}
	
	@Override
	public boolean updateMemberInfoByAdmin(MemberDto memberDto) {
		String sql = "update member set "
				+ "member_nickname = ?, member_level = ?, member_point = ? "
				+ "where member_id = ?";
		Object[] data = {
				memberDto.getMemberNickname(), memberDto.getMemberLevel(),
				memberDto.getMemberPoint(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean updateMemberLogin(String memberId) {
		String sql = "update member set member_login = sysdate "
				+ "where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}

	
	@Override
	public void insertBlock(String memberId) {
		String sql = "insert into block_list(member_id) values(?)";
		Object[] data = {memberId};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean deleteBlock(String memberId) {
		String sql = "delete block_list where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public List<BlockDetailDto> findBlock(String memberId) {
		String sql ="select * from block_detail where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.query(sql, blockDetailMapper, data);
	}

	@Override
	public int countBlockList(PaginationVO vo) {
	    if (vo.isSearch()) {
	        String sql = "select count(*) from block_list "
	        			+ "where instr(" + vo.getType() + ", ?) > 0 "
	        			+ "and member_level != '관리자'";
	        Object[] data = {vo.getKeyword()};
	        return jdbcTemplate.queryForObject(sql, Integer.class, data);
	    } else {
	        String sql = "select count(*) from block_list "
						+ "where member_level != '관리자'";
	        return jdbcTemplate.queryForObject(sql, Integer.class);
	    }
	}
	
	@Override
	public List<BlockListDto> selectBlockListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select * from ( "
								+ "select rownum rn, tmp.* from ( "
									+ "select * from block_list "
									+ "order by block_time desc "
									+ "where instr(" + vo.getType() + ", ?) > 0 "
									+ "and member_level != '관리자' "
									+	"order by block_time desc "
								+ ") tmp"
							+ ") where rn between ? and ?";
			Object[] data = {
					vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()
			};
			return jdbcTemplate.query(sql, blockListMapper, data);
		}
		else {
			String sql = "select * from ( "
				    			+	"select rownum rn, tmp.* from ( "
				    				+	"select * from block_list "
				    				+	"order by block_time desc "
				    			+	") tmp "
				    		+	") where rn between ? and ? ";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, blockListMapper, data);
		}
	}
	
	@Autowired
	private ExpiredListMapper expiredListMapper;
	
	@Override
	public ExpiredListDto findMemberExpiredList(String memberId) {
		String sql = "select * from expired_list where member_id = ?";
		Object[] data = {memberId};
		List<ExpiredListDto> list = jdbcTemplate.query(sql, expiredListMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public boolean updateMemberLevel() {
		String sql = "update member set member_level = 'tripper' "
				+ "where member_id in ("
				+ "select member_id from member "
				+ "where member_point >= 1000)";
		return jdbcTemplate.update(sql) > 0;
	}
	
	@Override
	public boolean deleteReport(int ReportNo) {
		String sql = "delete report_list where report_no = ?";
		Object[] data = {ReportNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public List<ReportListDto> selectReportList(PaginationVO vo) {
		String sql = "SELECT * FROM ( "
							+ "SELECT rownum rn, tmp.* FROM( "
								+ "SELECT * FROM report_list "
								+ "ORDER BY report_no desc"
							+ ") tmp"
						+ ") WHERE rn BETWEEN ? AND ?";
		Object[] data = {vo.getStartRow(), vo.getFinishRow()};
		return jdbcTemplate.query(sql, reportListMapper, data);
	}

	//글작성시 포인트 증가
	@Override
	public boolean increaseMemberPoint(String memberId, int memberPoint) {
		String sql = "update member "
				+ "set member_point = member_point + ? "
				+ "where member_id = ?";
		Object[] data = {memberPoint, memberId};
		return jdbcTemplate.update(sql, data)>0;
	}

}
