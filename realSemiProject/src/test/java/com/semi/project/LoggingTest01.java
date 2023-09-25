package com.semi.project;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class LoggingTest01 {

	
	@Test
	public void test() {
		System.out.println("메세지");
		log.trace("메세지1");
		log.debug("메세지2");
		log.info("메세지3");
		log.warn("메세지4");
		log.error("메세지5");
	}
	
}
