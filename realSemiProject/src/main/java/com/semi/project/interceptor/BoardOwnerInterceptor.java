package com.semi.project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.semi.project.dao.BoardDao;
import com.semi.project.dto.BoardDto;
import com.semi.project.error.AuthorityException;

//게시글 소유자인 경우만 통과시키는 인터셉터
//필요한 정보: 게시글 번호(파라미터), 사용자 ID(세션)

@Component
public class BoardOwnerInterceptor implements HandlerInterceptor{
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//현재 사용자의 아이디 세션에서 가져오기
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("name");
		
		//글 번호 가져오기
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDto boardDto = boardDao.selectOne(boardNo);
		
		if(boardDto.getBoardWriter().equals(memberId)) {
			return true;
		}
		else {
			throw new AuthorityException("글 소유자가 아닙니다");
		}
	}

}
