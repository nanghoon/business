<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html data-wf-page="612355761b8556127dd669fe" data-wf-site="612355761b8556d533d669fc">
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
					<div class="list_top">
						<div class="kind">WEBTOON [ 웹툰 ]</div>
						<a href="/business/webtoonList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${webtoon}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="listbox">
					<div class="list_top">
						<div class="kind">SPORTS BET [ 스포츠 배팅 /토토 ]</div>
						<a href="/business/sportList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${sport}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="listbox">
					<div class="list_top">
						<div class="kind">ADULT [ 성인 ]</div>
						<a href="/business/adultList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${adult}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="listbox">
					<div class="list_top">
						<div class="kind">JAP ADULT [ 일본성인 ]</div>
						<a href="/business/jadultList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${jadult}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="listbox">
					<div class="list_top">
						<div class="kind">WEST ADULT [ 해외성인 ]</div>
						<a href="/business/wadultList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${wadult}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="listbox">
					<div class="list_top">
						<div class="kind">TORRENT [ 토렌트 ]</div>
						<a href="/business/torrentList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${torrent}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="listbox">
					<div class="list_top">
						<div class="kind">SPORTS [ 먹튀검증 ]</div>
						<a href="/business/eatList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${eat}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="listbox">
					<div class="list_top">
						<div class="kind">REAL TIME TV [ 실시간TV ]</div>
						<a href="/business/reviewList.do" class="mlink w-inline-block">
							<div class="m_arrow">&gt;</div>
						</a>
					</div>
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${review}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update">UP <fmt:formatDate value="${item.udate}" pattern="MM/dd"/></div></c:if>
									<c:if test="${item.kind == 2 }"><div class="badge detour">우회필수</div></c:if>
									<c:if test="${item.kind == 3 }"><div class="badge">접속불가</div></c:if>
								</c:if>
								<img src="/filePath/business/photo/${item.logo}" loading="lazy" alt="" class="listimg">
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
		</main>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
	</div>
	<jsp:include page="../userFrame/footer.jsp"></jsp:include>
</body>
</html>