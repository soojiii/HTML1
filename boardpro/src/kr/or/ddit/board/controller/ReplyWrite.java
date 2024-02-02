package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.config.StreamData;

/**
 * Servlet implementation class ReplyWrite
 */
@WebServlet("/ReplyWrite.do")
public class ReplyWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyWrite() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//
		request.setCharacterEncoding("utf-8");
		
		//요청시 전송 데이타 받기
		//String bonum = request.getParameter("bonum");
		
		String reqdata = StreamData.dataChange(request);
		
		//역직렬화
		
		Gson gson = new Gson();
		ReplyVO rvo = gson.fromJson(reqdata, ReplyVO.class);
		
		//service객체 얻기
		IBoardService service = BoardServiceImpl.getService();
		
		//메소드 호출
		int res = service.insertReply(rvo);
		
		//request에 저장
		request.setAttribute("result", res);
		
		//view페이지로 이동
		request.getRequestDispatcher("/boardview/result.jsp").forward(request, response);
		
	
	}

}
