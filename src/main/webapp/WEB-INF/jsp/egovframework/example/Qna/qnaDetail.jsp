<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
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
					<div class="sitenamebox">
						<div class="title" style="word-break:break-all;">
							[
							<c:if test="${qnaDetail.category == 'noQna'}">일반문의</c:if>
							<c:if test="${qnaDetail.category == 'inQna'}">입점문의</c:if>
							<c:if test="${qnaDetail.category == 'adQna'}">광고문의</c:if>
							]
							${qnaDetail.title}
						</div>
					</div>
					<div class="userinfobox">
						<div class="userinfowrap">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">${qnaDetail.nickname}</div>
						</div>
						<div class="userinfowrap">
							<img src="/business/webflow/images/bubble.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">${fn:length(repleList)}</div>
						</div>
						<div class="userinfowrap">
							<img src="/business/webflow/images/eye-2.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">${qnaDetail.view}</div>
						</div>
						<div class="userinfowrap2">
							<img src="/business/webflow/images/clock.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt"><fmt:formatDate value="${qnaDetail.bdate}" pattern="yyyy.MM.dd HH:mm"/></div>
						</div>
					</div>
					<c:if test="${qnaDetail.link1 != null && qnaDetail.link1 != ''}">
						<div class="linkbox" style="height:auto; padding:3px;">
							<img src="/business/webflow/images/link.png" loading="lazy" alt="" class="linkicon">
							<div class="text-block-9" style="cursor:pointer" onclick="goLink('${qnaDetail.link1}')"> ${qnaDetail.link1}</div>
						</div>
					</c:if>
					<c:if test="${qnaDetail.link2 != null && qnaDetail.link2 != ''}">
						<div class="linkbox" style="height:auto; padding:3px;">
							<img src="/business/webflow/images/link.png" loading="lazy" alt="" class="linkicon">
							<div class="text-block-9" style="cursor:pointer" onclick="goLink('${qnaDetail.link2}')"> ${qnaDetail.link2}</div>
						</div>
					</c:if>
					<div class="content"  style="word-break:break-all;">
						${text}
					</div>
					<div class="commentbox">
						<div class="div-block-17">
							<div class="commnet">Comments</div>
						</div>
						<c:if test="${UserLoginIdx == '' || UserLoginIdx == null }">
							<div class="commentnotice">댓글을 등록할 수 있는 권한이 없습니다.</div>
						</c:if>
						<c:if test="${UserLoginIdx != '' && UserLoginIdx != null }">
							<div class="c_writebox">
								<div class="ctext">댓글은 자신을 나타내는 &#x27;얼굴&#x27;입니다*^^*</div>
								<form id="repleForm">
									<div class="div-block-11">
										<input type="hidden" name="idx" value="${qnaDetail.idx}"/>
										<textarea name="reple" maxlength="5000" class="textarea w-input"></textarea>
										<a href="#"  onclick="qnaReple()" class="registerbtn w-button">등 록</a>
									</div>
								</form>
							</div>
						</c:if>
						<div class="c_btnwrap">
							<c:if test="${qnaDetail.bidx == UserLoginIdx}">
								<a href="#" onclick="qnaDetailDelete(${qnaDetail.idx})" class="button-2 w-button">삭제</a> 
								<a href="/business/qnaUpdate.do?idx=${qnaDetail.idx}&category=${qnaDetail.category}" class="button-2 w-button">수정</a> 
							</c:if>
							<a href="/business/qna.do?category=${category}" class="button-2 w-button">목록</a>
							<c:if test="${UserLoginIdx != null && UserLoginIdx != '' }"> 
								<a href="/business/qnaInsert.do?category=${category}" class="button-2 w-button">글쓰기</a>
							</c:if>
						</div>
						<c:forEach var="item" items="${repleList}">
							<div class="ctable">
								<div class="div-block-8">
									<div class="c_userid">${item.writer} - <fmt:formatDate value="${item.rdate}" pattern="yyyy-MM-dd HH:mm"/></div>
									<div class="comment" style="word-break:break-all;">${item.reple}</div>
								</div>
								<c:if test="${item.ridx == UserLoginIdx}">
									<div class="d_btnwrap">
										<!-- <a href="#" class="c_answer w-button">답변</a> --> 
										<a href="javascript:listRepleDel(${item.idx});" class="c_delete w-button">삭제</a>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
		</main>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
	</div>
<script>
function goLink( link){
	if(link.indexOf("http") < 0){
		link = "http://"+link;
	}
	window.open(link);
}
function qnaReple(){
	var data = $("#repleForm").serialize();
	var url = "/business/qnaRepleProcess.do";
	$.ajax({
		type:'post',
		url : url,
		data: data,
		success:function(data){
			alert(data.msg)
			if(data.result == 'success'){
				location.reload();
			}
		},
		error:function(e){
			console.log('ajaxError' + e);
		}
	});
}
function qnaDetailDelete(idx){
	if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
		jQuery.ajax({
			type:'get',
			url:"/business/qnaDetailDelete.do?idx="+idx,
			success:function(data){
				if(data.result == 'success'){
					alert("삭제되었습니다.");
					location.href='/business/qna.do';
				}else{
					alert("에러가 발생했습니다. 다시 시도해주세요");
				}
			},
			errer:function(e){
				console.log('error' + e);
			}
		});
	}
}
function listRepleDel(idx){
	if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
		jQuery.ajax({
			type:'get',
			url:"/business/qnaRepleDelete.do?idx="+idx,
			success:function(data){
				if(data.result == 'success'){
					alert("삭제되었습니다.");
				}else{
					alert("에러가 발생했습니다. 다시 시도해주세요");
				}
				location.reload();
			},
			errer:function(e){
				console.log('error' + e);
			}
		});
	}
}
</script>
</body>
</html>