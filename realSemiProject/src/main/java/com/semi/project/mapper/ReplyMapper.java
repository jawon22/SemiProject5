package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.ReplyDto;

@Component
public class ReplyMapper implements RowMapper<ReplyDto>{

	@Override
	public ReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReplyDto replyDto = new ReplyDto();
		replyDto.setReplyNo(rs.getInt("reply_no"));
		replyDto.setReplyWriter(rs.getString("reply_writer"));
		replyDto.setReplyOrigin(rs.getInt("reply_origin"));
		replyDto.setReplyContent(rs.getString("reply_content"));
		replyDto.setReplyTime(rs.getDate("reply_time"));
		replyDto.setBoardGroup(rs.getInt("board_Group"));
		replyDto.setBoardParent(rs.getInt("board_parent"));
		replyDto.setBoardDepth(rs.getInt("board_depth"));
		return replyDto;
	}

}
