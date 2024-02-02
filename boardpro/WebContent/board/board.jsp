<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="../css/board.css" rel="stylesheet">

<script src="../js/board.js"></script>

<script src="../js/jquery.serializejson.min.js"></script>

<script>
<%
//로그인 체크 - session의 값을 가져오기 - 비교하기
MemberVO vo = (MemberVO)session.getAttribute("loginok");

//json형태로
String ss = null;

Gson gson = new Gson();
if(vo !=null) ss= gson.toJson(vo);

/* 	ss={"mem_id" : "a001",
		"mem_name" : "김은대"
	} */

%>

uvo = <%=ss%>

currentPage =1;
mypath = '<%=request.getContextPath() %>'

reply={ }; //객체;
board ={ };

$(document).ready(function(){
	//시작하자마자 listPageServer를 실행하여
	//게시판 리스트 출력 된다
   $.listPageServer();
	
	//검색 이벤트
	$('#search').on('click', function(){
		$.listPageServer();
		
		//modifyform이 열려 있는지 비교
		if($('#modifyform').css('display') != "none"){
			//열려있는 상태
			replyReset();
		}
		
	})
	
	//next이벤트
	$(document).on('click', '#next', function(){
		currentPage = parseInt($('.pageno').last().text()) +1;
		$.listPageServer();
		
		//modifyform이 열려 있는지 비교
		if($('#modifyform').css('display') != "none"){
			//열려있는 상태
			replyReset();
		}
	})
	//prev이전 이벤트
	$(document).on('click', '#prev', function(){
		currentPage = parseInt($('.pageno').first().text()) -1;
		$.listPageServer();
		
		//modifyform이 열려 있는지 비교
		if($('#modifyform').css('display') != "none"){
			//열려있는 상태
			replyReset();
		}
	})
	
	//페이지번호.pageno 이벤트
	$(document).on('click', '.pageno', function(){
		currentPage = parseInt($(this).text());
		$.listPageServer();
	})
	
	//글쓰기 이벤트
	$('#write').on('click', function(){
		if(uvo==null){
			alert("로그인하세요");
		}else{
			$('#wModal').modal('show');
			$('#wwriter').val(uvo.mem_name);			
		}		
	})
	
	//글쓰기 전송 이벤트
/* 	$('#wform').on('submit', function(){
		event.preventDefault();
		//입력한 모든값을 가져온다
		//서버로 전송
		//모달창 닫기
	}) */ // 전송을 submit으로 만들었을때의 방법
	
	$('#wsend').on('click', function(){
		//입력한 모든값을 가져온다
		fdata=$('#wform').serializeJSON();
		console.log(fdata);
		
		//서버로 전송
		$.boardWriteServer();
		
		//모달창 닫기
		$('.txt').val("");
		$('#wModal').modal('hide');
		
	})
	
	//수정, 삭제, 등록, 제목, 댓글수정 클릭이벤트
	$(document).on('click', '.action', function(){
		vaction = $(this).attr('name');
		vidx = $(this).attr('idx').trim();
		
		gtarget = this;
		
		if(vaction == "delete"){
			//alert(vidx+"번 글을 삭제합니다");
			$.boardDeleteServer();
			
			
		}else if(vaction == "modify"){
			alert(vidx+"번 글을 수정합니다");		
			
			$('#mnum').val(vidx);
			
			//본문의 게시글 내용으로 모달창에 출력- 수정을 위하여
			vparent = $(this).parents('.card');
			wr = $(vparent).find('.wr').text().trim();
			em = $(vparent).find('.em').text().trim();
			ti = $(vparent).find('a').text().trim();
			wp3 = $(vparent).find('.wp3').html().trim();
			
			wp3 = wp3.replaceAll(/<br>/g, "")
			
			$('#mModal #mwriter').val(wr);
			$('#mModal #msubject').val(ti);
			$('#mModal #mmail').val(em);
			$('#mModal #mcontent').val(wp3);
			
			$('#mModal').modal('show');
			
		}else if(vaction == "reply"){
			//alert(vidx+"번 글에 댓글을 답니다");	
			
			
			//입력한 값을 가져온다
			vcont = $(this).prev().val();
	
			reply.cont = vcont;
			reply.name = uvo.mem_name;
			reply.bonum = vidx;
			
			//서버로 전송
			$.replyInsertServer();
			
			//입력 후 비우기
			$(this).prev().val("");
			
			
		}else if(vaction == "title"){
			//alert(vidx + "번 글의 댓글 가져오기")
			$.replyList();
			
		}else if(vaction == "r_modify"){
			alert(vidx + "번 댓글을 수정합니다")
			
			//modifyform이 열려 있는지 비교
			if($('#modifyform').css('display') != "none"){
				//열려있는 상태
				replyReset();
			}
			
			vp3 = $(this).parents('.reply-body').find('.p3');
			
			//원래내용을 가져온다
			modifycont = $(vp3).html().trim();  //<br>포함
			
			//<br>을 변경
			mcont = modifycont.replaceAll(/<br>/g,"\n")
			
			//수정폼에 출력
			$('#modifyform textarea').val(mcont);
			
			//수정폼을 p3으로 이동 - append
			$(vp3).empty().append($('#modifyform'));
			
			//수정폼을 보이게
			//$('#modifyform').css('display', 'block');
			$('#modifyform').show();
			
			
		}else if(vaction == "r_delete"){
			alert(vidx + "번 댓글을 삭제합니다")
			
			$.replyDelete();
		}
	})
	
	//댓글 수정창에서 취소버튼 클릭했을때
	$('#btnreset').on('click', function(){
		replyReset();
		
	})
	
	replyReset = function(){
		p3 = $('#modifyform').parent();
		
		//modifyform를 body로 이동 - 안보이도록 설정
		$('body').append($('#modifyform'));
		
		$('#modifyform').hide();
		
		//p3에 원래내용 modifycont를 출력
		$(p3).html(modifycont);
	}
	
	
	//댓글 수정창에서 확인버튼 클릭했을때
	$('#btnok').on('click', function(){
		//입력한 내용을 가져온다 - \n 포함
		modicont = $('#modifyform textarea').val();
		
		modiout = modicont.replace(/\n/g, "<br>");
		
		//p3을 검색 접근
		p3 = $('#modifyform').parent();
		
		//modiform을 body로 이동
		$('#modifyform').appendTo($('body'));
		$('#modifyform').hide();
		
		// p3에 출력 - db수정 성공 후
		//$(p3).html(modiout);
		
		//서버로전송 - modicont, vidx
		reply.cont = modicont;
		reply.renum = vidx;
		$.replyUpdateServer();
		
	})
	
	//글수정 모달창에서 수정입력하고 전송 버튼 클릭
	$("#msend").on("click", function(){
		//모달창에서 새로입력한 내용들을 가져온다 - 
		//subject, mail, password, content
		board.num = vidx
		board.subject =$('#mModal #msubject').val();
		board.password = $('#mModal #mpassword').val();
		board.mail = $('#mModal #mmail').val();
		board.content = $('#mModal #mcontent').val();
		
		//서버로 전송 - 성공시 본문의 내용을 모달창 내용으로 변경한다
		$.boardUpdateServer();
		
		//모달창 닫기
		//입력내용 지우기
		$('#mModal.txt').val();
		$('#mModal').modal('hide');
		
		
	})
	
	
})//document ready function
</script>
</head>
<body>

