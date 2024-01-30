/**
 * 
 */
$.boardWriteServer = function(){
	$.ajax({
		url : `${mypath}/BoardWrite.do`,
		method : 'post',
		data : JSON.stringify(fdata),
		success : function(res){
			//alert(res.flag);
			
			if(res.flag=="성공"){
				currentPage=1;
				$.listPageServer();
			}
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
}


$.listPageServer = function(){
	//검색 type과 검색어 가져오기 - 최초 실행시에는 없다
	vtype = $('#stype option:selected').val().trim();
	vword = $('#sword').val().trim();
	
	$.ajax({
		url : `${mypath}/BoardList.do`,
		method : 'post',
		data : JSON.stringify({
			"page" : currentPage,
			"stype" : vtype,
			"sword" : vword
		}),
		success : function(res){
		 code = "";
		 code = `<div class="container mt-3">
  			<div id="accordion">`
	
		$.each(res.datas, function(i, v){
			cont = v.content;
			
			cont = cont.replaceAll(/\n/g, "<br>")
			
    code += `<div class="card">
      <div class="card-header">
        <a class="btn" data-bs-toggle="collapse" href="#collapse${v.num}">
          ${v.subject}
        </a>
      </div>
      <div id="collapse${v.num}" class="collapse" data-bs-parent="#accordion">
        <div class="card-body">
          <div class="p12">
            <p class="p1">작성자 <span>${v.writer}</span>&nbsp;&nbsp;&nbsp;&nbsp;
           				    이메일<span>${v.mail}</span>&nbsp;&nbsp;&nbsp;&nbsp;
         				    조회수<span>0</span>&nbsp;&nbsp;&nbsp;&nbsp;
            			    날짜<span>${v.wdate}</span>&nbsp;&nbsp;&nbsp;&nbsp;</p>
            
            <p class="p2">
             <p class="p2">`

				if(uvo!=null && uvo.mem_name== v.writer){
			  code += `<input type="button" value="수정" name="modify" class="action">
              <input type="button" value="삭제" name="delete" class="action">`
            }
			code+=`</p> 
			
          </div>
          <p class="p3">${cont}</p>
          <p class="p4">
            <textarea rows="" cols="50" class="area"></textarea>
            <input type="button" value="등록" name="reply" class="action"> 
          </p>
        </div>
      </div>
    </div>`
 	}) //$.each반복문
 code +=`</div>
</div>`	
			$('#result').html(code);
			
			pager = $.pageList(res.sp, res.ep, res.tp);
			$('#pagelist').html(pager);
		},
		error : function(xhr){
			alert("상태 : " +xhr.status);
			
		},
		dataType : 'json'
		
	})
}


$.pageList = function(sp, ep, tp){
	pager = `<ul class="pagination">`;
	//이전버튼
	if(sp>1){
		pager += `<li class="page-item"><a id="prev" class="page-link" href="#">Previous</a></li>`
	}
	
	//페이지번호
	for(i=sp; i<=ep; i++){
		if(i==currentPage){
			pager += `<li class="page-item active"><a class="page-link pageno" href="#">${i}</a></li>`
		}else{
			pager += ` <li class="page-item"><a class="page-link pageno" href="#">${i}</a></li>`
		}
	}
	
	//다음
	if(tp>ep){
		pager += `<li class="page-item"><a id="next" class="page-link" href="#">Next</a></li>`
	}
	
	pager += `</ul>`;
	
    return pager;
}


