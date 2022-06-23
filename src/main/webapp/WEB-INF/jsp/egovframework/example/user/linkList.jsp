<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html data-wf-page="612486b7524a66331d645cf7" data-wf-site="612355761b8556d533d669fc">
<head>
	<jsp:include page="../userFrame/header.jsp"></jsp:include>
</head>
<body class="body">
	<div class="form-block w-form">
		<c:import url="/top.do" charEncoding="UTF-8"/>
		<main class="main">
			<c:import url="/rightBanner.do" charEncoding="UTF-8"/>
			<section class="section">
				<c:import url="/topBanner.do" charEncoding="UTF-8"/>
				<div class="listbox">
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${linkListAll}">
							<div class="m_list" onclick="location.href='/business/${category}Detail.do?idx=${item.idx}'">
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/> </div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div> <br/></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
				<form action="/business/${category}List.do" name="listForm" id="listForm">
					<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
					<div class="searchcontent">
						<select name="orderKind" onchange="$('#listForm').submit()" class="select-field w-select">
							<option value="" <c:if test="${orderKind == '' || orderKind == null}">selected</c:if>>최신순</option>
							<option value="old" <c:if test="${orderKind == 'old'}">selected</c:if>>오래된순</option>
							<option value="view" <c:if test="${orderKind == 'view'}">selected</c:if>>조회순</option>
						</select>
						<div class="searchbox2">
							<input type="text" name="search" value="${search}" class="searchinput w-input" placeholder="검색어를 입력하세요.">
							<img src="/business/webflow/images/3844467_magnifier_search_zoom_icon.png" loading="lazy" alt="" class="searchicon" onclick="$('#listForm').submit();">
						</div>
					</div>
					<div class="detaillist">
						<div class="d_top">
							<div class="dtxt">번호</div>
							<div class="dtxt2">로고</div>
							<div class="dtxt3">사이트명</div>
							<div class="dtxt4">조회</div>
							<div class="dtxt5">날짜</div>
							<div class="dtxt7">바로가기</div>
						</div>
						<c:set var="number" value="${pi.totalRecordCount -pi.recordCountPerPage*(pi.currentPageNo-1) }"/>
						<c:forEach var="item" items="${linkList}">
							<div onclick="location.href='/business/${category}Detail.do?idx=${item.idx}'" data-w-id="18ff22ff-35c1-1702-1c2a-f8c8b8cfd71a" class="d_table">
								<div class="dtxt">${number}<c:set var="number" value="${number - 1}" /></div>
								<div class="logobox">
									<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="logoicon">
								</div>
								<div class="dtxt3">
									<c:choose>
										<c:when test="${fn:length(item.title) > 15}">${fn:substring(item.title, 0 , 15)}..</c:when>
										<c:otherwise>${item.title}</c:otherwise>
									</c:choose>
								</div>
								<div class="dtxtwrap">
									<img src="/business/webflow/images/eye-2.png" loading="lazy" alt="" class="eye">
									<div class="dtxt4 _2"> 
										${item.view}
									</div>
								</div>
								<div class="dtxt5">
									<fmt:formatDate value="${item.ldate}"/><br> 
								</div>
								<div class="text-block-2">&gt;</div>
								<div class="buttonbox">
									<a href="${item.link}" class="detailbtn w-button">바로가기</a>
								</div>								
							</div>
						</c:forEach>
					</div>
					<div class="pbox">
						<ui:pagination paginationInfo="${pi}" jsFunction="page"  type="user"/>
					</div>
				</form>
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