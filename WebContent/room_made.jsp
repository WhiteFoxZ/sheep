<!DOCTYPE html>

<%@ page pageEncoding="UTF-8"%>


<%@ include file="include.jsp" %>


<%


if(userinfo!=null){


    String event = request.getParameter("event");
    if (event == null) {
        event = "find";
    }




    String room_num=request.getParameter("room_num")!=null?request.getParameter("room_num").toString():"";
    String rdate=request.getParameter("rdate")!=null?request.getParameter("rdate").toString():"";
    String LOGINID = userinfo.getString("LOGINID");
    String IMG_UPLOAD = userinfo.getString("IMG_UPLOAD");	//이미지 업로드 기능활성화인지 체크

    DataSource ds = (DataSource)application.getAttribute("jdbc/mysql_ds");

    DBManager dbm = new DBManager(ds);





	String RESERVE_DATE = request.getAttribute("RESERVE_DATE")!=null?request.getAttribute("RESERVE_DATE").toString():""; // 카드ID
	String USER_TEL1 = request.getAttribute("USER_TEL1")!=null?request.getAttribute("USER_TEL1").toString():""; // 카드ID
	String ROOM_NUM = request.getAttribute("ROOM_NUM")!=null?request.getAttribute("ROOM_NUM").toString():""; // 카드ID
	String MEMO = request.getAttribute("MEMO")!=null?request.getAttribute("MEMO").toString():""; // 카드ID
	String USER_EMAIL = request.getAttribute("USER_EMAIL")!=null?request.getAttribute("USER_EMAIL").toString():""; // 카드ID

	String USER_NAME = request.getAttribute("USER_NAME")!=null?request.getAttribute("USER_NAME").toString():""; // 카드ID
	String DAY = request.getAttribute("DAY")!=null?request.getAttribute("DAY").toString():""; // 카드ID
	String CAR_NUM = request.getAttribute("CAR_NUM")!=null?request.getAttribute("CAR_NUM").toString():""; // CAR_NUM

	if(ROOM_NUM.length()>0) room_num = ROOM_NUM;






	//메시지
    EmsHashtable[] hash_msg = dbm.selectMultipleRecord("SELECT CD_ID,CD_MEANING,PRICE FROM comm_info WHERE CD_GROUP_ID='MESSAGE' AND LOGIN_ID=? ",
    		new String[] { LOGINID });

    String message = hash_msg[0].getString("CD_MEANING");


    EmsHashtable[] hash_deck = dbm.selectMultipleRecord("SELECT CD_ID,CD_MEANING,PRICE FROM comm_info WHERE CD_GROUP_ID='ROOM_NUM' AND LOGIN_ID=? AND CD_ID=? ",
    		new String[] { LOGINID,room_num });

    String deck_desc = hash_deck[0].getString("CD_MEANING");	//자리설명

    message =  deck_desc +"<P>"+ message;


	//1박금액 ,고기어종
    EmsHashtable[] hash_money = dbm.selectMultipleRecord(
    		"SELECT CD_ID,CD_MEANING as FISH_TYPE ,PRICE FROM comm_info WHERE CD_GROUP_ID='DAY_MONEY'  AND LOGIN_ID=? and CD_MEANING = (SELECT EXT1 FROM comm_info WHERE CD_GROUP_ID='FISH_TYPE' AND LOGIN_ID=?  and CD_MEANING=? ) ",
    		new String[] {LOGINID, LOGINID,rdate.replaceAll("-", "") });


	//기간을 몇일까지 가져올지 체크
    EmsHashtable[] hash_day = dbm.selectMultipleRecord("SELECT DATE_FORMAT( RESERVE_DATE, '%m/%d' ) RDATE FROM reserve_info WHERE LOGIN_ID =? AND ROOM_NUM = ? AND RESERVE_DATE > ? AND RESERVE_DATE < DATE_ADD(? , INTERVAL 5 DAY) ",
    		new String[] { LOGINID,room_num,rdate,rdate });


	StringBuffer q1 = new StringBuffer("");
	q1.append("SELECT INFO.CD_MEANING as IMG_URL, INFO.EXT1 AS FISH_TYPE, FISH.CD_MEANING AS FISHDAY  FROM comm_info INFO , comm_info FISH");
	q1.append(" where INFO.CD_GROUP_ID='SHIP_POSTION' AND FISH.CD_GROUP_ID='FISH_TYPE' ");
	q1.append(" AND INFO.LOGIN_ID=FISH.LOGIN_ID   ");
	q1.append(" AND (case when INFO.EXT1='타이라바' then INFO.EXT1 else FISH.EXT1 END ) =FISH.EXT1 ");
	q1.append(" AND INFO.LOGIN_ID=? AND FISH.CD_MEANING =? ");
	q1.append(" order by FISH_TYPE desc ");



  //배위치사진
    EmsHashtable[] postion = dbm.selectMultipleRecord(q1.toString(),  		new String[] { LOGINID ,rdate.replaceAll("-", "") });




%>

<!-- html시작 -->

<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />


<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="jquery/js/jquery.number.min.js"></script>
<script src="jquery/js/moment.min.js"></script>
<script src="jquery/js/attach_file.js"></script>

<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>



<style>
* { -webkit-text-size-adjust:none; max-width:100%; }
</style>

<style>
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

.pre_con{

	padding-top:2em;
	padding-bottom:2em;
	margin-top :0;
	margin-bottom :0;
	padding-left : 1em;
	padding-right : 1em;
	font-size: 0.9em;
	max-width:10%;
}


/*+ 첨부파일 */

.filebox label {
  display: inline-block;
  padding-left:10px;
  padding-right:10px;
  padding-top:7px;
  padding-bottom:2px;
  margin-top:7px;
  margin-bottom:3px;


  color: #999;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  position: relative;
  left: 10px;
}



div.file_upload {
	float: left;
	width: 60%;
}


#div_submit {
display: none;
}

