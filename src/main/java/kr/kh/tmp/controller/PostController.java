package kr.kh.tmp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.tmp.service.PostService;

@Controller
@RequestMapping("/post")		//PostController안의 모든 메소드가 /post url을 포함할 때 사용 가능
public class PostController {

	@Autowired
	private PostService postService;
}
