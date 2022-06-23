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
function guideInsertProcess(){
	oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD",[]);
	var data = $("#insertForm").serialize();
	var url = "/business/admin/guide/insertProcess.do";
	$.ajax({
		type:'post',
		url : url,
		data: data,
		success:function(data){
			alert(data.msg)
			if(data.result == 'success'){
				location.reload();
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
					<h1 class="page-header">
						<c:choose>
							<c:when test="${info.kind == 1}">사이트소개</c:when>
							<c:when test="${info.kind == 2}">이용약관</c:when>
							<c:when test="${info.kind == 3}">개인정보처리방침</c:when>
							<c:when test="${info.kind == 4}">이메일 무단수집 거부</c:when>
							<c:when test="${info.kind == 5}">책임의 한계와 법적고지</c:when>
						</c:choose>
					</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
						</div>
						<div class="panel-body">
							<form name="insertForm" id="insertForm" method="post">
								<input type="hidden" name="idx" value="${info.idx}"/>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>내용</label>
											<textarea class="form-control" rows="20" name="text" id="smartEditor">${info.text}</textarea>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<button type="button" onclick="javascript:guideInsertProcess()" class="btn btn-default">글 수정</button>
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