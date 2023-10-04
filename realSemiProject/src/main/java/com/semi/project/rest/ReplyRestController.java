package com.semi.project.rest;

import java.lang.reflect.Member;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.BoardDao;
import com.semi.project.dao.MemberDao;
import com.semi.project.dao.ReplyDao;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.ReplyDto;
import com.semi.project.vo.ReplyDataVo;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private BoardDao boardDao;
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		int replyNo = replyDao.sequence();
		replyDto.setReplyNo(replyNo);
		String memberId = (String) session.getAttribute("name");
		replyDto.setReplyWriter(memberId);
		replyDao.insert(replyDto);
		boardDao.updateBoardReplyCount(replyDto.getReplyOrigin());
	}
	
	@PostMapping("/list")
	public ReplyDataVo list(@RequestParam int replyOrigin, HttpSession session) {
		ReplyDataVo dataVo  =  new ReplyDataVo();
		
		ReplyDto replyDto = replyDao.selectOneByRlplyOrigin(replyOrigin);
		String replyWriter = replyDto.getReplyWriter();
		
		List<String> nicknameList = memberDao.selectListByMemberNick(replyOrigin);
		
		List<ReplyDto> replyList = replyDao.selectList(replyOrigin);
		dataVo.setList(replyList);
		dataVo.setMemberNickname(nicknameList);
		return dataVo;
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int replyNo) {
		ReplyDto replyDto = replyDao.selectOne(replyNo);
		replyDao.delete(replyNo);
		boardDao.updateBoardReplyCount(replyDto.getReplyOrigin());
	}
	
	@PostMapping("/edit")
	public void edit(@ModelAttribute ReplyDto replyDto) {
		replyDao.update(replyDto);
	}
}
