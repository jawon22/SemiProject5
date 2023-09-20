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
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping("/list") // 정보게시판 리스트
	public String list(@ModelAttribute(name="vo") PaginationVO vo, Model model) {
//		int count = vo.isSearch() ? boardDao.countList(vo) : boardDao.countList();
//		vo.setCount(count);
		
		List<BoardListDto> list =boardDao.selectListByPage(vo);
		model.addAttribute("list",list);
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
                        @RequestParam(required = false) Integer boardParent) {
        // 답글이라면 원본글 정보를 화면에 전달
        if (boardParent != null) {
            BoardDto originDto = boardDao.selectOne(boardParent);
            model.addAttribute("originDto", originDto);
            model.addAttribute("isReply", true);
        } else {
            model.addAttribute("isReply", false);
        }
        return "/WEB-INF/views/board/write.jsp";
    }

    @PostMapping("/write")
    public String write(@ModelAttribute BoardDto boardDto, HttpSession session,
                        @RequestParam String boardCategory,
                        @RequestParam String boardTitle,
                        @RequestParam String boardContent) {
        int boardNo = boardDao.sequence();
        boardDto.setBoardNo(boardNo);
        String memberId = (String) session.getAttribute("name");
        boardDto.setBoardWriter(memberId);
        
        // boardCategory, boardTitle, boardContent 설정
        int category = Integer.parseInt(boardCategory);
        boardDto.setBoardCategory(category);
        boardDto.setBoardTitle(boardTitle);
        boardDto.setBoardContent(boardContent);

        // 글을 등록
        boardDao.insert(boardDto);

        return "redirect:detail?boardNo=" + boardNo;
    }

	//@RequestMapping("/delete")
	//@GetMapping("/edit")
	//@PostMapping("/edit")
	
}

















