package com.semi.project.controller;

import java.util.ArrayList;
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
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.BoardReportDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.dto.ReportDto;
import com.semi.project.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	MemberDao memberDao;
	
	
	@RequestMapping("/list") // 정보게시판 리스트
	public String list(@ModelAttribute(name="vo") PaginationVO vo, Model model,
	                   @RequestParam(name = "sort", required = false) String sort) {
		
	    int count = boardDao.countList(vo);
	    vo.setCount(count);

	    List<BoardListDto> list;

	    if ("readcount".equals(sort)) {
	        list = boardDao.selectListByReadcount(vo);
	    } else if ("likecount".equals(sort)) {
	        list = boardDao.selectListByLikecount(vo);
	    } else {
	        list = boardDao.selectListByPage(vo);
	    }
	    
	    model.addAttribute("list", list);

	    return "/WEB-INF/views/board/list.jsp";
	}
	
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int boardNo, Model model) {
		BoardDto boardDto = boardDao.selectOne(boardNo);
		model.addAttribute("boardDto", boardDto);
		return "/WEB-INF/views/board/detail.jsp";
	}

	
	
	@GetMapping("/write")
	public String write(Model model, 
	                    @RequestParam(required = false) Integer boardParent,
	                    @RequestParam(required = false) Integer boardCategory,
	                    HttpSession session) {
	    // 답글이라면 원본글 정보를 화면에 전달
	    if (boardParent != null) {
	        BoardDto originDto = boardDao.selectOne(boardParent);
	        model.addAttribute("originDto", originDto);
	        model.addAttribute("isReply", true);
	    } else {
	        model.addAttribute("isReply", false);
	    }
	    
	    // boardCategory가 null이 아닌 경우, 즉, 파라미터로 전달된 경우에만 설정
	    if (boardCategory != null) {
	        model.addAttribute("boardCategory", boardCategory);
	        // 여기에서 boardCategory를 boardDto에 설정
	        BoardDto boardDto = new BoardDto();
	        boardDto.setBoardCategory(boardCategory);
	        model.addAttribute("boardDto", boardDto);
	    }

	    return "/WEB-INF/views/board/write.jsp";
	}


	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto, HttpSession session, MemberDto memberDto) {
	    int boardNo = boardDao.sequence();
	    
	    boardDto.setBoardNo(boardNo);
	    //boardDto.setBoardCategory(boardDto.getBoardCategory()); // 이미 모델에 설정되어 있음

	    String memberId = (String) session.getAttribute("name");
	    boardDto.setBoardWriter(memberId);
	    
	    // 글을 등록
	    boardDao.insert(boardDto);
	    return "redirect:detail?boardNo=" + boardNo;
	}

	
	
	
    //삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int boardNo) {
		boolean result = boardDao.delete(boardNo);
		if(result) {
			return "redirect:list";
		}
		else {
			return "redirect:에러페이지";
			//throw new NoTargetException("없는 게시글 번호");
		}
	}
	
	
	
	//수정
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo, Model model) {
		BoardDto boardDto = boardDao.selectOne(boardNo);
		model.addAttribute("boardDto", boardDto);
		return "/WEB-INF/views/board/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto) {
		boolean result = boardDao.edit(boardDto);
		if(result) {
			return "redirect:detail?boardNo=" + boardDto.getBoardNo();
		}
		else {
			return "redirect:에러페이지";
			//throw new NoTargetException("존재하지 않는 글번호");
		}
	}
	
	//신고 등록
	@GetMapping("/report/board")
	public String report(@RequestParam ReportDto reportDto) {
		boardDao.insertReport(reportDto);
		
		BoardDto boardDto = new BoardDto();
		int boardNo = boardDto.getBoardNo();
		
		return "redirect:edit?boardNo=" + boardNo;
	}
		
	//게시글 신고 처리
	@PostMapping("/report/board")
	public String boardReport(@ModelAttribute BoardReportDto boardReportDto) {
		boardDao.insertBoardReport(boardReportDto);
		return "redirect:detail";
	}
	
}
