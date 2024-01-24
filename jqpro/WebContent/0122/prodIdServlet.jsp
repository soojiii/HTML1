<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.prod.service.ProdServiceImpl"%>
<%@page import="kr.or.ddit.prod.service.IProdService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//요청시 전송데이타 받기
	//String id = request.getParameter("id");

	//직렬화된 데이타를 stream을 이용하여 가져온다
	StringBuffer buf = new StringBuffer();
	String line =null;
	
	BufferedReader reader = request.getReader();
	while((line = reader.readLine()) !=null){
		buf.append(line);
	}
	
	String reqdata = buf.toString();
	
	Gson gson = new Gson();
	ProdVO vo = gson.fromJson(reqdata, ProdVO.class);
	//vo.setprod_id("P101000001")
	
	String id = vo.getProd_id();
	
	//service객체 얻기
	IProdService service = ProdServiceImpl.getService();
	//service메소드 호출 - 결과값 - ProdVO
	ProdVO pvo = service.selectById(id);
	//결과값을 request에 저장
	request.setAttribute("idlist", pvo);
	//view페이지로 이동 - /0122/prodIdView.jsp
	request.getRequestDispatcher("/0122/prodIdView.jsp").forward(request, response);
	
%>
</body>
</html>