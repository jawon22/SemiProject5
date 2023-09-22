package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.BlockListDto;

@Component
public class BlockListMapper implements RowMapper<BlockListDto>{

	@Override
	public BlockListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BlockListDto blockListDto = new BlockListDto();
		blockListDto.setMemberId(rs.getString("member_id"));
		blockListDto.setBlockTime(rs.getDate("block_time"));
		blockListDto.setMemberNickname(rs.getString("member_nickname"));
		blockListDto.setMemberLevel(rs.getString("member_level"));
		return blockListDto;
	}

}
