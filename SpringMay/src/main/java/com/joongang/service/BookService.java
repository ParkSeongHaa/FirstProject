package com.joongang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joongang.domain.BoardAttachVO;
import com.joongang.domain.BoardVO;
import com.joongang.domain.BookAttachVO;
import com.joongang.domain.BookVO;
import com.joongang.domain.Criteria;
import com.joongang.mapper.BookAttachMapper;
import com.joongang.mapper.BookMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BookService {
	@Setter(onMethod_=@Autowired)
	private BookMapper mapper;

	@Setter(onMethod_=@Autowired)
	private BookAttachMapper attachMapper;
	
	public void registBook(BookVO vo) {
		mapper.insert(vo);
		System.out.println("리스트" + vo.getAttachList());
//		List<BookAttachVO> list = vo.getAttachList();
//		for(BookAttachVO attach : list) {
//			attach.setBooknumber(vo.getBooknumber());
//			attachMapper.insert(attach);
//		}
		BookAttachVO attachVO = vo.getAttachList();
		attachVO.setBooknumber(vo.getBooknumber());
		attachMapper.insert(attachVO);
	}
	
	public List<BookVO> getAllBookList(){
		return mapper.getAllBookList();
	}
	
	public List<BookAttachVO> getAttachList(){
		return attachMapper.getAllBookAttachList();
	}
	
//	public List<BookVO> getSpecificBookList(BookVO vo , Criteria criteria){
//		System.out.println("서비스도착");
//		return mapper.getSpecificBookList(vo , criteria);
//	}
	
	public List<BookVO> getSpecificBookList(BookVO vo ){					// 옵션 검색
		if(vo.getBookyear1().equals("")) {
			vo.setBookyear1("0");
		}
		if(vo.getBookyear2().equals("")) {
			vo.setBookyear2("2023");
		}
		
		return mapper.getSpecificBookList(vo);
	}
	
	
	public List<BookAttachVO> getSpecificBookAttachList(int booknumber){
		return attachMapper.getSpecificBookAttachList(booknumber);
	}
	
	public List<BookVO> getList(Criteria criteria){
		return mapper.getListWithPaging(criteria);
	}
	
	public int getTotal(Criteria criteria) {
		return mapper.getTotalCount(criteria);
	}
	
	public List<BookAttachVO> getAttachList(long booknumber){
		return attachMapper.findByBookNumber(booknumber);
	}
	
	public BookAttachVO getAttach(long booknumber){
		return attachMapper.findByBookNumber2(booknumber);
	}
	
	public BookVO get(long booknumber) {
		return mapper.read(booknumber);
	}
	
	@Transactional
	public void modifyWithAttach(BookVO book) {
		System.out.println("서비스 도착1");
		log.info("modify" + book);
		attachMapper.deleteAll(book.getBooknumber());
		System.out.println("서비스 도착2");
//		boolean modifyResult = mapper.update(book) == 1;
		mapper.update(book);
		System.out.println("서비스 도착3");
		BookAttachVO attachVo = book.getAttachList();
		attachVo.setBooknumber(book.getBooknumber());
		System.out.println("사진정보:"+attachVo);
		attachMapper.insert(attachVo);
//		List<BookAttachVO> list = book.getAttachListList();
//		if(list != null) {
//			for(BookAttachVO vo : list) {
//				vo.setBooknumber(book.getBooknumber());
//				attachMapper.insert(vo);
//			}
//		}
		System.out.println("서비스 도착4");
	}
	
	public void bookdelete(BookVO vo) {
		attachMapper.deleteAll(vo.getBooknumber());
		mapper.deleteAll(vo.getBooknumber());
	}
	
}
