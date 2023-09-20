package com.semi.project.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class CertDto {
	private String certEmail;
	private String certCode;
	private Date certTime;
}
