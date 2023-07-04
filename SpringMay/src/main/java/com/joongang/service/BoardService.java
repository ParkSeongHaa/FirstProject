package com.joongang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joongang.domain.BoardAttachVO;
import com.joongang.domain.BoardVO;
import com.joongang.domain.Criteria;
import com.joongang.mapper.BoardAttachMapper;
import com.joongang.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BoardService {
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	public void register(BoardVO vo) {
		mapper.insert(vo);									// 게시글내용 저장
		List<BoardAttachVO> list = vo.getAttachList();	
		if(list == null || list.isEmpty()) {				// 게시글에 이미지가 있다면
			return;
		}
		for(BoardAttachVO attach : list) {					//사진수만큼 사진도 저장
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		}
	}
	
	public List<BoardVO> getList() {
		return mapper.getList();
	}
	
	public List<BoardVO> getList(Criteria criteria){
		return mapper.getListWithPaging(criteria);
	}
	
	public int getTotal(Criteria criteria) {
		return mapper.getTotalCount(criteria);
	}
	
	public BoardVO get(long bno) {
		return mapper.read(bno);
	}
	
	public void modify(BoardVO vo) {
		mapper.modify(vo);
	}

	public void remove(long bno) {
		mapper.remove(bno);
	}

	public List<BoardAttachVO> getAttachList(long bno){
		return attachMapper.findByBno(bno);
	}
	
	public int getCommentCount(long bno) {
		return mapper.getCommentCount(bno);
	}
	
	@Transactional
	public boolean modifyWithAttach(BoardVO board) {
		log.info("modify" + board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		List<BoardAttachVO> list = board.getAttachList();
		if(modifyResult && list != null) {
			for(BoardAttachVO vo : list) {
				vo.setBno(board.getBno());
				attachMapper.insert(vo);
			}
		}
		return modifyResult;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
