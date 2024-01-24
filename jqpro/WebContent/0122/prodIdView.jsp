<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProdVO pvo =  (ProdVO)request.getAttribute("idlist");	
%>

	{
		"prod_id" : "<%= pvo.getProd_id() %>",
		"prod_name" : "<%= pvo.getProd_name() %>",
		"prod_lgu" : "<%= pvo.getProd_lgu() %>",
		"prod_buyer" : "<%= pvo.getProd_buyer() %>",
		"prod_price" : "<%= pvo.getProd_price() %>",
		"prod_sale" : "<%= pvo.getProd_sale() %>"
	}