<div id="modifyform">
	<textarea rows="5" cols="40"></textarea>
	<input type="button" value="확인" id="btnok">
	<input type="button" value="취소" id="btnreset">
</div>

<h1>게시판</h1>
<input type="button" value="글쓰기" id="write">
<br>
<br>

<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="javascript:void(0)">Logo</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mynavbar">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
      </ul>
      <form class="d-flex">
         <select class="form-select" id="stype">
            <option value="">전체</option>
            <option value="writer">작성자</option>
            <option value="subject">제목</option>
            <option value="content">내용</option>
         </select>
        <input id="sword"class="form-control me-2" type="text" placeholder="Search">
        <button id="search" class="btn btn-primary" type="button">Search</button>
      </form>
    </div>
  </div>
</nav>

<div id="result"></div>
<br><br>
<div id="pagelist"></div>

<br>
<!-- 글쓰기 The Modal -->
<div class="modal" id="wModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">글쓰기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form name="wform" id="wform">
        	<label>제목</label>
        	<input type="text" class="txt" id="wsubject" name="subject"><br>
        	
        	<label>이름</label>
        	<input readonly="readonly" class="txt" type="text" id="wwriter" name="writer"><br>
        	
        	<label>메일</label>
        	<input type="text" class="txt" id="wmail" name="mail"><br>
        	
        	<label>비밀번호</label>
        	<input type="text" class="txt" id="wpassword" name="password"><br>
        	
        	<label>내용</label>
        	<br>
        	<textarea rows="5"  cols="40" class="txt" id="wcontent" name="content"></textarea>
        	<br>
        	<br>
        	<input type="button" value="전송" id="wsend">
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- 글쓰기 The Modal 끝-->


<!-- 글수정 The Modal -->
<div class="modal" id="mModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">글수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form name="mform" id="mform">
        	<input type="hidden" name="num" id="mnum" class="txt">
        
        	<label>제목</label>
        	<input type="text" class="txt" id="msubject" name="subject"><br>
        	
        	<label>이름</label>
        	<input readonly="readonly" class="txt" type="text" id="mwriter" name="writer"><br>
        	
        	<label>메일</label>
        	<input type="text" class="txt" id="mmail" name="mail"><br>
        	
        	<label>비밀번호</label>
        	<input type="password" class="txt" id="mpassword" name="password"><br>
        	
        	<label>내용</label>
        	<br>
        	<textarea rows="5"  cols="40" class="txt" id="mcontent" name="content"></textarea>
        	<br>
        	<br>
        	<input type="button" value="전송" id="msend">
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

</body>
</html>