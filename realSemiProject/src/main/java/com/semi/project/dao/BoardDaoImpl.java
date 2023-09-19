package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BoardDto;
import com.semi.project.mapper.BoardMapper;

@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	BoardMapper boardMapper;
	
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
		List<BoardDto> list = jdbcTemplate.query(sql, boardMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<BoardDto> selectList() {//리스트 조회
		String sql = "select * from board order by board_no asc";
		
		return jdbcTemplate.query(sql, boardMapper);
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

	

}
