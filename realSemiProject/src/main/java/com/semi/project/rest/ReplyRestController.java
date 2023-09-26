package com.semi.project.rest;

import java.lang.reflect.Member;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.MemberDao;
import com.semi.project.dao.ReplyDao;
import com.semi.project.dto.ReplyDto;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private MemberDao memberDao;
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		int replyNo = replyDao.sequence();
		replyDto.setReplyNo(replyNo);
		String memberId = (String) session.getAttribute("name");
		replyDto.setReplyWriter(memberId);
		
		replyDao.insert(replyDto);
	}
	@PostMapping("/profile")
	public Integer profile(@RequestParam String memberId) {
		Integer attach = memberDao.findProfile(memberId);
		return attach;
	}
	
	@PostMapping("/list")
	public List<ReplyDto> list(@RequestParam int replyOrigin, HttpSession session) {
		List<ReplyDto> list = replyDao.selectList(replyOrigin);
		return list;
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int replyNo) {
		replyDao.delete(replyNo);
	}
	
	@PostMapping("/edit")
	public void edit(@ModelAttribute ReplyDto replyDto) {
		replyDao.update(replyDto);
	}
}
