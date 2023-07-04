package com.joongang.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	private String userid;
	private String username;
	private String userpw;
	private String gender;
	private Timestamp regdate;
	private Timestamp updatedate;
	private String email1;
	private String email2;
	private String email;
	private String birthday;
	private String phone1;
	private int phone2;
	private int phone3;
	private int addresscode;
	private String address;
	private String addressdetail;
	private String addressnote;
	private String phonecompany;
//	private String location;
	private String totalphone;
	private String totaladdress;
	private String admin;
	
}
