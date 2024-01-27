<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	
	$('#logout').on('click', function(){
		fetch('<%=request.getContextPath()%>/LogOutServlet.ddit')
		.then(response=>{  //콜백
			console.log(response);
			if(response.ok){
				return response.text()
			}else{
				throw new Error(`${response.status}`)
			}
		})
		.then(res=>{
			//$('.dlog').html(res);
			location.href = '<%=request.getContextPath()%>/start/index.jsp'
		})
		.catch(error=>{
			alert(error);
		})
	})
	
	
	$('#login').on('click', function(){
		//입력한 id와 pass를 가져온다
		vid = $('#id').val().trim();
		vpass = $('#pass').val().trim();
		
		vdata = {"mem_id" : vid, "mem_pass" : vpass}
		
		$.ajax({
			url : '<%=request.getContextPath()%>/LogProServlet.ddit',
			data : JSON.stringify(vdata),
			type : 'post',
			success : function(res){
				//$('.dlog').html(res);
				location.href = '<%=request.getContextPath()%>/start/index.jsp'
			},
			error : function(xhr){
				alert("상태 : " +xhr.status)
			},
			dataType : 'html'
		})
	})
})

</script>
</head>
<body>
<%
 //세션 로그인 값 
 //controller에서 저장한 데이타 꺼내기
 
 	//HttpSession  session2 = request.getSession();
     MemberVO  vo = (MemberVO)session.getAttribute("loginok");
     String check = (String)session.getAttribute("check");
    
     System.out.println("login : " + vo);
     System.out.println("check : " + check);
     
     if(vo == null){
 %>
      <input id="id" type="text" placeholder="id" >&nbsp;&nbsp;
      <input id="pass" type="password" placeholder="password">&nbsp;&nbsp; 
      <button id="login" type="button">로그인</button><br> 
       
     
 <%   }else  if(vo != null ){  %>
    
       <span><%= vo.getMem_id() %>님 환영합니다</span>&nbsp;&nbsp;
       <button id="logout" type="button">로그아웃</button><br>
        
 <%  } %>
  
   <%    
      if(check == "false" ){
  %>
    	  <span id="check">로그인 오류 또는 비회원입니다</span>
  <%
      }
 %> 
 
</body>
</html>