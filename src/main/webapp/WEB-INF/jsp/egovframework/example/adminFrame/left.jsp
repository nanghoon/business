<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="navbar-default sidebar" role="navigation"  style="margin:0px;">
		<div class="sidebar-nav navbar-collapse">
			<ul class="nav" id="side-menu">
				<li><a href="/business/admin/board/topNoti.do"><i class="fa fa-space-shuttle fa-fw"></i> 흘러가는공지</a></li>	
				<li><a href="/business/admin/banner/banner.do"><i class="fa fa-photo fa-fw"></i> 배너관리</a></li>	
				<li><a href="/business/admin/user/userList.do"><i class="fa fa-user fa-fw"></i> 회원관리</a></li>	
				<li>
					<a href="javascript:void(0)"><i class="fa fa-share-square-o fa-fw"></i> 링크게시판<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="/business/admin/board/webtoonList.do"> 웹툰</a></li>
						<li><a href="/business/admin/board/torrentList.do"> 토렌트</a></li>
						<li><a href="/business/admin/board/eatList.do"> 먹튀검증</a></li>
						<li><a href="/business/admin/board/reviewList.do"> 다시보기</a></li>
						<li><a href="/business/admin/board/sportList.do"> 스포츠배팅</a></li> 
						<li><a href="/business/admin/board/adultList.do"> 성인</a></li> 
						<li><a href="/business/admin/board/jadultList.do"> 일본성인</a></li> 
						<li><a href="/business/admin/board/wadultList.do"> 해외성인</a></li> 
					</ul>
				</li>
				<li><a href="/business/admin/board/notice.do"><i class="fa fa-check-circle fa-fw"></i> 공지사항</a></li>	
				<li>
					<a href="javascript:void(0)"><i class="fa fa-question-circle fa-fw"></i> 문의사항<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="/business/admin/board/qnaAdmin.do?category=noQna">일반문의</a></li>
						<li><a href="/business/admin/board/qnaAdmin.do?category=inQna">입점문의</a></li>
						<li><a href="/business/admin/board/qnaAdmin.do?category=adQna">광고문의</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)"><i class="fa fa-info-circle fa-fw"></i> 사이트정보<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="/business/admin/guide/insert.do?kind=1"> 사이트 소개</a></li> 
						<li><a href="/business/admin/guide/insert.do?kind=2"> 이용약관</a></li> 
						<li><a href="/business/admin/guide/insert.do?kind=3"> 개인정보처리방침</a></li> 
						<li><a href="/business/admin/guide/insert.do?kind=4"> 이메일무단수집거부</a></li> 
						<li><a href="/business/admin/guide/insert.do?kind=5"> 책임의 한계와 법적고지</a></li> 
					</ul>
				</li>
			</ul>
			
		</div>
	</div>
</body>
</html>