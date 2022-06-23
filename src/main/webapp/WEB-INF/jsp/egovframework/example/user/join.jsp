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
		<main class="main2" id="join1">
			<div class="ptbox">
				<div class="ptitle">JOIN</div>
				<div class="line"></div>
			</div>
			<form id="joinForm1" style="display:contents">
				<div class="clause">
					<label class="w-checkbox checkbox-field agree1">
						<div class="w-checkbox-input w-checkbox-input--inputType-custom checkbox"></div> 
						<input type="checkbox" name="agree1" style="opacity: 0; position: absolute; z-index: -1">
						<span class="checkbox-label w-form-label">회원가입 약관 </span>
						<div class="agree" >내용에 동의합니다.</div>
					</label>
					<div class="clausetxt">
						링크쇼은 어떠한 자료도 저장하지 않고 오직 사이트링크 정보만 공유하는 사이트입니다.<br>회원가입없이 링크쇼의
						모든 메뉴는 이용가능합니다. 문의 사항 등록시에만 회원가입하시면 됩니다.
					</div>
				</div>
				<div class="clause">
					<label class="w-checkbox checkbox-field agree2">
						<div class="w-checkbox-input w-checkbox-input--inputType-custom checkbox"></div> 
						<input type="checkbox" name="agree2" style="opacity: 0; position: absolute; z-index: -1">
						<span class="checkbox-label w-form-label">개인정보처리방침안내 </span>
						<div class="agree" >내용에 동의합니다.</div>
					</label>
					<div class="clausetxt">
						[ 목적 ] <br>이용자 식별 및 본인여부 확인<br>‍<br>[ 항목 ]<br>아이디,
						이름, 비밀번호<br>‍<br>[ 보유기간 ] <br>회원 탈퇴 시까지
					</div>
				</div>
			</form>
			<div class="j_notice">
				<span class="text-span-4">!</span>회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.
			</div>
			<a href="javascript:checkAgreeForm()" class="joinbtn w-button">회원가입</a> 
		</main>
		<form id="joinForm2">
			<main class="main3"  id="join2" style="display:none;">
				<div class="ptbox">
					<div class="ptitle">JOIN</div>
					<div class="line"></div>
				</div>
				<div class="joinbox">
					<div class="jtxt" >사이트 이용정보 입력</div>
					<div class="jtable">
						<div class="ttitle">아이디</div>
						<div class="jwrap">
							<input type="text" class="tinput w-input" name="id" maxlength="20">
							<div class="jnotice">영문자, 숫자만 입력 가능, 최소 3자이상 입력하세요.</div>
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
						<div class="ttitle">이름</div>
						<div class="jwrap">
							<input type="text" class="tinput w-input" maxlength="20" name="name" >
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">닉네임</div>
						<div class="jwrap">
							<input type="text" class="tinput w-input" maxlength="20" name="nickname" >
							<div class="jnotice">공백없이 한글, 영문, 숫자만 입력 가능 </div>
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">E-mail</div>
						<div class="jwrap">
							<input type="text" class="tinput w-input" maxlength="200" name="email" >
						</div>
					</div>
				</div>
				<div class="joinbox">
					<div class="jtxt" >기타 개인설정</div>
					<div class="jtable">
						<div class="ttitle">메일링서비스</div>
						<div class="jwrap">
							<label class="w-checkbox checkbox-field join">
								<div class="w-checkbox-input w-checkbox-input--inputType-custom checkbox"></div>
								<input type="checkbox" name="mail" id="main" value="Y" style="opacity: 0; position: absolute; z-index: -1">
								<span class="checkbox-label w-form-label">정보 메일을 받겠습니다.</span>
							</label>
						</div>
					</div>
					<div class="jtable">
						<div class="ttitle">정보공개</div>
						<div class="jwrap">
							<label class="w-checkbox checkbox-field join">
								<div class="w-checkbox-input w-checkbox-input--inputType-custom checkbox"></div>
								<input type="checkbox" name="info" id="info" value="Y" style="opacity: 0; position: absolute; z-index: -1">
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
				<a href="javascript:checkJoinForm()" class="joinbtn w-button">회원가입</a> 
			</main>
		</form>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
		<div class="popframe4" id="join3">
			<div class="joinpop">
				<img src="/business/webflow/images/ce.png" loading="lazy" data-w-id="eaaa286d-8507-5567-a4b9-20b5c69ee486" alt="" class="jicon">
				<div class="jtext2"><span class="joinNm"></span>님의 회원가입을 진심으로 축하합니다 !</div>
				<div class="jtext">
					<span class="joinNm"></span>님의 회원가입을 진심으로 축하합니다.<br>아이디, 비밀번호 분실시에는 회원가입시 입력하신 이메일 주소를 이용하여 찾을 수
					있습니다.<br>회원 탈퇴는 언제든지 가능하며 일정기간이 지난 후, 회원님의 정보는 삭제하고 있습니다.<br>감사합니다.
				</div>
				<div class="jtext"></div>
				<a href="/business/main.do" class="button w-button">확 인</a>
			</div>
		</div>
	</div>
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
function checkAgreeForm(){
	if(!$(".agree1").children('div').hasClass("w--redirected-checked")){
		alert("가입 약관에 동의해주세요.");
		return;
	}
	if(!$(".agree2").children('div').hasClass("w--redirected-checked")){
		alert("개인정보처리방침에 동의해주세요.");
		return;
	}
	$("#join2").css("display", "flex");
	$("#join1").css("display","none");
	window.scrollTo(0, 0);
}
function checkJoinForm(){
	let data = $("#joinForm2").serialize();
	$.ajax({
		url:'/business/checkJoinForm.do',
		type:'post',
		data:data,
		success:function(data){
			if(data.result == 'success'){
				$("#join3").css("display", "flex");
				$(".joinNm").text(data.name);
			}else{
				alert(data.msg);				
			}
		}
	})
}
</script>
</body>
</html>