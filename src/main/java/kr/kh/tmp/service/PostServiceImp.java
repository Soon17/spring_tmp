package kr.kh.tmp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.tmp.dao.PostDAO;

@Service
public class PostServiceImp implements PostService{

	@Autowired
	private PostDAO postDAO;
}
