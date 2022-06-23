<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<!--  onmouseout="document.getElementsByClassName('pcmenuwrap')[0].style.display ='none'"  -->
<c:if test="${topNoti != ''}">
	<div style="background:red; color:yellow; font-weight:bold;">
		<marquee id="marquee" onclick="clickNoti('0')" onmouseover="this.stop();" onmouseout="this.start();" style="font-size: 18px;padding: 5px;">${topNoti.text}</marquee>
	</div>
</c:if>

<header class="header" >
	<div class="top">
		<div class="topmenuframe">
			<a href="/business/main.do" class="logolink w-inline-block"> 
				<img src="/business/webflow/images/LINKDA_LOGO2.png" loading="lazy" alt="" class="logoimg">
				<div class="logotxt">LINKSHOW</div><!-- 타이틀변경 -->
			</a> 
			<a href="/business/webtoonList.do" class="topmbtn w-inline-block">
				<div class="topmtxt">웹툰</div>
			</a> 
			<a href="/business/torrentList.do" class="topmbtn w-inline-block">
				<div class="topmtxt">토렌트</div>
			</a> 
			<a href="/business/eatList.do" class="topmbtn w-inline-block">
				<div class="topmtxt">먹튀검증</div>
			</a> 
			<a href="/business/reviewList.do" class="topmbtn w-inline-block">
				<div class="topmtxt">다시보기</div>
			</a> 
			<a href="/business/sportList.do" class="topmbtn w-inline-block">
				<div class="topmtxt">스포츠베팅</div>
			</a>
			<div class="pcmenuframe" onmouseout="document.getElementsByClassName('pcmenuwrap')[0].style.display ='none'" class="topmbtn w-inline-block" onmouseover="document.getElementsByClassName('pcmenuwrap')[0].style.display ='block'">
				<a href="/business/noticeList.do" class="topmbtn w-inline-block">
					<div class="topmtxt">공지사항</div>
				</a>
				<div class="pcmenuwrap" style="display:none; background-color:#E6E6E6;">
					<div class="pcmenu" onclick="location.href='/business/qna.do'">문의사항</div>
					<div class="pcmenu" onclick="location.href='/business/noticeList.do'">공지사항</div>
				</div>
			</div>
		</div>
		<div class="searchbox">
			<input type="text" class="searchinput w-input" maxlength="30" id="search_pc" onkeypress="if(event.keyCode==13) {javascript:searchAll('pc'); return false;}" name="searchAll" placeholder="검색어를 입력하세요."> 
			<img src="/business/webflow/images/3844467_magnifier_search_zoom_icon.png" loading="lazy" alt="" class="searchicon" onclick="searchAll('pc')" />
		</div>
	</div>
	<div class="m_top">
		<a href="#" class="m_menubtn w-inline-block"> 
			<img src="/business/webflow/images/bars-solid.png" loading="lazy" alt="" class="m_menuicon">
		</a> 
		<a href="/business/main.do" class="logolink w-inline-block"> 
			<img src="/business/webflow/images/LINKDA_LOGO2.png" loading="lazy" alt="" class="logoimg">
			<div class="logotxt">LINKSHOW</div><!-- 타이틀변경 -->
		</a> 
		<a href="#" class="m_searchbtn w-inline-block"> 
			<img src="/business/webflow/images/search-solid.png" loading="lazy" width="23" alt="" class="m_searchicon">
		</a>
	</div>
	<div class="m_menuframe" style="display:none;">
		<div class="m_menubox">
			<a href="#" onclick="$('.m_menuframe').hide()" class="closebtn w-inline-block"><img src="/business/webflow/images/closeimg.png" loading="lazy" alt="" class="x"></a>
            <div class="div-block-28">
              <a href="/business/main.do" class="logolink w-inline-block"><img src="/business/webflow/images/LINKDA_LOGO2.png" loading="lazy" alt="" class="logoimg2"></a>
            </div>
			<c:if test="${UserLoginIdx != null && UserLoginIdx != ''}">
				<div class="userloginbox" style="display:flex">
					<div class="div-block-19">
						<img src="/business/webflow/images/human_1.png" loading="lazy" alt="" class="m_profile">
						<div class="m_userid">${UserLoginNickName}</div>
					</div>
					<a href="/business/logout.do" class="m_logoutbtn w-button">로그아웃</a>
					<div>
						<a href="javascript:userDel(${item.idx})" style="text-decoration:none;color:white; font-size:3.2vw; margin-right:3vw;">회원 탈퇴</a>
						<a href="/business/edit.do" style="text-decoration:none;color:white; font-size:3.2vw; margin-right:3vw;">내정보</a>
						<a href="javascript:window.open('/business/scrapPop.do' , '_blank' , 'toolbar=yes,scrollbars=yes,resizable=no,top=70,left=500,width=300,height=300')" style="text-decoration:none;color:white; font-size:3.2vw;">스크랩</a>
					</div>
				</div>
			</c:if>
			<c:if test="${UserLoginIdx == null || UserLoginIdx == ''}">
				<form role="form" method="post" id="loginForm_m">
					<div class="m_loginbox2">
						<input type="text" class="m_logininput w-input" name="id" placeholder="아이디">
						<input type="password" name="pw" class="m_logininput w-input" placeholder="비밀번호"> 
						<a href="javascript:userLoginM()" class="m_loginbtn w-button">로그인</a>
					</div>
				</form>
				<div class="loginbtnwrap">
					<a href="/business/join.do" class="m_joinbtn w-button">회원가입</a> 
					<a href="#" onclick="$('.m_menuframe').hide();$('.popframe3').css('display' , 'flex')" class="m_mysearchbtn w-button">계정 찾기</a>
				</div>
			</c:if>
			<div>
				<div class="m_searchcontent">
					<!-- <select class="select-field w-select">
						<option value="">게시물</option>
						<option value="First">태그</option>
					</select> -->
					<div class="searchbox2">
						<input type="text" class="searchinput w-input" maxlength="30" placeholder="검색어를 입력하세요." id="search_mo" onkeypress="if(event.keyCode==13) {javascript:searchAll('mo'); return false;}" name="searchAll" />
						<img onclick="searchAll('mo')" src="/business/webflow/images/3844467_magnifier_search_zoom_icon.png" loading="lazy" alt="" class="searchicon">
					</div>
				</div>
			</div>
			<div class="m_sidemenubox">
				<div class="m_sidemenuwrap" onclick="location.href='/business/webtoonList.do'">
					<div class="m_sidemenu">
						<div class="mtxt">웹툰</div>
					</div>
				</div>
				<div class="m_sidemenuwrap" onclick="location.href='/business/torrentList.do'">
					<div class="m_sidemenu">
						<div class="mtxt">토렌트</div>
					</div>
				</div>
				<div class="m_sidemenuwrap" onclick="location.href='/business/eatList.do'">
					<div class="m_sidemenu">
						<div class="mtxt">먹튀검증</div>
					</div>
				</div>
				<div class="m_sidemenuwrap" onclick="location.href='/business/reviewList.do'">
					<div class="m_sidemenu">
						<div class="mtxt">다시보기</div>
					</div>
				</div>
				<div class="m_sidemenuwrap" onclick="location.href='/business/sportList.do'">
					<div class="m_sidemenu">
						<div class="mtxt">스포츠배팅</div>
					</div>
				</div>
				<div class="m_sidemenuwrap">
					<div class="m_sidemenu">
						<div class="mtxt">공지사항</div>
					</div>
					<div class="menu">
						<div class="m_sidemenu _2" onclick="location.href='/business/qna.do'">
							<div class="mtxt">문의사항</div>
						</div>
						<div class="m_sidemenu _2" onclick="location.href='/business/noticeList.do'">
							<div class="mtxt">공지사항</div>
						</div>
					</div>
				</div>
			</div>
			<div class="m_sidebox _2">
				<div class="s_title m">State</div>
				<div class="side_list mobile">
					<!-- <div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">현재 접속자</div>
						</div>
						<div class="statetxt m">79명</div>
					</div> -->
					<div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">오늘 방문자</div>
						</div>
						<div class="statetxt m">${todayVisit}명</div>
					</div>
					<div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">어제 방문자</div>
						</div>
						<div class="statetxt m">${yesterVisit}명</div>
					</div>
					<div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">최대 방문자</div>
						</div>
						<div class="statetxt m">${maxVisit}명</div>
					</div>
					<div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">전체 방문자</div>
						</div>
						<div class="statetxt m">${sumVisit}명</div>
					</div>
					<div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">전체 게시물 수</div>
						</div>
						<div class="statetxt m">${allBoard.cnt}개</div>
					</div>
					<div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">전체 댓글수</div>
						</div>
						<div class="statetxt m">${allreple.cnt}개</div>
					</div>
					<div class="stable">
						<div class="div-block-7">
							<img src="/business/webflow/images/human.png" loading="lazy" alt="" class="usericon">
							<div class="statetxt m">전체 회원수</div>
						</div>
						<div class="statetxt m">${alluser}명</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<div class="popframe3">
	<div class="searchpop">
		<form id="findInfo">
			<div class="div-block-20">
				<img src="/business/webflow/images/3844467_magnifier_search_zoom_icon.png" loading="lazy" alt="" class="picon">
				<div class="searchnotice">
					회원가입 시 등록하신 이메일 주소를 입력해주세요.<br>해당 이메일로 아이디와 비밀번호 정보를 보내드립니다.
				</div>
				<input type="text" class="emailinput w-input" maxlength="200" name="email">
				<div id="ccaudioTop" style="display: none"></div>
				<div class="infosearchbox">
					<div class="div-block-23">
						<img src="/business/captchaImg.do" loading="lazy" alt="" class="image-8">
					</div>
					<div class="div-block-22">
						<a href="javaScript:getImageTop()" class="updatebtn w-inline-block">
							<img src="/business/webflow/images/update.png" loading="lazy" alt="" class="updateicon">
						</a>
						<a href="javaScript:audioTop()" class="soundbtn w-inline-block">
							<img src="/business/webflow/images/sound.png" loading="lazy" alt="" class="image-7">
						</a>
					</div>
					<input type="text" class="numinput w-input" name="captcha" id="captcha">
				</div>
				<div class="searchnotice">자동등록방지 숫자를 순서대로 입력하세요.</div>
			</div>
		</form>
		<div class="popbtnwrap">
			<a href="#" onclick="$('.popframe3').css('display' , 'none')" class="checkbtn w-button">취소</a> 
			<a href="javascript:checkInfoForm()" class="cancelbtn w-button">확 인</a>
		</div>
	</div>
