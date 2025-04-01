package kr.kh.tmp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.tmp.model.vo.CommentVO;
import kr.kh.tmp.model.vo.MemberVO;
import kr.kh.tmp.service.CommentService;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	@ResponseBody
	@PostMapping("/insert")
	public boolean insert(@RequestBody CommentVO comment, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		return commentService.insertComment(comment, user);
	}
}
