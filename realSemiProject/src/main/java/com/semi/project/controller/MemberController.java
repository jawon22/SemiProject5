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

import com.semi.project.component.CertCodeRandom;
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.StatDto;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private CertCodeRandom certCodeRandom;
	
	
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
	public String findPw() {
		return "/WEB-INF/views/member/searchPw.jsp";
	}
	
	@PostMapping("/searchPw")
	public String searchPw(@ModelAttribute MemberDto memberDto) {
		//아이디로 회원 정보 검색
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		//아이디가 존재하고, 회원의 이메일과 입력한 이메일이 맞는지 확인
		boolean isValid = findDto != null && findDto.getMemberEmail()
														.equals(memberDto.getMemberEmail());
		
		if(isValid) {
			//임시 비밀번호 생성
			String certCode = certCodeRandom.generatePassword();
			//회원 이메일 가져오기
			String memberEmail = findDto.getMemberEmail();
			
			//회원 이메일로 임시 비밀번호 전송
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(memberEmail);
			message.setSubject("[TRIPEE] 임시 비밀번호");
			message.setText("임시 비밀번호 : " + certCode);
			sender.send(message);
			
			//회원 비밀번호 변경
			memberDao.updateMemberPw(findDto.getMemberId(), certCode);
			
			return "redirect:searchPwFinish";
		}
		return "redirect:searchPw?error";

	}
	@RequestMapping("/searchPwFinish")
	public String searchPwFinish() {
		return "/WEB-INF/views/member/searchPwFinish.jsp";
	}
	
}
