<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,java.util.Date"  contentType="text/html; charset=utf-8"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="barcode" scope="session" class="com.popultrade.webapp.BarCodeGenerator" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);

//ConPool.setCas(request.getServletContext());

%>
<%
control.prvi_page = "index.jsp";
barcode.getChart(request);
String userAgent = request.getHeader( "User-Agent" );
boolean isFirefox = ( userAgent != null && userAgent.indexOf( "Firefox/" ) != -1 );
String size="0";
String scrol = "yes";
if (isFirefox) {
size="1";
scrol="auto";
}

System.out.println("USERAGENT :::: "+userAgent);

boolean novimenu = false;
String browser=request.getHeader("user-agent");

String browsername = "";
String browserversion = "";
String[] otherBrowsers={"Firefox","Chrome","Chrome","Safari"};
try {
    if(browser != null ){
        if((browser.indexOf("MSIE") == -1) && (browser.indexOf("msie") == -1)){
            for(int i=0; i< otherBrowsers.length;  i++){
                System.out.println(browser.indexOf(otherBrowsers[i]));
                browsername=otherBrowsers[i];
                novimenu=true;
                break;
            }
            String subsString = browser.substring( browser.indexOf(browsername));
            String Info[] = (subsString.split(" ")[0]).split("/");
            browsername = Info[0];
            browserversion = Info[1];
    }
    else{
    if (browser.indexOf("MSIE")!=-1) {
        String tempStr = browser.substring(browser.indexOf("MSIE"),browser.length());
            browsername    = "IE";
        browserversion = tempStr.substring(4,tempStr.indexOf(";"));
        novimenu=false;
        if (browserversion.indexOf("10")!=-1) {
       // novimenu=true;
        }
        }
        else { /// novejsi od 10 browser
        
        novimenu=true;
        
        }
    }
}
}
catch (Exception e) {
}






//response.setHeader( "Vary", "User-Agent" );
%>
<html lang="en"> 
    <head> 
    
    <script type="text/javascript"    src="scripts/jquery-1.7.2.min.js"></script>
<script type="text/javascript"    src="scripts/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css"    href="scripts/jquery-ui.css"/> 
    <!-- SmartMenus jQuery plugin -->
<script src="js/jquery.smartmenus.js" type="text/javascript"></script>

<!-- SmartMenus core CSS (required) -->
<link href='js/css/sm-core-css.css' rel='stylesheet' type='text/css' />
<!-- "sm-blue" menu theme (optional, you can use your own CSS, too) -->
<link href='js/css/sm-simple/sm-simple.css' rel='stylesheet' type='text/css' />
    
<!-- #main-menu config - instance specific stuff not covered in the theme -->
<style type="text/css">
	#main-menu {
		position:relative;
		z-index:9999;
		width:auto;
	}
	#main-menu ul {
		width:12em; /* fixed width only please - you can use the "subMenusMinWidth"/"subMenusMaxWidth" script options to override this if you like */
	}
</style>


    
    <style type="text/css">



body {

margin:0px;
}

.resizeDiv{
	width:100%;
	
	padding-bottom:3px;
	padding-top:3px;
	position:relative;	
}

.resizeDiv2{
	width:100%;
	height:110px;
	padding:2px;
	
	position:relative;	
}

.resizeDiv3{
	width:100%;
	

}
.container1{
	width:100%;
	height:100%;
	
	

	
}



</style>
        <title>popultrade</title> 
    </head> 
    <script language="javascript">



    function sizeUMove(sm,vr1) {
  
        document.getElementById('ifr'+vr1).style.height =(Number((document.getElementById('ifr'+vr1).style.height+"").replace("px","")) + sm)+"px" ;
        offsetY = event.clientY;
       
        return true;
        }











    
    function sizeU(sm,vr1,vr2) {
    //alert((document.getElementById('ifrtd'+vr2).style.height+""));
    if (sm=='u') {
      //  alert(document.getElementById('ifr'+vr2).style.height+"");
   // document.getElementById('ifr2').style.height = (Number((document.getElementById('ifr2').style.height+"").replace("%","")) + 10)+"%" ;
//if ((Number((document.getElementById('ifr'+vr2).style.height+"").replace("%","")) - 6)>6) {
//alert(document.getElementById('ifr'+vr1).contentWindow.location.href);

if ((document.getElementById('ifr'+vr1).contentWindow.location.href+"").indexOf("framein.jsp")==-1) {
    document.getElementById('ifr'+vr1).style.height =(Number((document.getElementById('ifr'+vr1).style.height+"").replace("px","")) + 60)+"px" ;
}
    // document.getElementById('ifrtd'+vr2).style.height = (Number((document.getElementById('ifrtd'+vr2).style.height+"").replace("%","")) - 6)+"%" ;
//}    


    }
    if (sm=='d') {
   // document.getElementById('ifr2').style.height = (Number((document.getElementById('ifr2').style.height+"").replace("%","")) - 10)+"%";
   
//if ((Number((document.getElementById('ifr'+vr1).style.height+"").replace("%","")) - 6)>6) {
	if ((document.getElementById('ifr'+vr1).contentWindow.location.href+"").indexOf("framein.jsp")==-1) {
	
 document.getElementById('ifr'+vr1).style.height = (Number((document.getElementById('ifr'+vr1).style.height+"").replace("px","")) - 60)+"px" ;
	}
 //   document.getElementById('ifrtd'+vr2).style.height = (Number((document.getElementById('ifrtd'+vr2).style.height+"").replace("%","")) + 6)+"%" ;
  //  }

    }

    return false;
    }

