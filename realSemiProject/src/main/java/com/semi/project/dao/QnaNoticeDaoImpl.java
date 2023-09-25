package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.mapper.AttachmentMapper;
import com.semi.project.mapper.QnaNoticeMapper;

@Repository
public class QnaNoticeDaoImpl implements QnaNoticeDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AttachmentMapper attachmentMapper;
	
	@Autowired
	private QnaNoticeMapper qnaNoticeMapper;
	
	@Override
	public int sequence() {
		String sql = "select qnanotice_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(QnaNoticeDto qnaNoticeDto) {
		String sql = "insert into qnanotice("
				+ "qnanotice_no, qnanotice_title, qnanotice_content, member_id, "
				+ "qnanotice_type, qnanotice_group, qnanotice_parent, qnanotice_depth"
				+ ") values(?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				qnaNoticeDto.getQnaNoticeNo(), qnaNoticeDto.getQnaNoticeTitle(),
				qnaNoticeDto.getQnaNoticeContent(), qnaNoticeDto.getMemberId(),
				qnaNoticeDto.getQnaNoticeType(), qnaNoticeDto.getQnaNoticeGroup(), 
				qnaNoticeDto.getQnaNoticeParent(), qnaNoticeDto.getQnaNoticeDepth()
		};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public void connect(int attachmentNo, int qnaNoticeNo) {
			String sql = "insert into qna_attach values(?, ?)";
			Object[] data = {attachmentNo, qnaNoticeNo};
			jdbcTemplate.update(sql, data);
	}
	
	@Override
	public AttachmentDto findImage(int qnaNoticeNo) {
		String sql = "select * from attachment where attachment_no = ("
				+ "select attachment_no from qna_attach "
				+ "where qnanotice_no = ?)";
		Object[] data = {qnaNoticeNo};
		List<AttachmentDto> list = jdbcTemplate.query(sql, attachmentMapper, data);
		return list.isEmpty() ? null : list.get(0);			

	}
	
	@Override
	public QnaNoticeDto selectOne(int qnaNoticeNo) {
		String sql = "select q.*, qa.attachment_no from "
				+ "qnanotice q left outer join qna_attach qa "
				+ "on q.qnanotice_no = qa.qnanotice_no "
				+ "where q.qnanotice_no = ?";
		Object[] data = {qnaNoticeNo};
		List<QnaNoticeDto> list = jdbcTemplate.query(sql, qnaNoticeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
