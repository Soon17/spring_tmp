package kr.kh.tmp.service;

import java.util.List;

import kr.kh.tmp.model.vo.CommentVO;
import kr.kh.tmp.model.vo.MemberVO;
import kr.kh.tmp.pagination.CommentCriteria;
import kr.kh.tmp.pagination.Criteria;
import kr.kh.tmp.pagination.PageMaker;

public interface CommentService {

	boolean insertComment(CommentVO comment, MemberVO user);

	List<CommentVO> getCommentList(Criteria cri);

	PageMaker getPageMaker(Criteria cri);

	boolean deleteComment(MemberVO user, int co_num);

}
