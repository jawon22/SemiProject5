package com.semi.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.semi.project.dao.MemberDao;
import com.semi.project.dto.MemberDto;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender sender;
	
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:joinFinish";
	}
	
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
	
	@GetMapping("/searchId")
	public String searchId() {
		return "/WEB-INF/views/member/searchId.jsp";
	}
	
	@PostMapping("/searchId")
	public String searchId(@RequestParam String inputEmail, HttpSession session) {
		MemberDto memberId = memberDao.selectIdByMemberEmail(inputEmail);

		if (memberId != null) {
	        //return "redirect:searchIdFinish?memberId=" + memberId.getMemberId();
			session.setAttribute("memberId", memberId.getMemberId());
	    } 
		return "redirect:searchIdFinish";
	}
	
	@RequestMapping("/searchIdFinish")
	public String searchIdFinish(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		model.addAttribute("memberId", memberId);
		
		session.removeAttribute(memberId);
		
		return "/WEB-INF/views/member/searchIdFinish.jsp";
	}
	
	@GetMapping("/searchPw")
	public String searchPw() {
		return "/WEB-INF/views/member/searchPw.jsp";
	}
	
//	@PostMapping("/searchPw")
//	public String searchPw(@ModelAttribute MemberDto memberDto) {
//	
//	}
	
//	@PostMapping("/searchPw")
//	@RequestMapping("/searchPwFinish")
}
