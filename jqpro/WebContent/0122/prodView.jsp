<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//컨트롤러에서 저장한 값을 꺼내기
List<ProdVO> list = (List<ProdVO>)request.getAttribute("lgulist");
if(list!=null && list.size()>0){
%>
{
	"flag" : "ok",
	"datas" : 
[
	<%
	for(int i=0; i<list.size(); i++){
		ProdVO vo = list.get(i);
		if(i>0) out.print(",");
	%>		
		{
			"prod_id" : "<%= vo.getProd_id() %>",
			"prod_name" : "<%= vo.getProd_name() %>"
		}
<% 
	}
%>
]
}
<% }else{ %>
	{
	"flag" : "no"
	}
	
<%	
}
%>
