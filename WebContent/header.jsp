<%@ page language="java" pageEncoding="UTF-8"%>

<%@ include file="include.jsp" %>

<h1><%=userinfo.getString("USERNAME") %>
<%if(ADMIN!=null && ADMIN.equals("true")){ %>(관리자)
<%}%>
</h1>
<div data-role="navbar">

<ul>

<li><a href=cal2.jsp data-icon="home"  data-ajax="false">Home</a></li>

<li><a href="#" onclick="javascript:history.back();" data-icon="back">Back</a></li>

<li><a href="#" onclick="javascript:location.reload();"   data-icon="refresh">Refresh</a></li>

<%if(ADMIN!=null && ADMIN.equals("true")){ %>
 <li><a href="admin_list.jsp" data-icon="gear" data-ajax="false" >Admin</a></li>
<%}else{ %>
 <li> <a href="logout_user.jsp" data-icon="gear" data-ajax="false" >LogOut</a></li>
<%} %>

</ul>

</div>
