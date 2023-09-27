package com.semi.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.semi.project.dao.MemberDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RegularServiceImpl implements RegularService {
	
	@Autowired
	private MemberDao memberDao;
	
//	@Scheduled(fixedRate = 1000) //매일 오후6시
//	@Scheduled(cron = "0 0 18 * * *") //매일 오후6시
	@Override
	public void memberLevelUp() {
		memberDao.updateMemberLevel();
		log.debug("실행되니?");
	}

}
