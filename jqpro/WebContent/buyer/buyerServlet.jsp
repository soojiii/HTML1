<%@page import="kr.or.ddit.buyer.vo.BuyerVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.buyer.service.BuyerServiceImpl"%>
<%@page import="kr.or.ddit.buyer.service.IBuyerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
IBuyerService service = BuyerServiceImpl.getService();

List<BuyerVO> list = service.listBuyer();

request.setAttribute("list", list);

request.getRequestDispatcher("/buyer/buyerView.jsp").forward(request, response);


%>