package com.semi.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.semi.project.dao.BoardDao;
import com.semi.project.dto.MainPageListDto;

@Controller
public class HomeController {
	
	@Autowired
	BoardDao boardDao;
	
	@RequestMapping("/")
	public String home(Model model) {
		
			List<MainPageListDto> seasonList = boardDao.selectListSeasonTop5();
			List<MainPageListDto> areaList = boardDao.selectListAreaTop5();
			
//		    for (BoardListDto dto : list) {
//		        int boardNo = dto.getBoardNo();
//		        
//		        // 대체할 데이터베이스 쿼리 (예시)
//		        int attachmentCount = boardDao.getAttachmentCount(boardNo);// 첨부 파일 갯수 계산
//
//		        dto.setAttachmentCount(attachmentCount);
//
//		        if (attachmentCount > 0) {
//		            // 대체할 데이터베이스 쿼리 (예시)
//		            int firstAttachmentNo = boardDao.getFirstAttachmentNo(boardNo); // 첫 번째 첨부 파일 번호 계산
//		            dto.setFirstAttachmentNo(firstAttachmentNo);
//		        }
//		    }
			
			model.addAttribute("seasonList", seasonList);
			model.addAttribute("areaList", areaList);
			return "/WEB-INF/views/home.jsp";
		}
		
		
}
