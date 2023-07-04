package com.joongang.controller;

import java.util.ArrayList;
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
import com.joongang.domain.BookAttachVO;
import com.joongang.domain.BookVO;
import com.joongang.domain.Criteria;
import com.joongang.domain.PageDTO;
import com.joongang.service.BookService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/book/*")
@Log4j2
public class BookController {
	@Setter(onMethod_=@Autowired)
	private BookService bookService;
	
	@GetMapping("/bookSearch2")  //도서검색 페이지
	public String bookSearch3(Criteria criteria , Model model) {
		List<BookVO> list = bookService.getList(criteria);
		model.addAttribute("list", list);
		
		int total = bookService.getTotal(criteria);
		model.addAttribute("pageDTO",new PageDTO(criteria,total));
		
		log.info(list + "total:" + total + "  " + criteria.getListLink());
		return"/book/bookSearch2";
	}
	
	@GetMapping(value = "/getSpecificBookList")		//도서 옵션으로 검색
	public String getSpecificBookList(BookVO vo , Model model) {
		BookVO inputOptions = new BookVO();									// =vo 로 바로저장하니까 추후 vo값이 변할때마다 옵션값들도 바뀌어서 하나씩 저장함
		String inputTitle = vo.getBooktitle();
		String inputWriter = vo.getBookwriter();
		String inputCompany = vo.getBookcompany();
		String inputYear1 = vo.getBookyear1();
		String inputYear2 = vo.getBookyear2();
		String inputLocation = vo.getBooklocation();
		inputOptions.setBooktitle(inputTitle);
		inputOptions.setBookwriter(inputWriter);
		inputOptions.setBookcompany(inputCompany);
		inputOptions.setBookyear1(inputYear1);
		inputOptions.setBookyear2(inputYear2);
		inputOptions.setBooklocation(inputLocation);
		model.addAttribute("inputOptions",inputOptions);							//입력된 옵션들을 그대로 저장해서 돌려보내줌(안됨 ㅠㅠ) 			
		
		List<BookVO> list = bookService.getSpecificBookList(vo);		//입력된 옵션에 맞는 List<BookVO> 리턴
		model.addAttribute("list",list);
		
		
		int total = bookService.getTotal(vo.getCriteria());
		model.addAttribute("pageDTO",new PageDTO(vo.getCriteria(),total));

		log.info(list + "total:" + total + "  " + vo.getCriteria().getListLink());
		return "/book/bookSearch2";
	}
	
	
	@GetMapping(value="/getAttachListOnList",
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> getAttachListOnList(
			@RequestParam(value="list[]") List<Long> list) {
		log.info("getAttachListOnList" + list.stream().collect(Collectors.toList()));
		Map<Long,List<BookAttachVO>> map = new HashMap<Long , List<BookAttachVO>>();
		for(Long booknumber : list) {
			map.put(booknumber, bookService.getAttachList(booknumber));
		}
		String gson = new Gson().toJson(map,HashMap.class);
		return new ResponseEntity<>(gson,HttpStatus.OK);	
	}
	
	@GetMapping("/bookRegisterForm")
	public String bookRegisterForm() {
		return"/book/bookRegisterForm";
	}
	
	@PostMapping("/registBook")
	public String registBook(BookVO vo , RedirectAttributes rttr) {
		log.info(vo);
		bookService.registBook(vo);
		rttr.addFlashAttribute("msg","registFinish");
		return "redirect:/book/bookRegisterForm";
	}

	
	@GetMapping(value = "/getAllBookList",                          // 책정보
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BookVO>> getAllBookList() {
		return new ResponseEntity<>(bookService.getAllBookList(),HttpStatus.OK);
	}
	
	
	@GetMapping(value = "/getAllBookAttach",                          //책 사진
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BookAttachVO>> getAllBookAttachList() {
		return new ResponseEntity<>(bookService.getAttachList(),HttpStatus.OK);
	}
	
	
	
//	@GetMapping(value = "/getSpecificBookList",                          // 책정보(옵션선택시)
//			produces = MediaType.APPLICATION_JSON_VALUE)
//	@ResponseBody	
//	public ResponseEntity<List<BookVO>> getSpecificBookList(Criteria criteria , Model model , 
//															@RequestParam(value="booktitle",required=false,defaultValue="") String booktitle,
//															@RequestParam(value="bookwriter",required=false,defaultValue="") String bookwriter,
//															@RequestParam(value="bookcompany",required=false,defaultValue="") String bookcompany , 
//															@RequestParam(value="bookyear1",required=false,defaultValue="0") int year1, 
//															@RequestParam(value="bookyear2",required=false,defaultValue="3000") int year2 , 
//															@RequestParam(value="booklocation",required=false,defaultValue="") String booklocation) {
//			BookVO vo = new BookVO();
//			vo.setBooktitle(booktitle);
//			vo.setBookwriter(bookwriter);
//			vo.setBookcompany(bookcompany);
//			vo.setYear1(year1);
//			vo.setYear2(year2);
//			vo.setBooklocation(booklocation);
//			System.out.println("vo:"+vo);
//			int total = bookService.getTotal(criteria);
//			model.addAttribute("pageDTO",new PageDTO(criteria,total));
//			return new ResponseEntity<>(bookService.getSpecificBookList(vo),HttpStatus.OK);
//		}
	
	
	@GetMapping(value = "/getSpecificBookAttach/{booknumber}",                          //책 사진(옵션선택시)
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BookAttachVO>> getSpecificBookAttachList(@PathVariable("booknumber") int booknumber) {
		System.out.println("책넘버 : " + booknumber);
		return new ResponseEntity<>(bookService.getSpecificBookAttachList(booknumber),HttpStatus.OK);
	}
	
	
	@GetMapping("/getBookInfo")
	public String getBookInfo(@RequestParam("booknumber")Long booknumber , Model model , Criteria criteria) {
		model.addAttribute("list",bookService.get(booknumber));
		return"/book/getBookInfo";
	}
	
	@GetMapping(value = "/getAttachList/{booknumber}",                          //get AttachList
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BookAttachVO>> getAttachList
			(@PathVariable("booknumber") long booknumber) {
		log.info("getAttachList : :" + booknumber);
		return new ResponseEntity<>(bookService.getAttachList(booknumber),HttpStatus.OK);
	}
	
	@GetMapping(value = "/getAttach/{booknumber}",                          //get AttachList
			produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<BookAttachVO> getAttach
			(@PathVariable("booknumber") long booknumber) {
		log.info("책번호 : :" + booknumber);
		return new ResponseEntity<>(bookService.getAttach(booknumber),HttpStatus.OK);
	}
	
	@GetMapping("/bookModify")
	public String bookModify(Criteria criteria , Model model) {
		List<BookVO> list = bookService.getList(criteria);
		model.addAttribute("list", list);
		
		int total = bookService.getTotal(criteria);
		model.addAttribute("pageDTO",new PageDTO(criteria,total));
		
		log.info(list + "total:" + total + "  " + criteria.getListLink());
		return"/book/bookModify";
	}
	
	@GetMapping("/getBookInfoToModify")
	public String getBookInfoToModify(@RequestParam("booknumber")Long booknumber , Model model , Criteria criteria) {
		model.addAttribute("list",bookService.get(booknumber));
		return"/book/getBookInfoToModify";
	}
	
	@GetMapping("/bookModifyForm")
	public String bookModifyForm(Model model , @RequestParam("booknumber") Long booknumber , Criteria criteria) {
		model.addAttribute("list",bookService.get(booknumber));
		return "/book/bookModifyForm";
	}
	
	@PostMapping("/bookModifyForm")
	public String bookModifyForm2(BookVO vo , RedirectAttributes rttr , Criteria criteria) {
		System.out.println("컨트롤러 도착");
		bookService.modifyWithAttach(vo);
		rttr.addFlashAttribute("msg","modify");
		return "redirect:/book/bookModify" + criteria.getListLink();
	}
	
	@GetMapping("/bookDelete")
	public String bookDelete(BookVO vo , RedirectAttributes rttr , Criteria criteria) {
		bookService.bookdelete(vo);
		rttr.addFlashAttribute("msg","delete");
		
		return "redirect:/book/bookModify" + criteria.getListLink();
	}
	
	
	
}