function showNews() {
<%
if (!control.getUser().equals("anonymous") && control.getPrivilegijeUporabnika().equals("U")) {
%>
parent.frames[0].document.location="news.jsp";
	<%
}
	%>
	//document.getElementById("tr"+"ifr4").style.display='none';

	//document.getElementById("tr2"+"ifr4").style.display='none';
}
    
    </script>
    
    
    
    <script language="javascript"> 
    


// premik strani
var scrollAmount = 0;
var iframeup="";
var iframemi="";
var iframedo="";
var smot = 1;
var poss=0;
var scrollTo=0;
var scrollAmount=0;
var scrr=0;

function premakni() {
//alert(top.document.getElementById('difr2').style.top);

if ((parent.frames[1].location+"").indexOf("nic.jsp")!=-1) {
iframemi="";
//iframeup=parent.frames[0].location+"";
}
if ((parent.frames[2].location+"").indexOf("nic.jsp")!=-1) {
iframedo="";
iframeup=parent.frames[0].location+"";
}
//alert(document.body.scrollTop);
if (iframemi!=parent.frames[1].location+"" && (parent.frames[1].location+"").indexOf("nic.jsp")==-1 && (parent.frames[0].location+"")==iframeup) {
//top.document.getElementById('difr3').style.height.replace("px","")
if ((Number($(window).height()))<(145-document.body.scrollTop+Number(top.document.getElementById('difr2').style.height.replace("px","")))) {
scrollAmount=0;
scrollTo=(70+Number(top.document.getElementById('difr2').style.height.replace("px","")) );

if (scrollTo>=($(document).height()-$(window).height())) {

scrollTo=($(document).height()-$(window).height());

}
scrr=1;
pageScroll();

}
iframeup=parent.frames[0].location+"";
iframemi=parent.frames[1].location+"";
iframedo=parent.frames[2].location+"";
}
else if (iframedo!=parent.frames[2].location+"" && (parent.frames[2].location+"").indexOf("nic.jsp")==-1 && (parent.frames[0].location+"")==iframeup) {

if ((Number($(window).height()))<(145-document.body.scrollTop+Number(top.document.getElementById('difr3').style.height.replace("px",""))+Number(top.document.getElementById('difr2').style.height.replace("px","")))) {
//alert( document.body.scrollHeight + "  " + $(document).height());
scrollAmount=0;
scrollTo=(70+Number(top.document.getElementById('difr3').style.height.replace("px",""))+Number(top.document.getElementById('difr2').style.height.replace("px","")) );
//pageScroll();
//alert("MAX : "+($(document).height()-$(window).height()) + " "+scrollTo);

if (scrollTo>=($(document).height()-$(window).height())) {

scrollTo=($(document).height()-$(window).height());

}

scrr=2;
pageScroll();

//alert("MAX : "+($(document).height()-$(window).height()));
}
iframeup=parent.frames[0].location+"";
iframedo=parent.frames[2].location+"";
}

}


function startScroll() {
iframemi="";
iframedo="";
if (smot==1) {



setInterval(premakni,1000);
smot=2;
}
}


function pageScroll() {
    window.scrollBy(0,30);
    scrollAmount += 30;
    if(scrollAmount < scrollTo) {
if ((parent.frames[scrr].location+"").indexOf("nic.jsp")==-1) {
        scrolldelay = setTimeout('pageScroll()',10);
}
    }
}



