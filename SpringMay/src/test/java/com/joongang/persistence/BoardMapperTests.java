package com.joongang.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.BoardVO;
import com.joongang.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,com.joongang.config.SecurityConfig.class})
@Log4j2
public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	BoardMapper BoardMapper;

	
//	@Test
	public void insertMember() {
		for(int i=0; i<100; i++) {
			BoardVO vo = new BoardVO();
			vo.setContent("aaaㅁㅁㅁ");
			vo.setTitle("aaaㅁㅁㅁ");
			vo.setWriter("aaaㅁㅁㅁ");
			BoardMapper.insert(vo);
		}
		
	}
	

	
}
