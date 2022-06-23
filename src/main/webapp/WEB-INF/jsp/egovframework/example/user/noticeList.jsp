<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html data-wf-page="61271be372340abcb6281481" data-wf-site="612355761b8556d533d669fc">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="../userFrame/header.jsp"></jsp:include>
</head>
<body class="body">
	<div class="form-block w-form">
		<c:import url="/top.do" charEncoding="UTF-8"/>
		<main class="main">
			<c:import url="/rightBanner.do" charEncoding="UTF-8"/>
			 <section class="section">
			 	<c:import url="/topBanner.do" charEncoding="UTF-8"/>
				<div class="detailcontentbox">
					<form action="/business/noticeList.do" name="listForm" id="listForm">
						<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
						<div class="searchcontent3" style="justify-content:flex-start">
							<select name="orderKind" onchange="$('#listForm').submit()" class="select-field w-select">
								<option value="" <c:if test="${orderKind == '' || orderKind == null}">selected</c:if>>최신순</option>
								<option value="old" <c:if test="${orderKind == 'old'}">selected</c:if>>오래된순</option>
								<option value="view" <c:if test="${orderKind == 'view'}">selected</c:if>>조회순</option>
							</select>
							<div class="searchbox4">
								<input type="text" class="searchinput w-input" maxlength="100" name="search" value="${search}" placeholder="검색어를 입력하세요.">
								<img src="/business/webflow/images/3844467_magnifier_search_zoom_icon.png" loading="lazy"
									alt="" class="searchicon" onclick="$('#listForm').submit()">
							</div>
						</div>
						<div class="detaillist">
							<div class="n_top">
								<div class="ntxt">번호</div>
								<div class="ntxt2">제목</div>
								<div class="ntxt3">이름</div>
								<div class="ntxt4">날짜</div>
								<div class="ntxt5">조회</div>
							</div>
							<c:forEach var="item" items="${topList}">
								<div class="n_table" onclick="location.href='/business/noticeDetail.do?idx=${item.idx}'">
									<div class="ntxt notice">[공지]</div>
									<div class="ntitlebox notice">
										<div class="ntxt2 _2">
											<c:choose>
												<c:when test="${fn:length(item.title) > 19}">${fn:substring(item.title, 0 , 19)}..</c:when>
												<c:otherwise>${item.title}</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="ntxt3 notkce">관리자</div>
									<div class="ntxt4"><fmt:formatDate value="${item.bdate}" pattern="yyyy-MM-dd"/> </div>
									<div class="div-block-18">
										<img src="/business/webflow/images/eye-2.png" loading="lazy" alt="" class="eye">
										<div class="ntxt5">${item.view}</div>
									</div>
								</div>
							</c:forEach>
							<c:set var="number" value="${pi.totalRecordCount -pi.recordCountPerPage*(pi.currentPageNo-1) }"/>
							<c:forEach var="item" items="${list}">
								<div class="n_table" onclick="location.href='/business/noticeDetail.do?idx=${item.idx}'">
									<div class="ntxt">${number}<c:set var="number" value="${number - 1}" /></div>
									<div class="ntitlebox">
										<div class="ntxt2 _2">
											<c:choose>
												<c:when test="${fn:length(item.title) > 25}">${fn:substring(item.title, 0 , 25)}..</c:when>
												<c:otherwise>${item.title}</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="ntxt3">관리자</div>
									<div class="ntxt4"><fmt:formatDate value="${item.bdate}" pattern="yyyy-MM-dd"/> </div>
									<div class="div-block-18">
										<img src="/business/webflow/images/eye-2.png" loading="lazy" alt="" class="eye">
										<div class="ntxt5">${item.view}</div>
									</div>
								</div>
							</c:forEach>
						</div>	
						<div class="pbox">
							<ui:pagination paginationInfo="${pi}" jsFunction="page"  type="user"/>
						</div>
					</form>
				</div>
			</section>
		</main>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
	</div>
	<jsp:include page="../userFrame/footer.jsp"></jsp:include>
<script>
	function page(num){
		$("#pageIndex").val(num);
		$("#listForm").submit();
	}
</script>
</body>
</html>