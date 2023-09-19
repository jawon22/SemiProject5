package com.semi.project.controller;

import javax.servlet.http.HttpSession;

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
public class MemberMypageController {

	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto,
										HttpSession session) {
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		
		if(findDto == null) {
			return "오류페이지";
		}
		
		boolean isCorrect = inputDto.getMemberPw().equals(findDto.getMemberPw());
		if(isCorrect) { //비밀번호가 일치하면
			session.setAttribute("name", findDto.getMemberId());
			session.setAttribute("level", findDto.getMemberLevel());
			return "redirect:/";
		}
		else { //비밀번호가 일치하지 않으면
			return "오류페이지"; //나중에 param으로 바꿀 것임
		}
	}
	
	
	@RequestMapping("/mypage") //마이페이지
	public String mypage(Model model, HttpSession session) {
		
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		model.addAttribute("memberDto", memberDto);

		return "/WEB-INF/views/member/mypage.jsp";
	}
	
//	@GetMapping("/infoChange") //개인정보변경
//	public String infochange() {
//		
//	}
//	@PostMapping("/infoChange")
//	
//	@GetMapping("/pwChange") //비밀번호변경
//	@PostMapping("/pwChange")
//	
	@GetMapping("/exit") //탈퇴
	public String exit() {
		return "/WEB-INF/views/member/exit.jsp";
	}
	@PostMapping("/exit")
	public String exit(@RequestParam String inputPw,
									HttpSession session) {
		
		String memberId = (String)session.getAttribute("name");
		MemberDto findDto = memberDao.selectOne(memberId);
		
		if(inputPw.equals(findDto.getMemberPw())) {
			memberDao.delete(memberId);
			session.removeAttribute("name");			
			return "/WEB-INF/views/member/exitFinish.jsp";
		}
		else {
			return "redirect:exit?error";
		}
	}
	
}
