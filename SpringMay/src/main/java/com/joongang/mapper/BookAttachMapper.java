package com.joongang.mapper;

import java.util.List;

import com.joongang.domain.BoardAttachVO;
import com.joongang.domain.BookAttachVO;
import com.joongang.domain.BookVO;

public interface BookAttachMapper {
	public void insert(BookAttachVO vo);
	public List<BookAttachVO> getAllBookAttachList();
	public List<BookAttachVO> getSpecificBookAttachList(int booknumber);
	public List<BookAttachVO> getOldFiles(String uploadpath);
	public List<BookAttachVO> findByBookNumber(long booknumber);
	public BookAttachVO findByBookNumber2(long booknumber);
	public void deleteAll(long booknumber);
	
	
	
}
