package kr.kh.tmp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.tmp.model.vo.CommentVO;
import kr.kh.tmp.model.vo.MemberVO;
import kr.kh.tmp.pagination.CommentCriteria;
import kr.kh.tmp.pagination.PageMaker;
import kr.kh.tmp.service.CommentService;

@RequestMapping("/comment")
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
	
	@PostMapping("/list")
	public String list(Model model, @RequestBody CommentCriteria cri) {
		List<CommentVO> list = commentService.getCommentList(cri);
		PageMaker pm = commentService.getPageMaker(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pm", pm);
		return "comment/list";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public boolean delete(@RequestParam int co_num, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		return commentService.deleteComment(user, co_num);
	}
}
