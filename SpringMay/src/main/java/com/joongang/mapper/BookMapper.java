package com.joongang.mapper;

import java.util.List;

import com.joongang.domain.BoardVO;
import com.joongang.domain.BookAttachVO;
import com.joongang.domain.BookVO;
import com.joongang.domain.Criteria;

public interface BookMapper {
	public void insert(BookVO vo);
	public List<BookVO> getAllBookList();
	public List<BookVO> getSpecificBookList(BookVO vo);					//옵션검색시 사용
	public List<BookVO> getListWithPaging(Criteria criteria);			//일반 검색창에서 사용
	public int getTotalCount(Criteria criter);
	public BookVO read(long booknumber);
	public int update(BookVO vo);
	public void deleteAll(long booknumber);
}
