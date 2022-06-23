<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html data-wf-page="612c85e8c15c01aea4f17382" data-wf-site="612355761b8556d533d669fc">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../userFrame/header.jsp"></jsp:include>
</head>
<body>
<body class="body">
	<div class="form-block w-form">
		<c:import url="/top.do" charEncoding="UTF-8"/>
		<main class="main">
			<c:import url="/rightBanner.do" charEncoding="UTF-8"/>
			<section class="section">
				<div class="pagetbox">
					<div class="ptbox3">
						<div data-w-id="cc12ca50-14b7-f117-f494-4f9853b0fb3f" class="ptitle">
							<c:choose>
								<c:when test="${kind == 1}">사이트소개</c:when>
								<c:when test="${kind == 2}">이용약관</c:when>
								<c:when test="${kind == 3}">개인정보처리방침</c:when>
								<c:when test="${kind == 4}">이메일 무단수집 거부</c:when>
								<c:when test="${kind == 5}">책임의 한계와 법적고지</c:when>
							</c:choose>
						</div>
						<div data-w-id="cc12ca50-14b7-f117-f494-4f9853b0fb41" class="line"></div>
					</div>
				</div>
				<div class="ccontentbox">
					<div class="sitenamebox">
						<div class="title2">
							<c:choose>
								<c:when test="${kind == 1}">사이트소개</c:when>
								<c:when test="${kind == 2}">이용약관</c:when>
								<c:when test="${kind == 3}">개인정보처리방침</c:when>
								<c:when test="${kind == 4}">이메일 무단수집 거부</c:when>
								<c:when test="${kind == 5}">책임의 한계와 법적고지</c:when>
							</c:choose>
						</div>
					</div>
					<div class="cbox">
						<div class="calusetxt" style="width:100%;">
							${text}
						</div>
					</div>
				</div>
			</section>
		</main>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
	</div>
	<jsp:include page="../userFrame/footer.jsp"></jsp:include>
</body>
</html>