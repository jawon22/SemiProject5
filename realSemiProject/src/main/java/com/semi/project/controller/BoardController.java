package com.semi.project.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;

import com.semi.project.dao.AttachmentDao;
import com.semi.project.dao.BoardDao;
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	AttachmentDao attachmentDao;
	
	@RequestMapping("/list") // 정보게시판 리스트
	public String list(@ModelAttribute(name="vo") PaginationVO vo, Model model) {
		int count = boardDao.countList(vo);
		vo.setCount(count);
		
		List<BoardListDto> list =  boardDao.selectListByPage(vo);
	
		model.addAttribute("list",list);
		return "/WEB-INF/views/board/list.jsp";
	}
	
	@RequestMapping("/readcount") // 정보게시판 조회수순 리스트
	public String listReadcount(@ModelAttribute(name="vo") PaginationVO vo, Model model) {
		int count = boardDao.countList(vo);
		vo.setCount(count);
		
		List<BoardListDto> list =  boardDao.selectListByReadcount(vo);
		model.addAttribute("list",list);

		if(vo.isSearch()) {
			return "redirect:?weather="+vo.getWeather()+"&area="+vo.getArea()
				+"&type="+vo.getType()+"&keyword="+vo.getKeyword();
		}
		
		return "/WEB-INF/views/board/list.jsp";
	}
	
	@RequestMapping("/likecount") // 정보게시판 좋아요순 리스트
	public String listLikecount(@ModelAttribute(name="vo") PaginationVO vo, Model model) {
		int count = boardDao.countList(vo);
		vo.setCount(count);
		
		List<BoardListDto> list =  boardDao.selectListByLikecount(vo);
		model.addAttribute("list",list);
		
		if(vo.isSearch()) {
			return "redirect:?weather="+vo.getWeather()+"&area="+vo.getArea()
				+"&type="+vo.getType()+"&keyword="+vo.getKeyword();
		}
		
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
			/* @RequestParam MultipartFile attachment, */
	                    HttpSession session) throws IllegalStateException, IOException {
		int no = boardDao.sequence();
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
	    
		/*
		 * if(!attach.isEmpty()) { //첨부파일등록(파일이 있을때만) int attachNo =
		 * attachmentDao.sequence();
		 * 
		 * String home = System.getProperty("user.home"); File dir = new File(home,
		 * "upload"); dir.mkdirs(); File target = new File(dir,
		 * String.valueOf(attachNo)); attach.transferTo(target);
		 * 
		 * AttachmentDto attachDto = new AttachmentDto();
		 * attachDto.setAttachmentNo(attachNo);
		 * attachDto.setAttachmentName(attach.getOriginalFilename());
		 * attachDto.setAttachmentSize(attach.getSize());
		 * attachDto.setAttachmentType(attach.getContentType());
		 * attachmentDao.insert(attachDto);
		 * 
		 * //연결(파일이 있을때만) boardDao.connect(no, attachNo); }
		 */

	    return "/WEB-INF/views/board/write.jsp";
	}


	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto, HttpSession session, 
			MemberDto memberDto
	/* ,@RequestParam MultipartFile attachment */
			) throws IllegalStateException, IOException {
	    int boardNo = boardDao.sequence();
	    
	    boardDto.setBoardNo(boardNo);
	    //boardDto.setBoardCategory(boardDto.getBoardCategory()); // 이미 모델에 설정되어 있음

	    String memberId = (String) session.getAttribute("name");
	    boardDto.setBoardWriter(memberId);
	    
	    //첨부파일 등록
	    int no = boardDao.sequence();
	    int attachmentNo = attachmentDao.sequence();
	    
	    String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		dir.mkdirs();
		File target = new File(dir, String.valueOf(attachmentNo));
		attachment.transferTo(target);
		
		AttachmentDto attachmentDto = new AttachmentDto();
		attachmentDto.setAttachmentNo(attachmentNo);
		attachmentDto.setAttachmentName(attachment.getOriginalFilename());
		attachmentDto.setAttachmentSize(attachment.getSize());
		attachmentDto.setAttachmentType(attachment.getContentType());
		attachmentDao.insert(attachmentDto);
		
		//연결(파일이 있을때만)
		boardDao.connect(no, attachmentNo);	    		
	    		
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
	
}
