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
 * Servlet implementation class ReplyUpdate
 */
@WebServlet("/ReplyUpdate.do")
public class ReplyUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String reqdata = StreamData.dataChange(request);
		
		//역직렬화
		Gson gson = new Gson();
		ReplyVO rvo = gson.fromJson(reqdata, ReplyVO.class);
		//rvo.setRenum(12)
		//rvo.setCont("sksk")
		
		IBoardService service = BoardServiceImpl.getService();
		
		int res = service.updateReply(rvo);
		
		request.setAttribute("result", res);
		
		request.getRequestDispatcher("/boardview/result.jsp").forward(request, response);
		
	}

}