function toggle() {
	var ele = document.getElementById("toggleText");
	var elee = document.getElementById("toggleText2");
	
	//var text = document.getElementById("displayText");
	if(ele.style.display == "block") {
    		elee.style.display = "none";
    		ele.style.display = "none";
	//	text.innerHTML = "show";
  	}
	else {
		elee.style.display = "none";
		
		ele.style.display = "block";
		
		//text.innerHTML = "hide";
		document.getElementById("fr1").value=top.document.getElementById('difr2').style.height.replace("px","");
		document.getElementById("fr2").value=top.document.getElementById('difr3').style.height.replace("px","");
		document.getElementById("fr3").value=top.document.getElementById('difr4').style.height.replace("px","");

		}


	
	return false;
} 


function setSize(fram1,fram2,fram3) {
	
	top.document.getElementById('difr2').style.height = fram1+"px";
	top.document.getElementById('difr3').style.height = fram2+"px";
	top.document.getElementById('difr4').style.height = fram3+"px";
	startScroll() ;
}

function setAll() {

	/// dobim ime jsp datoteke v frame 1
 var loc = parent.frames[0].document.location+"";

if (loc.indexOf("/")!=-1) {
	//alert(1);
loc = loc.substring(loc.lastIndexOf("/")+1,loc.length);
	
}
 

	 xmlHttp=GetXmlHttpObject();
	 if (xmlHttp==null) {
	 alert ("Browser does not support HTTP Request");
	 return false;
	 } 

	 var url="nastavitve_save_frames.jsp";
	 url=url+"?jsp_page="+loc;
	 url=url+"&frame1="+document.getElementById("fr1").value;
	 url=url+"&frame2="+document.getElementById("fr2").value;
	 url=url+"&frame3="+document.getElementById("fr3").value;
	 url=url+"&sid="+Math.random();

	 xmlHttp.open("GET",url,false);
	 xmlHttp.send(null);
	 //alert(xmlHttp.responseText);
	 
	 if (xmlHttp.responseText.indexOf("TRUE")!=-1) {
		 var ele = document.getElementById("toggleText");
		 ele.style.display = "none";

		 var elee = document.getElementById("toggleText2");
		 elee.style.display = "block";
		 
	// document.getElementById("OZNNAR1").innerHTML="<font color='red'><b>Napaka: OZNAKA LADJAR ze obstaja!<b></font>";
	 }
	 else {
		// document.getElementById("OZNNAR1").innerHTML="";
		 }

	 return false;
	
	
}




function GetXmlHttpObject() {

	 var objXMLHttp=null;

	 if (window.XMLHttpRequest) {
	 objXMLHttp=new XMLHttpRequest();
	 }
	 else if (window.ActiveXObject){
	 objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
	 }
	 return objXMLHttp;
	 }

var yy=0;
var xx=0;
var IE = document.all?true:false
var jein=1;
/// set koordinate
function setCor() {
	  if (IE) { 
		    xx = event.clientX + document.body.scrollLeft
		    yy = event.clientY + document.body.scrollTop
		  } else {  
		    xx = e.pageX
		    yy = e.pageY
		  }  
}


function hideFrame() {
	//window.frameElement.id
	// alert(parent.frames[2].location);
	/*if ((parent.frames[1].location+"").indexOf("nic.jsp")!=-1) {
	document.getElementById("tr"+"ifr3").style.display='none';

	document.getElementById("tr2"+"ifr3").style.display='none';
	}
	else {
	document.getElementById("tr"+"ifr3").style.display='block';

	document.getElementById("tr2"+"ifr3").style.display='block';
	}*/
/*	if ((parent.frames[2].location+"").indexOf("nic.jsp")!=-1) {
		document.getElementById("tr"+"ifr4").style.display='none';

		document.getElementById("tr2"+"ifr4").style.display='none';
		}
		else {
		document.getElementById("tr"+"ifr4").style.display='block';

		document.getElementById("tr2"+"ifr4").style.display='block';
		}*/

	}

</script>
    
    <SCRIPT LANGUAGE="JavaScript">
// global variables used while dragging
var offsetX = 0;
var offsetY = 0;
var selectedObj;
var frontObj;
// set document-level event handlers


///////// DISABLE DA NE DELA SCROLL
//document.onmousedown = engage;
//document.onmouseup = release;
/////////


// positioning an object at a specific pixel coordinate
function shiftTo(obj, x, y) {
    obj.style.pixelLeft = x;
    obj.style.pixelTop = y;
}
// setting the z-order of an object
function bringToFront(obj) {
    if (frontObj) {
        frontObj.style.zIndex = 0;
    }
    frontObj = obj;
    frontObj.style.zIndex = 1;
}

