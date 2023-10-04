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

// 게시글 소유자인 경우와 level이 관리자인 경우에만 삭제 가능한 인터셉터
// 필요정보 게시글 번호(파라미터), 사용자 ID(세션), 사용자 level(세션)
@Component
public class BoardDetailDeleteInterceptor implements HandlerInterceptor{
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 현자 사용자의 아이디와 레벨을 가져오기
		HttpSession session = request.getSession();
		String memberLevel = (String) session.getAttribute("level");
		String memberId = (String) session.getAttribute("name");
		
		//글 번호 가져오기
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDto boardDto = boardDao.selectOne(boardNo);
		
		boolean isCorrect = boardDto.getBoardWriter().equals(memberId) || 
								(memberLevel.equals("관리자") && memberLevel !=null);
		
		if(isCorrect) return true;
		else {
			throw new AuthorityException("글 소유자 또는 관리자가 아닙니다");
		}
		
	}
	
}