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
    String firstDay = yearMonth+"-01";    
       
	
    String USERNAME="";
    
    if(userinfo!=null){   
    	
    	USERNAME = userinfo.getString("USERNAME");

    DBManager dbm = new DBManager((DataSource)application.getAttribute("jdbc/mysql_ds"));	

    EmsHashtable[] hash = dbm.selectMultipleRecord("SELECT DATE_FORMAT(RESERVE_DATE,'%d') RDATE, count(RESERVE_DATE) CNT FROM reserve_info where LOGIN_ID=? and RESERVE_DATE between ? and LAST_DAY(?) group by DATE_FORMAT(RESERVE_DATE,'%d') ",
    		new String[] { userinfo.getString("LOGINID"),firstDay,firstDay });

    
  	//데크갯수    	
      EmsHashtable[] hash2 = dbm.selectMultipleRecord("select count(CD_ID) CNT  from comm_info where CD_GROUP_ID='ROOM_NUM' and LOGIN_ID=? ",
      		new String[] { userinfo.getString("LOGINID") });
  	
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

</style>


<style>

<%if(mobile){ %>
table { width:100%;  align:center; }

tr, td { width:14.2%;  height:50px; align:center; text-align: center; }


<%}else{%>
table,tr,td { width:600px; height:80px; align:center; text-align: center; }


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
    for (var i=2008;i<=2017 ; i++)
   {
        var op= new Option(i+ "년",i);
         syear.options[i -2008]=op;
         
       
         if(i== <%=year %> )
         {
            syear.options[i -2008].selected ="selected" ;
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
   myselect[0].selectedIndex = <%=year%>-2008;
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


<title><%=USERNAME %>메인달력</title>
</head>

<body onload ="window_onload()" >
<div data-role="page" data-theme="a">

<div data-role="header">
<h1><%=USERNAME %></h1>
</div>

<div data-role="content">
<!-- 
<%=today %><br>
<%=addMonths %><br>
<%=afterDay %><br>
  -->

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
	   
	       	int leftSiteCnt = Integer.parseInt(cnt) - Integer.parseInt(dayHash.getString(EmsNumberUtil.format(i,"00")));
	       	
       		
       		
       		if(leftSiteCnt!=0){
       		
       		sb.append(i).append("<br><font class='ui-mini'  >");       			
       		sb.append( dayHash.getString(EmsNumberUtil.format(i,"00")) );
       		sb.append("건 예약");
       		sb.append("</font>");
       		
       		}else{
       			sb.append(i).append("<br><font class='ui-mini_red'   >");       			
       			sb.append("예약마감");
       			sb.append("</font>");
       		}
       		
       		
       		
       		
	   }else{
		    sb.append(i);
	   }
       
	   if(Integer.parseInt(tmpDay) <= Integer.parseInt(afterDay)  ){	//현재일로 2개월까지만 예약가능
       	sb.append("</a>");
	   }
       
       out.println( "<td  bgcolor="+bgColor+ " ><font color="+fontColor+ ">"+sb.toString()+ "</font></td>" );
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

<table align="center" >    
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
  
</div>
</div>  
</body>
</html>

<%
}else{	//LOGIN 정보가 없을때
%>

<jsp:include page="userinfo.jsp" flush="true"/>

<%} %>

