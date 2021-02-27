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



StringBuffer sb = new  StringBuffer("");

sb.append("SELECT  \n");
sb.append(" max(case when CD_ID ='PEOPLE_ADD_CNT' then PRICE else 0 end ) PEOPLE_ADD_CNT \n");
sb.append(",max(case when CD_ID ='PEOPLE_ADD_CNT' then IFNULL(EXT1,0) else 0 end )PEOPLE_CNT      \n");
sb.append(" FROM comm_info                                                               \n");
sb.append(" WHERE CD_GROUP_ID='ADD_OPTION'                                               \n");
sb.append(" AND LOGIN_ID=?                                                               \n");


	//추가인원단가
    EmsHashtable[] hash_option = dbm.selectMultipleRecord(sb.toString(),
    		new String[] { LOGINID });


    String PEOPLE_ADD_CNT = hash_option[0].getString("PEOPLE_ADD_CNT");

    int PEOPLE_CNT = Integer.parseInt( hash_option[0].getString("PEOPLE_CNT") );





	//메시지
    EmsHashtable[] hash_msg = dbm.selectMultipleRecord("SELECT CD_ID,CD_MEANING,PRICE FROM comm_info WHERE CD_GROUP_ID='MESSAGE' AND LOGIN_ID=? ",
    		new String[] { LOGINID });

    String message = hash_msg[0].getString("CD_MEANING");


    EmsHashtable[] hash_deck = dbm.selectMultipleRecord("SELECT CD_ID,CD_MEANING,PRICE FROM comm_info WHERE CD_GROUP_ID='ROOM_NUM' AND LOGIN_ID=? AND CD_ID=? ",
    		new String[] { LOGINID,room_num });

    String deck_desc = hash_deck[0].getString("CD_MEANING");	//데크설명

    message =  deck_desc +"<P>"+ message;


	//1박금액 lov
    EmsHashtable[] hash_money = dbm.selectMultipleRecord("SELECT CD_ID,CD_MEANING,PRICE FROM comm_info WHERE CD_GROUP_ID='DAY_MONEY'  AND LOGIN_ID=? ",
    		new String[] { LOGINID });

	//성수기기간
    EmsHashtable[] hot_day = dbm.selectMultipleRecord("SELECT CD_ID,CD_MEANING,PRICE FROM comm_info WHERE CD_GROUP_ID='HOT_DAY' AND LOGIN_ID=? ",
    		new String[] { LOGINID });


	//기간을 몇일까지 가져올지 체크
    EmsHashtable[] hash_day = dbm.selectMultipleRecord("SELECT DATE_FORMAT( RESERVE_DATE, '%m/%d' ) RDATE FROM reserve_info WHERE LOGIN_ID =? AND ROOM_NUM = ? AND RESERVE_DATE > ? AND RESERVE_DATE < DATE_ADD(? , INTERVAL 5 DAY) ",
    		new String[] { LOGINID,room_num,rdate,rdate });




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

            	if($("#TOTAL_PAY").val()==""){
            		cal();
            	}


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

        	//radte = rdate.add(2,'months').add(-1,'days');

        	//alert(rdate.format('YYYY-MM-DD'));

        	var FROM_DAY = $("#FROM_DAY").val();	//성수기시작

        	var TO_DAY   = $("#TO_DAY").val() ;	//성수기 종료


        	//성수기 기간에 포함된 일자 계산 + 성수기 기간이 아닌 일자 계산


        	var hot_day_cnt=0;
        	var default_day =0;

        	for(var i=0; i<DAY; i++){

        		if(rdate.add(i,'days').isBetween( FROM_DAY, TO_DAY )){	//moment('2010-10-20').isBetween('2010-10-19', '2010-10-25'); // true
        			hot_day_cnt++;
        		}else{
        			default_day++;
        		}

        	}

        	//alert("hot_day_cnt "+hot_day_cnt);

        	//alert("default_day "+default_day);



        	var MAIN_PRICE = parseInt($("#price_"+default_day).val());

        	var price999 = parseInt($("#price_999").val());	//성수기금액

        	var HOT_PRICE = hot_day_cnt * price999;

        	var peo_cnt = $('select[name="PEOPLE_ADD_CNT"]').val();

        	var peo_unit = <%=PEOPLE_ADD_CNT%>;


    		var TOTAL_PAY = MAIN_PRICE + HOT_PRICE +  (peo_cnt*peo_unit);


    		 $("#TOTAL_PAY").val( $.number( TOTAL_PAY ) );


         	if(hot_day_cnt>0){
//         		var html="성수기:"+hot_day_cnt+"일["+HOT_PRICE+"]";
         		var html=""+hot_day_cnt+"일["+HOT_PRICE+"]";         		

         		if(default_day>0)
//        		html=html+"+비성수기:"+default_day+"일["+MAIN_PRICE+"]";

         		html=html+""+default_day+"일["+MAIN_PRICE+"]";

         		if(peo_cnt>0)
         		html=html+"+추가인원:"+peo_cnt+"명["+(peo_cnt*peo_unit)+"]";


        		$("#cal_result").html(html);
        		$("#PRICE_DESC").val(html);

        	}else{



//        		var html = "비성수기:"+default_day+"일["+MAIN_PRICE+"]";
        		var html = ""+default_day+"일["+MAIN_PRICE+"]";

         		if(peo_cnt>0)
         		html=html+"+추가인원:"+peo_cnt+"명["+(peo_cnt*peo_unit)+"]";


        		$("#cal_result").html(html);
        		$("#PRICE_DESC").val(html);

        	}



        }


        $(document).ready(function(){

    		  <% if(ADMIN.equals("true")){ %>
    			//첨부파일 init 및 첨부파일 전송
    			attach_file_init();
        	 <%}%>


    		$("#btnSubmit").hide();


        	 $('select[name="PEOPLE_ADD_CNT"]').change(function(){
        		 cal();
       		});

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


<h3>데크No : <%=room_num %></h3>


<div data-role="collapsible" class="jqm-demos jqm-content">

<h2>데크이미지</h2>


<div id="attch_roomImg" >
</div>


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
 <!-- 데크설명 -->
<p><%=message %>

</div>


<form name="frmMain" method="post" onsubmit="return false;" >

<input type="hidden" name="event" value="" />
<input type="hidden" name="ROOM_NUM" id="ROOM_NUM" value="<%=room_num %>" >
<input type="hidden" name="rdate" id="rdate" value="<%=rdate %>" >

<input type="hidden" name="price_0" id="price_0" value="0" >
<%for(int i=0;i<hash_money.length; i++){ %>
<input type="hidden" name="price_<%=hash_money[i].getString("CD_ID") %>" id="price_<%=hash_money[i].getString("CD_ID") %>" value="<%=hash_money[i].getString("PRICE") %>" >
<%} %>

<!-- 성수기 기간 -->
<%for(int i=0;i<hot_day.length; i++){ %>
<input type="hidden" name="<%=hot_day[i].getString("CD_ID") %>" id="<%=hot_day[i].getString("CD_ID") %>" value="<%=hot_day[i].getString("CD_MEANING") %>" >
<%} %>



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

                           <label for="PEOPLE_ADD_CNT"><H4>추가인원: </H4></label>

                           <select name="PEOPLE_ADD_CNT" id="PEOPLE_ADD_CNT" data-icon="info" data-iconpos="left" data-native-menu="false">

<%for(int i=0; i<=PEOPLE_CNT; i++){ %>
                                        <option value="<%=i%>"><%=i%>명</option>
<%} %>
                           </select>
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





