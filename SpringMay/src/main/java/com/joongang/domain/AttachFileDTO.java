package com.joongang.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	private String filename; // fileName 아닌이유 : mybatis에서 field명하고 햇갈림
	private String uploadpath;
	private String uuid;
	private boolean image;
}
