package kr.kh.tmp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.tmp.model.vo.BoardVO;
import kr.kh.tmp.model.vo.MemberVO;
import kr.kh.tmp.model.vo.PostVO;
import kr.kh.tmp.service.PostService;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostService postService;
	
	@GetMapping("/list")
	public String list(Model model, Integer bo_num) {
		bo_num = bo_num == null ? 0 : bo_num;
		List<PostVO> list = postService.getPostList(bo_num);
		
		List<BoardVO> boardList = postService.getBoardList();
		
		model.addAttribute("list", list);
		model.addAttribute("boardList", boardList);
		model.addAttribute("bo_num", bo_num);
		return "/post/list";
	}
	
	@GetMapping("/insert")
	public String insert(Model model, Integer bo_num) {
		bo_num = bo_num == null ? 0 : bo_num;
		
		List<BoardVO> boardList = postService.getBoardList();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("bo_num", bo_num);
		return "/post/insert";
	}
	@PostMapping("/insert")
	public String insertPost(Model model, PostVO post, HttpSession session) {
		
		System.out.println(post);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(postService.insertPost(post, user)) {
			model.addAttribute("url", "/post/list");
			model.addAttribute("msg", "게시글을 등록했습니다.");
		}else {
			model.addAttribute("url", "/post/list");
			model.addAttribute("msg", "게시글을 등록하지 못했습니다.");
		}
		
		System.out.println(post);
		return "message";
	}
}