<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
private Connection conn = null;
private ResultSet rs = null;
private PreparedStatement ps = null;

private String driver = "oracle.jdbc.driver.OracleDriver";
private String url = "jdbc:oracle:thin:@localhost:1521:xe";
private String user = "HSJ91";
private String password = "java";
%>

<%
	// 입력한 id 값을 가져온다.
	String userId= "a001";

	//OracleDriver클래스를 로드시킨다.
	Class.forName(driver);
	
	//db 연결객체
	conn = DriverManager.getConnection(url,user,password);
	
	//sql쿼리문 작성
	String sql = "select mem_id from member where mem_id = ?";
	
	// 실행객체
	ps = conn.prepareStatement(sql);
	
	// 실행문에 값 셋팅
	ps.setString(1, userId);
	
	// 실행
	rs = ps.executeQuery();
	
	// 실행결과 비교하기 - 사용가능 불가능 상태를 출력
	if(rs.next()){
%>
	<p><%= userId %> 는 사용 <span>불가능</span> 아이디 입니다.</p>	
<% 	}else{   %>
	<p><%= userId %> 는 사용 <span>가능</span> 아이디 입니다.</p>		
 <% }
%>
</body>
</html>