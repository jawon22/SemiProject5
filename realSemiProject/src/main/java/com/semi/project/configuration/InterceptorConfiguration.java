package com.semi.project.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.semi.project.interceptor.AdminInterceptor;
import com.semi.project.interceptor.BoardDetailDeleteInterceptor;
import com.semi.project.interceptor.BoardOwnerInterceptor;
import com.semi.project.interceptor.MemberInterceptor;
import com.semi.project.interceptor.QnASecretInterceptor;
import com.semi.project.interceptor.TripperLevelInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private BoardOwnerInterceptor boardOwnerInterceptor;
	
	@Autowired
	private BoardDetailDeleteInterceptor boardDetailDeleteInterceptor;
	
	@Autowired
	private TripperLevelInterceptor tripperLevelInterceptor;
	
	@Autowired
	private QnASecretInterceptor qnaSecretInterceptor;
	
	//인터셉터를 추가할 수 있는 설정 메소드(registry 저장소에 설정)
	//등록시 주소의 패턴 설정 방법
		//- *이 한개면 동일한 엔드포인트 내에서만 적용
		//- **이면 하위 엔드포인트를 포함하여 적용
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		//[1] 관리자 인터셉터 등록
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns("/admin/**","/board/deleteByAdmin");
		
		//[2] 회원 전용 페이지 (인터셉터 등록)(모든회원)
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns("/member/**","/board/**","/qnaNotice/**","/rest/reply/**","/rest/boardReport/**") //회원만 들어오기
				.excludePathPatterns("/member/join*","/member/login","/member/exitFinish",
				"/member/search*","/board/list","/board/freeList","/board/reviewList",
				"/board/all","/board/communityAll","/board/detail","/qnaNotice/list",
				"/qnaNotice/noticeList","/qnaNotice/qnaList","/rest/reply/list","/member/activate"); //비회원도 접속가능

		//[3] 게시글 소유자 외 접근 차단
		registry.addInterceptor(boardOwnerInterceptor)
				.addPathPatterns("/board/edit");
		
		//[4] 게시글 소유자 또는 관리자 외 접근 차단
		registry.addInterceptor(boardDetailDeleteInterceptor)
				.addPathPatterns("/board/delete");
		
		//[5] 정보게시판 작성가능 (관리자 , tripper) 외 차단
		registry.addInterceptor(tripperLevelInterceptor)
				.addPathPatterns("/board/write*");
		
		//[6] QnA게시판 비밀글열람 (관리자 , 작성자) 외 차단
		registry.addInterceptor(qnaSecretInterceptor)
				.addPathPatterns("/qnaNotice/detail");

		
	}

}
