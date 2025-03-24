package kr.kh.tmp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.tmp.model.vo.MemberVO;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Override
	public void postHandle(					//컨트롤러를 나올 때 가로채는 인터셉터
	    HttpServletRequest request, 
	    HttpServletResponse response, 
	    Object handler, 
	    ModelAndView mv)
	    throws Exception {
		//넘겨준 회원 정보를 가져옴
		MemberVO user = (MemberVO)mv.getModel().get("user");		//HomeController의 addAttribute("여기", )와 이름이 같아야 함
		//회원정보가 있으면(로그인에 성공했으면)
		if(user != null) {
			//세션에 회원 정보 추가
			request.getSession().setAttribute("user", user);
		}
	}
	@Override
	public boolean preHandle(				//컨트롤러로 들어갈 때 가로채는 인터셉터
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
		throws Exception {
		
		//구현
		return true;
	}
}
