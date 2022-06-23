<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div class="banner">
		<div class="w-layout-grid grid-2">
			<c:forEach var="item" items="${topBannerList}">
				<div class="m_list" onclick="window.open('${item.url}')">
					<div class="mtitle"></div>
					<img src="/filePath/business/banner/${item.imgNm}" style="display:flex;" loading="lazy" alt="" class="listimg">
				</div>
			</c:forEach>
		</div>
		<div class="b_txt">링크쇼는 가장 빠른 최신주소를 업데이트 합니다.</div><!-- 타이틀 변경 -->
		<img src="/business/webflow/images/LINKSHOW_01.png" loading="lazy" alt="" class="b_img"><!-- LINKSHOW → LINKDA 타이틀변경 -->
	</div>
</body>
</html>