package com.semi.project.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "custom.fileupload")
public class CustomFileuploadProperties {
	private String path;
}
//게시판용 첨부파일 관련 그거