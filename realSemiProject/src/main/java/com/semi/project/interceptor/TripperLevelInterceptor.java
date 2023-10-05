package com.semi.project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.semi.project.error.AuthorityException;

// 정보게시판 페이지 글 작성 제한 (관리자,Tripper)외 차단 인터셉터

@Component
public class TripperLevelInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 현재 사용자의 등급 확인
		HttpSession session = request.getSession();
		String memberLevel = (String) session.getAttribute("level");
		
		// 카테고리 번호 가져오기
		Integer categoryNo = Integer.parseInt(request.getParameter("boardCategory"));
		
		// 등급이 null아니고 관리자 또는 tripper 회원일 경우에만 정보게시판 들어오는 조건
		boolean isPass= memberLevel.equals("tripper") ||  memberLevel.equals("관리자")
				|| (memberLevel.equals("beginner") && (categoryNo.equals(42) || categoryNo.equals(41)));
		
		if(memberLevel !=null && isPass) {
			return true;
		}
		else throw new AuthorityException("관리자 또는 우수회원이 아닙니다");
		
	}
	
}
