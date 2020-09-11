<%@ page pageEncoding="UTF-8"%>

<%@ include file="include.jsp" %>     

<%if(ADMIN!=null && ADMIN.equals("true")){ %>
<%if(mobile){ %>
<div data-role="navbar" style="text-align: center;" >
<a class="ui-btn ui-btn-inline ui-mini ui-icon-edit ui-btn-icon-left" onclick="setEvent('modify');">입금확인</a>
<a class="ui-btn ui-btn-inline ui-mini ui-icon-edit ui-btn-icon-left" onclick="setEvent('cancel');">입금취소</a>
<a class="ui-btn ui-btn-inline ui-mini ui-icon-delete ui-btn-icon-left" onclick="setEvent('delete');">예약삭제</a>
</div>
<%} %>
<%}%>