.attach {
margin-top: 25px;
}

.attach input[type="button"] {

display: inline-block;
  padding-left:10px;
  padding-right:10px;
  padding-top:7px;
  padding-bottom:2px;


  margin-bottom:3px;

  color: #999;
  font-size: inherit;
  line-height: normal;
  vertical-align: top;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
}



.hidden_data {
	display: none;
}

img.popphoto{
display: block;
margin: 0 auto;
width: 90%;
max-height: 700px;
}
</style>


<title>예약등록</title>

        <SCRIPT>
    	/** 첨부파일 시작 **/
    	var attach_exist = true;	//첨부기능 있을경우 true, 없을경우 false
    	var attach_file_ext = "jpg|png|gif";	//첨부가능한 파일 확장자
    	var attach_file_cnt =1; //첨부 가능 파일 갯수
    	var tname="reserve_info";	//해당화면에 db 테이블 정보


    	/** 첨부파일 끝 **/



        $.mobile.ajaxEnabled = false;	//submit 이 작동되도록

        var submitFlag=true;

            function setEvent(event){
                document.frmMain.event.value=event;

                if(event=="modify" && submitFlag==true){

                	document.frmMain.action="room_madeAction.jsp";

                	submitFlag=false;

                }

                document.frmMain.submit();
                return false;
            }


            function emailCheck(email_address){
        		email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
        		if(!email_regex.test(email_address)){
        			return false;
        		}else{
        			return true;
        		}
        	}



            function save(event){

            	if(document.frmMain.USER_NAME.value==""){
            		showMsg('이름을 넣어주세요.');
            		return false;
            	}

            	if(document.frmMain.USER_TEL1.value==""){
            		showMsg('전화번호를 넣어주세요.');
            		document.frmMain.USER_TEL1.focus();
            		return false;
            	}

/*
            	if(document.frmMain.signup.value==""){
            		showMsg('그림 숫자를 입력해주세요.');
            		return false;
            	}


            	if(document.frmMain.DAY.value==""){
            		showMsg('기간을 선택해주세요.');
            		return false;
            	}
*/

				cal();


            	setEvent(event);
            }

            function showMsg(msgText){
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


        	var timer = setTimeout(hideMsg, 3000);

        }


        function hideMsg(){
        	$.mobile.loading( "hide" );
        }


        function init(){

        		<%
            	String msg = request.getAttribute("msg")!=null?request.getAttribute("msg").toString():null;

            	if(msg!=null && msg.length()>0){
            	%>

            	var msgText="<%=msg%>";

            	showMsg(msgText);

        	<%}%>

        	// 첨부파일을 보여준다.
        	data  = viewAttachFileJson(<%=room_num%>);
        	//alert(JSON.stringify(data) );

        	//alert('<%=ADMIN%>');

        	 <% if(ADMIN.equals("true")){ %>
        	 output(data);	//어드민일 경우 보여진다.
        	 <%}else{%>
        	//일반사용자 첨부파일을 보여준다.
        	 if(data.photo)
        	 {
        	        $.each(data.photo, function(index, item){

        	     	  var link2 = "DisplayImage?PK_IMG="+item.uploadedFileName;

        	     	  if(item.contentType=="image/jpeg"){

        	     		var link3="";

        	     		link3 = link3+"<img class='popphoto'  alt='' src='DisplayImage?PK_IMG="+item.uploadedFileName+"'>";

        	     		$("#attch_roomImg").append(link3);

        	     	  }

        	        });


        	    }

        	 <%}%>

        }


        function cal(){


        	var DAY =$('select[name="DAY"]').val();


 			var rdate = moment('<%=rdate%>',"YYYY-MM-DD");

        	var MAIN_PRICE = parseInt($("#price").val());


    		var TOTAL_PAY = MAIN_PRICE;


    		 $("#TOTAL_PAY").val( $.number( TOTAL_PAY ) );

    			var html = "<%=hash_money.length>0?hash_money[0].getString("FISH_TYPE"):"" %> :"+" 일["+$.number( TOTAL_PAY )+"]원";


        		$("#cal_result").html(html);
        		$("#PRICE_DESC").val(html);

        }


        $(document).ready(function(){

    		  <% if(ADMIN.equals("true")){ %>
    			//첨부파일 init 및 첨부파일 전송
    			attach_file_init();
        	 <%}%>


    		$("#btnSubmit").hide();

        	 $('select[name="DAY"]').change(function(){
        		 cal();
       		});

        		cal();

        });

        </script>


