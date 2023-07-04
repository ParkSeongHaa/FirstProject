package com.joongang.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class , com.joongang.config.SecurityConfig.class })
@Log4j2
public class BoardServiceTests {
	@Setter(onMethod_=@Autowired)
	private BoardService boardService;
	

//	@Test
	public void testRegister() {
		BoardVO vo = new BoardVO();
		vo.setContent("33");
		vo.setTitle("33");
		vo.setWriter("33");
		boardService.register(vo);
	}
	
	
}
