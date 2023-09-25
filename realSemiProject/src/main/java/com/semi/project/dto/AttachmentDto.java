package com.semi.project.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AttachmentDto {
	
	private int attachmentNo;
	private String attachmentName, attachmentType;
	private long attachmentSize;
	
}
