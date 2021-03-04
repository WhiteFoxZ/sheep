<%@ page pageEncoding="UTF-8" %>


<%@ include file="include.jsp" %>


<%

//관리자 패스워드 바꾸는 기능

if(userinfo!=null){

  String event = request.getParameter("event");
  if (event == null) {
      event = "find";
  }



  String LOGINID = userinfo.getString("LOGINID");

  int sessionHashCode = session.getId().hashCode();

  PasswdAdmin passwdAdmin = new PasswdAdmin(application,request, userinfo, sessionHashCode);


  EmsHashtable[] hash  = (EmsHashtable[])request.getAttribute("hash");

  DataSource ds = (DataSource)application.getAttribute("jdbc/mysql_ds");

  DBManager dbm = new DBManager(ds);


%>
<!-- html 시작 -->

<html>
<head>
<title></title>

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<style>
* { -webkit-text-size-adjust:none; max-width:100%; }
</style>




        <SCRIPT language=javascript>

        $.mobile.ajaxEnabled = false;

        var submitFlag=true;


            function setEvent(event){

	            if(submitFlag==true){
	                document.frmMain.event.value=event;
	                submitFlag=false;
	                document.frmMain.submit();
	                return false;

	            }


            }



            function init(){

            	<%
            	String msg = request.getAttribute("msg")!=null?request.getAttribute("msg").toString():null;

            	if(msg!=null && msg.length()>0){
            	%>

            	var msgText="<%=msg%>";
            	var textVisible="true";
            	var textonly="true";
            	var theme="a";
            	var html="";

            	$.mobile.loading( "show", {
            		text: msgText,
            		textVisible: textVisible,
            		theme: theme,
            		textonly: textonly,
            		html: html
            	});


            	var timer = setTimeout(hideMsg, 1500);

            	<%}%>


            	// 전체선택 체크박스 클릭
            	$("#allCheck").click(function(){ //만약 전체 선택
				// 체크박스가 체크된상태일경우
					if($("#allCheck").prop("checked")) { //해당화면에 전체 checkbox들을 체크해준다

					$("input[type=checkbox]").prop("checked",true);
					// 전체선택 체크박스가 해제된 경우
					} else {
						//해당화면에 모든 checkbox들의 체크를해제시킨다.
					 	$("input[type=checkbox]").prop("checked",false);
					}
            	});


            }


            function hideMsg(){
            	$.mobile.loading( "hide" );
            }


        </script>

<style type="text/css">
	.ui-datepicker-trigger {
		vertical-align: middle;
		cursor: pointer;
		border-width:1px; background-color:#E9F3FE; border-color:#404040;font:12px;text-align: left; padding-left:2px;

	}

</style>


<style type="text/css">

<%if(!mobile){ %>

table th,td {
    padding:10px;
    text-align:right;
}
table.lamp th,td {
    padding:10px;
    text-align:l;
}




input[type="text"] {
        width:120px;
        height:30px;
      }

select {
        width:120px;
        height:30px;

      }


<%}else{ %>
<!--모바일일경우 폰트 더작게.-->
.ui-mini {
	font-size: 12px;
}


<%} %>
</style>

</head>


<body onload=init() >

<form name="frmMain" method="post" onsubmit="return false;"  >

<input type="hidden" name="event" value="" />

       <section id="page1" data-role="page">

				<header data-role="header">

                <jsp:include page="header.jsp" flush="true"/>

               </header>

               <div class="content" data-role="content">

<table align="right" >
<thead>
<tr>
<th >



<%if(mobile){ %>
<a class="ui-btn ui-btn-inline ui-mini ui-icon-search ui-btn-icon-left" onclick="setEvent('find');">조회</a>

<a class="ui-btn ui-btn-inline ui-mini ui-icon-edit ui-btn-icon-left" onclick="setEvent('modify');">수정</a>

<%}else{ %>
<a class="ui-btn ui-btn-inline ui-icon-search ui-btn-icon-left" onclick="setEvent('find');">조회</a>

<a class="ui-btn ui-btn-inline ui-icon-edit ui-btn-icon-left" onclick="setEvent('modify');">수정</a>

<%} %>

	</th>
</tr>
</thead>
</table>


<table id="table-custom-2"
	class="ui-body-d ui-shadow table-stripe ui-responsive"
	data-role="table"
	data-column-popup-theme="a"
    data-column-btn-theme="b">
    <%
    int idx=1;
    %>
	<thead>
		<tr class="ui-bar-a">
			<th data-priority="<%=idx++ %>"><input type="checkbox" id="allCheck" data-role="none"  /> &nbsp; CHK</th>
			<th data-priority="<%=idx++ %>">USERNAME</th>
			<th data-priority="<%=idx++ %>">TEL1</th>
			<th data-priority="<%=idx++ %>">LOGINPW</th>
			<th data-priority="<%=idx++ %>">ACCESSPW</th>







		</tr>
	</thead>
	<tbody >
	<%
	if(hash!=null){
		for (int i = 0; i < hash.length; i++) {
	%>
		<tr >
			<th >
			<input type="checkbox" id="chk" name="chk" value="<%=i%>" data-role="none"  >
			<input type="HIDDEN" name="PK_LOGINID" value="<%=hash[i].getString("LOGINID")%>" data-role="none"  >
			</th>
			<td><input type="text" name="USERNAME"   value="<%=hash[i].getString("USERNAME")%>"  data-role="none" ></td>
			<td><input type="text" name="TEL1"   value="<%=hash[i].getString("TEL1")%>"  data-role="none" ></td>
			<td><input type="text" name="LOGINPW" value="<%=hash[i].getString("LOGINPW")%>"  data-role="none" ></td>
			<td><input type="text" name="ACCESSPW" 	  value="<%=hash[i].getString("ACCESSPW")%>"  data-role="none" ></td>
		</tr>
	<%	}	//end of for

	}%>
	</tbody>
</table>
</div>

       </section>
</form>
</body>



</html>


<!-- html 끝 -->
<%


}else{	//LOGIN 정보가 없을때
%>

<jsp:include page="userinfo.jsp" flush="true"/>

<%} %>

