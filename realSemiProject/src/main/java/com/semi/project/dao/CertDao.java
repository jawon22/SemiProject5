package com.semi.project.dao;

import com.semi.project.dto.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean delete(String certEmail);
	boolean deleteOver5min();
	CertDto selectOne(String certEmail);
	CertDto selectOneIn5min(String certEmail);
}
