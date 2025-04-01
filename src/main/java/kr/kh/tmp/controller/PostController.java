package kr.kh.tmp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.tmp.model.vo.BoardVO;
import kr.kh.tmp.model.vo.FileVO;
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
	public String insertPost(Model model, PostVO post, HttpSession session, MultipartFile[] fileList) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(postService.insertPost(post, user, fileList)) {
			model.addAttribute("url", "/post/list");
			model.addAttribute("msg", "게시글을 등록했습니다.");
		}else {
			model.addAttribute("url", "/post/list");
			model.addAttribute("msg", "게시글을 등록하지 못했습니다.");
		}
		return "message";
	}
	
	@GetMapping("/detail/{po_num}")
	public String detail(Model model,@PathVariable("po_num") int po_num) {
		//조회수 증가
		postService.updateView(po_num);
		//게시글을 가져와서 화면에 전달
		PostVO post = postService.getPost(po_num);
		
		//첨부파일을 가져옴
		List<FileVO> list = postService.getFileList(po_num);
		
		model.addAttribute("post", post);
		model.addAttribute("list", list);
		return "/post/detail";
	}
	
	@GetMapping("/delete/{po_num}")
	public String deletePost(Model model, @PathVariable("po_num") int po_num, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(postService.deletePost(po_num, user)) {
			model.addAttribute("url", "/post/list");
			model.addAttribute("msg", "게시글을 삭제했습니다.");
		}else {
			model.addAttribute("url", "/post/detail/"+po_num);
			model.addAttribute("msg", "게시글을 삭제하지 못했습니다.");
		}
		return "message";
	}
	
	@GetMapping("/update/{po_num}")
	public String updatePost(Model model, @PathVariable("po_num") int po_num, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		PostVO post = postService.getPost(po_num);
		if(post == null || user == null || !post.getPo_me_id().equals(user.getMe_id())) {
			model.addAttribute("url", "/post/detail/" + po_num);
			model.addAttribute("msg", "작성자가 아니거나 없는 게시글입니다.");
			return "message";
		}
		
		List<FileVO> list = postService.getFileList(po_num);
		
		model.addAttribute("post", post);
		model.addAttribute("list", list);
		return "/post/update";
	}
	
	@PostMapping("/update")
	public String updatePost(Model model, PostVO post, HttpSession session,
			MultipartFile[] fileList, int[] delNums) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(postService.updatePost(post, user, fileList, delNums)) {
			model.addAttribute("msg", "게시글을 수정했습니다.");
		}else {
			model.addAttribute("msg", "게시글을 수정하지 못했습니다.");
		}
		model.addAttribute("url", "/post/detail/" + post.getPo_num());
		return "message";
	}
}