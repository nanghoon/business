<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../adminFrame/header.jsp"></jsp:include>
</head>
<script src="/business/se2/js/HuskyEZCreator.js" charset="utf-8" ></script>
<body>
	<div id="wrapper">
		<jsp:include page="../adminFrame/top.jsp"></jsp:include>
		<jsp:include page="../adminFrame/left.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">공지사항 수정</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading"> 
						</div>
						<div class="panel-body">
							<form name="noticeDetail" id="noticeDetail" method="post" enctype="multipart/form=data">
								<input type="hidden" name="idx" value="${info.idx}"/>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label>제목</label> 
											<input class="form-control" placeholder="사이트명" value="${info.title}" name="title" id="title" maxlength="100">
										</div>
									</div>
									<div class="col-lg-3">
										<div class="form-group">
											<label>상단 고정 ※최대 3개까지 고정 (최신글 기준)</label>
											<div class="radio">
												<label class="radio-inline"> 
													<input type="radio" name="top" value="Y" <c:if test="${info.top == 'Y' }">checked</c:if>> 고정
												</label> 
												<label class="radio-inline"> 
													<input type="radio" name="top" value="N" <c:if test="${info.top == 'N' }">checked</c:if>>고정안함
												</label>
											</div>
										</div>
									</div>
									<div class="col-lg-3">
										<div class="form-group">
											<label>우측고정 ※1개만 고정가능 (최신글 기준)</label>
											<div class="radio">
												<label class="radio-inline"> 
													<input type="radio" name="rightYn" value="Y" <c:if test="${info.rightYn == 'Y' }">checked</c:if>> 고정
												</label> 
												<label class="radio-inline"> 
													<input type="radio" name="rightYn" value="N" <c:if test="${info.rightYn == 'N' }">checked</c:if>>고정안함
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>내용</label>
											<textarea class="form-control" rows="20" name="text" id="smartEditor">${info.text}</textarea>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-3">
										<div class="form-group">
											<label>조회수</label> 
											<input class="form-control" value="${info.view}" onkeyup="SetNum(this);" name="view" id="view">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<button type="button" onclick="noticeUpdateProcess()" class="btn btn-default">글 수정</button>
			<button type="button" onclick="noticeDetailDel(${info.idx})" class="btn btn-outline btn-danger">글삭제</button>
		</div>
	</div>
	<jsp:include page="../adminFrame/footer.jsp"></jsp:include>
	<script>
	function SetNum(obj){
		val=obj.value;
		re=/[^0-9]/gi;
		obj.value=val.replace(re,"");
	}
	var oEditors = []; 
	nhn.husky.EZCreator.createInIFrame({ 
		oAppRef : oEditors, 
		elPlaceHolder : "smartEditor",  
		sSkinURI : "/business/se2/SmartEditor2Skin.html",  
		fCreator : "createSEditor2", 
		htParams : {  
			bUseToolbar : true,  
			bUseVerticalResizer : false,
			//bSkipXssFilter : true,
			bUseModeChanger : false 
			},
		fOnAppLoad : function(){
		   oEditors.getById["smartEditor"].exec("PASTE_HTML", ['${text}']);
		  },		
	});	
	function noticeUpdateProcess(){
		oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD",[]);
		var data = $("#noticeDetail").serialize();
		var url = "/business/admin/board/noticeUpdateProcess.do";
		$.ajax({
			type:'post',
			url : url,
			data: data,
			success:function(data){
				alert(data.msg)
				if(data.result == 'success'){
					location.href='/business/admin/board/notice.do';
				}
			},
			error:function(e){
				console.log('ajaxError' + e);
			}
		});
	}
	function noticeDetailDel(idx){
		if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
			jQuery.ajax({
				type:'get',
				url:"/business/admin/board/noticeDetailDelete.do?idx="+idx,
				success:function(data){
					if(data.result == 'success'){
						alert("삭제되었습니다.");
						location.href='/business/admin/board/notice.do';
					}else{
						alert("에러가 발생했습니다. 다시 시도해주세요");
						location.reload();
					}
				},
				errer:function(e){
					console.log('error' + e);
				}
			});
		}
	}
	</script>
</body>
</html>