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
<body>
<script>
function insertProcess(){
	var url = "/business/admin/board/topNotiInsertProcess.do";
	$.ajax({
		type:'post',
		url : url,
		data: $("#insertForm").serialize(),
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
					<h1 class="page-header">흘러가는 공지</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
						</div>
						<div class="panel-body">
							<form name="insertForm" id="insertForm" method="post">
								<input type="hidden" value="${topNoti.idx}" name="idx"/>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label>흘러가는 공지 내용 ※이곳에 적은 내용만 노출됩니다</label> 
											<input class="form-control" name="text" value="${topNoti.text}" id="text" maxlength="200">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<button type="button" onclick="javascript:insertProcess()" class="btn btn-default">등록</button>
		</div>
	</div>
	<jsp:include page="../adminFrame/footer.jsp"></jsp:include>
</body>
</html>