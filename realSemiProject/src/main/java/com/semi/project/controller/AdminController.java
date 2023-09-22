package com.semi.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.semi.project.dao.BoardDao;
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.vo.PaginationVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping("/member/list")
	public String memberList(Model model,
					@ModelAttribute(name="vo") PaginationVO vo) {
		int count = memberDao.countList(vo);
		vo.setCount(count);
		
		List<MemberDto> memberList = memberDao.selectMemberListByPage(vo);
		model.addAttribute("memberList", memberList);
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	
	@RequestMapping("/member/detail")
	public String memberDetail(Model model, 
					@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		
		//멤버 프로필 보기
		Integer attachNo = memberDao.findProfile(memberId);
		model.addAttribute("attachNo", attachNo);
		
		//멤버 활동내역 보기(멤버가 쓴 글 리스트 불러오기)
		List<BoardListDto> boardList = memberDao.findWriteListByMemberId(memberId);
		model.addAttribute("boardList", boardList);
		
		
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	
}