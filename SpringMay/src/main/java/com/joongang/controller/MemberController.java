package com.joongang.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joongang.domain.AuthVO;
import com.joongang.domain.MemberVO;
import com.joongang.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/member/*")
@Log4j2
public class MemberController {
	@Setter(onMethod_=@Autowired)
	private MemberService memberService;

	@GetMapping("/signup")
	public String signupForm() {
		return"/member/signupForm";
	}
	
	@GetMapping("/signupLv1")
	public String signupForm1() {
		return"/member/signupFormLv1";
	}
	
	@GetMapping("/signupLv2")
	public String signupForm2() {
		return"/member/signupFormLv2";
	}
	
	@GetMapping("/signupLv3")
	public String signupForm3() {
		return"/member/signupFormLv3";
	}
	
	@PostMapping("/signup")
	public String signupSubmit(MemberVO vo , HttpSession session) {
			memberService.signup(vo); 
			AuthVO authVO = new AuthVO(); 
			authVO.setUserid(vo.getUserid());
			authVO.setUsername(vo.getUsername());
			authVO.setTotalphone(vo.getTotalphone());
			authVO.setUserpw(vo.getUserpw());
			session.setAttribute("auth",authVO);
		return "redirect:/";
	}
	
	@PostMapping("/checkDuplicateId")	//아이디 중복확인
	@ResponseBody
	public String checkDuplicateId(@RequestBody String id) {
		String[] id1 = id.split("=");
		id = id1[0];
		boolean isDuplicate = memberService.checkIfIdIsDuplicate(id); //아이디 중복여부 확인
		if(isDuplicate) {
			System.out.println("중복여부 : " + isDuplicate );
			return "duplicate";
		} else{
			System.out.println("중복여부 : " + isDuplicate );
			return "unique";
		}
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return"/member/loginForm2";
	}
	
	@PostMapping("/login")
	public String loginSubmit(MemberVO vo , HttpSession session ,
			RedirectAttributes rttr) {
		try {
			AuthVO authVO = memberService.authenticate(vo);		
			session.setAttribute("auth", authVO);
			String userURI = (String) session.getAttribute("userURI");
			System.out.println("userURI : " + userURI);
			if(userURI != null) {
				session.removeAttribute("userURI");
				return "redirect:"+userURI; //  로그인이 필요해서 화면전환됐을떄 로그인 후 그 화면으로 바로 이동하게
			}
				return  "redirect:/";  //홈으로 리다이렉트
			
		} catch(Exception e) {
			rttr.addFlashAttribute("error",e.getMessage()); 
			rttr.addFlashAttribute("memberVO",vo);
			return "redirect:/member/login";	// 오류발생시 로그인화면으로 다시 이동
		} 
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.removeAttribute("auth");
		rttr.addFlashAttribute("msg","logout");
		return"redirect:/";
	}
	
	@GetMapping("/CheckPw")
	public String CheckPw() {
		return"/member/CheckPw";
	}
	
	@PostMapping("/CheckPw")
	public String CheckPw2(MemberVO vo , HttpSession session ,
			RedirectAttributes rttr) {
		try {	// 기존에 남아있는 세션을 불러와서 memberService.authenticate 돌린 후 authVO 를 세션으로 저장
			AuthVO authVO = (AuthVO) session.getAttribute("auth");	//authVO에 기존 session에 있던값을 저장
			MemberVO voo = new MemberVO();							//MemberVO 생성
			voo.setUserid(authVO.getUserid());						// 세션에 저장된 id 셋팅
			voo.setUserpw(vo.getUserpw());							// 입력된 pw 셋팅
			authVO = memberService.authenticate(voo);				// voo에 셋팅된 id로 회원정보를 불러와서 비밀번호 확인
			authVO.setUserpw(vo.getUserpw());						// 비밀번호는 암호화되기 전 비밀번호로 저장
			session.setAttribute("auth", authVO);
			System.out.println("일치");
			return  "redirect:/member/editInfo";  
		} catch(Exception e) {
			rttr.addFlashAttribute("pwIncorrect","pwIncorrect"); 
			System.out.println(e.getMessage());
			return "redirect:/member/CheckPw";
		} 
	}
	
	@GetMapping("/deleteMember")
	public String deleteMember1() {
		return "/member/deleteMember";
	}
	
	@PostMapping("/deleteMember")
	public String deleteMember2(MemberVO vo , HttpSession session ,
			RedirectAttributes rttr) {
		try {	// 기존에 남아있는 세션을 불러와서 memberService.authenticate 돌린 후 authVO 를 세션으로 저장
			AuthVO authVO = (AuthVO) session.getAttribute("auth");	//authVO에 기존 session에 있던값을 저장
			MemberVO voo = new MemberVO();							//MemberVO 생성
			voo.setUserid(authVO.getUserid());						// 세션에 저장된 id 셋팅
			voo.setUserpw(vo.getUserpw());							// 입력된 pw 셋팅
			memberService.deleteMember(voo);		
			session.removeAttribute("auth");
			rttr.addFlashAttribute("msg","deleteFinish"); 
			return  "redirect:/";  
		} catch(Exception e) {
			rttr.addFlashAttribute("pwIncorrect","pwIncorrect"); 
			return "redirect:/member/deleteMember";
		} 
	}
	
	
	@GetMapping("/editInfo")
	public String editInfo(HttpSession session , Model model) {
		AuthVO authVO = (AuthVO) session.getAttribute("auth");	//세션에 저장된값 불러오기
		MemberVO vo = new MemberVO();
		vo.setUserid(authVO.getUserid());						//로그인된 id 값 불러와서 vo에 셋팅
		vo = memberService.getUserInfo(vo);						// id값으로 회원정보 불러오기
		vo.setUserpw("");						// pw값은 초기화(정보수정에 pw란을 비우기위함
		String[] separateEmail = vo.getEmail().split("@");		// 하나로 저장된 풀email을 @로 나눈다
		vo.setEmail1(separateEmail[0]);							// 찢어진 앞 뒤 값을 저장
		vo.setEmail2(separateEmail[1]);
		model.addAttribute("MemberVO",vo);						//회원정보 내보내기
		return "/member/editInfo";
	}
	
	@PostMapping("/editInfo")
	public String editInfo(MemberVO vo , HttpSession session) {
		memberService.editInfo(vo); 
		AuthVO authVO = new AuthVO(); 
		authVO.setUserid(vo.getUserid());
		authVO.setUsername(vo.getUsername());
		authVO.setTotalphone(vo.getTotalphone());
		authVO.setUserpw(vo.getUserpw());
		session.setAttribute("auth",authVO);
	return "redirect:/";
	}
	
	@GetMapping("/findId")
	public String findId() {
		return "/member/findId";
	}
	
	@PostMapping("/findId")
	public String findIdResult(MemberVO vo , Model model , RedirectAttributes rttr) {
		try{
			MemberVO resultVO = memberService.findId(vo);
			model.addAttribute("userId",resultVO.getUserid());
			return "/member/findIdResult";
		} catch(Exception e) {
			rttr.addFlashAttribute("error","nonuser"); 
			return "redirect:/member/findId";
		}
	}
	
	@GetMapping("/findPw")
	public String findPw() {
		return "/member/findPw";
	}
	
	@PostMapping("/findPw")
	public String findPwResult(MemberVO vo , HttpSession session , RedirectAttributes rttr) {
		try {
			MemberVO resultVO = memberService.findIdForPw(vo);
			if(resultVO != null) {
				session.setAttribute("userId",resultVO.getUserid());
				return "/member/findPwResult";
			} else {
				rttr.addFlashAttribute("error","nonuser");
				return "redirect:/member/findPw";
			}
		} catch(Exception e){
			System.out.println("오류발생");
			rttr.addFlashAttribute("error","nonuser");
			return "redirect:/member/findPw";
		}
	}
	
	@PostMapping("/modifyPw")
	public String modifyPw(MemberVO vo , HttpSession session) {
		vo.setUserid((String)session.getAttribute("userId"));
		memberService.modifyPw(vo);
		return "redirect:/";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
