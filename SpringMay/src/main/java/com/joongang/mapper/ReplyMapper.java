package com.joongang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.joongang.domain.BoardVO;
import com.joongang.domain.Criteria;
import com.joongang.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	public ReplyVO read(long rno);
	public int delete(long rno);
	public int update(ReplyVO reply);
	public List<ReplyVO> getList(Long bno);
	public List<ReplyVO> getListWithPaging(@Param("criteria") Criteria criteria,
			@Param("bno") Long bno);
	public int getTotalCount(long bno);
	
}
