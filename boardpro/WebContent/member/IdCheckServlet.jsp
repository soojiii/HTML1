<%@page import="kr.or.ddit.member.service.MemberServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IMemberService"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
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
//여기는 서블릿 controller이다

//요청시 전송 데이타 받기 
//String memId = request.getParameter("id");

StringBuffer buf = new StringBuffer();  //여러줄일경우를 생각해서 씀
String line = null;   //한줄이면 이것만 써도됨
 
BufferedReader reader = request.getReader();
while((line=reader.readLine())!=null){
	   buf.append(line);
};
String reqdata = buf.toString(); //{"mem_id" : "a001"};
 
//역직렬화 - 객체 형태로 변환
Gson gson = new Gson();
MemberVO vo = gson.fromJson(reqdata, MemberVO.class);
//vo.setMem_id("korea")

String memId = vo.getMem_id();

//service객체 얻기
IMemberService service = MemberServiceImpl.getService();

//service메소드 호출 - 결과값받기
String res = service.selectById(memId);

//결과값을 request에 저장
request.setAttribute("res", res);

//view페이지로 이동
request.getRequestDispatcher("/member/idView.jsp").forward(request, response);


%>
</body>
</html>