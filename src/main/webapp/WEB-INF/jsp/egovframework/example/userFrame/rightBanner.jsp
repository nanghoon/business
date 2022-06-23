<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<aside class="aside">
	<c:if test="${rightBanner != null}">
		<img onclick="window.open('${rightBanner.url}')" src="/filePath/business/banner/${rightBanner.imgNm}" loading="lazy" alt="" class="sidebanner_img">
	</c:if>
	<c:if test="${UserLoginIdx != null && UserLoginIdx != ''}">
		<div class="loginbox">
			<div class="loginuserinfo">
				<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
				<div>${UserLoginNickName}</div>
			</div>
			<a href="/business/logout.do" class="loginbtn w-button">로그아웃</a>
			<div class="logininfo">
				<div class="join" onclick="location.href='/business/edit.do'">정보수정</div>
				<div class="join" onclick="window.open('/business/scrapPop.do' , '_blank' , 'toolbar=yes,scrollbars=yes,resizable=no,top=70,left=500,width=600,height=600')">스크랩</div>
				<div class="join" onclick="userDel(${item.idx})">회원탈퇴</div>
			</div>
		</div>
	</c:if>
	<c:if test="${UserLoginIdx == null || UserLoginIdx == ''}">
		<form role="form" method="post" id="loginForm">
			<div class="loginbox2">
				<input type="text" class="logininput w-input" maxlength="20" name="id"  placeholder="아이디">
				<input type="password" class="logininput w-input" onkeyup="enterkey();" maxlength="20" name="pw" placeholder="비밀번호"> 
				<a href="javascript:userLogin()" class="loginbtn w-button">로그인</a>
				<div class="logininfo">
				<c:forEach var="item" items="${UserLogin}" varStatus="i">
                  <tr>
                   <td><input type="checkbox" name="arrayLoginIdx" value="${item.idx}"/></td>
                 </tr>
                </c:forEach>
					<div class="join" onclick="location.href='/business/join.do'">회원가입</div>
					<div class="idpwsearch" onclick="$('.popframe3').css('display' , 'flex')">정보찾기</div>
				</div>
			</div>
		</form>
	</c:if>
	<div class="side_bannerbox">
		<c:forEach var="item" items="${rightBannerList}">
			<img onclick="window.open('${item.url}')" src="/filePath/business/banner/${item.imgNm}" loading="lazy" alt="" class="sidebanner_img">
		</c:forEach>
	</div>
	<c:if test="${notice != null && notice != ''}">
		<div onclick="location.href='/business/noticeDetail.do?idx=${notice.idx}'" style="cursor:pointer;">
			<div class="m_notice">
				${notice.title}
			</div>
		</div>
	</c:if>
	<div class="sidebox">
		<div class="s_title">최신업데이트</div>
		<div class="side_list">
			<c:forEach var="item" items="${recentUpdateLink}">
				<div class="div-block-2" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
					<div class="div-block-3">
						<div class="updateinfo">${item.category}</div>
						<div class="update">
							<c:choose>
								<c:when test="${item.kind == 1}">[ 주소변경  ] </c:when>
								<c:when test="${item.kind == 2}">[ 우회접속  ] </c:when>
								<c:when test="${item.kind == 3}">[ 접속불가 ] </c:when>
								<c:otherwise></c:otherwise>
							</c:choose>						
						 </div>
						<div class="update_site">
							<c:choose>
								<c:when test="${fn:length(item.title) > 7}">${fn:substring(item.title, 0 , 7)}..</c:when>
								<c:otherwise>${item.title}</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="update_date"><fmt:formatDate value="${item.udate}" pattern="MM-dd"/></div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="sidebox">
		<div class="s_title">신규사이트</div>
		<c:if test="${fn:length(NewLink) == 0}">
			<div class="text-block-10">글이 없습니다.</div>
		</c:if>
		<c:if test="${fn:length(NewLink) > 0}">
			<div class="side_list">
				<c:forEach var="item" items="${NewLink}">
					<div class="div-block-2" onclick="location.href='/business/${item.category}Detail.do?idx=${item.idx}'">
						<div class="div-block-3">
							<div class="updateinfo">${item.category}</div>
							<div class="update_site">
								<c:choose>
									<c:when test="${fn:length(item.title) > 7}">${fn:substring(item.title, 0 , 7)}..</c:when>
									<c:otherwise>${item.title}</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="update_date"><fmt:formatDate value="${item.ldate}" pattern="MM-dd"/></div>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
	<div class="sidebox _2">
		<div class="s_title">State</div>
		<div class="side_list">
			<!-- <div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">현재 접속자</div>
				</div>
				<div class="statetxt">79명</div>
			</div> -->
			<div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">오늘 방문자</div>
				</div>
				<div class="statetxt">${todayVisit}명</div>
			</div>
			<div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">어제 방문자</div>
				</div>
				<div class="statetxt">${yesterVisit}명</div>
			</div>
			<div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">최대 방문자</div>
				</div>
				<div class="statetxt">${maxVisit}명</div>
			</div>
			<div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">전체 방문자</div>
				</div>
				<div class="statetxt">${sumVisit}명</div>
			</div>
			<div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">전체 게시물 수</div>
				</div>
				<div class="statetxt">${allBoard.cnt}개</div>
			</div>
			<div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">전체 댓글수</div>
				</div>
				<div class="statetxt">${allreple.cnt}개</div>
			</div>
			<div class="stable">
				<div class="div-block-7">
					<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
					<div class="statetxt">전체 회원수</div>
				</div>
				<div class="statetxt">${alluser}명</div>
			</div>
		</div>
	</div>
</aside>
<script>
function userLogin(){
	var data = $("#loginForm").serialize();
	$.ajax({
		type: 'post',
		data: data,
		url:'/business/loginProcess.do',
		success: function(data){
			if(data.result == "success"){
				location.href = '/business/main.do';
			}else{
				alert(data.msg);
			}
		}
	})
}
function enterkey() {
       if (window.event.keyCode == 13) {
       	userLogin();
       }
}
function userDel(idx){
	if(confirm("탈퇴하시겠습니까? \n모든 기록이 삭제됩니다. ")){
		$.ajax({
			type:'get',
			url:'/business/userDelete.do?idx='+idx,
			success:function(data){
				alert(data.msg);
				location.href="/business/logout.do";
			},
			error:function(e){
				console.log('ajax Error ' + JSON.stringify(e));
			}
		})
	}
}
</script>
</html>