package com.semi.project.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.semi.project.dao.MemberDao;

@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	
	@Autowired
	private MemberDao memberDao;
	
}
