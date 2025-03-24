package kr.kh.tmp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.kh.tmp.model.vo.MemberVO;
import kr.kh.tmp.service.MemberService;

@Controller
public class HomeController {
	
	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "home";
	}
	
//	화면 띄울 때 사용됨
	@GetMapping("/signup")
	public String signup(Model model, String id) {
		model.addAttribute("id", id);
		return "/member/signup";
	}
	
//	화면 값을 받아올 때 사용됨
	@PostMapping("/signup")
	public String signupPost(Model model, MemberVO member) {
		if(memberService.signup(member)) {
			model.addAttribute("url", "/");			//성공하면 home
			model.addAttribute("msg", "회원가입에 성공했습니다.");
		} else {
			model.addAttribute("url", "/signup?id=" + member.getMe_id());	//실패하면 화면 유지
			model.addAttribute("msg", "회원가입에 실패했습니다.");
		}
		return "message";
	}
	
	@GetMapping("/login")
	public String login(Model model, String id) {
		model.addAttribute("id", id);
		return "/member/login";
	}
	
	@PostMapping("/login")
	public String loginPost(Model model, MemberVO member) {
		MemberVO user = memberService.login(member);
		if(user != null) {
			model.addAttribute("url", "/");			//성공하면 home
			model.addAttribute("msg", "로그인에 성공했습니다.");
		} else {
			model.addAttribute("url", "/login?id=" + member.getMe_id());	//실패하면 화면 유지
			model.addAttribute("msg", "로그인에 실패했습니다.");
		}
		return "message";
	}
}