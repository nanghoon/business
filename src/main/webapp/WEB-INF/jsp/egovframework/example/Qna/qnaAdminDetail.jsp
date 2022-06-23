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
					<h1 class="page-header">문의사항 답변</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading"> </div>
						<div class="panel-body">
							<form name="qnaAdminDetail" id="qnaAdminDetail" method="post">
								<input type="hidden" name="idx" value="${qnaAdminDetail.idx}"/>
								<div class="row">
									<div class="col-lg-2">
										<div class="form-group">
											<label>카테고리 설정</label>
											<div class="well well-sm">
												<p style="margin:0px">
													<c:choose>
														<c:when test="${qnaAdminDetail.category == 'inQna'}">입점문의</c:when>
														<c:when test="${qnaAdminDetail.category == 'adQna'}">광고문의</c:when>
														<c:otherwise>일반문의</c:otherwise>
													</c:choose>
												</p>
											</div>
										</div>
									</div>
									<div class="col-lg-5">
										<div class="form-group">
											<label>링크1</label>
											<div class="well well-sm">
												<p style="margin:0px">
													<a href="${qnaAdminDetail.link1}" target="blank">${qnaAdminDetail.link1}</a>&nbsp;
												</p>
											</div>
										</div>
									</div>
									<div class="col-lg-5">
										<div class="form-group">
											<label>링크2</label>
											<div class="well well-sm">
												<p style="margin:0px">
													<a href="${qnaAdminDetail.link2}" target="blank">${qnaAdminDetail.link2}</a>&nbsp;
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>문의제목 </label>
											<div class="well well-sm">
												<p style="margin:0px;word-break:break-all;">
													${qnaAdminDetail.title}
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>문의내용 </label>
											<div class="well well-sm">
												<p style="margin:0px;word-break:break-all;">
													${text}
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>답변작성 </label>
											<textarea rows="7" name="reple" class="form-control"></textarea>
											<button type="button" onclick="qnaAdminUpdateProcess()" class="btn btn-default">답변등록</button>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label>등록된 답변  </label>
											<c:if test="${fn:length(repleList) ==  0}">
												<div class="well well-sm">
													<p style="margin:0px">
														등록된 댓글이 없습니다.
													</p>
												</div>
											</c:if>
											<c:if test="${fn:length(repleList) > 0}">
												<c:forEach var="item" items="${repleList}">
													<div>
														${item.writer} - <fmt:formatDate value="${item.rdate}" pattern="yyyy-MM-dd HH:mm:ss"/> 
														&nbsp;<button type="button" style="padding:0px; border:none;" onclick="listRepleDel(${item.idx})" class="btn btn-outline btn-danger">댓글삭제</button>
													</div>
													<p style="border:1px solid #ccc; background-color:#f5f5f5;border-radius:4px;padding:9.5px;margin:0px;word-break:break-all;">
													${item.reple}
													</p>
												</c:forEach>
											</c:if>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					<button type="button" onclick="qnaAdminDetailDel(${qnaAdminDetail.idx} , '${qnaAdminDetail.category}')" class="btn btn-outline btn-danger">글삭제</button>
				</div>
			</div>
		</div>
	</div>		
	<jsp:include page="../adminFrame/footer.jsp"></jsp:include>
	<script>
	function qnaAdminUpdateProcess(){
		var data = $("#qnaAdminDetail").serialize();
		var url = "/business/admin/board/qnaAdminUpdateProcess.do";
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
	function qnaAdminDetailDel(idx,category){
		if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
			jQuery.ajax({
				type:'get',
				url:"/business/admin/board/qnaAdminDetailDelete.do?idx="+idx,
				success:function(data){
					if(data.result == 'success'){
						alert("삭제되었습니다.");
						location.href='/business/admin/board/qnaAdmin.do?category='+category;
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
				url:"/business/admin/board/qnaRepleDelete.do?idx="+idx,
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