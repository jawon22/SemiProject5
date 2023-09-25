package com.semi.project.controller;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.semi.project.dao.BoardDao;
import com.semi.project.dao.MemberDao;
import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.BoardReportDto;
import com.semi.project.dto.MemberDto;
import com.semi.project.service.BoardService;
import com.semi.project.dto.ReportDto;
import com.semi.project.dto.ReportListDto;
import com.semi.project.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	private BoardService boardService;
	
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
		boardDao.readcountEdit(boardDto.getBoardReadcount(), boardNo);
		boardDto = boardDao.selectOne(boardNo);
		Integer attachNo = memberDao.findProfile(boardDto.getBoardWriter());
		model.addAttribute("attachNo", attachNo);
		model.addAttribute("boardDto", boardDto);
		return "/WEB-INF/views/board/detail.jsp";
	}

	
	
	@GetMapping("/write")
	public String write(Model model, 
	                    @RequestParam(required = false) Integer boardParent,
	                    @RequestParam(required = false) Integer boardCategory,
	                    HttpSession session) {
		/*
		 * // 답글이라면 원본글 정보를 화면에 전달 if (boardParent != null) { BoardDto originDto =
		 * boardDao.selectOne(boardParent); model.addAttribute("originDto", originDto);
		 * model.addAttribute("isReply", true); } else { model.addAttribute("isReply",
		 * false); }
		 */
	    
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
	public String write(@ModelAttribute BoardDto boardDto, 
			HttpSession session
	/* , MemberDto memberDto */
			, @RequestParam(required = false) List<Integer> attachmentNo,
			RedirectAttributes attr
			) {
		
	    String memberId = (String) session.getAttribute("name");
	    boardDto.setBoardWriter(memberId);
	
	    
	    //boardDto.setBoardNo(boardNo1);
	    //boardDto.setBoardCategory(boardDto.getBoardCategory()); // 이미 모델에 설정되어 있음
	    
		//이 사용자의 마지막 글번호를 조회
		Integer lastNo = boardDao.selectMax(memberId);

		System.out.println(lastNo);
		
	    // 글을 등록
	    //boardDao.insert(boardDto);
		int boardNo = boardService.write(boardDto, attachmentNo); 
	    attr.addAttribute("boardNo", boardNo);
	
		//포인트 계산 작업
		//- lastNo가 null이라는 것은 처음 글을 작성했다는 의미
		//- lastNo가 null이 아니면 조회한 다음 시간차를 비교
		if(lastNo == null) {//처음이라면
			memberDao.increaseMemberPoint(memberId, 100);//100점 부여
		}
		else {//처음이 아니라면 시간 차이를 계산
			BoardDto lastDto = boardDao.selectOne(lastNo);
			Timestamp stamp = new Timestamp(
								lastDto.getBoardCtime().getTime());
			LocalDateTime lastTime = stamp.toLocalDateTime();
			LocalDateTime currentTime = LocalDateTime.now();
			
			Duration duration = Duration.between(lastTime, currentTime);
			long seconds = duration.getSeconds();
			if(seconds > 300) {//시간차가 300초보다 크다면(5분 초과)
				memberDao.increaseMemberPoint(memberId, 100);//100점 부여
			}
		}
	    
	    //상세페이지로
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
	
	//관리자가 이용하는 선택삭제 기능
	@PostMapping("/deleteByAdmin")
	public String deleteByAdmin(@RequestParam List<Integer> boardNoList) {
		for(int boardNo : boardNoList) {
			boardDao.delete(boardNo);
		}
		return "redirect:list";
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
	
	//게시글 신고 등록
	@RequestMapping("/report/board")
	public String report(@RequestParam("boardNo") int boardNo,
									@RequestParam("reportReason") String reportReason) {
		
		ReportDto reportDto = new ReportDto();
		int reportNo = boardDao.reportSequence();
		reportDto.setReportNo(reportNo);
		reportDto.setReportReason(reportReason);
		boardDao.insertReport(reportDto);
		
		BoardReportDto boardReportDto = new BoardReportDto();
		boardReportDto.setReportNo(reportNo);
		boardReportDto.setBoardNo(boardNo);
		boardReportDto.setBoardWriter(boardReportDto.getBoardWriter());
		boardDao.insertBoardReport(boardReportDto);
		
		return "redirect:/board/detail?boardNo=" + boardNo;
	}
	
}
