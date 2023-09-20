package com.semi.project.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.semi.project.dto.CertDto;

@Component
public class CertMapper implements RowMapper<CertDto>{

	@Override
	public CertDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CertDto certDto = new CertDto();
		certDto.setCertEmail(rs.getString("cert_email"));
		certDto.setCertCode(rs.getString("cert_code"));
		certDto.setCertTime(rs.getDate("cert_time"));
		return certDto;
	}

}
