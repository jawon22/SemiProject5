package com.semi.project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.semi.project.dao.BoardDao;
import com.semi.project.dao.CertDao;
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.ExpiredListDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberMypageController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private CertDao certDao;
	
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto,
										HttpSession session, Model model) {
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		
		if(findDto == null) { //회원정보가 없으면
			return "redirect:login?error";
		}
		
		boolean isCorrect = inputDto.getMemberPw().equals(findDto.getMemberPw());
		if(isCorrect) { //비밀번호가 일치하면
			session.setAttribute("name", findDto.getMemberId());
			session.setAttribute("level", findDto.getMemberLevel());
			
			memberDao.updateMemberLogin(findDto.getMemberId());
			ExpiredListDto expiredListDto =  memberDao.findMemberExpiredList(findDto.getMemberId());
			
			//비밀번호 변경 90일 경과한 회원
			if(expiredListDto.getIsExpired().equals("Y")) {
				return "redirect:login?expire";
			}
			
			return "redirect:/";
		}
		else { //비밀번호가 일치하지 않으면
			return "redirect:login?error"; //나중에 param으로 바꿀 것임
		}
	}
	
	@RequestMapping("/delay")
	public String delay(HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		memberDao.updateMemberPwDelay(memberId);
		return "redirect:/";
	}
	
	@RequestMapping("/mypage") //마이페이지
	public String mypage(Model model, HttpSession session, 
			@ModelAttribute(name="vo") PaginationVO vo) {
		
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		ExpiredListDto expiredListDto =  memberDao.findMemberExpiredList(memberId);
		
		model.addAttribute("expiredListDto", expiredListDto);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("profile", memberDao.findProfile(memberId));
		
		//내가쓴글
		model.addAttribute("myWriteList", memberDao.findWriteListByMemberId(vo, memberId));
		model.addAttribute("myLikeList", memberDao.findLikeListByMemberId(vo, memberId));
		
		
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
			
			String memberEmail = findDto.getMemberEmail();
			if(certDao.selectOne(memberEmail) != null) {
				certDao.delete(memberEmail);
			}
			
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
		
		log.debug(findDto.getMemberPw());
		
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
	public String myWriteList(HttpSession session, Model model, 
			@ModelAttribute(name="vo") PaginationVO vo) {
		
		String memberId = (String) session.getAttribute("name");

		int count = memberDao.countListMyWriteList(vo, memberId);
		vo.setCount(count);
		
//		log.debug("count = {}", count);
		model.addAttribute("boardDto", memberDao.findWriteListByMemberId(vo, memberId));
		
		return "/WEB-INF/views/member/myWriteList.jsp";				
	}
	
	@RequestMapping("/myLikeList")
	public String myLikeList(HttpSession session, Model model, 
			@ModelAttribute(name="vo") PaginationVO vo) {
		
		String memberId = (String) session.getAttribute("name");
		
		int count = memberDao.countListMyLikeList(vo, memberId);
		vo.setCount(count);
		model.addAttribute("boardDto", memberDao.findLikeListByMemberId(vo, memberId));
		
		return "/WEB-INF/views/member/myLikeList.jsp";
	}
	
	@RequestMapping("/myReplyList")
	public String myReplyList(HttpSession session, Model model, 
			@ModelAttribute(name="vo") PaginationVO vo) {
		
		String memberId = (String) session.getAttribute("name");
		
		int count = memberDao.countListMyReplyList(vo, memberId);
		vo.setCount(count);
		model.addAttribute("boardDto", memberDao.findReplyListByMemberId(vo, memberId));

		
		return "/WEB-INF/views/member/myReplyList.jsp";
	}
	
	@RequestMapping("/myQnaList")
	public String myQnaList(HttpSession session, Model model, 
			@ModelAttribute(name="vo") PaginationVO vo) {
		
		String memberId = (String) session.getAttribute("name");
		
		int count = memberDao.countListMyQnaList(vo, memberId);
		vo.setCount(count);
		model.addAttribute("qnaNoticeDto", memberDao.findQnaListByMemberId(vo, memberId));
		model.addAttribute("memberDto", memberDao.selectOne(memberId));
		
		return "/WEB-INF/views/member/myQnaList.jsp";
	}
	
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("name");
		session.removeAttribute("level");
		return "redirect:/";
	}

}
