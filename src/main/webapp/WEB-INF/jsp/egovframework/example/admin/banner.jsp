<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../adminFrame/header.jsp"></jsp:include>
</head>
<script src="/business/se2/js/HuskyEZCreator.js" charset="utf-8" ></script>
<body>
	<div id="wrapper">
		<jsp:include page="../adminFrame/top.jsp"></jsp:include>
		<jsp:include page="../adminFrame/left.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">배너관리</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-6">
									<div class="row">
										<form id="banner1" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="1"/>
										<input type="hidden" name="originBanner" value="${topBanner1.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 1번째 배너</label>
													<div>
														<c:if test="${topBanner1.imgNm != null && topBanner1.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner1.imgNm}"/>
															<br/>
														</c:if>
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner1.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(1)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner2" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="2"/>
										<input type="hidden" name="originBanner" value="${topBanner2.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 2번째 배너</label>
													<div>
														<c:if test="${topBanner2.imgNm != null && topBanner2.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner2.imgNm}"/>
															<br/>
														</c:if>
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner2.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(2)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner3" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="3"/>
										<input type="hidden" name="originBanner" value="${topBanner3.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 3번째 배너</label>
													<div>
														<c:if test="${topBanner3.imgNm != null && topBanner3.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner3.imgNm}"/>
															<br/>
														</c:if>
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner3.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(3)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner4" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="4"/>
										<input type="hidden" name="originBanner" value="${topBanner4.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 4번째 배너</label>
													<div>
														<c:if test="${topBanner4.imgNm != null && topBanner4.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner4.imgNm}"/>
															<br/>
														</c:if>
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner4.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(4)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner5" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="5"/>
										<input type="hidden" name="originBanner" value="${topBanner5.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 5번째 배너</label>
													<div>
														<c:if test="${topBanner5.imgNm != null && topBanner5.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner5.imgNm}"/>
															<br/>
														</c:if>
													
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner5.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(5)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner6" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="6"/>
										<input type="hidden" name="originBanner" value="${topBanner6.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 6번째 배너</label>
													<div>
														<c:if test="${topBanner6.imgNm != null && topBanner6.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner6.imgNm}"/>
															<br/>
														</c:if>
													
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner6.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(6)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner7" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="7"/>
										<input type="hidden" name="originBanner" value="${topBanner7.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 7번째 배너</label>
													<div>
														<c:if test="${topBanner7.imgNm != null && topBanner7.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner7.imgNm}"/>
															<br/>
														</c:if>
													
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner7.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(7)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner8" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="8"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 8번째 배너</label>
													<div>
														<c:if test="${topBanner8.imgNm != null && topBanner8.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner8.imgNm}"/>
															<br/>
														</c:if>
													
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner8.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(8)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner9" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="0"/>
										<input type="hidden" name="ordNum" value="9"/>
										<input type="hidden" name="originBanner" value="${topBanner9.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>상단 9번째 배너</label>
													<div>
													<c:if test="${topBanner9.imgNm != null && topBanner9.imgNm != ''}">
															<img src="/filePath/business/banner/${topBanner9.imgNm}"/>
															<br/>
														</c:if>
													
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${topBanner9.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(9)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
								<div class="col-lg-6">
									<div class="row">
										<form id="banner10" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="1"/>
										<input type="hidden" name="ordNum" value="1"/>
										<input type="hidden" name="originBanner" value="${rightBanner1.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>사이드 1번째 배너</label>
													<div>
														<c:if test="${rightBanner1.imgNm != null && rightBanner1.imgNm != ''}">
															<img src="/filePath/business/banner/${rightBanner1.imgNm}"/>
															<br/>
														</c:if>
													
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${rightBanner1.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(10)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner11" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="1"/>
										<input type="hidden" name="ordNum" value="2"/>
											<input type="hidden" name="originBanner" value="${rightBanner2.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>사이드 2번째 배너</label>
													<div>
														<c:if test="${rightBanner2.imgNm != null && rightBanner2.imgNm != ''}">
															<img src="/filePath/business/banner/${rightBanner2.imgNm}"/>
															<br/>
														</c:if>
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${rightBanner2.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(11)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner12" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="1"/>
										<input type="hidden" name="ordNum" value="3"/>
										<input type="hidden" name="originBanner" value="${rightBanner3.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>사이드 3번째 배너</label>
													<div>
														<c:if test="${rightBanner3.imgNm != null && rightBanner3.imgNm != ''}">
															<img src="/filePath/business/banner/${rightBanner3.imgNm}"/>
															<br/>
														</c:if>
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${rightBanner3.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(12)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="row">
										<form id="banner13" method="post" enctype="multipart/form-data">
										<input type="hidden" name="location" value="1"/>
										<input type="hidden" name="ordNum" value="4"/>
										<input type="hidden" name="originBanner" value="${rightBanner4.imgNm}"/>
											<div class="col-lg-12">
												<div class="form-group">
													<label>사이드 4번째 배너</label>
													<div>
														<c:if test="${rightBanner4.imgNm != null && rightBanner4.imgNm != ''}">
															<img src="/filePath/business/banner/${rightBanner4.imgNm}"/>
															<br/>
														</c:if>
														<input type="file" name="file"/><br/>
													</div>
													<div class="form-group input-group">
														<input type="text" name="link" placeholder="※ http:// or https://형식으로 시작해야합니다"class="form-control" value="${rightBanner4.url}" placeholder="연결링크"> 
														<span class="input-group-btn">
															<button class="btn btn-default" onclick="insertForm(13)" type="button">등록</button>
														</span>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../adminFrame/footer.jsp"></jsp:include>
	<script>
		function insertForm(idx){
			var form = $("#banner"+idx)[0]; 
			var data = new FormData(form);
			var url = "/business/admin/banner/bannerInsert.do";
			$.ajax({
				type:'post',
				url : url,
				data: data,
				processData:false,
				contentType:false,
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
	</script>
</body>
</html>