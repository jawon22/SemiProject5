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
			
			model.addAttribute("seasonList", seasonList);
			model.addAttribute("areaList", areaList);
			return "/WEB-INF/views/home.jsp";
		}
		
		
}
