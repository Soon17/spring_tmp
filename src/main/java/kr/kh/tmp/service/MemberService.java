package kr.kh.tmp.service;

import kr.kh.tmp.model.vo.MemberVO;

public interface MemberService {

	boolean signup(MemberVO member);

	MemberVO login(MemberVO member);

}
