<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../adminFrame/header.jsp"></jsp:include>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../adminFrame/top.jsp"></jsp:include>
		<jsp:include page="../adminFrame/left.jsp"></jsp:include>
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                	<h1 class="page-header">회원관리</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
						<div class="panel-heading">
						</div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
											<th>아이디</th>
											<th>이름</th>
											<th>닉네임</th>
											<th>이메일</th>
											<th>메일서비스동의</th>
											<th>정보공개동의</th>
											<th>가입날짜</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:set var="number" value="${pi.totalRecordCount -pi.recordCountPerPage*(pi.currentPageNo-1) }"/>
                                    	<c:forEach var="item" items="${list}" varStatus="i">
                                        <tr>
                                            <td>${number}<c:set var="number" value="${number - 1}" /></td>
											<td>${item.id}</td>
											<td>${item.name}</td>
											<td>${item.nickname}</td>
											<td>${item.email}</td>
                                            <td>${item.mail}</td>
                                            <td>${item.info}</td>
											<td><fmt:formatDate value="${item.jdate}" type="date"/></td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
							 <div class="row">
								<div class="col-sm-12" style="text-align:center;">
								<ul class="pagination">
									<ui:pagination paginationInfo="${pi}" type="admin" jsFunction="page"/>
								</ul>
								</div>
							</div>
                        </div>
                    </div>
                </div>
            </div>
		   <form action="/business/admin/user/userList.do" name="listForm" id="listForm">
				<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
			</form>
        </div>
	</div>
	<jsp:include page="../adminFrame/footer.jsp"></jsp:include>
	<script>
	function page(num){
		$("#pageIndex").val(num);
		$("#listForm").submit();
	}
	</script>
</body>
</html>