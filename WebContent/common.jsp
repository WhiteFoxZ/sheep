<%@ page pageEncoding="UTF-8" %>


<%@ include file="include.jsp" %>


<%


if(userinfo!=null){

  String event = request.getParameter("event");
  if (event == null) {
      event = "find";
  }


  String P_CD_GROUP_ID = request.getParameter("P_CD_GROUP_ID")==null?"":request.getParameter("P_CD_GROUP_ID");

  String P_CD_MEANING = request.getParameter("P_CD_MEANING")==null?"":request.getParameter("P_CD_MEANING");



  int sessionHashCode = session.getId().hashCode();

  COMMON book = new COMMON(application,request, userinfo, sessionHashCode);


  EmsHashtable[] hash  = (EmsHashtable[])request.getAttribute("hash");

  DataSource ds = (DataSource)application.getAttribute("jdbc/mysql_ds");

  DBManager dbm = new DBManager(ds);

  EmsHashtable[] hash2 = dbm.selectMultipleRecord("SELECT CD_GROUP_ID,CD_GROUP_NM FROM fishfox.comm_info   group by CD_GROUP_ID,CD_GROUP_NM  order by CD_GROUP_ID ",
    		new String[] { });



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


            	var timer = setTimeout(hideMsg, 1000);

            	<%}%>
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

CD_GROUP_NM:
<select name="P_CD_GROUP_ID" data-role="none"  class="ui-datepicker-trigger ui-mini" style="margin-right:50px;" >

<option value="%">선택하세요</option>

<%=EmsOption.getOption(hash2,"CD_GROUP_ID","CD_GROUP_NM",P_CD_GROUP_ID) %>

</select>

CD_MEANING:
<input type="text" name="P_CD_MEANING" value="<%=P_CD_MEANING%>" data-role="none"  class="ui-datepicker-trigger ui-mini" style="margin-right:50px;" >


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
			<th data-priority="<%=idx++ %>">CHK</th>
			<th data-priority="<%=idx++ %>">CD_GROUP_ID</th>
			<th data-priority="<%=idx++ %>">CD_GROUP_NM</th>
			<th data-priority="<%=idx++ %>">CD_ID</th>
			<th data-priority="<%=idx++ %>">CD_MEANING</th>
			<th data-priority="<%=idx++ %>">PRICE</th>
			<th data-priority="<%=idx++ %>">EXT1</th>
			<th data-priority="<%=idx++ %>">EXT2</th>
			<th data-priority="<%=idx++ %>">SORT</th>

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
			<input type="HIDDEN" name="PK_CD_ID" value="<%=hash[i].getString("CD_ID")%>" data-role="none"  >
			</th>
			<td><input type="text" name="CD_GROUP_ID"   value="<%=hash[i].getString("CD_GROUP_ID")%>"  data-role="none" ></td>
			<td><input type="text" name="CD_GROUP_NM" value="<%=hash[i].getString("CD_GROUP_NM")%>"  data-role="none" ></td>
			<td><input type="text" name="CD_ID" 	  value="<%=hash[i].getString("CD_ID")%>"  data-role="none" ></td>
			<td><textarea name="CD_MEANING"  rows="1" cols="30"><%=hash[i].getString("CD_MEANING")%></textarea></td>
			<td><input type="text" name="PRICE" 	  style="width:60px;" value="<%=hash[i].getString("PRICE")%>"  data-role="none" ></td>
			<td><input type="text" name="EXT1" 		  style="width:150px;" value="<%=hash[i].getString("EXT1")%>"  data-role="none" ></td>
			<td><input type="text" name="EXT2" 		  style="width:50px;" value="<%=hash[i].getString("EXT2")%>"  data-role="none" ></td>
			<td><input type="text" name="SORT_SEQ" 	  style="width:50px;" value="<%=hash[i].getString("SORT_SEQ")%>"  data-role="none" ></td>
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

