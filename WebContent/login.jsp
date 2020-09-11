<%@ page  pageEncoding="UTF-8"%>
    

<%@ include file="include.jsp" %>

<%

Cookie cookies[] = request.getCookies();
String cookieName=null;
String id="";
String pw="";

if(cookies!=null && cookies.length>0){
for(int i=0; i<cookies.length; i++){
	
	cookieName = cookies[i].getName();
	
	if(cookieName.equals("LOGINID")){
		id = cookies[i].getValue();
	}
	
	if(cookieName.equals("LOGINPW")){
		pw = cookies[i].getValue();
	}
	
}
}


%>

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


<SCRIPT language="JavaScript">
    function sendData()
    {
     var f = document.frmMain;
     if(f.id.value == "")
     {
      window.alert("ID를 반드시 입력해야 합니다.");
      f.id.focus();
      return false;
     }
     if(f.id.value.length < 4 || f.id.value.length > 10)
     {
      window.alert("ID는 4자 이상 10자 이하 입니다.");
      f.id.select();
      return false;
     }

     if(f.pw.value == "")
     {
      window.alert("비밀번호를 반드시 입력해야 합니다.");
      f.pw.focus();
      return false;
     }

     if(f.pw.value.length < 4 || f.pw.value.length > 10)
     {
      window.alert("비밀번호를 4자 이상 10자 이하 입니다.");
      f.pw.select();
      return false;
     }
     
     f.submit();
    }
  </SCRIPT>



<title>관리자메뉴</title>
</head>


<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"  onload="document.frmMain.id.focus();">
<form name="frmMain" method=post action="loginAction.jsp" target="_self">

<input type="hidden" name="event" value="" />

<div data-role="page" data-theme="a">

<div data-role="header"></div>


<div data-role="content">

<table  width='100%' cellSpacing="0" borderColorDark="#ffffff" cellPadding="0" borderColorLight="#666666" border="1" align="center">
	<tr>
		<!-- showLogo  -->
		<td background="./img/book_head_bg.gif" align="right" height=80>&nbsp;</td>		
		
	</tr>

	<tr>
		<td bgcolor="e5e5e5">
		<table width='100%' borderColorDark="#ffffff" cellPadding="0" borderColorLight="#666666" border="0" align="center">
			<tr height="25">
				<td  style="padding-left: 5">Login (테스트용 : TEST/TEST)</td>
				
			</tr>
		</table>
		</td>
	</tr>
		
<tr>
<td>
		<table borderColorDark="#ffffff" cellPadding="0" borderColorLight="#666666" border="0" align="center">
		<TR >
			<TD>User ID :</td>
			<td><input type="text" name="id" value="<%=id %>" required="required"></TD>
		</TR>
		<TR >
			<TD>User Password :</TD>
			<TD><INPUT type="password" name="pw" value="<%=pw %>" required="required"></TD>
		</TR>
		
		<TR >
			<TD>로그인유지 :</TD>
			<TD><input type="checkbox" name="remember" id="gr_login_rememberme"  <%=pw.equals("")?"":"checked" %> /></TD>
		</TR>
		
		
		<TR >
			<TD>&nbsp;</td>
			<td>
			<INPUT type="button" value="로그인" onclick="sendData();">	
			
			</TD>
		</TR>
		

						
		</table>
</td>
</tr>		

</table>
</div>

<div data-role="footer"></div>

</div>
</form>
</body>


</html>