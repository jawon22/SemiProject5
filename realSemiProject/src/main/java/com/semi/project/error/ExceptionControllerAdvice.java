package com.semi.project.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/*
	컨트롤러를 간섭하여 예외 상황을 다르게 처리하도록 하는 객체
	- 등록시 @ControllerAdvice라고 등록
	- @RestController를 간섭할 경우는 @RestControllerAdvice를 사용
	- 적용 대상을 옵션으로 지정
*/
@ControllerAdvice(annotations = {Controller.class})
public class ExceptionControllerAdvice {

	/*
	 * - 이 메소드에는 컨트롤러처럼 매개변수를 선언하면 사용할 수 있다. 
	 * - Model, HttpSession등 기본적인 컨트롤러의 도구 사용 가능
	 * - catch 예외 처리 객체를 선언할 수 있다
	 */
	
	@ExceptionHandler(Exception.class)
	public String error(Exception e) {
		e.printStackTrace();
		return "/WEB-INF/views/error/500.jsp";
	}
	
//	내가 지정한 예외들을 처리하도록 추가 핸들러(처리기) 설정
	@ExceptionHandler(NoTargetException.class)
	public String noTarget(NoTargetException e) {
		e.printStackTrace();
		return "/WEB-INF/views/error/noTarget.jsp";
	}
	
	
	@ExceptionHandler(AuthorityException.class)
	public String authority(AuthorityException e) {
		e.printStackTrace();
		return "/WEB-INF/views/error/authority.jsp";
	}
	
}
