package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BoardLikeDto;
import com.semi.project.mapper.BoardLikeMapper;

@Repository
public class BoardLikeDaoImpl implements BoardLikeDao{

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	BoardLikeMapper boardLikeMapper;
	
	@Override
	public void insert(BoardLikeDto boardLikeDto) {
		String sql = "insert into board_like(member_id, board_no) values(?, ?)";
		Object[] data = {boardLikeDto.getMemberId(), boardLikeDto.getBoardNo()};
		jdbcTemplate.update(sql, data);
		
	}

	@Override
	public boolean delete(BoardLikeDto boardLikeDto) {
		String sql = "delete board_like where member_id=? and board_no=?";
		Object[] data = {boardLikeDto.getMemberId(), boardLikeDto.getBoardNo()};
		
		return jdbcTemplate.update(sql, data)>0;
	}

	@Override
	public boolean check(BoardLikeDto boardLikeDto) {
		String sql = "select * from board_like where member_id=? and board_no=?";
		Object[] data= {boardLikeDto.getMemberId(), boardLikeDto.getBoardNo()};
		List<BoardLikeDto> list = jdbcTemplate.query(sql, boardLikeMapper, data);
		return list.isEmpty() ? false : true;
	}

}
