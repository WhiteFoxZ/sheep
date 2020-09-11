<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>



<link type="text/css" href="jquery/css/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="jquery/js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="jquery/js/ui.core.js"></script>
<script type="text/javascript" src="jquery/js/ui.datepicker.js"></script>
<script type="text/javascript">
$(function() {
	$.datepicker.setDefaults({
	    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear:true,
	    dateFormat: 'yy-mm-dd',
	    showOn: 'both',
	    buttonImage: 'jquery/ic_03.gif',
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
	.ui-input-text {
		
	}
</style>




<title>Insert title here</title>
</head>


<body>

    <div data-role="page" data-theme="a">

        <div data-role="header" >

            <h1>Header</h1>

        </div>

 

        <div data-role="content">    
        
<ul data-role="listview" data-inset="true">

              <li data-role="fieldcontain">
                             기간 : <input type="text" id="P_SDATE"  name="P_SDATE"  class="ui-datepicker-trigger" onchange="commonWork()" data-mini="true" data-role="none">   />
								~
					<input type="text" id="P_EDATE" name="P_EDATE"  class="ui-datepicker-trigger"  onchange="commonWork()"  data-mini="true" data-role="none">   / >
					
					<input type="text" data-role="date" data-inline="true">
					                                                   
              </li>
                      
</ul>

         
               
                                      

        </div>

        <div data-role="footer">

            <h2>Footer</h2>

        </div>

    </div>    

</body>


</html>