<script>
    //enter 키방지 자동submit 방지
/*
$(function() {
    $("#name").on("keyup", function(e){

        $("#keyCode").html(e.which);

        if(e.which==13)
        {
            alert("enter Key");
        }
    });
});
*/
</script>




</head>


<body onload=init()  >

       <section id="page1" data-role="page">

				<header data-role="header">

                <jsp:include page="header.jsp" flush="true"/>

               </header>

<div class="content" data-role="content">


<h3>자리No : <%=room_num %></h3>


<div data-role="collapsible" class="jqm-demos jqm-content">
<!-- 첨부파일 기능은 아직 미완성 FileUploadServelt 에서 tnme , key 값 저장하도록 변경해야함. -->

<h2>


 <%if(postion.length>0){ %>

<%=postion[0].getString("FISH_TYPE")%>


  <%}%>

  <a href="#" >(자리위치 사진)</a>

</h2>


<div id="attch_roomImg" >
</div>

  <%if(postion.length>0){ %>

<img src="<%=postion[0].getString("IMG_URL") %>"  />

  <%}%>


    		 <% if(ADMIN.equals("true")){ %>

				<!-- id="attach_file" start -->
<div id="attach_file" style="<%=IMG_UPLOAD.equals("")?"display:none":"" %>">

<!-- jQuery Form Plugin import -->
<script src="jquery/js/jquery.form.js"></script>
<!-- jQuery MultiFile Plugin import -->
<script src="jquery/js/jQuery.MultiFile.min.js"></script>



<form name="multiform" id="multiform" action="FileUploadServlet?TABLE_NAME=reserve_info&TABLE_KEY=<%=room_num %>" method="POST" enctype="multipart/form-data">
<div class="filebox">
	<div class="file_upload" ><input type="file" id="photo" name="photo" /></div>
	<label for="btnSubmit">전송</label> <label id="btnCancel">취소</label>
 	<div id="afile3-list" style="border:2px solid #c9c9c9;min-height:50px; margin-top: 20px" ></div>
	<div id="div_submit"><input type="submit"  id="btnSubmit" value="전송"/></div>
</div>
</form>
</div><!-- id="attach_file" end -->

<div id="result" style="<%=IMG_UPLOAD.equals("")?"display:none":"" %>"></div>	<!-- 첨부파일 결과 -->


        	 <%}%>

