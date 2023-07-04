package com.joongang.domain;

import lombok.Data;

@Data
public class BookAttachVO {
	private String uuid;
	private String uploadpath;
	private String filename;
	private boolean filetype;
	private int booknumber;
}
