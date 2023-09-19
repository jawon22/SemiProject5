package com.semi.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.semi.project.dao.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	
//	@PostMapping("/join")
//	@RequestMapping("/joinFinish")
//	
//	@GetMapping("/login")
//	@PostMapping("/login")
//	
//	@GetMapping("/searchId")
//	@PostMapping("/searchId")
//	@RequestMapping("/searchIdFinish")
//	
//	@GetMapping("/searchPw")
//	@PostMapping("/searchPw")
//	@RequestMapping("/searchPwFinish")
}
