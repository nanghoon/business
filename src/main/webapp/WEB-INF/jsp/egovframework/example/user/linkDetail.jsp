<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
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
						<div class="title" style="word-break:break-all;">${info.title}</div>
					</div>
					<div class="userinfobox">
						<div class="userinfowrap">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">관리자</div>
						</div>
						<div class="userinfowrap">
							<img src="/business/webflow/images/bubble.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">${fn:length(repleList)}</div>
						</div>
						<div class="userinfowrap">
							<img src="/business/webflow/images/eye-2.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt">${info.view}</div>
						</div>
						<div class="userinfowrap2">
							<img src="/business/webflow/images/clock.png" loading="lazy" alt="" class="image-2">
							<div class="usertxt"><fmt:formatDate value="${info.ldate}" pattern="yyyy.MM.dd HH:mm"/></div>
						</div>
					</div>
					<div class="cnoticebox">
						<img src="/filePath/business/photo/${info.logo}" loading="lazy" alt="" class="siteicon">
						<div class="detail--notice">
							<c:if test="${info.kind != 0}">
								<c:if test="${info.kind == 2 }">
									<div class="cnotice">
										<span class="text-span-2">●</span> ${info.title} https 우회접속만 가능합니다.
									</div>
									<!-- <div class="cnotice">
										<span class="text-span-2">●</span> https 우회접속 방법보기
									</div> -->
								</c:if>
								<c:if test="${info.kind == 3 }">
									<div class="cnotice">
										<span class="text-span-2">●</span> ${info.title} 접속불가!! 새로운 주소를 찾고 있습니다.
									</div>
								</c:if>
								<div class="cnotice">
									<span class="text-span-2">●</span> 최신 사이트주소 업데이트일 : <fmt:formatDate value="${info.udate}" pattern="MM-dd"/>
								</div>
							</c:if>
						</div>
					</div>
					<div class="content" style="word-break:break-all;">
						${text}
					</div>
					<div>
						<div class="tagbox">
							<img src="/business/webflow/images/2561399_tag_icon.png" loading="lazy" alt="" class="tagicon">
							<div class="tagwrap">
								<c:forEach var="item" items="${tagList}">
									<div class="tagtxt" onclick="location.href='/business/tagSearch.do?search=${item.tag}'">${item.tag},</div>
								</c:forEach>
							</div>
						</div>
						<c:if test="${UserLoginIdx != '' && UserLoginIdx != null }">
							<div class="btnbox">
								<a href="javascript:scrap(${info.idx} , 'l');" class="scrapbtn w-inline-block"><img src="/business/webflow/images/scrap.png" loading="lazy" alt="" class="scrapicon"></a>
							</div>
						</c:if>
						<div class="linkbox" style="height:auto; padding:3px;">
							<img src="/business/webflow/images/link.png" loading="lazy" alt="" class="linkicon">
							<div class="text-block-9" style="cursor:pointer;word-break:break-all;max-width:89%" onclick="goLink(${info.idx} , '${info.link}')">${info.title}바로가기  ${info.link}</div>
							<div class="num">+ ${info.click}</div>
						</div>
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
								<!-- <div class="ctext">ㅇㅇㅇ님께 댓글</div> -->
								<form id="linkRepleForm">
									<input type="hidden" name="idx" value="${info.idx}"/>
									<div class="div-block-11">
										<textarea name="reple" maxlength="5000" class="textarea w-input"></textarea>
										<a href="javascript:linkReple()" class="registerbtn w-button">등 록</a>
									</div>
								</form>
							</div>
						</c:if>
						<div class="c_btnwrap">
							<a href="/business/${category}List.do" class="button-2 w-button">목록</a>
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
						<!-- <div class="ctable _2">
							<div class="userprofile">
								<img src="/business/webflow/images/facebook.png" loading="lazy" alt="">
							</div>
							<div class="div-block-8">
								<div class="ctxt">[ ㅇㅇㅇ님께 대댓글 ]</div>
								<div class="c_userid">crocounch</div>
								<div class="comment">도움 많이 됐습니다.도움 많이 됐습니다.도움 많이 됐습니다.</div>
							</div>
							<div class="d_btnwrap">
								<a href="#" class="c_answer w-button">답변</a> <a href="#"
									class="c_delete w-button">삭제</a>
							</div>
						</div> -->
					</div>
				</div>
				<div class="listbox">
					<div class="w-layout-grid grid">
						<c:forEach var="item" items="${linkList}">
							<div class="m_list" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
								<div class="mtitle">${item.title}</div>
								<c:if test="${item.kind != 0}">
									<c:if test="${item.kind == 1 }"><div class="badge update"><fmt:formatDate value="${item.udate}" pattern="MM-dd"/></div></c:if>
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
	function goLink(idx , link){
		$.ajax({
			type :'get',
			url :'/business/linkClick.do?idx='+idx,
			success:function(){
				if(link.indexOf("http") < 0){
					link = "http://"+link;
				}
				window.open(link);
			}
		})
	}
	function  linkReple(){
		var data = $("#linkRepleForm").serialize();
		var url = "/business/linkRepleProcess.do";
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
	function listRepleDel(idx){
		if(confirm("삭제하시겠습니까? \n복구하실 수 없습니다.")){
			jQuery.ajax({
				type:'get',
				url:"/business/repleUserDelete.do?idx="+idx,
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