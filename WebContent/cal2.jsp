<%@ page language="java"  pageEncoding="UTF-8"%>


<%@ include file="include.jsp" %>

<%@page import="com.ems.common.util.EmsDateUtil"%>
<%@page import="com.ems.common.util.EmsNumberUtil"%>


  <%


  Calendar cal =Calendar.getInstance();

  int nowYear = cal.get(Calendar.YEAR);
  int nowMonth = cal.get(Calendar.MONTH)+1; // +1
  int nowDay = cal.get(Calendar.DAY_OF_MONTH);


  String strYear = request.getParameter( "year");
  String strMonth = request.getParameter( "month");

    int year = nowYear; // 현재의 년을 받아옴.
    int month = nowMonth; // 현재의 월을 받아옴.
    int i;
    if(strYear != null)
    {
     year = Integer.parseInt(strYear);
    }

    if(strMonth != null)
    {
     month = Integer.parseInt(strMonth);
    }

    cal.set(year,month-1,1);
    int startDay = 1;

    int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    int week = cal.get(Calendar.DAY_OF_WEEK);
    String yearMonth = year+"-"+EmsNumberUtil.format(month,"00");
    String yyyyMM = yearMonth.replaceAll("-", "");

    String firstDay = yearMonth+"-01";




    String USERNAME="";

    if(userinfo!=null){

    	USERNAME = userinfo.getString("USERNAME");

    DBManager dbm = new DBManager((DataSource)application.getAttribute("jdbc/mysql_ds"));



	//예약정보
    EmsHashtable[] hash = dbm.selectMultipleRecord("SELECT DATE_FORMAT(RESERVE_DATE,'%Y%m%d') RESERVE_DATE, DATE_FORMAT(RESERVE_DATE,'%d') RDATE, count(RESERVE_DATE) CNT FROM reserve_info where LOGIN_ID=? and RESERVE_DATE between ? and LAST_DAY(?) group by DATE_FORMAT(RESERVE_DATE,'%d') ",
    		new String[] { userinfo.getString("LOGINID"),firstDay,firstDay });


  	//데크갯수
      EmsHashtable[] hash2 = dbm.selectMultipleRecord("select count(CD_ID) CNT  from comm_info where CD_GROUP_ID='ROOM_NUM' and LOGIN_ID=? ",
      		new String[] { userinfo.getString("LOGINID") });


    	//어종
      EmsHashtable[] hash0 = dbm.selectMultipleRecord("SELECT CD_MEANING as FISH_DAY,EXT1 as FISH_NAME, IFNULL(EXT2,0) AS MAN FROM fishfox.comm_info where CD_GROUP_ID='FISH_TYPE'  and LOGIN_ID=? and CD_MEANING like concat(?,'%') ",
      		new String[] { userinfo.getString("LOGINID"), yyyyMM });

      EmsHashtable fishHash =new EmsHashtable();
      EmsHashtable manHash =new EmsHashtable();


    for(int hashCnt=0; hashCnt<hash0.length; hashCnt++){

    	fishHash.put(hash0[hashCnt].getString("FISH_DAY"), hash0[hashCnt].getString("FISH_NAME"));

    	log(hash0[hashCnt].getString("FISH_DAY")+" : "+hash0[hashCnt].getString("FISH_NAME"));

    	manHash.put(hash0[hashCnt].getString("FISH_DAY"), hash0[hashCnt].getString("MAN"));
    }



      String cnt = hash2[0].getString("CNT");

    EmsHashtable dayHash = new EmsHashtable();
    if(hash!=null)
    for(int j=0; j<hash.length; j++){
    	dayHash.put(hash[j].getString("RDATE"),hash[j].getString("CNT"));
    }


    EmsHashtable[] hash3 = dbm.selectMultipleRecord("select CD_MEANING from comm_info where CD_GROUP_ID='CALENDAR_CNT' and LOGIN_ID=? ",
      		new String[] { userinfo.getString("LOGINID") });

    String CALENDAR_CNT = hash3[0].getString("CD_MEANING");


    String today = EmsDateUtil.getCurrentDate("yyyyMM01");

    String addMonths = EmsDateUtil.addMonths(today, Integer.parseInt(CALENDAR_CNT), "yyyyMMdd");

    String afterDay = EmsDateUtil.addDay(addMonths, -1, "yyyyMMdd");

%>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<style>
* {
	-webkit-text-size-adjust: none;
	max-width: 100%;
}

.ui-mini {
	font-size: 12px;
	color: black;
}

.ui-mini_red {
	font-size: 12px;
	color: red;
}

div.Box {position:relative; width:100%; height:100%;;}
div.head {float:left; width:100%; height:30%; font-size: 13px;color: red; margin-top: 0px;}
div.body {clear:left; float:left; width:100%; height:40%; font-size: 21px;  }
div.foot {position:absolute; clear:left; float:left; width:100%; height:20%; ; bottom:0px; font-size: 13px;color: black;}

div.body2 {clear:left; float:left; width:100px; height:100px; font-size: 18px; display: flex; align-items: center; }

 h1 {
        width: 100%;
        padding: 20px 0px;

        text-align: center;

      }

</style>


<style>
tbody.tr{height:60px;}
<%if(mobile){ %>
table { width:100%;  align:center; }
tbody.tr, td {   height:80px; align:center; text-align: center; }


<%}else{%>

table { width:100%;  align:center; }
tbody.tr, td {  height:90px; align:center; text-align: center; }

<%}%>

a:link    { text-decoration: none; color: #0000cc;}
a:visited { text-decoration: none; color: #99209b; }
a:active  { text-decoration: none; color: #0000cc; }
a:hover   { text-decoration: none; color: #0000ff; }

</style>





<script type="text/javascript">
$.mobile.ajaxEnabled = false;
</script>

<script type="text/javascript">


function window_onload()
 {


    for (var i=2021;i<=2030; i++)
   {
        var op= new Option(i+ "년",i);
         syear.options[i -2021]=op;


         if(i== <%=year %> )
         {
            syear.options[i -2021].selected ="selected" ;
         }

   }

   for (var i=1;i<=12 ; i++)
   {
      var op= new Option(i+ "월",i);
       smonth.options[i -1]=op;

       if(i== <%=month %>)
       {
           smonth.options[i -1].selected = "selected";
       }
   }

   var myselect = $( "#syear" );
   myselect[0].selectedIndex = <%=year%>-2021;
   myselect.selectmenu( "refresh" );

   var myselect = $( "#smonth" );
   myselect[0].selectedIndex =  <%=month%>-1;
   myselect.selectmenu( "refresh" );


 }

function month_onchange()
{
     var month = smonth.value;
     var year = syear.value;
     var addr = "cal2.jsp?year=" + year +"&month=" + month;
    // alert(addr);
    //addr 이 가지는 주소값으로  페이지를 이동시킨다.
   location.href = addr;

}

function year_onchange()
{
     var year = syear.value;
     var month = smonth.value;
     var addr = "cal2.jsp?year=" + year +"&month=" + month;

        location.href = addr;

}

</script>


<title><%=USERNAME %>메인달력 </title>
</head>

<body onload ="window_onload()" >
<div data-role="page" data-theme="a">

<div data-role="header" style='font-size:2em;text-align:center;'>
<%=USERNAME %>
</div>

<div data-role="content"    style=" padding-bottom: 0px;  padding-top: 0px " >



<table align="center"  >
	<thead>
		<tr>
			<th>
			 <select id = "syear" name="syear" data-inline="true"  data-ajax="false" >

			    </select >
			    &nbsp;
			     <select   id= "smonth" name="smonth" onchange= "month_onchange()" data-inline="true"  >

			    </select >

			</th>

		</tr>
	</thead>

</table >


  <table align="center"  cellspacing= "1" cellpadding= "2" bgcolor ="#cccccc" class="ui-body-d" >

  <thead>
   <tr >
     <th bgcolor = "#e6e4e6"  style=" color: red;" > 일</th >
     <th bgcolor = "#e6e4e6" > 월 </th >
     <th bgcolor = "#e6e4e6" > 화 </th >
     <th bgcolor = "#e6e4e6" > 수 </th >
     <th bgcolor = "#e6e4e6" > 목 </th >
     <th bgcolor = "#e6e4e6" > 금 </th >
     <th bgcolor = "#e6e4e6"  style=" color: black;" > 토  </th>

   </tr >
   </thead>

   <%
   	String tmpDay;

      int newLine=0;

      out.println( "<tr>");

      for(i=1; i<week; i++)
      {
       out.println( "<td  bgcolor='#ffffff'>&nbsp;</td>");
       newLine++;
      }

      for(i=startDay; i<=endDay; i++)
      {
       String fontColor=(newLine==0)?"red":(newLine==6)? "blue": "black";
       String bgColor=(nowYear==year)&&(nowMonth==month) &&(nowDay==i)? " #e6e4e6": "#ffffff";
       StringBuffer sb = new StringBuffer("");

       tmpDay = year + EmsNumberUtil.format(month, "00")  + EmsNumberUtil.format(i, "00");




       if(Integer.parseInt(tmpDay) <= Integer.parseInt(afterDay)  ){	//현재일로 2개월까지만 예약가능
	   		sb.append("<a href='list.jsp?rdate=").append(yearMonth).append("-").append(EmsNumberUtil.format(i,"00")).append("'>");
       }

	   if(dayHash.getString(EmsNumberUtil.format(i,"00")).length()>0){

	       	//int leftSiteCnt = Integer.parseInt(cnt) - Integer.parseInt(dayHash.getString(EmsNumberUtil.format(i,"00")));

	       	int totalSiteCnt = Integer.parseInt( manHash.getString(yyyyMM + EmsNumberUtil.format(i,"00")) );

	       	//남은자리수
	       	int leftSiteCnt = totalSiteCnt - Integer.parseInt(dayHash.getString(EmsNumberUtil.format(i,"00")));



       		if(leftSiteCnt!=0){

      			sb.append("<div class='head '>");
      	  		sb.append( fishHash.getString(yyyyMM + EmsNumberUtil.format(i,"00")) );
      	  		sb.append("</div>");


	       		sb.append("<div class='body'>");	//날짜
	       		sb.append(i);	//날짜
	       		sb.append("</div>");	//날짜

	       		sb.append("<div class='foot'>");

	       		sb.append( dayHash.getString(EmsNumberUtil.format(i,"00")) );
	       		sb.append("/");
	       		sb.append( manHash.getString(yyyyMM + EmsNumberUtil.format(i,"00")) );

	       		sb.append("</div>");

       		}else{



					sb.append("<div class='head '>");
					sb.append( fishHash.getString(yyyyMM + EmsNumberUtil.format(i,"00")) );
					sb.append("</div>");


					sb.append("<div class='body'>");	//날짜
					sb.append(i);	//날짜
					sb.append("</div>");	//날짜

					sb.append("<div class='foot'>");

					sb.append( dayHash.getString(EmsNumberUtil.format(i,"00")) );
					sb.append("/");
					sb.append( manHash.getString(yyyyMM + EmsNumberUtil.format(i,"00")) );
					sb.append( "&nbsp;예약마감" );


					sb.append("</div>");

       		}




	   }else{



		    sb.append("<div class='head '>");
			sb.append( fishHash.getString(yyyyMM + EmsNumberUtil.format(i,"00")) );
			sb.append("</div>");


			sb.append("<div class='body'>");	//날짜
			sb.append(i);	//날짜
			sb.append("</div>");	//날짜

			sb.append("<div class='foot'>");


			sb.append( manHash.getString(yyyyMM + EmsNumberUtil.format(i,"00")) );


			sb.append("</div>");



	   }

	   if(Integer.parseInt(tmpDay) <= Integer.parseInt(afterDay)  ){	//현재일로 2개월까지만 예약가능
       	sb.append("</a>");
	   }

       out.println( "<td  bgcolor="+bgColor+ " ><font color="+fontColor+ "><div class='Box'>"+sb.toString()+ "</div></font></td>" );	//최종내용
       newLine++;

           if(newLine ==7 &&i!=endDay)
           {
            out.println( "</tr><tr>" );
            newLine=0;
           }
      }
     while(newLine>0 && newLine<7)
     {
      out.println( "<td  bgcolor='#ffffff'>&nbsp;</td>");
      newLine++;
     }
     out.println( "</tr>");

   %>
  </table >


</div> <!-- content -->
</div> <!-- page -->
</body>
</html>



<%
}else{	//LOGIN 정보가 없을때
%>

<jsp:include page="userinfo.jsp" flush="true"/>

<%} %>
