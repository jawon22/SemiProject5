package com.semi.project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import com.semi.project.error.AuthorityException;

// 관리자 외의 접근을 차단하는 인터셉터
@Component
public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//세션에 있는 항목에 관리자인지 확인
		HttpSession session = request.getSession();
		String memberLevel = (String) session.getAttribute("level");
		
		if(memberLevel.equals("관리자") && memberLevel !=null) {
			return true;
		}
		else throw new AuthorityException("관리자가 아닙니다");
	}
	
}
