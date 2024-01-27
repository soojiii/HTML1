package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.or.ddit.config.StreamData;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

/**
 * Servlet implementation class LogProServlet
 */
@WebServlet("/LogProServlet.ddit")
public class LogProServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqdata = StreamData.dataChange(request);
		//{"mem_id : vid, "mem_pass" : vpass}
		
		//vo객체로 역직렬화
		Gson gson = new Gson();
		MemberVO vo = gson.fromJson(reqdata, MemberVO.class);
		//vo.setMem_id("a001");
		//vo.setMem_pass("asdfasdf");
		
		//service객체 얻기
		IMemberService service = MemberServiceImpl.getService();
		
		//service메소드 호출 - 결과값 얻기
		MemberVO mvo = service.logSelect(vo);
		
		//session객체 생성
		HttpSession session = request.getSession();
		
		//로그인성공 실패 ?
		if(mvo != null) {
			//로그인 성공
			//session에 저장
			session.setAttribute("loginok", mvo);
			session.setAttribute("check", "true");  //"true"그냥문자임!!!
			
		}else {
			//로그인 실패
			session.setAttribute("check", "false");  //"false"그냥문자임!!!
			
		}
		
		//view페이지로 이동 - logpro.jsp - html결과 생성
		request.getRequestDispatcher("/start/logpro.jsp").forward(request, response);
		
		
	}

}
