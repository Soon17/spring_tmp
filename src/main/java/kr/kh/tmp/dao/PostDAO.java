package kr.kh.tmp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.tmp.model.vo.BoardVO;
import kr.kh.tmp.model.vo.PostVO;

public interface PostDAO {

	boolean insertBoard(@Param("bo_name")String name);

	List<BoardVO> selectBoardList();

	boolean updateBoard(@Param("board")BoardVO board);

	boolean deleteBoard(@Param("bo_num")int num);

	List<PostVO> selectPostList(@Param("po_bo_num")Integer bo_num);

}