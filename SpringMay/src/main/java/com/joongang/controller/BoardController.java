package com.joongang.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.joongang.domain.BoardAttachVO;
import com.joongang.domain.BoardVO;
import com.joongang.domain.Criteria;
import com.joongang.domain.PageDTO;
import com.joongang.service.BoardService;
import com.joongang.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board/*")
@Log4j2
public class BoardController {
	@Setter(onMethod_=@Autowired)
	private BoardService boardService;
	
	@Setter(onMethod_=@Autowired)
	private ReplyService replyService;

	
	@GetMapping("/register")
	public String registerForm() {
		return"/board/registerForm2";
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo , RedirectAttributes rttr) {
		String content = vo.getContent();                  // ckeditor사용으로 본문에 <p> <h1>등 태그가 붙어서 
		String[] content2 = content.split(">");            // 해당태그를 split으로 제거
		String[] content3 = content2[1].split("<");
		vo.setContent(content3[0]);
		boardService.register(vo);
		rttr.addFlashAttribute("result",vo.getBno());			//n번쨰 게시글 등록 알림
		return"redirect:/board/list";
	}
	
//	@GetMapping("/list")
//	public String List(Criteria criteria , Model model) {
//		List<BoardVO> list = boardService.getList(criteria);
//		model.addAttribute("list", list);
//		int total = boardService.getTotal(criteria);
//		model.addAttribute("pageDTO",new PageDTO(criteria,total));
//		log.info(list + "total:" + total + "  " + criteria.getListLink());
//		return"/board/list";
//	}
	
	@GetMapping("/list")
	public String List(Criteria criteria , Model model) {
		List<BoardVO> list = boardService.getList(criteria);
		model.addAttribute("list", list);
		
		int total = boardService.getTotal(criteria);
		model.addAttribute("pageDTO",new PageDTO(criteria,total));
		
		
		log.info(list + "total:" + total + "  " + criteria.getListLink());
		return"/board/list2";
	}
	
//	@GetMapping("/get")
//	public String get(@RequestParam("bno")Long bno , Model model , Criteria criteria) {
//		model.addAttribute("list",boardService.get(bno));
//		return "/board/get";
//	}
	
	@GetMapping("/get")
	public String get2(@RequestParam("bno")Long bno , Model model , Criteria criteria) {
		model.addAttribute("list",boardService.get(bno));
		return "/board/get2";
	}
	
//	@GetMapping("/modify")
//	public String modify(Model model , @RequestParam("bno") Long bno , Criteria criteria) {
//		model.addAttribute("list",boardService.get(bno));
//		return "/board/modify";
//	}
	
	@GetMapping("/modify")
	public String modify(Model model , @RequestParam("bno") Long bno , Criteria criteria) {
		model.addAttribute("list",boardService.get(bno));
		return "/board/modify2";
	}
	
	@PostMapping("/modify")
	public String modifyFinish(BoardVO vo , RedirectAttributes rttr , Criteria criteria) {
		boardService.modifyWithAttach(vo);
		rttr.addFlashAttribute("result","modify");
		return "redirect:/board/list" + criteria.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno , RedirectAttributes rttr, Criteria criteria) {
		boardService.remove(bno);
		rttr.addFlashAttribute("result","remove");
		return "redirect:/board/list" + criteria.getListLink();
	}
	
	@GetMapping(value = "/getAttachList/{bno}",                          //get AttachList
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList
			(@PathVariable("bno") long bno) {
		log.info("getAttachList : :" + bno);
		return new ResponseEntity<>(boardService.getAttachList(bno),HttpStatus.OK);
	}
	
	@GetMapping(value = "/getCommentCount")
	@ResponseBody
	public int getCommentCount(@RequestBody long bno) {
		int CommentCount = boardService.getCommentCount(bno);
		System.out.println("댓글갯수 : " + CommentCount);
		return CommentCount;
	}

	
	@GetMapping(value="/getAttachListOnList",
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> getAttachListOnList(
			@RequestParam(value="list[]") List<Long> list) {
		log.info("getAttachListOnList" + list.stream().collect(Collectors.toList()));
		Map<Long,List<BoardAttachVO>> map = new HashMap<Long , List<BoardAttachVO>>();
		for(Long bno : list) {
			map.put(bno, boardService.getAttachList(bno));
		}
		String gson = new Gson().toJson(map,HashMap.class);
		return new ResponseEntity<>(gson,HttpStatus.OK);	
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		for(BoardAttachVO attachVO : attachList) {
			try {
				Path file = Paths.get("C:\\upload\\" + attachVO.getUploadpath()+
						"\\"+attachVO.getUuid()+"_"+attachVO.getFilename());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attachVO.getUploadpath()+
							"\\s"+attachVO.getUuid()+"_"+attachVO.getFilename());
					Files.delete(thumbNail);
				}
			} catch(Exception e) {
				log.error("delete file error",e.getMessage());
			}
		}
	}
	
}
