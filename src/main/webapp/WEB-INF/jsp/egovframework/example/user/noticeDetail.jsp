<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html  data-wf-page="612486b7524a66331d645cf7" data-wf-site="612355761b8556d533d669fc">
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
							${info.title}
						</div>
					</div>
					<div class="userinfobox">
						<div class="userinfowrap">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">관리자</div>
						</div>
						<div class="userinfowrap">
							<img src="/business/webflow/images/eye-2.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">${info.view}</div>
						</div>
						<div class="userinfowrap2">
							<img src="/business/webflow/images/clock.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt"><fmt:formatDate value="${info.bdate}" pattern="yyyy.MM.dd HH:mm"/></div>
						</div>
					</div>
					<div class="content"  style="word-break:break-all;">
						${text}
					</div>
					<c:if test="${UserLoginIdx != '' && UserLoginIdx != null }">
						<div class="btnbox">
							<a href="javascript:scrap(${info.idx} , 'b');" class="scrapbtn w-inline-block"><img src="/business/webflow/images/scrap.png" loading="lazy" alt="" class="scrapicon"></a>
						</div>
					</c:if>
				</div>
				<div class="c_btnwrap">
					<a href="/business/noticeList.do" class="button-2 w-button">목록</a>
				</div>
			</section>
		</main>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
	</div>
	<script>
	function scrap(idx , tb){
		$.ajax({
			type :'get',
			url : '/business/scrap.do?idx='+idx+'&tb='+tb,
			success:function(data){
				if(confirm(data.msg)){
					window.open("/business/scrapPop.do" , "_blank" , "toolbar=yes,scrollbars=yes,resizable=no,top=70,left=500,width=600,height=600")
				}
			}
		})
	}	
	</script>
</body>
</html>