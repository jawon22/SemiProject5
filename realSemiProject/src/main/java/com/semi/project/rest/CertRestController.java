package com.semi.project.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.CertDao;

@CrossOrigin
@RestController
@RequestMapping("/rest/cert")
public class CertRestController {
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private JavaMailSender sender;
	
//	@Autowired
//	private CertCodeRandom certCodeRandom;
	
	
//	@PostMapping("/send")
//	public void send(@RequestParam String certEmail) {
//		
//		
//	}
}
