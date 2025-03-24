package kr.kh.tmp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.tmp.dao.MemberDAO;
import kr.kh.tmp.model.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
	
	@Autowired
	MemberDAO memberDao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override
	public boolean signup(MemberVO member) {
		if(member == null) return false;
		//아이디, 비번, 이메일 유효성 검사
		
		//비밀번호 암호화
		String encPw = passwordEncoder.encode(member.getMe_pw());
		member.setMe_pw(encPw);
		try {
			return memberDao.insertMember(member);			
		} catch (Exception e) {
			//e.printStackTrace();
			return false;
		}
	}

	@Override
	public MemberVO login(MemberVO member) {
		if(member == null) return null;
		MemberVO user = memberDao.selectMember(member.getMe_id());
		//아이디가 없는 경우
		if(user == null) return null;
		//비밀번호가 다른 경우
		if(!passwordEncoder.matches(member.getMe_pw(), user.getMe_pw())) return null;	//암호화 안 된 비번, 암호화 된 비번
		return user;
	}

}