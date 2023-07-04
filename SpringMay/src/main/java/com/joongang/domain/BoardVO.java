package com.joongang.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long rn;
	private Integer bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp regdate;
	private Timestamp updatedate;
	
	private List<BoardAttachVO> attachList;
	
	private Integer commentCount;
}
