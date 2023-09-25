package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.QnaNoticeDto;

@Component
public class QnaNoticeListMapper implements RowMapper<QnaNoticeDto> {
	@Override
	public QnaNoticeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		QnaNoticeDto qnaNoticeDto = new QnaNoticeDto();
		qnaNoticeDto.setMemberId(rs.getString("member_id"));
		qnaNoticeDto.setQnaNoticeNo(rs.getInt("qnanotice_no"));
		qnaNoticeDto.setQnaNoticeTitle(rs.getString("qnanotice_title"));
		qnaNoticeDto.setQnaNoticeType(rs.getInt("qnanotice_type"));
		qnaNoticeDto.setQnaNoticeSecret(rs.getString("qnanotice_secret"));
		qnaNoticeDto.setQnaNoticeTime(rs.getDate("qnanotice_time"));
		qnaNoticeDto.setQnaNoticeGroup(rs.getInt("qnanotice_group"));
		qnaNoticeDto.setQnaNoticeParent(rs.getInt("qnanotice_parent"));
		qnaNoticeDto.setQnaNoticeDepth(rs.getInt("qnanotice_depth"));
		return qnaNoticeDto;
	}
}
