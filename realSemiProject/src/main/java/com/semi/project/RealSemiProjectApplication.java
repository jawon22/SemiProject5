package com.semi.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

//스케줄러 설정
@EnableScheduling
@SpringBootApplication
public class RealSemiProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(RealSemiProjectApplication.class, args);
	}

}
