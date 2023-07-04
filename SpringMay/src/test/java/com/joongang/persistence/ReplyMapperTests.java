package com.joongang.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.joongang.domain.ReplyVO;
import com.joongang.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.joongang.config.RootConfig.class,com.joongang.config.SecurityConfig.class})
@Log4j2
public class ReplyMapperTests {
	@Setter(onMethod_ = @Autowired)
	ReplyMapper replyMapper;

	
//	@Test
	public void insert() {
//		ReplyVO vo = new ReplyVO();
//		vo.setBno((long) 38);
//		vo.setReply("댓글1");
//		vo.setReplyer("사람1");
//		replyMapper.insert(vo);
		
		for(int i=0; i<3; i++) {
			ReplyVO vo = new ReplyVO();
			vo.setBno((long)39);
			vo.setReply("댓글2");
			vo.setReplyer("사람2");
			replyMapper.insert(vo);
		}
	}
	
//	@Test
	public void read() {
		ReplyVO vo = new ReplyVO();
		vo.setRno((long) 5);
		log.info(replyMapper.read(vo.getRno()));
	}
	
//	@Test
	public void delete() {
		ReplyVO vo = new ReplyVO();
		vo.setRno((long) 4);
		replyMapper.delete(vo.getRno());
	}
	
//	@Test
	public void update() {
		ReplyVO vo = new ReplyVO();
		vo.setReply("수정");
		vo.setRno((long)6 );
		replyMapper.update(vo);
	}

	@Test
	public void getList() {
		ReplyVO vo = new ReplyVO();
		vo.setBno((long)39);
		List<ReplyVO> replies = replyMapper.getList(vo.getBno());
		for(ReplyVO voo : replies) {
			log.info(voo);
		}
//		log.info(replyMapper.getList(vo.getBno()));
	}
	
}
