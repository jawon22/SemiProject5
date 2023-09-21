package com.semi.project.dto;

import lombok.Data;

@Data
public class AttachmentDto {
	
	private int attachmentNo;
	private String attachmentName, attachmentType;
	private long attachmentSize;
	
}
