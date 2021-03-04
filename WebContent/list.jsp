<!DOCTYPE html>

<%@ page   pageEncoding="UTF-8"%>

<%@ include file="include.jsp" %>

<%@ page import="com.ems.common.encrypt.AES256Util"%>

<%


String yyyy = EmsDateUtil.getCurrentDate("yyyy");

if(userinfo!=null){

	String USERNAME = userinfo.getString("USERNAME");

    StringBuffer serverURL = new StringBuffer("http://").append(request.getServerName()).append(":").append(request.getServerPort()).append("/").append(request.getContextPath());


    String TO_DAY = EmsDateUtil.getCurrentDate("yyyy-MM-dd");




    String room_num=request.getParameter("rdate")!=null?request.getParameter("rdate").toString():"";
    String rdate=request.getParameter("rdate")!=null?request.getParameter("rdate").toString():TO_DAY;

    String P_SDATE = request.getParameter("P_SDATE");
    String P_EDATE = request.getParameter("P_EDATE");
    String P_NAME = request.getParameter("P_NAME");

    if(P_NAME==null) P_NAME="";




    if(P_SDATE==null){
    	if(rdate!=null)	P_SDATE = rdate;
    }

    if(P_EDATE==null){
    	if(rdate!=null)	P_EDATE=rdate;
    }


    String event = request.getParameter("event");
    if (event == null) {
        event = "find";
    }

    int sessionHashCode = session.getId().hashCode();

    new LIST(application,request, userinfo, sessionHashCode);


    EmsHashtable[] hash  = (EmsHashtable[])request.getAttribute("hash");


    DataSource ds = (DataSource)application.getAttribute("jdbc/mysql_ds");

    DBManager dbm = new DBManager(ds);


    String LOGINID = userinfo.getString("LOGINID");


    //어종
    EmsHashtable[] fish = dbm.selectMultipleRecord("SELECT EXT1 AS FISH_TYPE, case when EXT2='' then 0 else ifnull(EXT2,0) end AS MAN FROM comm_info INFO where INFO.CD_GROUP_ID='FISH_TYPE' AND INFO.LOGIN_ID=? AND CD_MEANING =? ",
    		new String[] { LOGINID ,rdate.replaceAll("-", "") });

    String fishtype="";
    String fishman="";
    int intMan=0;



    if(fish!=null&& fish.length>0){
    	fishtype=fish[0].getString("FISH_TYPE");
    	fishman=fish[0].getString("MAN");
    	intMan = Integer.parseInt(fishman);

    }

    //배위치사진
    EmsHashtable[] postion = dbm.selectMultipleRecord("SELECT CD_MEANING , EXT1  FROM comm_info INFO where INFO.CD_GROUP_ID='SHIP_POSTION' AND INFO.LOGIN_ID=?  ",
    		new String[] { LOGINID });


	AES256Util aes = new AES256Util("asdwsx1031902461");


    String perid=null;


%>

<html>
<head>
<title><%=USERNAME %>예약리스트</title>

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<style>
* { -webkit-text-size-adjust:none; max-width:100%; }
</style>



<!-- 달력관련 -->
<link type="text/css" href="./jquery/css/ui.all.css" rel="stylesheet" />
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script type="text/javascript">
$(function() {

	$.datepicker.setDefaults({
	    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear:true,
	    dateFormat: 'yy-mm-dd',
	    showOn: 'both',
	    buttonImage: './jquery/ic_03.gif',
	    buttonImageOnly: true

	});
	$("#P_SDATE").datepicker({
	    buttonText: '시작일',
	    showButtonPanel:true


	});
	$("#P_EDATE").datepicker({
	    buttonText: '종료일',
	    showButtonPanel:true
	});
});
function commonWork() {
	var stdt = document.getElementById("P_SDATE");
	var endt = document.getElementById("P_EDATE");

	if(endt.value != '' && stdt.value > endt.value) {
		alert("종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
		stdt.value = "";
		endt.value = "";
		stdt.focus();
	}
}
</script>
<style type="text/css">
	.ui-datepicker-trigger {
		vertical-align: middle;
		cursor: pointer;
		border-width:1px; background-color:#E9F3FE; border-color:#404040;font:12px;text-align: left; padding-left:2px;

	}

</style>

<!-- 달력관련끝 -->



        <SCRIPT >

            function setEvent(event){

                document.frmMain.event.value=event;
                document.frmMain.submit();

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

            function cancel(pk,idx){

            	var pw = $("#PASSWD"+idx).val();

            	if(pw==""){

            		alert('취소시 PW에 전화번호를 넣어주세요.');
            		return false;

            	}

            	//alert('취소합니다.');

        		document.frmMain.pk_key.value=pk;
        		document.frmMain.pk_pw.value=pw;


        		setEvent('deletePK');
        		return false;

            }


        </script>

<style type="text/css">
/**
예약버튼 어드민
**/
.ui-btn2 {
	padding-top:0.15em;
	padding-bottom:0.15em;
	margin-top :0;
	margin-bottom :0;
	padding-left : 0.2em;
	padding-right : 0.2em;
	font-size: 0.95em;

}

.ui-btn3 {
	padding-top:0.5em;
	padding-bottom:0.5em;
	margin-top :0;
	margin-bottom :0;
}




.ui-bar-a,.ui-page-theme-a .ui-bar-inherit
,html .ui-bar-a .ui-bar-inherit
,html .ui-body-a .ui-bar-inherit
,html body .ui-group-theme-a .ui-bar-inherit
	{
	background-color: #8bccf7;
	color: #ffffff;
	text-shadow: 0 1px 0 #444444;
	font-weight: 700;

}

.ui-body{
padding-top:0;
padding-bottom:0;

}


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


.pre_con{

	padding:1em;


}


<%}else{ %>
<!--모바일일경우 폰트 더작게.-->
.ui-mini {
	font-size: 12px;
}

<%if(ADMIN!=null && ADMIN.equals("true")){ %>
.ui-table td, th{
font-size: 0.85em;
}
.pre_con{

	padding-top:2em;
	padding-bottom:2em;
	margin-top :0;
	margin-bottom :0;
	padding-left : 1em;
	padding-right : 1em;
	font-size: 0.9em;
	min-width: 400px;

}


<%}%>


<%} %>
</style>

</head>


<body onload=init() >

<form name="frmMain" method="post" >


<input type="hidden" name="event" value="" />
<input type="hidden" name="pk_key" value="" />
<input type="hidden" name="pk_pw" value="" />


       <section id="page1" data-role="page">

				<header data-role="header">

                <jsp:include page="header.jsp" flush="true"/>

               </header>

               <div class="content" data-role="content">

<%if(ADMIN!=null && ADMIN.equals("true")){ %>
<table align="right" >
<thead>
<tr>
<th >


<%if(!mobile){ %>
● 기간 :
<input type="text" id="P_SDATE" name="P_SDATE" value="<%=P_SDATE %>"  data-role="none"  class="ui-datepicker-trigger ui-mini"   onchange="commonWork()" />
~
<input type="text" id="P_EDATE" name="P_EDATE" value="<%=P_EDATE %>"  data-role="none"  class="ui-datepicker-trigger ui-mini"  onchange="commonWork()" />

● 이름 :
<input type="text" id="P_NAME" name="P_NAME" value="<%=P_NAME %>"  data-role="none"  />
&nbsp;
<a class="ui-btn ui-btn3 ui-btn-inline ui-icon-search ui-btn-icon-left" onclick="setEvent('find');">조회</a>
<a class="ui-btn ui-btn3 ui-btn-inline ui-icon-edit ui-btn-icon-left" onclick="setEvent('modify');">입금확인</a>
<a class="ui-btn ui-btn3 ui-btn-inline ui-icon-edit ui-btn-icon-left" onclick="setEvent('cancel');">입금취소</a>
<a class="ui-btn ui-btn3 ui-btn-inline ui-icon-delete ui-btn-icon-left" onclick="setEvent('delete');">예약삭제</a>



<%} %>



	</th>
</tr>
</thead>
</table>

<%}else{ %>

<input type="hidden" name="P_SDATE" value="<%=P_SDATE %>" />
<input type="hidden" name="P_EDATE" value="<%=P_SDATE %>" />



<%} %>

<input type="hidden" name="rdate" value="<%=rdate %>" />

<div class="ui-body ui-body-a">


  <%if(!mobile){ %>

  <h1 style='margin-top:10px; margin-bottom: 10px; '>예약일 : <%=rdate %>&nbsp;<b style="color: red;">[<%=fishtype %>]</b>


     &nbsp;&nbsp;&nbsp;★자리위치사진 :

  <%for(int i=0; i<postion.length; i++){ %>

<a href="<%=postion[i].getString("CD_MEANING") %>" target="_blank" /><%=postion[i].getString("EXT1")%></a>&nbsp;
<%=i<postion.length-1?"|&nbsp;":""%>

  <%}%>

  </h1>



  <%}else{%>

<h1 style='margin-top:5px; margin-bottom: 3px; font-size:17px;' >예약일 : <%=rdate %>&nbsp;<b style="color: red;">[<%=fishtype %>]</b></h1>


  ★자리위치사진 :

  <%for(int i=0; i<postion.length; i++){ %>

<a href="<%=postion[i].getString("CD_MEANING") %>" target="_blank" /><%=postion[i].getString("EXT1")%></a>&nbsp;
<%=i<postion.length-1?"|&nbsp;":""%>


  <%} %>

  <%} %><!-- if(!mobile) -->

</div>


<table id="table-custom-2"
	class="ui-body-d ui-shadow table-stripe ui-responsive"
	data-role="table"
	data-column-popup-theme="a"
    data-column-btn-theme="b">
	<thead>
		<tr class="ui-bar-a">
<%
int idx=1;
if(ADMIN!=null && ADMIN.equals("true")){ %>
			<th data-priority="<%=idx++ %>">▼</th>
			<th data-priority="<%=idx++ %>">No</th>
			<th data-priority="<%=idx++ %>">작성일</th>
			<th data-priority="<%=idx++ %>">이름</th>
			<th data-priority="<%=idx++ %>">전화</th>
			<!-- <th data-priority="<%=idx++ %>">차량</th> -->
			<th data-priority="<%=idx++ %>">기간</th>
			<th data-priority="<%=idx++ %>">금액</th>
			<th data-priority="<%=idx++ %>">메모</th>
			<th data-priority="<%=idx++ %>">상태</th>
			<th data-priority="<%=idx++ %>">버튼</th>
<%}else{ %>
			<th data-priority="<%=idx++ %>">자리No</th>
			<th data-priority="<%=idx++ %>">이름</th>
			<th data-priority="<%=idx++ %>">전화</th>
			<th data-priority="<%=idx++ %>">기간</th>
			<th data-priority="<%=idx++ %>">상태</th>
			<!-- <th data-priority="<%=idx++ %>">PW</th> -->
			<th data-priority="<%=idx++ %>">버튼</th>
<%}%>
		</tr>
	</thead>
	<tbody >
	<%
	if(hash!=null){

		String USER_TEL1="";

		for (int i = 0; i < hash.length;  i++) {

			if(hash[i].getString("USER_TEL1").length()>0){
				USER_TEL1 = aes.decrypt( hash[i].getString("USER_TEL1") );
			}else{
				USER_TEL1="";
			}

			if(intMan>0 && i>=intMan)break;
	%>


		<tr >
<% //어드민일경우
if(ADMIN!=null && ADMIN.equals("true")){ %>


			<th><input type="checkbox" id="chk" name="chk" value="<%=i%>" data-role="none"  >		</th>
			<td><%=EmsNumberUtil.format(hash[i].getString("CD_ID"), "00")%><%=hash[i].getString("EXT1")%></td>
			<td ><%=hash[i].getString("CREATION_TIMESTAMP")%></td>

			<td><%=hash[i].getString("USER_NAME")%></td>
			<td><%=USER_TEL1%></td>
			 <!--
			<td>
				<%=hash[i].getString("CAR_NUM")%>
			</td>
			 -->

			<td>
			<%
					if(hash[i].getString("GROUP_KEY").length()>17){
						perid = hash[i].getString("GROUP_KEY").substring(0,17);
						out.println(perid.replaceAll(yyyy, ""));
					}
			%>
			<input type="hidden" id="PK_GROUP_KEY" name="PK_GROUP_KEY" value="<%=hash[i].getString("GROUP_KEY")%>" >
			</td>
			<td>


	<%if(hash[i].getString("PRICE_DESC").length()>0){ %>
      <a href="#POP_PRICE_DESC<%=i%>" data-rel="popup" data-position-to="window" data-transition="fade">
      <%=hash[i].getString("TOTAL_PAY")%>
      </a>
      <%}else{ %>
      <%=hash[i].getString("TOTAL_PAY")%>
      <%} %>



      <div data-role="popup" id="POP_PRICE_DESC<%=i%>" data-overlay-theme="b" data-theme="b" data-corners="false">
      	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
      	<P>
      	<%=hash[i].getString("PRICE_DESC")%>
      	<P>
      </div>

			</td>

			<td class="">
      <%

      if(hash[i].getString("MEMO").length()>0){
      %>

      <a href="#POP_MENO<%=i%>" data-rel="popup" data-position-to="window" data-transition="fade">
      클릭
      </a>

      <div data-role="popup" id="POP_MENO<%=i%>" data-overlay-theme="b" data-theme="b" data-corners="false">
      	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
      	<pre class="pre_con"><%=hash[i].getString("MEMO")%></pre>
      </div>

      <%}else{%>

      <%}%>
			</td>

			<td><%=hash[i].getString("RESERVE_STATE_NAME")%></td>
			<td>
			<% if(hash[i].getString("RESERVE_STATE").equals("")){%>

			<a href="room_made.jsp?room_num=<%=hash[i].getString("CD_ID")%>&rdate=<%=rdate %>" class="ui-btn ui-btn3 ui-btn-inline ui-icon-edit ui-btn-icon-left" data-ajax="false" >예약</a>

			<%}else{ %>
			&nbsp;
			<%} %>
			</td>
<%}else{ %>
			<!-- 일반유저 -->
			<th><%=EmsNumberUtil.format(hash[i].getString("CD_ID"), "00") %><%=hash[i].getString("EXT1")%></th>
			<td><%
					if(hash[i].getString("USER_NAME").length()>2){
						out.println("*"+hash[i].getString("USER_NAME").substring(1,2)+"*");
					}else if(hash[i].getString("USER_NAME").length()==2){
						out.println("*"+hash[i].getString("USER_NAME").substring(1));
					}
				%>
			</td>
			<td>
			<%


			String tel[] =USER_TEL1.split("-") ;

			if(tel.length==3)
				out.println(tel[0] +"-****-"+tel[2]);
			else
				out.println(!USER_TEL1.equals("")?aes.maskify(USER_TEL1):"");

			%>
			</td>
			<td>
			<%
					if(hash[i].getString("GROUP_KEY").length()>17){
						perid = hash[i].getString("GROUP_KEY").substring(0,17);
						out.println(perid.replaceAll(yyyy, ""));
					}
			%>
			</td>
			<td><%=hash[i].getString("RESERVE_STATE_NAME")%></td>
			<!--
			<td></td>
			-->

			<td>
			<% if(hash[i].getString("RESERVE_STATE").equals("")){%>
			<a href="room_made.jsp?room_num=<%=hash[i].getString("CD_ID")%>&rdate=<%=rdate %>" class="ui-btn ui-btn3 ui-btn-inline ui-icon-edit ui-btn-icon-left" data-ajax="false" >예약</a>
			<%}else if(hash[i].getString("RESERVE_STATE").equals("1")) { %>

			<a href="#passwdPOP<%=i%>"  class="ui-btn ui-btn3 ui-btn-inline ui-icon-edit ui-btn-icon-left"
			data-rel="popup" data-position-to="window" data-transition="fade" >취소</a>


			<div data-role="popup" id="passwdPOP<%=i%>" data-overlay-theme="a" data-theme="a" >
	      	<a href="#"  data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete
	      	 ui-btn-icon-notext ui-btn-right">Close</a>


	      	 <div class="content" data-role="content">


	      	 <ul data-role="listview" data-inset="true">

              <li data-role="fieldcontain">


                          <input type="text" style="width:200px;" id="PASSWD<%=i%>" value="" placeholder="전화번호" data-enhance="false" >


              </li>

                <li data-role="fieldcontain">


                     <a href="#" onclick="cancel('<%=hash[i].getString("GROUP_KEY")%>','<%=i%>')" class="ui-btn ui-btn3 ui-btn-inline ui-icon-edit ui-btn-icon-left">취소</a>



              </li>

              </ul>
              </div>



	      </div>


			<%}else{ %>
			&nbsp;
			<%} %>
			</td>
<%}%>
		</tr>
	<%	}	//end of for

	}%>
	</tbody>
</table>
</div>
		<footer data-role="footer" data-position="fixed">
		<jsp:include page="footer.jsp" flush="true"/>
		</footer>
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





