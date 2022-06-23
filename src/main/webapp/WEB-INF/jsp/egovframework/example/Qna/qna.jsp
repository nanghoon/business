<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html data-wf-page="61271be372340abcb6281481" data-wf-site="612355761b8556d533d669fc">
<head>
	<jsp:include page="../userFrame/header.jsp"></jsp:include>
</head>
<style>
.m{
	display:none;
}
</style>
<body class="body">
	<div class="form-block w-form">
		<c:import url="/top.do" charEncoding="UTF-8"/>
		<main class="main">
			<c:import url="/rightBanner.do" charEncoding="UTF-8"/>
			<section class="section">
				<c:import url="/topBanner.do" charEncoding="UTF-8" />
				<form action="/business/qna.do" name="listForm" id="listForm">
					<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
					<input type="hidden" name="category" id="category" value="${category}"/>
					<div class="detailcontentbox">
						<div class="searchcontent3">
							<div class="selectwrap">
								<select class="selectbox w-select" onchange="changeCate(this)">
									<option value="" <c:if test="${category =='' || category eq null}">selected</c:if>>전체</option>
									<option value="noQna" <c:if test="${category =='noQna'}">selected</c:if>>일반문의</option>
									<option value="inQna" <c:if test="${category =='inQna'}">selected</c:if>>입점문의</option>
									<option value="adQna" <c:if test="${category =='adQna'}">selected</c:if>>광고문의</option>
								</select>
								<div class="searchbox4">
									<input type="text" name="search" value="${search}"  maxlength="256" class="searchinput w-input" placeholder="검색어를 입력하세요.">
									<img src="/business/webflow/images/3844467_magnifier_search_zoom_icon.png" loading="lazy" alt="" class="searchicon" onclick="$('#listForm').submit()">
								</div>
							</div>
							<c:if test="${UserLoginIdx != null && UserLoginIdx != ''}">
								<a href="/business/qnaInsert.do?category=${category}" class="writebtn w-button">글쓰기</a>
							</c:if>
							</div>
							<div class="detaillist">
								<div class="n_top">
									<div class="ntxt">번호</div>
									<div class="ntxt2">제목</div>
									<div class="ntxt3">이름</div>
									<div class="ntxt4">날짜</div>
									<div class="ntxt5">조회</div>
								</div>
								<c:set var="number" value="${pi.totalRecordCount -pi.recordCountPerPage*(pi.currentPageNo-1) }"/>
								<c:forEach var="item" items="${qnaMemberList}">
									<div class="n_table" onclick="checkDetail(${item.bidx} , ${item.idx})">
										<div class="ntxt">${number}<c:set var="number" value="${number - 1}" /></div>
										<div class="ntitlebox">
											<img src="/business/webflow/images/lock.png" loading="lazy" alt="" class="lock">
											<div class="ntxt2 _2">
												<span class="text-span-3">[
													<c:choose>
														<c:when test="${item.category == 'noQna'}">일반문의</c:when>
														<c:when test="${item.category == 'inQna'}">입점문의</c:when>
														<c:otherwise>광고문의</c:otherwise>
													</c:choose>											
												] </span> 
												<c:choose>
													<c:when test="${fn:length(item.title) > 19}">${fn:substring(item.title, 0 , 19)}..</c:when>
													<c:otherwise>${item.title}</c:otherwise>
												</c:choose>
											</div>
										</div>
										<div class="ntxt3">${item.nickname}</div>
										<div class="ntxt4"><fmt:formatDate value="${item.bdate}"/></div>
										<div class="div-block-18">
											<img src="/business/webflow/images/eye-2.png" loading="lazy" alt="" class="eye">
											<div class="ntxt5"> ${item.view}</div>
										</div>
									</div>
								</c:forEach>
								<c:if test="${UserLoginIdx != null && UserLoginIdx != ''}">
									<a href="/business/qnaInsert.do?category=${category}" class="writebtn m w-button">글쓰기</a>
								</c:if>
							</div>
							<div class="pbox">
								<ui:pagination paginationInfo="${pi}" jsFunction="page" type="user"/>
							</div>
						</div>
					</form>
				</section>
			</main>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
		<div class="popframe" id="pwChk">
			<form name="qnaPwForm" id="qnaPwForm">
				<input type="hidden" name="qbidx" id="qbidx"/>
				<input type="hidden" name="qidx" id="qidx"/>
				<div class="pwpop">
					<img src="/business/webflow/images/notice.png" loading="lazy" alt="" class="picon">
					<div class="text-block-6">비밀글 기능으로 보호된 글입니다.</div>
					<input type="password" class="text-field w-input" maxlength="30" name="qnaPw"> 
					<div class="popbtnwrap">
						<a href="javascript:pwChk()" class="checkbtn w-button">확 인</a> 
						<a href="#" onclick="$('.popframe').css('display' , 'none')" class="cancelbtn w-button">취소</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../userFrame/footer.jsp"></jsp:include>
<script>
function changeCate(self){
	$("#pageIndex").val("1");
	$("#category").val($(self).val());
	$("#listForm").submit();
}
function checkDetail(bidx , idx){
	let sessionId = "${UserLoginIdx}";
	if(sessionId == bidx){
		let category = $("#category").val();
		location.href="/business/qnaDetail.do?idx="+idx+'&category='+category;
	}else{
		$("#qbidx").val(bidx);
		$("#qidx").val(idx);
		$("#pwChk").css('display' , 'flex');
	}
}
function pwChk(){
	let data = $("#qnaPwForm").serialize();
	let category = $("#category").val();
	$.ajax({
		type : 'post',
		data : data ,
		url :'/business/qnaPwCheck.do',
		success:function(data){
			if(data.result == 'success'){
				location.href="/business/qnaDetail.do?idx="+data.qidx+'&category='+category;		
			}else{
				alert(data.msg);
				location.reload();
			}
		}
	})
}
function page(num){
	$("#pageIndex").val(num);
	$("#listForm").submit();
}

</script>
</body>
</html>