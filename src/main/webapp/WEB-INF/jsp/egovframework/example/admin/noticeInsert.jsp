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
<script>
function noticeInsertProcess(){
	oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD",[]);
	var data = $("#insertForm").serialize();
	var url = "/business/admin/board/noticeInsertProcess.do";
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
</script>
	<%-- THIS PAGE IS ${type} - ${subType} --%>
	<div id="wrapper">
		<jsp:include page="../adminFrame/top.jsp"></jsp:include>
		<jsp:include page="../adminFrame/left.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">공지사항 등록</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
						</div>
						<div class="panel-body">
							<form name="insertForm" id="insertForm" method="post">
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label>제목</label> 
											<input class="form-control" placeholder="제목" name="title" id="title" maxlength="100">
										</div>
									</div>
									<div class="col-lg-3">
										<div class="form-group">
											<label>상단 고정 ※최대 3개까지 고정 (최신글 기준)</label>
											<div class="radio">
												<label class="radio-inline"> 
													<input type="radio" name="top" value="Y"> 고정
												</label> 
												<label class="radio-inline"> 
													<input type="radio" name="top" value="N" checked> 고정안함
												</label>
											</div>
										</div>
									</div>
									<div class="col-lg-3">
										<div class="form-group">
											<label>우측고정 ※1개만 고정가능 (최신글 기준)</label>
											<div class="radio">
												<label class="radio-inline"> 
													<input type="radio" name="right" value="Y"> 고정
												</label> 
												<label class="radio-inline"> 
													<input type="radio" name="right" value="N" checked>고정안함
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>내용</label>
											<textarea class="form-control" rows="20" name="text" id="smartEditor"></textarea>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<button type="button" onclick="javascript:noticeInsertProcess()" class="btn btn-default">글 등록</button>
		</div>
	</div>
	<jsp:include page="../adminFrame/footer.jsp"></jsp:include>
<script>
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
</script>
</body>
</html>