</div>

<div class="ui-body ui-body-a">
 <!-- 자리설명 -->
<p><%=message %>

</div>


<form name="frmMain" method="post" onsubmit="return false;" >

<input type="hidden" name="event" value="" />
<input type="hidden" name="ROOM_NUM" id="ROOM_NUM" value="<%=room_num %>" >
<input type="hidden" name="rdate" id="rdate" value="<%=rdate %>" >

<input type="hidden" name="price" id="price" value="<%=hash_money.length>0?hash_money[0].getString("PRICE"):"0" %>" >




<ul data-role="listview" data-inset="true">

              <li data-role="fieldcontain">

                           <label for="id">예약일: </label>

                           <input type="text" name="RESERVE_DATE" id="RESERVE_DATE" value="<%=rdate %>" readonly="readonly">

              </li>

              <li data-role="fieldcontain">

                           <label for="id"><H4>이름:</H4> </label>

                           <input type="text" name="USER_NAME" id="USER_NAME" value="<%=USER_NAME %>" placeholder="이름을 입력하세요." data-enhance="false" >

              </li>

              <li data-role="fieldcontain">

                           <label for="USER_TEL1"><H4>연락처:</H4> </label>
                           <input type="text" name="USER_TEL1" id="USER_TEL1" value="<%=USER_TEL1 %>" placeholder="연락처를 입력하세요." data-enhance="true">
              </li>




              <li data-role="fieldcontain" style="display: none">

                   <label for="DAY"><H4>기간:
                    <font size="3" color="red">
						<%for(int j=0; j<hash_day.length; j++){ %>
					      	<%=hash_day[j].getString("RDATE") %>,
					    <%
						}
						if(hash_day.length>0)
					    	 out.println("(예약불가)");
					      	%>
					</font>
					</H4>

                    </label>

                     <select name="DAY" id="DAY" data-icon="info" data-iconpos="left" data-native-menu="false">
                     <!-- <option value="">선택하세요</option>  -->

<%for(int i=0;i<hash_money.length; i++){
	if(!hash_money[i].getString("CD_ID").equals("999")){
%>
<option value="<%=hash_money[i].getString("CD_ID") %>"><%=hash_money[i].getString("CD_MEANING") %> </option>
<%	}

}//end of for
%>


                    </select>


              </li>



              <li data-role="fieldcontain">

                           <label for="TOTAL_PAY">비용:
                            </label>

                            <div id="cal_result"></div>
                           <input type="text" name="TOTAL_PAY" id="TOTAL_PAY"  readonly="readonly" required >
                           <input type="HIDDEN" name="PRICE_DESC" id="PRICE_DESC"  readonly="readonly" >

              </li>


              <li data-role="fieldcontain">

                   <label for="MEMO">MEMO:</label><textarea id="MEMO" cols="40" rows="8" name="MEMO"><%=MEMO %></textarea>
              </li>


<!--
              <li data-role="fieldcontain">
              		<label for="signup" style="margin-top: 0px;"><img src="jcaptcha"  ></label>

              		<input type="text" name="signup" id="signup"  >
              </li>
 -->

              <li data-role="fieldcontain">

                   <button class="ui-btn ui-icon-edit ui-btn-icon-left" onclick="javascript:return save('modify');">저장</button>

              </li>

</ul>

</form>

</div>




       </section>








</body>



</html>


<!-- html끝 -->
<%
}else{	//LOGIN 정보가 없을때
%>

<jsp:include page="userinfo.jsp" flush="true"/>

<%} %>

