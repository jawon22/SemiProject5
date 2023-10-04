package com.semi.project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.semi.project.dao.QnaNoticeDao;
import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.error.AuthorityException;

// QnA에서 비밀글 차단 인터셉터 (관리자와 ,작성자만 볼 수 있음)

@Component
public class QnASecretInterceptor implements HandlerInterceptor{

	@Autowired
	private QnaNoticeDao qnaNoticeDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//현재 사용자의 아이디 세션에서 가져오기 (작성자)
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("name");
		
		//현재 사용자의 등급 가져오기 (관리자)
		String memberLevel = (String) session.getAttribute("level");
		
		//글 번호 가져오기
		int qnaNo = Integer.parseInt(request.getParameter("qnaNoticeNo"));
		QnaNoticeDto qnaNoticeDto = qnaNoticeDao.selectOne(qnaNo);
		
		//답글일 경우에 (parent가 null이 아닐 때) 해당 글의 group번호가 qnaNoticeNo인 글의 작성자를 찾아서 작성자는 볼 수 있도록!
		if(qnaNoticeDto.getQnaNoticeParent() != null) {
			QnaNoticeDto findDto = qnaNoticeDao.selectOne(qnaNoticeDto.getQnaNoticeGroup());
			String originId = findDto.getMemberId(); //얘가 작성자니까 얘는 볼 수 있음
			if(memberId.equals(originId)) {
				return true;		
			}
		}

		//비밀글이면 관리자랑 작성자만 들어가야함
		// 비밀글이면서 작성자와 세션아이디가 같거나 비밀글이면서 관리자이면 통과
		boolean isPass = (qnaNoticeDto.getQnaNoticeSecret().equals("Y") &&
				(qnaNoticeDto.getMemberId().equals(memberId)) || (memberLevel.equals("관리자") && memberLevel != null))
				|| qnaNoticeDto.getQnaNoticeSecret().equals("N");
		
		
		if(isPass) return true;
		else throw new AuthorityException("글 작성자 또는 관리자가 아닙니다");
	}
}













