package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.StatDto;

@Component
public class StatMapper implements RowMapper<StatDto>{

	@Override
	public StatDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		StatDto statDto = new StatDto();
		statDto.setName(rs.getString("name"));
		statDto.setCnt(rs.getInt("cnt"));
		return statDto;
	}

}
