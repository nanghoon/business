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
                	</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
						<div class="panel-heading">
						</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th><input id="allChk" type="checkbox" onclick="allChk(this)"/></th>
                                            <th>번호</th>
                                            <th>로고</th>
                                            <th>사이트명</th>
                                            <th>등록일</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:set var="number" value="${pi.totalRecordCount -pi.recordCountPerPage*(pi.currentPageNo-1) }"/>
                                    	<c:forEach var="item" items="${linkList}" varStatus="i">
                                        <tr>
                                            <td><input type="checkbox" name="arrayIdx" value="${item.idx}"/></td>
											<td>${number}<c:set var="number" value="${number - 1}" /></td>
                                            <td style="cursor:pointer" onclick="location.href='/business/admin/board/${category}Detail.do?idx=${item.idx}'">
                                            	<img src="/filePath/business/photo/${item.logo}" style="width:100%; max-width:200px;"/>
                                            </td>
                                            <td style="cursor:pointer" onclick="location.href='/business/admin/board/${category}Detail.do?idx=${item.idx}'">
												<c:choose>
													<c:when test="${fn:length(item.title) > 30}">${fn:substring(item.title, 0 , 30)}..</c:when>
													<c:otherwise>${item.title}</c:otherwise>
												</c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${item.ldate}" type="date"/></td>
                                            <td><fmt:formatNumber value="${item.view}"/></td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
							<div class="row">
								<div class="col-sm-12" style="text-align:center;">
								<ul class="pagination">
									<ui:pagination paginationInfo="${pi}" type="admin" jsFunction="page"/>
								</ul>
								</div>
							</div>
                        </div>
                    </div>
                </div>
            </div>
		   <form action="/business/admin/board/${category}List.do" name="listForm" id="listForm">
				<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
				<input type="hidden" name="category" value="${category}" />
			</form>
            <button type="button" onclick="location.href='/business/admin/board/${category}Insert.do'" class="btn btn-outline btn-default">글등록</button>
            <button type="button" onclick="listDel()" class="btn btn-outline btn-danger">글삭제</button>
        </div>
	</div>
	<jsp:include page="../adminFrame/footer.jsp"></jsp:include>
	<script>
	function allChk(obj){
		var chkObj = document.getElementsByName("arrayIdx");
		var rowCnt = chkObj.length - 1;
		var check = obj.checked;
	    if (check) {﻿
	        for (var i=0; i<=rowCnt; i++){
	         if(chkObj[i].type == "checkbox")
	             chkObj[i].checked = true;
	        }
	    } else {
	        for (var i=0; i<=rowCnt; i++) {
	         if(chkObj[i].type == "checkbox"){
	             chkObj[i].checked = false;
	         }
	        }
	    }
	}
	function listDel(){
		var idx = "";
		var idxChk = document.getElementsByName("arrayIdx");
		var chked = false;
		var indexid = false;
		for(i=0; i < idxChk.length; i++){
			if(idxChk[i].checked){
				if(indexid){
					idx = idx + '-';
				}
				idx = idx + idxChk[i].value;
				indexid = true;
			}
		}
		if(!indexid){
		 alert("삭제할 글을 선택해주세요");
		 return false;
		}
		var param = {"delArray" : idx};
		if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
			jQuery.ajax({
				type:'post',
				data:param,
				url:"/business/admin/board/linkDelete.do",
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
		}else{
			return false;
		}
	}
	function page(num){
		$("#pageIndex").val(num);
		$("#listForm").submit();
	}
	</script>
</body>
</html>