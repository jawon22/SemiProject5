package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BoardDto;
import com.semi.project.mapper.BoardDetailMapper;
import com.semi.project.mapper.BoardListMapper;
import com.semi.project.vo.PaginationVO;

@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	BoardListMapper boardListMapper;
	
	@Autowired
	BoardDetailMapper boardDetailMapper;
	
	@Override
	public int sequence() {
		String sql = "select board_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(BoardDto boardDto) {//등록
		String sql = "insert into board(board_no, board_title, board_content) values(?, ?, ?)";
		Object[] data = {boardDto.getBoardNo(), boardDto.getBoardTitle(), boardDto.getBoardContent()};
		
		jdbcTemplate.update(sql, data);
	}

	@Override
	public BoardDto selectOne(int boardNo) {//상세 조회
		String sql = "select * from board where board_no = ?";
		Object[] data = {boardNo};
		List<BoardDto> list = jdbcTemplate.query(sql, boardDetailMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<BoardDto> selectList() {//리스트 조회
		String sql = "select * from board order by board_no asc";
		
		return jdbcTemplate.query(sql, boardListMapper);
	}

	@Override
	public boolean delete(int boardNo) {//삭제
		String sql = "delete board where board_no = ?";
		Object[] data = {boardNo};
		return jdbcTemplate.update(sql, data)>0;
	}

	@Override
	public boolean edit(BoardDto boardDto) {//수정
		String sql = "update board set board_title=?, board_content=? where board_no=?";
		Object[] data= {boardDto.getBoardTitle(), boardDto.getBoardContent(), boardDto.getBoardNo()};
		return jdbcTemplate.update(sql, data)>0;
	}

	// 정보게시판 목록 페이지 조회
	@Override
	public List<BoardDto> selectListByPage(int page) {
		int start = (page-1)*10 +1;
		int end = page*10;
		
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from("
					+ "SELECT "
					+ "m.member_nickname,"
					+ "bc.board_categoryweather,"
					+ "bc.board_area,"
					+ "b.board_no,"
					+ "b.board_writer,"
					+ "b.board_title,"
					+ "b.board_readcount,"
					+ "b.board_likecount,"
					+ "b.board_replycount,"
					+ "b.board_ctime"
					+ "FROM board b"
					+ "LEFT OUTER JOIN member m ON b.board_writer = m.member_id "
					+ "LEFT OUTER JOIN board_category bc ON b.board_category = bc.board_category"
					+ ")TMP"
				+ ")where rn between ? and ?";
		return jdbcTemplate.query(sql, boardListMapper,start,end);
	}
	
	//정보게시판 목록 페이지 검색 및 페이지 조회
	@Override
	public List<BoardDto> selectListByPage(String type, String keyword, int page) {
		int start = (page-1)*10 +1;
		int end = page*10;
		
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from("
					+ "SELECT "
					+ "m.member_nickname,"
					+ "bc.board_categoryweather,"
					+ "bc.board_area,"
					+ "b.board_no,"
					+ "b.board_writer,"
					+ "b.board_title,"
					+ "b.board_readcount,"
					+ "b.board_likecount,"
					+ "b.board_replycount,"
					+ "b.board_ctime"
					+ "FROM board b where instr("+type+",?) >0 "
					+ "LEFT OUTER JOIN member m ON b.board_writer = m.member_id "
					+ "LEFT OUTER JOIN board_category bc ON b.board_category = bc.board_category"
					+ ")TMP"
				+ ")where rn between ? and ?";
		Object[] data = {keyword,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		
	}
	
	//정보게시판 목록 조회(검색,페이지)(VO로 간단히)
	@Override
	public List<BoardDto> selectListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			return selectListByPage(vo.getType(), vo.getKeyword(), vo.getPage());
		}
		else return selectListByPage(vo.getPage());
	}


	

}
