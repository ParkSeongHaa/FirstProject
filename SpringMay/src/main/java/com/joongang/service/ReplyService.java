package com.joongang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joongang.domain.Criteria;
import com.joongang.domain.ReplyPageDTO;
import com.joongang.domain.ReplyVO;
import com.joongang.mapper.ReplyMapper;

import lombok.Setter;

@Service
//@Log4j2
public class ReplyService {
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	public int register(ReplyVO vo) {
		return mapper.insert(vo);
	}
	
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}
	
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}
	
	public int remove(Long rno) {
		return mapper.delete(rno);
	}
	
	public List<ReplyVO> getList(Long bno) {		//댓글리스트 get
		return mapper.getList(bno);
	}
	
	public ReplyPageDTO getListWithPaging(Criteria criteria , Long bno) {	//criteria로 페이징까지 함께 get
		return new ReplyPageDTO(mapper.getTotalCount(bno),
				mapper.getListWithPaging(criteria, bno));
	}
	
	public int getReplyCnt(long bno) {		//한 게시글의 댓글갯수 get
		return mapper.getTotalCount(bno);
	}
	
	
}
