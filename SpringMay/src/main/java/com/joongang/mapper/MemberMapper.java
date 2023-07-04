package com.joongang.mapper;

import java.util.ArrayList;
import java.util.List;

import com.joongang.domain.MemberVO;

public interface MemberMapper {
	public void insert(MemberVO vo);
	public MemberVO selectMemberByUserid(String userid);
	public MemberVO selectMemberByUserpw(String userpw);
	public List<String> getIdList();
	public void editInfo(MemberVO vo);
	public MemberVO findId(MemberVO vo);
	public MemberVO findIdForPw(MemberVO vo);
	public void modifyPw(MemberVO vo);
	public void deleteMember(MemberVO vo);
}
