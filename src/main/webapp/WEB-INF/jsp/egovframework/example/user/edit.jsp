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
				<div class="ptitle">회원 정보 수정 </div>
				<div class="line"></div>
			</div>
			<form id="checkPwForm" name="checkPwForm" style="width:100%;">
				<div class="pwpop2">
					<img src="/business/webflow/images/notice.png" loading="lazy" alt="" class="picon">
					<div class="pwnotice">
						회원님의 정보를 안전하게 보호하기위해 비밀번호를 <br>한번 더 입력해주세요.
					</div>
					<div class="pwuserid">회원아이디 : ${UserLoginId}</div>
					<input type="password" class="pwinput w-input" name="pw" maxlength="30">
				</div>
			</form>
			<a href="javascript:checkForm()" class="joinbtn w-button">확인하기</a> 
		</main>
		<jsp:include page="../userFrame/bottom.jsp"></jsp:include>
	</div>
<script>
function checkForm(){
	let data = $("#checkPwForm").serialize();
	$.ajax({
		type : 'post',
		url :'/business/editPwCheck.do',
		data : data,
		success:function(data){
			if(data.result == 'success')location.href='/business/editForm.do' ; // 좀이따 링크이동넣어야함  location.href=''  
			else alert(data.msg);
		}
	})	
	
}
</script>
</body>
</html>