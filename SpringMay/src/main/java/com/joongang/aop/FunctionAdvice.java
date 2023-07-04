package com.joongang.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.joongang.domain.BoardVO;
import com.joongang.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component	//@Component is a class level annotation
public class FunctionAdvice {
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder; 

//	@Around("execution(* com.joongang.service.BoardService.modify(..))")
//	public Object boardModify(ProceedingJoinPoint pjp) {
//		Object result = null;
//		try {
//			BoardVO vo = (BoardVO) pjp.getArgs()[0];
//			vo.setTitle("TT"+vo.getTitle());
//			result = pjp.proceed();
//		} catch(Throwable e) {
//			e.printStackTrace();
//		}
//		return result;
//	}
	
	@Around("execution(* com.joongang.service.MemberService.signup(..))")
	public Object memberSignup(ProceedingJoinPoint pjp) {
		Object result = null;
		try {
			MemberVO vo = (MemberVO) pjp.getArgs()[0];
			vo.setUserpw(pwencoder.encode(vo.getUserpw()));
			result = pjp.proceed();
		} catch(Throwable e) {
			e.printStackTrace();
		}
		return result;
	}
	
//	@Before("execution(* com.joongang.service.MemberService.signup(..)")
//	public void memberSignup(JoinPoint jp) {
//		try {
//			MemberVO vo = (MemberVO) jp.getArgs()[0];
//			vo.setUserpw(pwencoder.encode(vo.getUserpw()));
//		} catch(Throwable e) {
//			e.printStackTrace();
//		}
//	}
	
	
	//all methods in BoardService class
//	@Before("execution(* com.joongang.service.BoardService.*(..))")
//	public void boardBefore() {
//		log.info("----------------------boardBefore-------------------");
//	}
	
	
}
