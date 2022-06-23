<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html data-wf-page="6124b2b8eb59b4f366ff8c20" data-wf-site="612355761b8556d533d669fc">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../userFrame/header.jsp"></jsp:include>
</head>
<script src="/business/se2/js/HuskyEZCreator.js" charset="utf-8" ></script>
<body class="body">
	<div class="form-block w-form">
		<c:import url="/top.do" charEncoding="UTF-8"/>
		<main class="main">
			<c:import url="/rightBanner.do" charEncoding="UTF-8"/>
			<section class="section">
				<form method="post" id="qnaInsert">
					<div class="detailcontentbox">
						<div class="pagetbox">
							<div class="ptbox3">
								<div data-w-id="997d423b-c4a9-662a-a91b-9bee42e57d73" class="ptitle">REGISTER</div>
								<div data-w-id="997d423b-c4a9-662a-a91b-9bee42e57d75" class="line"></div>
							</div>
						</div>
						<div class="write--notice">
							<div class="cnotice">[ 입점문의 안내사항 ]</div>
							<div class="cnotice">
								<span class="text-span-2">●</span> 입점을 원하는 카테고리와 사이트명과 주소를 남겨주시기 바랍니다.
							</div>
							<div class="cnotice">
								<span class="text-span-2">●</span>입점 신청전에 반드시 신청 사이트에 제휴카테고리가 있다면 링크쇼을 등록해 주시기 바랍니다.
							</div>
							<div class="cnotice">
								<span class="text-span-2">●</span> 제휴카테고리가 없다면 신청 사이트에 아무게시판이나 링크쇼 링크게시물을 남겨 주시바랍니다.
							</div>
							<div class="cnotice">
								<span class="text-span-2">●</span> 웹툰사이트처럼 게시판이 전혀 없다면 안해셔도 됩니다.
							</div>
							<div class="cnotice">
								<span class="text-span-2">●</span> 게시판이 전혀 없는 사이트를 제외하고 제휴카테고리 또는 아무게시판이나 저희 링크쇼 게시물이 없다면 등록이 보류 될 수 있습니다.
							</div>
						</div>
						<div class="writecontent">
							<div class="wtable">
								<div class="ttitle">분류</div>
								<div class="jwrap">
									<select  name="category" id="category" class="select-field-2 w-select">
										<option value="noQna" <c:if test="${category == 'noQna'}">selected</c:if>>일반문의</option>
										<option value="inQna" <c:if test="${category == 'inQna'}">selected</c:if>>입점문의</option>
										<option value="adQna" <c:if test="${category == 'adQna'}">selected</c:if>>광고문의</option>
									</select>
								</div>
							</div>
							<div class="wtable">
								<div class="ttitle">제목</div>
								<div class="jwrap2">
									<input type="text" class="winput w-input" maxlength="100" name="title">
									<!-- <a href="#" class="savebtn w-button">저장</a>  -->
									<a href="#" onclick="$('.popframe2').css('display' , 'flex');"class="w_noticebtn w-inline-block">
										<div class="w_notice">!</div>
									</a>
								</div>
							</div>
							<div class="wtable">
								<div class="ttitle">내용</div>
								<div class="jwrap">
									<textarea name="text" id="smartEditor" class="textarea-2 w-input"></textarea>
								</div>
							</div>
							<div class="wtable">
								<div class="ttitle">링크 #1</div>
								<div class="jwrap2">
									<input type="text" placeholder="※ http:// or https://형식으로 시작해야합니다" class="winput w-input" name="link1">
								</div>
							</div>
							<div class="wtable">
								<div class="ttitle">링크 #2</div>
								<div class="jwrap2">
									<input type="text" placeholder="※ http:// or https://형식으로 시작해야합니다" class="winput w-input" name="link2">
								</div>
							</div>
							<div class="div-block-12">
								<a href="javascript:qnaInsert()" class="donebutton w-button" >문의 등록</a> 
								<a href="/business/qna.do?category=${category}" class="donebutton w-button">취소</a>
							</div>
						</div>
					</div>
				</form>
			</section>
		</main>
		<div class="popframe2">
			<div class="guidepop">
				<div class="guidetxt">
					1. 등록가능 동영상 공유주소형태<br/>
					유튜브 동영상<br/>
					http://youtu.be/oL2AlXWVbKU 또는 http://www.youtube.com/watch?v=oL2AlXWVbKU<br/>
					비메오 동영상<br/>
					http://vimeo.com/18923281<br/>
					다음TV 동영상<br/>
					http://tvpot.daum.net/v/kxxUvNy1ndg$<br/>
					네이트TV 동영상<br/>
					http://pann.nate.com/video/221313865<br/>
					판도라TV 동영상<br/>
					http://channel.pandora.tv/channel/video.ptv?ch_userid=sobboso&prgid=47491832<br/>
					태그스토리 동영상<br/>
					http://www.tagstory.com/video/100470056<br/>
					테드(TED) 동영상<br/>
					http://www.ted.com/talks/lang/ko/cesar_kuriyama_one_second_every_day.html<br/>
					데일리모션 동영상<br/>
					http://www.dailymotion.com/video/xzh0jv_iron-man-3-review_shortfilms<br/>
					페이스북 동영상<br/>
					https://www.facebook.com/photo.php?v=337102899759854&set=vb.470756562961560&type=2&theater<br/>
					네이버tvcast & 블로그 동영상<br/>
					http://tvcast.naver.com/v/92491<br/>
					슬라이더쉐어 동영상<br/>
					http://www.slideshare.net/boozcompany/2013-innovation-100-study-v3<br/><br/>
					2. 동영상 입력방법<br/>
					내용에 {동영상:동영상 공유주소} 형태로 입력합니다.<br/>
					ex) {동영상:http://youtu.be/oL2AlXWVbKU }<br/>
					동영상은 갯수제한없이 입력 가능합니다.<br/><br/>
					3. 첨부이미지 내용 삽입 방법<br/>
					에디터 사진부분을 누른 후 사진을 드래그하여 추가할 수 있습니다.<br/>				
				</div>
				<a href="#" onclick="$('.popframe2').css('display', 'none')" class="button w-button">확 인</a>
			</div>
		</div>
	</div>
<script>
	function qnaInsert() {
		oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []);
		var data = $("#qnaInsert").serialize();
		$.ajax({
			type : 'post',
			data : data,
			url : '/business/qnaInsertProcess.do',
			success : function(data) {
				alert(data.msg);
				if (data.result == "success") {
					location.href = '/business/qna.do';
				}
			}
		})
	}
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "smartEditor",
		sSkinURI : "/business/se2/SmartEditor2Skin.html",
		fCreator : "createSEditor2",
		htParams : {
			bUseToolbar : true,
			bUseVerticalResizer : false,
			//bSkipXssFilter : true,
			bUseModeChanger : false
		},
	});
</script>
</body>
</html>