package com.semi.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
	public String searchId(@RequestParam String memberEmail, Model model) {
		MemberDto memberDto = new MemberDto();
		memberDto = memberDao.selectEmailByMemberId(memberEmail);
		model.addAttribute("memberDto", memberDto);
		
		if(memberDto != null) {
			return "redirect:searchIdFinish";
		}else {
			return "redirect:searchId?error";
		}
	}
	
	@RequestMapping("/searchIdFinish")
	public String searIdFinish(Model model) {
		MemberDto memberDto = (MemberDto) model.getAttribute("memberDto");
		
		if(memberDto != null) {
			String memberId = memberDto.getMemberId();
			model.addAttribute("searchId", memberId);
		}else {
			model.addAttribute("notSearchId", "회원을 찾을 수 없습니다.");
		}
		
		return "/WEB-INF/views/member/searchIdFinish.jsp";
	}
//	
//	@GetMapping("/searchPw")
//	@PostMapping("/searchPw")
//	@RequestMapping("/searchPwFinish")
}