var lume = "";

function setSelectedObj() {
    var imgObj = window.event.srcElement;
    if (imgObj.id.indexOf("up1") != -1) {
        selectedObj = imgObj;
        selectedObj.style.cursor='n-resize';
       // bringToFront(selectedObj);
       lume = "2";
        return;
    }
    else if (imgObj.id.indexOf("up2") != -1) {
        selectedObj = imgObj;
        selectedObj.style.cursor='n-resize';
       // bringToFront(selectedObj);
       lume = "3";
        return;
    }
    else if (imgObj.id.indexOf("up3") != -1) {
        selectedObj = imgObj;
        selectedObj.style.cursor='n-resize';
       // bringToFront(selectedObj);
       lume = "4";
        return;
    }
    selectedObj = null;
    return;
}
// do the dragging (called repeatedly by onMouseMove)
function dragIt() {
    if (selectedObj) {
     //   shiftTo(selectedObj, (event.clientX - offsetX), (event.clientY - offsetY));
     
     
    // document.getElementById("mov").value = "Y: "+ window.event.clientY + " ::: "+offsetY;

var mit = event.clientY -offsetY;
     
     sizeUMove(mit,lume);
        return false;
    }
}


function movi() {

	if (selectedObj) {

		// document.getElementById("mov").value = "Y: "+ window.event.clientY + " ::: "+offsetY;

	//	function sizeUMove(sm,'2');
		//	dragIt();
}

	
}


// set global vars and turn on mousemove trapping (called by onMouseDown)
function engage() {
    setSelectedObj();
    if (selectedObj) {
        document.onmousemove = dragIt;
        offsetX = window.event.offsetX - document.body.scrollLeft;
        offsetY = event.clientY;//-document.body.scrollTop;

		
        
    }
}
// restore everything as before (called by onMouseUp)
function release() {

    if (selectedObj) {
        document.onmousemove = null;
        selectedObj.style.cursor='default';
        selectedObj = null;
    }
}

function micon(stl) {

	stl.style.cursor='n-resize';
}

function mhand(stl) {

	stl.style.cursor='hand';
}


</SCRIPT>
    
    
 <body onload="inito();showNews();monitor=document.getElementById('mon');<%=(!control.getUser().equals("anonymous"))?"init()":""%>"><% 
 try {
 if (!novimenu) {
 %>
  <jsp:include page="upor.jsp"/>
 <%
 }
 
 else {
 
 %>
 <jsp:include page="up.jsp"/>
<%
}
}
catch (Exception ee) {
}
 %>
<div class="container1" id="container">

<div class="resizeDiv" style="height:<%=control.getFrame1() %>;overflow-x:hidden;overflow-y:hidden;"  id="difr2"><iframe noresize="noresize"  id="ifr2" name="ifr2" scrolling="yes" frameborder="1"  style="width:100%;height:100%"  >b</iframe></div>
<div class="resizeDiv" style="height:<%=control.getFrame2() %>;overflow-x:hidden;overflow-y:hidden;"  id="difr3"><iframe noresize="noresize" id="ifr3" name="ifr3" src="nic.jsp" scrolling="yes" frameborder="1" style="width:100%;height:100%"  >b</iframe></div>
<div class="resizeDiv" style="height:<%=control.getFrame3() %>;overflow-x:hidden;overflow-y:hidden;"  id="difr4"><iframe noresize="noresize"  id="ifr4" scrolling="yes" src="nic.jsp" frameborder="1" style="width:100%;height:100%" >b</iframe></div>
<div class="resizeDiv3" id="div4"><jsp:include page="bottom.jsp"/></div>
</div>

      
     </body> 
     <script language="javascript">


$(function() { 
 
    var startwidth = 0; 
    var containerwidth = $('#container').width(); 
   // alert(containerwidth );
 $('.resizeDiv').resizable({handles:'s', 
 resize: function(event, ui) { 
        $(this).css({width:'100%'}); 
    } ,
    start: function () { 
        $(".container1").each(function (index, element) { 
            var d = $('<div class="iframeCover" style="z-index:99;position:absolute;width:100%;top:0px;left:0px;height:' + $(element).height() + 'px"></div>'); 
            $(element).append(d); 
        }); 
    }, 
    stop: function () { 
        $('.iframeCover').remove(); 
    } 

 
 });
 

}); 

</script>
     
</html> 
