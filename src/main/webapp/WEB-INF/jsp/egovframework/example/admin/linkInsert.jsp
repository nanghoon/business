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
function insertProcess(category){
	oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD",[]);
	var form = $("#insertForm")[0]; 
	var data = new FormData(form);
	var url = "/business/admin/board/"+category+"InsertProcess.do";
	$.ajax({
		type:'post',
		url : url,
		data: data,
		processData:false,
		contentType:false,
		success:function(data){
			alert(data.msg)
			if(data.result == 'success'){
				location.href='/business/admin/board/'+category+'List.do';
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
                			<c:when test="${category == 'webtoon' }">웹툰</c:when>
                			<c:when test="${category == 'torrent' }">토렌트</c:when>
                			<c:when test="${category == 'eat' }">먹튀검증</c:when>
                			<c:when test="${category == 'review' }">다시보기</c:when>
                			<c:when test="${category == 'sport' }">스포츠배팅</c:when>
                			<c:when test="${category == 'adult' }">성인</c:when>
                			<c:when test="${category == 'jadult' }">일본성인</c:when>
                			<c:when test="${category == 'wadult' }">해외성인</c:when>
                		</c:choose>
                		등록
					</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
						</div>
						<div class="panel-body">
							<form name="insertForm" id="insertForm" method="post" enctype="multipart/form=data">
								<input type="hidden" name="category" value="${category}"/>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label>사이트명(제목)</label> 
											<input class="form-control" placeholder="사이트명" name="title" id="title" maxlength="100">
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label>로고사진등록</label> 
											<input type="file" id="logo" name="logo">
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
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label>바로가기링크URL ※ http:// or https://형식으로 시작해야합니다</label> 
											<input class="form-control" placeholder="※ http:// or https://형식으로 시작해야합니다" name="link" id="link" maxlength="200">
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label>구분</label>
											<div class="radio">
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="0"> 없음
												</label> 
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="1" checked>최신날짜
												</label>
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="2">우회접속
												</label>
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="3">접속불가
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>태그</label>
											<input type="text" class="form-control" name="tag" placeholder="tag1, tag2, tag3 (태그는 띄어쓰기를 할 수 없으며, 하나의 태그는 최대 10글자로 제한됩니다.) " id="tag"> 
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<button type="button" onclick="javascript:insertProcess('${category}')" class="btn btn-default">글 등록</button>
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