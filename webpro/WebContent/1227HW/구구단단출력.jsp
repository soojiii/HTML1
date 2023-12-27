<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table{
  border : 20px solid skyblue;
  border-spacing : 20px;
}
td{
  width : 50px;
  height : 50px;
  text-align: center;
  border : none;
  border-bottom: 1px solid skyblue;
  
}
</style>
</head>
<body>
<%

  int gugu = Integer.parseInt(request.getParameter("gugu"));
  
	String str = "<table border='1'>";
  
	str += "<tr>";
  		  for(int i=1; i<=9; i++){
  			str += "<td>"+gugu+"</td>";
  			str += "<td>*</td>";
  			str += "<td>"+i+"</td>";
  			str += "<td>=</td>";
  			str += "<td>"+(gugu*i)+"</td>";
	str += "</tr>";
 	 	  }
 	str += "</table>";
  
%>
<br>
<%= str %>
</body>
</html>


