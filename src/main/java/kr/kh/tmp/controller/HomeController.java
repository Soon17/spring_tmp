package kr.kh.tmp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.tmp.model.dto.PersonDTO;
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
			model.addAttribute("url", "/");									//성공하면 home
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
			model.addAttribute("url", "/");									//성공하면 home
			model.addAttribute("msg", "로그인에 성공했습니다.");
			model.addAttribute("user", user);
		} else {
			model.addAttribute("url", "/login?id=" + member.getMe_id());	//실패하면 화면 유지
			model.addAttribute("msg", "로그인에 실패했습니다.");
		}
		return "message";
	}
	
	@GetMapping("/logout")
	public String logout(Model model, HttpSession session) {
		
		session.removeAttribute("user");
		
		model.addAttribute("url", "/");
		model.addAttribute("msg", "로그아웃 했습니다.");
		return "message";
	}
	
	@ResponseBody
	@GetMapping("/ajax/sample1")
	public Object ajaxSample1(@RequestParam String name, @RequestParam int age) {
		System.out.println(name + " : " + age);
		return "home";
	}
	@ResponseBody
	@PostMapping("/ajax/sample2")
	public Object ajaxSample2(@RequestBody PersonDTO person) {
		System.out.println(person);
		return "home2";
	}
	@ResponseBody
	@GetMapping("/ajax/sample3")
	public Map<String, Object> ajaxSample3(@RequestParam String name, @RequestParam int age) {
		PersonDTO person = new PersonDTO();
		person.setName(name);
		person.setAge(age);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("person", person);
		map.put("string", "안녕하세요");
		return map;
	}
	
	@GetMapping("/ajax/sample4")
	public Object ajaxSample4(@RequestParam int bo_num) {
		
		return "redirect:/post/list?bo_num=" + bo_num;
	}
}