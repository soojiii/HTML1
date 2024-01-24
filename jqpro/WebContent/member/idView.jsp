<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//controller에서 저장한 데이타 꺼내기
String res = (String)request.getAttribute("res");
if(res == null){
%>
	{
		"flag" : "사용 가능 id"
	}
	
<% }else{ %>
	{
		"flag" : "사용 불가능 id"
	}
<%	
}
%>