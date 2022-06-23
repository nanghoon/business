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
				<form id="searchForm" name="listForm" action="/business/tagSearch.do" >
					<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
					<div class="detailcontentbox">
						<div class="pagetbox">
							<div class="ptbox3">
								<div data-w-id="46f18e89-7935-4788-8d46-fa0f19387dd2" class="ptitle">TAG BOX</div>
								<div data-w-id="46f18e89-7935-4788-8d46-fa0f19387dd4" class="line"></div>
							</div>
						</div>
						<div class="sbox">
							<img src="/business/webflow/images/2561399_tag_icon.png" loading="lazy" alt="" class="tagicon2">
							<input type="text" class="searchinput2 w-input" name="search" value="${search}">
							<a href="#" onclick="searchForm()" class="searchbtn w-inline-block">
								<img src="/business/webflow/images/search-solid.png" loading="lazy" alt="" class="searchicon2">
							</a>
						</div>
						<div class="detaillist">
							<c:forEach var="item" items="${list}">
								<div class="s_table"  onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
									<div class="siteimgbox">
										<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="siteimg">
									</div>
									<div class="div-block-15">
										<div class="sitename">${item.title}</div>
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