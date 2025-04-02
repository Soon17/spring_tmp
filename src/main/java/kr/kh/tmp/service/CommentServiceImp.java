package kr.kh.tmp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.tmp.dao.CommentDAO;
import kr.kh.tmp.model.vo.CommentVO;
import kr.kh.tmp.model.vo.MemberVO;
import kr.kh.tmp.pagination.CommentCriteria;
import kr.kh.tmp.pagination.Criteria;
import kr.kh.tmp.pagination.PageMaker;

@Service
public class CommentServiceImp implements CommentService{
	
	@Autowired
	private CommentDAO commentDao;

	@Override
	public boolean insertComment(CommentVO comment, MemberVO user) {
		if(comment == null /*|| user == null*/) {
			return false;
		}
		//comment.setCo_me_id(user.getMe_id());
		comment.setCo_me_id("asd");
		return commentDao.insertComment(comment);
	}

	@Override
	public List<CommentVO> getCommentList(Criteria cri) {
		if(cri == null) return null;
		return commentDao.selectCommentList(cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) {
		if(cri == null) return null;
		int count = commentDao.selectCountCommentList(cri);
		return new PageMaker(3, cri, count);
	}
}
