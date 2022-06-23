<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html  data-wf-page="6139911c0aed4ced292bf721" data-wf-site="612355761b8556d533d669fc">
<head>
<jsp:include page="../userFrame/header.jsp"></jsp:include>
<title>SCRAP-POP</title>
</head>
<style>
.stxt , .stxt2{
	display:flex;
}
</style>
<body  class="body">
	<div class="scrapinfobox">
		<div class="div-block-29">
			<img src="images/human_1.png" loading="lazy" alt="" class="image-9">
		</div>
		<div class="scraptxt"> ${UserLoginNickName}님의 스크랩</div>
	</div>
	<div class="scraplist">
		<div class="d_top">
			<div class="stxt">번호</div>
			<div class="stxt _2">게시판</div>
			<div class="stxt _3">제목</div>
			<div class="stxt _4">보관일시</div>
			<div class="stxt _5">삭제</div>
		</div>
		<c:set var="number" value="${pi.totalRecordCount -pi.recordCountPerPage*(pi.currentPageNo-1) }"/>
		<c:forEach var="item" items="${list}" varStatus="i">
			<div class="d_table" style="height:8vw">
				<div onclick="javascript:goDetail('${item.category}' , ${item.sidx})" class="text-block-2"></div>
				<div onclick="javascript:goDetail('${item.category}' , ${item.sidx})" class="stxt">${number}<c:set var="number" value="${number - 1}" /></div>
				<div onclick="javascript:goDetail('${item.category}' , ${item.sidx})" class="stxt _2">
					<c:choose>
              			<c:when test="${item.category == 'webtoon' }">웹툰</c:when>
              			<c:when test="${item.category == 'torrent' }">토렌트</c:when>
              			<c:when test="${item.category == 'eat' }">먹튀검증</c:when>
              			<c:when test="${item.category == 'review' }">다시보기</c:when>
              			<c:when test="${item.category == 'sport' }">스포츠배팅</c:when>
              			<c:when test="${item.category == 'adult' }">성인</c:when>
              			<c:when test="${item.category == 'jadult' }">일본성인</c:when>
              			<c:when test="${item.category == 'wadult' }">해외성인</c:when>
              			<c:when test="${item.category == 'notice' }">공지사항</c:when>
              		</c:choose>				
				</div>
				<div onclick="javascript:goDetail('${item.category}' , ${item.sidx})" class="stxt2 _3">
					<c:choose>
						<c:when test="${fn:length(item.title) > 20}">${fn:substring(item.title, 0 , 20)}..</c:when>
						<c:otherwise>${item.title}</c:otherwise>
					</c:choose>						
				</div>
				<div onclick="javascript:goDetail('${item.category}' , ${item.sidx})" class="stxt _4">
					<fmt:formatDate value="${item.sdate}" pattern="yyyy-MM-dd HH:mm"/>
				</div>
				<a href="javascript:deleteScrap(${item.idx})" class="deletebtn w-button">삭제</a>
			</div>
		</c:forEach>
	</div>
	<div class="pbox" style="width:100%;">
		<ui:pagination paginationInfo="${pi}" jsFunction="page"  type="user"/>
	</div>
	<a href="#" onclick="window.close();" class="cancelbtn2 w-button">취소</a> 
<form name="listForm" action="/business/scrapPop.do">
	<input type="hidden" name="pageIndex" />
</form>
<script>
	function page(num){
		document.listForm.pageIndex.value = num;
		document.listForm.submit();
	}
	function deleteScrap(idx){
		if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
			location.href='/business/deleteScrap.do?idx='+idx;
		}
	}
	function goDetail(category , idx){
		opener.parent.location.href = '/business/'+category+'Detail.do?idx='+idx;
	}
</script>
</body>
</html>