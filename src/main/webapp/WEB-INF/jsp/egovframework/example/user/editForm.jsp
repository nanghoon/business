<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html data-wf-page="61245c915affd40619b4fea7" data-wf-site="612355761b8556d533d669fc">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../userFrame/header.jsp"></jsp:include>
</head>
<body class="body">
	<div class="form-block w-form">
	<c:import url="/top.do" charEncoding="UTF-8" />
	<form id="updateForm">
		<input type="hidden" name="idx" value="${info.idx}">
		<main class="main3"  id="join2">
				<div class="ptbox">
					<div class="ptitle">Edit Member Information</div>
					<div class="line"></div>
				</div>
				<div class="joinbox">
					<div class="jtxt" >사이트 이용정보 입력</div>
					<div class="jtable">
						<div class="ttitle">아이디</div>
						<div class="jwrap">
							<span class="tinput w-input" style="background-color:#EFEEEE">${info.id}</span>
							<div class="jnotice">아이디는 변경이 불가능 합니다.</div>
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">비밀번호</div>
						<div class="jwrap">
							<input type="password" class="tinput w-input" maxlength="20" name="pw">
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">비밀번호 확인</div>
						<div class="jwrap">
							<input type="password" class="tinput w-input" maxlength="20" name="pwchk" >
						</div>
					</div>
				</div>
				<div class="joinbox">
					<div class="jtxt" >개인정보 입력</div>
					<div class="jtable">
						<div class="ttitle">닉네임</div>
						<div class="jwrap">
							<span class="tinput w-input"  style="background-color:#EFEEEE">${info.nickname}</span>
							<div class="jnotice">닉네임은 변경이 불가능합니다</div>
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">E-mail</div>
						<div class="jwrap">
							 <input value="${info.email}" type="text" class="tinput w-input" maxlength="200" name="email" >
						</div>
					</div>
				</div>
				<div class="joinbox">
					<div class="jtxt" >기타 개인설정</div>
					<div class="jtable">
						<div class="ttitle">메일링서비스</div>
						<div class="jwrap">
							<label class="w-checkbox checkbox-field join">
								<div class="w-checkbox-input w-checkbox-input--inputType-custom checkbox <c:if test="${info.mail == 'Y'}">w--redirected-checked</c:if>"></div>
								<input type="checkbox" name="mail" id="mail" value="Y" style="opacity: 0; position: absolute; z-index: -1" <c:if test="${info.mail == 'Y'}">checked</c:if>>
								<span class="checkbox-label w-form-label">정보 메일을 받겠습니다.</span>
							</label>
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">정보공개</div>
						<div class="jwrap">
							<label class="w-checkbox checkbox-field join">
								<div class="w-checkbox-input w-checkbox-input--inputType-custom checkbox <c:if test="${info.info == 'Y'}">w--redirected-checked</c:if>"></div>
								<input type="checkbox" name="info" id="info" value="Y" style="opacity: 0; position: absolute; z-index: -1" <c:if test="${info.info == 'Y'}">checked</c:if>>
								<span class="checkbox-label w-form-label">다른분들이 나의 정보를 볼 수 있도록 합니다.</span>
							</label>
							<div class="jnotice">정보공개를 바꾸시면 앞으로 0일 이내에는 변경이 안됩니다.</div>
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">자동등록방지</div>
						<div>
							<div id="ccaudio" style="display: none"></div>
							<div class="infosearchbox">
								<div class="div-block-23">
									<img src="/business/captchaImg.do" loading="lazy" alt="" class="image-8">
								</div>
								<div class="div-block-22">
									<a href="javaScript:getImage()" class="updatebtn w-inline-block">
										<img src="/business/webflow/images/update.png" loading="lazy" alt="" class="updateicon">
									</a>
									<a href="javaScript:audio()" class="soundbtn w-inline-block">
										<img src="/business/webflow/images/sound.png" loading="lazy" alt="" class="image-7">
									</a>
								</div>
								<input type="text" class="numinput w-input" name="captcha" id="captcha">
							</div>
							<div class="jnotice">자동등록방지 숫자를 순서대로 입력하세요.</div>
						</div>
					</div>
				</div>
				<a href="javascript:updateForm()" class="joinbtn w-button">정보수정</a> 
			</main>
		</form>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
<script>
$(function(){
	$(".w-checkbox").click(function(e){
		e.preventDefault(); // 두번실행 방지 
		if($(this).children('div').hasClass("w--redirected-checked")){
			$(this).children('div').removeClass("w--redirected-checked");
			$(this).children('input').prop('checked' , false);
		}else{
			$(this).children('div').addClass("w--redirected-checked");
			$(this).children('input').prop('checked' , true);
		}
	})
})
function updateForm() {
	var data = $("#updateForm").serialize();
	var url = "/business/editUserForm.do";
	$.ajax({
		type : 'post',
		url : url,
		data : data,
		success : function(data) {
			alert(data.msg);
			if (data.result == 'success') {
				location.reload();
			}
		},
		error : function(e) {
			console.log('ajaxError' + e);
		}
	});
}
function getImage(){
	var rand = Math.random();
	var url = '/business/captchaImg.do?rand='+rand;
	$(".image-8").attr("src" , url);
}
function audio(){
	var rand = Math.random();
	var uAgent = navigator.userAgent;
	var soundUrl = '/business/captchaAudio.do?rand='+rand;
	if(uAgent.indexOf('Trident')>-1 || uAgent.indexOf('MISE')>-1){	/*IE 경우 */
		audioPlayer(soundUrl);
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
function audioPlayer(objUrl){
	document.querySelector('#ccaudio').innerHTML = '<bgsoun src="' +objUrl +'">';
}
</script>
</body>
</html>