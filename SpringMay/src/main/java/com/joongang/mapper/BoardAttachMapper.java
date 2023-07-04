package com.joongang.mapper;

import java.util.List;

import com.joongang.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public List<BoardAttachVO> findByBno(long bno);
	public void delete(String uuid);
	public void deleteAll(long bno);
	public List<BoardAttachVO> getOldFiles(String uploadpath);
	
	
	
	
	
	
	
}
