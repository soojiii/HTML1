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
<style>
table{
border : 1.5px solid skyblue;
}
td{
width : 120px;
height : 35px;
text-align: center;
border : 1.5px solid skyblue;
}
</style>
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
Class.forName(driver);
conn = DriverManager.getConnection(url, user, password);
String sql = "select MEM_ID, MEM_NAME, MEM_HP from MEMBER";
ps = conn.prepareStatement(sql);
rs = ps.executeQuery();
%>

<table>
<tr>
	<td>아이디</td>
	<td>이름</td>
	<td>전화번호</td>
</tr>
<%
while(rs.next()){
%>
<tr>
	<td><%=rs.getString("mem_id") %></td>
	<td><%=rs.getString("mem_name") %></td>
	<td><%=rs.getString("mem_hp") %></td>
</tr>
<%
}
%>
</table>
</body>
</html>