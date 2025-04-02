package kr.kh.tmp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.tmp.model.vo.CommentVO;
import kr.kh.tmp.pagination.Criteria;

public interface CommentDAO {

	boolean insertComment(@Param("co")CommentVO comment);

	List<CommentVO> selectCommentList(@Param("cri")Criteria cri);

	int selectCountCommentList(@Param("cri")Criteria cri);
	
}
