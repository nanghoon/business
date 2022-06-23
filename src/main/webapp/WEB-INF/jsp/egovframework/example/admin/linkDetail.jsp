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
function updateProcess(category){
	oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD",[]);
	var form = $("#updateForm")[0]; 
	var data = new FormData(form);
	var url = "/business/admin/board/"+category+"UpdateProcess.do";
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
                		수정
					</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
						</div>
						<div class="panel-body">
							<form name="updateForm" id="updateForm" method="post" enctype="multipart/form=data">
								<input type="hidden" name="idx" value="${info.idx}"/>
								<input type="hidden" name="category" value="${category}"/>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label>사이트명(제목)</label> 
											<input class="form-control" placeholder="사이트명" value="${info.title}" name="title" id="title" maxlength="100">
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label>로고사진등록</label> 
											<div>
												<img src="/filePath/business/photo/${info.logo}" style="max-width:100%; max-height:200px"/>
											</div>
											<br/>
											<input type="file" id="logo" name="logo">
											<span>※새로운 사진을 등록하면 변경됩니다.</span>
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
									<div class="col-lg-6">
										<div class="form-group">
											<label>바로가기링크URL ※ http:// or https://형식으로 시작해야합니다</label> 
											<input class="form-control" placeholder="※ http:// or https://형식으로 시작해야합니다" value="${info.link }" name="link" id="link" maxlength="200">
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label>구분</label>
											<div class="radio">
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="0" <c:if test="${info.kind == 0 }">checked</c:if>> 없음
												</label> 
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="1" <c:if test="${info.kind == 1 }">checked</c:if>>최신날짜
												</label>
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="2" <c:if test="${info.kind == 2 }">checked</c:if>>우회접속
												</label>
												<label class="radio-inline"> 
													<input type="radio" name="kind" value="3" <c:if test="${info.kind == 3 }">checked</c:if>>접속불가
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label>태그</label>
											<input type="text" class="form-control" name="tag" placeholder="tag1, tag2, tag3 (태그는 띄어쓰기를 할 수 없으며, 하나의 태그는 최대 10글자로 제한됩니다.) " id="tag"
											value="<c:forEach var="item" items="${tagList}">${item.tag},</c:forEach>"> 
										</div>
									</div>
									<div class="col-lg-3">
										<div class="form-group">
											<label>조회수</label> 
											<input class="form-control" value="${info.view}" onkeyup="SetNum(this);" name="view" id="view">
										</div>
									</div>
									<div class="col-lg-3">
										<div class="form-group">
											<label>링크 클릭횟수</label> 
											<input class="form-control" value="${info.click }" onkeyup="SetNum(this);" name="click" id="click">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>등록된 댓글  </label>
											<div>${info.reple}</div>
											<c:if test="${fn:length(repleList) > 0}">
												<c:forEach var="item" items="${repleList}">
													<div>
														${item.writer} - <fmt:formatDate value="${item.rdate}" pattern="yyyy-MM-dd HH:mm:ss"/> 
														&nbsp;<button type="button" style="padding:0px; border:none;" onclick="listRepleDel(${item.idx})" class="btn btn-outline btn-danger">댓글삭제</button>
													</div>
													<p style="border:1px solid #ccc; background-color:#f5f5f5;border-radius:4px;padding:9.5px;margin:0px;word-break:break-all;">${item.reple}</p>
												</c:forEach>
											</c:if>
										</div>
									</div>
								</div>
							</form>
							<button type="button" onclick="updateProcess('${category}')" class="btn btn-default">글 수정</button>
		 					<button type="button" onclick="listDetailDel(${info.idx} ,'${category}')" class="btn btn-outline btn-danger">글삭제</button>
						</div>
					</div>
				</div>
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
function listDetailDel(idx , category){
	if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
		jQuery.ajax({
			type:'get',
			url:"/business/admin/board/"+category+"DetailDelete.do?idx="+idx,
			success:function(data){
				if(data.result == 'success'){
					alert("삭제되었습니다.");
					location.href='/business/admin/board/'+category+'List.do';
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
function listRepleDel(idx){
	if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
		jQuery.ajax({
			type:'get',
			url:"/business/admin/board/repleAdminDelete.do?idx="+idx,
			success:function(data){
				if(data.result == 'success'){
					alert("삭제되었습니다.");
				}else{
					alert("에러가 발생했습니다. 다시 시도해주세요");
				}
				location.reload();
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