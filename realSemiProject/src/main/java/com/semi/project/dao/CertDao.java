package com.semi.project.dao;

import com.semi.project.dto.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean delete(String certEmail);
	CertDto selectOne(String certEmail);
}
