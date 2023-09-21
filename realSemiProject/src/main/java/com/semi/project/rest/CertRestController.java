package com.semi.project.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.component.CertCodeRandom;
import com.semi.project.dao.CertDao;
import com.semi.project.dto.CertDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/cert")
public class CertRestController {
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private CertCodeRandom certCodeRandom;
	
	
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) {
		String certCode = certCodeRandom.generatePassword();
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(certEmail);
		message.setSubject("[TIPEE] 임시 비밀번호");
		message.setText("임시 비밀번호 : " + certCode);
		sender.send(message);
		
		certDao.delete(certEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(certEmail);
		certDto.setCertCode(certCode);
		certDao.insert(certDto);
	}
	
	@PostMapping("/check")
	public Map<String, Object> check(@ModelAttribute CertDto certDto){
		CertDto findDto = certDao.selectOneIn5min(certDto.getCertEmail());
		
		if(findDto != null) {
			boolean isValid = findDto.getCertCode().equals(certDto.getCertCode());
			if(isValid) {
				certDao.delete(certDto.getCertEmail());
				return Map.of("result", true);
			}
		}
		return Map.of("result", false);
	}
}
