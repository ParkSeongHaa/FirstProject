package com.joongang.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookVO {
	private int booknumber;
	private String booktitle;
	private String bookwriter;
	private String bookcompany;
	private	int bookyear;
	private String booklocation;
	private String booklental;
	
	private BookAttachVO attachList;
//	private List<BookAttachVO> attachListList;
	
	private String bookyear1;
	private String bookyear2;
	
	private Criteria criteria;
	

}
