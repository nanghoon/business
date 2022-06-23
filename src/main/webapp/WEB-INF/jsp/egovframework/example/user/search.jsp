<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html data-wf-page="612726b3cc31ef7d23cfc1d7" data-wf-site="612355761b8556d533d669fc">
<head>
	<jsp:include page="../userFrame/header.jsp"></jsp:include>
</head>
<body class="body">
	<div class="form-block w-form">
		<c:import url="/top.do" charEncoding="UTF-8"/>
		<main class="main">
			<c:import url="/rightBanner.do" charEncoding="UTF-8"/>
			<section class="section">
				<form id="searchForm" name="listForm" action="/business/search.do" >
					<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
					<div class="detailcontentbox">
						<div class="pagetbox">
							<div class="ptbox3">
								<div data-w-id="46f18e89-7935-4788-8d46-fa0f19387dd2" class="ptitle">POST SEARCH</div>
								<div data-w-id="46f18e89-7935-4788-8d46-fa0f19387dd4" class="line"></div>
							</div>
							<select name="category" class="select w-select">
								<option value="">전체게시판</option>
								<option value="review" <c:if test="${category == 'review'}">selected</c:if>>다시보기</option>
								<option value="eat" <c:if test="${category == 'eat'}">selected</c:if>>먹튀검증</option>
								<option value="sport" <c:if test="${category == 'sport'}">selected</c:if>>스포츠 토토</option>
								<option value="torrent" <c:if test="${category == 'torrent'}">selected</c:if>>토렌트</option>
								<option value="webtoon" <c:if test="${category == 'webtoon'}">selected</c:if>>웹툰</option>
							</select>
						</div>
						<div class="sbox">
							<select name="kind" class="select2 w-select">
								<option value="all" <c:if test="${kind == 'all'}">selected</c:if>>제목+내용</option>
								<option value="title" <c:if test="${kind == 'title'}">selected</c:if>>제목</option>
								<option value="text" <c:if test="${kind == 'text'}">selected</c:if>>내용</option>
							</select>
							<input type="text" class="searchinput2 w-input" name="searchAll" value="${searchAll}">
							<a href="#" onclick="searchForm()" class="searchbtn w-inline-block">
								<img src="/business/webflow/images/search-solid.png" loading="lazy" alt="" class="searchicon2">
							</a>
						</div>
						<div class="detaillist">
							<c:forEach var="item" items="${linkList}">
								<div class="s_table" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
									<div class="siteimgbox">
										<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="siteimg">
									</div>
									<div class="div-block-15">
										<div class="sitename"style="word-break:break-all;">${item.title}</div>
										<div class="div-block-14">
											<div class="div-block-16">
												<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="image-5">
												<div class="writer">관리자</div>
											</div>
											<div class="div-block-13">
												<img src="/business/webflow/images/clock.png" loading="lazy" alt="" class="image-4">
												<div class="sdate"><fmt:formatDate value="${item.ldate}"/></div>
											</div>
										</div>
										<c:set value='${item.text.replaceAll("\\\<.*?\\\>","")}' var="replaceAllText" />
		                  				<c:set value='${fn:replace(replaceAllText , "&nbsp;" ," ")}' var="text" /> 
										<div class="scontent">
										<c:choose>
											<c:when test="${fn:length(text) > 30 }">
												${fn:substring(text, 0 , 30)}..
											</c:when>
											<c:otherwise>${text}</c:otherwise>							
										</c:choose>
										</div>
									</div>
				 				</div>
							</c:forEach>
						</div>
						<div class="pbox">
							<ui:pagination paginationInfo="${pi}" jsFunction="page"  type="user"/>
						</div>
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
			$("#searchForm").submit();
		}
		function searchForm(){
			$("#searchForm").submit();
		}
	</script>
</body>
</html>