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
//요청시 전송데이타 받기 "gu=P101"
//String lgu = request.getParameter("gu");

//JSON.stringify({"prod_lgu" : guvalue}) 형식의 직렬화 데이타
StringBuffer buf = new StringBuffer();  //여러줄일경우를 생각해서 씀
String line = null;   //한줄이면 이것만 써도됨
   
BufferedReader reader = request.getReader();
while((line=reader.readLine())!=null){
	   buf.append(line);
};
String reqdata = buf.toString(); //{"prod_lgu" : "P101"};
   
//역직렬화 - 객체 형태로 변환
Gson gson = new Gson();
ProdVO vo = gson.fromJson(reqdata, ProdVO.class);
//vo.setProd_lgu("P101");

String lgu = vo.getProd_lgu();


//service 객체 얻기
IProdService service = ProdServiceImpl.getService();

//service 메소드호출 - 결과값 받기 - List<ProdVO>
List<ProdVO> list = service.selectByLgu(lgu);  //P900

//결과값을 request에 저장
request.setAttribute("lgulist", list);

//view페이지로 이동
request.getRequestDispatcher("/0122/prodView.jsp").forward(request, response);


%>
</body>
</html>