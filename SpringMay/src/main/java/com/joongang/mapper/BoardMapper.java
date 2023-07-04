package com.joongang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.joongang.domain.BoardVO;
import com.joongang.domain.Criteria;

public interface BoardMapper {
	public void insert(BoardVO vo);
	public List<BoardVO> getList();
	public BoardVO read(long bno);
	public int modify(BoardVO vo);
	public void remove(long bno);
	public List<BoardVO> getListWithPaging(Criteria criteria);
	public int getTotalCount(Criteria criteria);
	public int getCommentCount(long bno);
	public int update(BoardVO vo);
}