</div>
<script>
var maClick = "1";
function clickNoti(num){
	maClick = num;
	var ma = document.getElementById("marquee");
	if(maClick =="0"){
		$("#marquee").attr("onclick" , "clickNoti('1')");
		ma.stop();
	}else{
		$("#marquee").attr("onclick" , "clickNoti('0')");
		ma.start();
	}
}
function checkInfoForm(){
	$(".cancelbtn").attr("href" , "javascript:void(0)");
	let data = $("#findInfo").serialize();
	$.ajax({
		url:'/business/checkInfoForm.do',
		type:'post',
		data:data,
		success:function(data){
			alert(data.msg);
			if(data.result == 'success')location.reload();
			$(".cancelbtn").attr("href" , "javascript:checkInfoForm()");
		}
	})
}
function getImageTop(){
	var rand = Math.random();
	var url = '/business/captchaImg.do?rand='+rand;
	$(".image-8").attr("src" , url);
}
function audioTop(){
	var rand = Math.random();
	var uAgent = navigator.userAgent;
	var soundUrl = '/business/captchaAudio.do?rand='+rand;
	if(uAgent.indexOf('Trident')>-1 || uAgent.indexOf('MISE')>-1){	/*IE 경우 */
		audioPlayerTop(soundUrl);
	}else if(!!document.createElement('audio').canPlayType){ /*Chrome 경우 */
		try {
			new Audio(soundUrl).play();
		} catch (e) {
			audioPlayer(soundUrl);
		}
	}else{
		window.open(soundUrl,'','width=1,height=1');
	}
}
function audioPlayerTop(objUrl){
	document.querySelector('#ccaudioTop').innerHTML = '<bgsoun src="' +objUrl +'">';
}

function searchAll(type){
	let search = $("#search_"+type).val();
	if(search == null || search == '' || search == 'null'){
		alert('검색어를 입력해주세요');
		return;
	}
	location.href= '/business/search.do?searchAll='+search;
}
function userLoginM(){
	var data = $("#loginForm_m").serialize();
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
  $(".m_sidemenu:eq(5)").on("click", function(){
    $(".menu").slideToggle();
  });
  $(".m_menubtn").on("click", function(){
  	$(".m_menuframe").show();
  });
  $(".m_searchbtn").on("click", function(){
  	$(".m_menuframe").show();
  });
</script>
</html>