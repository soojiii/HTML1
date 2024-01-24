<%@page import="kr.or.ddit.buyer.service.BuyerServiceImpl"%>
<%@page import="kr.or.ddit.buyer.service.IBuyerService"%>
<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
IBuyerService service = BuyerServiceImpl.getService();

String id = request.getParameter("id");

BuyerVO vo = service.selectBuyer(id);

request.setAttribute("vo", vo);

request.getRequestDispatcher("/buyer/buyerView2.jsp").forward(request, response);

%>