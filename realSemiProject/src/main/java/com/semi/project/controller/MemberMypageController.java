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
			return "redirect:login?error";
		}
		
		boolean isCorrect = inputDto.getMemberPw().equals(findDto.getMemberPw());
		if(isCorrect) { //비밀번호가 일치하면
			session.setAttribute("name", findDto.getMemberId());
			session.setAttribute("level", findDto.getMemberLevel());
			return "redirect:mypage";
		}
		else { //비밀번호가 일치하지 않으면
			return "redirect:login?error"; //나중에 param으로 바꿀 것임
		}
	}
	
	
	@RequestMapping("/mypage") //마이페이지
	public String mypage(Model model, HttpSession session) {
		
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		model.addAttribute("memberDto", memberDto);

		return "/WEB-INF/views/member/mypage.jsp";
	}
	
	@GetMapping("/infoChange") //개인정보변경
	public String infochange(Model model, HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/infoChange.jsp";
	}
	@PostMapping("/infoChange")
	public String infochange(@ModelAttribute MemberDto inputDto,
								HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		MemberDto findDto = memberDao.selectOne(memberId);
		if(inputDto.getMemberPw().equals(findDto.getMemberPw())) {
			memberDao.updateMemberInfo(inputDto);
			return "redirect:mypage";
		}
		else {
			return "redirect:infoChange?error";
		}
		
	}
	
	@GetMapping("/pwChange") //비밀번호변경
	public String pwChange() {
		return "/WEB-INF/views/member/pwChange.jsp";
	}
	
	@PostMapping("/pwChange")
	public String pwChange(HttpSession session, 
							String originPw, String changePw) {
		
		String memberId = (String)session.getAttribute("name");
		MemberDto findDto = memberDao.selectOne(memberId);
		
		if(originPw.equals(findDto.getMemberPw())) { //비밀번호가 일치하면
			memberDao.updateMemberPw(memberId, changePw);
			return "/WEB-INF/views/member/pwChangeFinish.jsp";
		}
		else { //비밀번호가 일치하지 않으면
			return "redirect:pwChange?error";
		}
	}
	
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
			return "redirect:exitFinish";
		}
		else {
			return "redirect:exit?error";
		}
	}
	@RequestMapping("/exitFinish")
	public String extiFinish() {
		return "/WEB-INF/views/member/exitFinish.jsp";		
	}
	
	@RequestMapping("/myWriteList")
	public String myWriteList(HttpSession session, Model model) {
		
		String memberId = (String) session.getAttribute("name");
		model.addAttribute("myWriteList", memberDao.findWriteListByMemberId(memberId));
		
		return "/WEB-INF/views/member/myWriteList.jsp";				
	}
	
	@RequestMapping("/myLikeList")
	public String myLikeList(HttpSession session, Model model) {
		
		String memberId = (String) session.getAttribute("name");
		model.addAttribute("myLikeList", memberDao.findLikeListByMemberId(memberId));
		
		return "/WEB-INF/views/member/myLikeList.jsp";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("name");
		session.removeAttribute("level");
		return "redirect:/";
	}
	
}
