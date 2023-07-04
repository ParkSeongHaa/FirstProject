package com.joongang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.joongang.domain.AuthVO;
import com.joongang.domain.MemberVO;
import com.joongang.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class MemberService {
	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;
	
	public void signup(MemberVO vo) {
//		vo.setUserpw(pwencoder.encode(vo.getUserpw()));     AOP functionAdvice에서 Before로 사용중
		String email1 = vo.getEmail1();
		String email2 = vo.getEmail2();
		String email = email1 + "@" + email2; //이메일 형태의 이메일
		vo.setEmail(email);
		String totalphone = vo.getPhone1() + "-" + vo.getPhone2() + "-" + vo.getPhone3();
		vo.setTotalphone(totalphone);
		String totaladdress = "(" + vo.getAddresscode() + ")" + vo.getAddress() + " " + vo.getAddressdetail() + " " + vo.getAddressnote();
		vo.setTotaladdress(totaladdress);
		System.out.println(vo);
		mapper.insert(vo);
	}

	public boolean checkIfIdIsDuplicate(String id) {
		List<String> userIdList = mapper.getIdList();
		System.out.println("useridList : " + userIdList);
		return userIdList.contains(id);
	}
	
	public AuthVO authenticate(MemberVO vo) throws Exception {
		MemberVO selectVO = mapper.selectMemberByUserid(vo.getUserid());
		if(selectVO == null) {
			System.out.println("유저정보없음2");
			throw new Exception("nonuser");
		}
		if(!pwencoder.matches(vo.getUserpw(),selectVO.getUserpw())) {
			System.out.println("비번다름");
			throw new Exception("nomatch");
		}
		AuthVO authVO = new AuthVO();
		authVO.setUserid(selectVO.getUserid());
		authVO.setUsername(selectVO.getUsername());
		authVO.setTotalphone(selectVO.getTotalphone());
		authVO.setAdmin(selectVO.getAdmin());
		authVO.setUserpw(selectVO.getUserpw());
		System.out.println("authVO : " + authVO);
		return authVO;
	}

	public MemberVO getUserInfo(MemberVO vo) {
		MemberVO selectVO = mapper.selectMemberByUserid(vo.getUserid());
		return selectVO;
	}
	
	
	public void editInfo(MemberVO vo) {
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		String email1 = vo.getEmail1();
		String email2 = vo.getEmail2();
		String email = email1 + "@" + email2; //이메일 형태의 이메일
		vo.setEmail(email);
		String totalphone = vo.getPhone1() + "-" + vo.getPhone2() + "-" + vo.getPhone3();
		vo.setTotalphone(totalphone);
		String totaladdress = "(" + vo.getAddresscode() + ")" + vo.getAddress() + " " + vo.getAddressdetail() + " " + vo.getAddressnote();
		vo.setTotaladdress(totaladdress);
		System.out.println(vo);
		mapper.editInfo(vo);
	}
	
	public MemberVO findId(MemberVO vo) {
		String totalphone = vo.getPhone1() + "-" + vo.getPhone2() + "-" + vo.getPhone3();
		vo.setTotalphone(totalphone);
		return mapper.findId(vo);
	}
	
	public MemberVO findIdForPw(MemberVO vo) {
		String totalphone = vo.getPhone1() + "-" + vo.getPhone2() + "-" + vo.getPhone3();
		vo.setTotalphone(totalphone);
		return mapper.findIdForPw(vo);
	}

	public void modifyPw(MemberVO vo) {
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		mapper.modifyPw(vo);
	}
	
	public void deleteMember(MemberVO vo) throws Exception {
		MemberVO selectVO = mapper.selectMemberByUserid(vo.getUserid());
		if(!pwencoder.matches(vo.getUserpw(),selectVO.getUserpw())) {
			System.out.println("비번다름");
			throw new Exception("nomatch");
		}
		mapper.deleteMember(vo);
	}
	
	
	
}

