<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />

<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script
	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<style>
* {
	-webkit-text-size-adjust: none;
	max-width: 100%;
}
</style>

<title>관리자메뉴</title>
</head>
<script type="text/javascript">
$.mobile.ajaxEnabled = false;
</script>

<body>

<div data-role="page" data-theme="a">

<div data-role="header"></div>


<div data-role="content">
<ul data-role="listview" data-inset="true">
	<li data-role="fieldcontain" data-icon="gear" ><a href="common.jsp" data-transition="fade"   >환경설정</a></li>
	<li data-role="fieldcontain" data-icon="search" ><a href="list.jsp" data-transition="fade"  >예약조회</a></li>
	<li data-role="fieldcontain" data-icon="search" ><a href="list2.jsp?pageid=list2" data-transition="fade"  >미입금대상</a></li>	
	<li data-role="fieldcontain" data-icon="action"><a href="logout_admin.jsp"  >LogOut</a></li>
</ul>

</div>

<div data-role="footer"></div>

</div>

</body>


</html>