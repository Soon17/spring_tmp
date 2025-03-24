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

}