package com.semi.project.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.QnaNoticeDto;

@Repository
public class QnaNoticeDaoImpl implements QnaNoticeDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public int sequence() {
		String sql = "select qnanotice_seq.nextvala from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(QnaNoticeDto qnaNoticeDto) {
		String sql = "insert into qnanotice("
				+ "qnanotice_no, qnanotice_title, qnanotice_content,"
				+ "qnanotice_group, qnanotice_parent, qnanotice_depth"
				+ ") values(?, ?, ?, ?, ?, ?)";
		Object[] data = {
				qnaNoticeDto.getQnaNoticeNo(), qnaNoticeDto.getQnaNoticeTitle(),
				qnaNoticeDto.getQnaNoticeContent(), qnaNoticeDto.getQnaNoticeGroup(), 
				qnaNoticeDto.getQnaNoticeParent(), qnaNoticeDto.getQnaNoticeDepth()
		};
		jdbcTemplate.update(sql, data);
	}
	
}
