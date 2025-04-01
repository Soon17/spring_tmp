package kr.kh.tmp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.kh.tmp.service.CommentService;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;
}
