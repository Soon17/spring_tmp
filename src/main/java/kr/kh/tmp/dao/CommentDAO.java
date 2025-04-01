package kr.kh.tmp.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.tmp.model.vo.CommentVO;

public interface CommentDAO {

	boolean insertComment(@Param("co")CommentVO comment);
	
}
