<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,java.util.Date"  contentType="text/html; charset=utf-8"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />

<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);

//ConPool.setCas(request.getServletContext());

%>
<%


control.prvi_page = "indexne.jsp";

 
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
        System.out.println("BROWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW "+browserversion);
        novimenu=true;
        
        }
    }
}
}
catch (Exception e) {
}


System.out.println("USERAGENT :::: "+novimenu);



//response.setHeader( "Vary", "User-Agent" );
%>
<html lang="en"> 
    <head> 
    
   

    <!-- SmartMenus jQuery plugin -->


<!-- SmartMenus core CSS (required) -->
<link href='js/css/sm-core-css.css' rel='stylesheet' type='text/css' />
<!-- "sm-blue" menu theme (optional, you can use your own CSS, too) -->
<link href='js/css/sm-simple/sm-simple.css' rel='stylesheet' type='text/css' />



  <link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="scripts/jquery.min.js"></script> <script type="text/javascript" src="scripts/jquery-migrate.min.js"></script>
    <script type="text/javascript" src="js/jqxcore.js"></script>
    <script type="text/javascript" src="js/jqxsplitter.js"></script>
<link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />


<%
/// samo ce user ima opcijo

if (nul.jeNull(control.getParameter07()).equals("1")) {
%>

<script src="js/taffy.js" type="text/javascript"></script>
<script src="js/jsDB.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000018","Y","SL"))%>" type="text/javascript"></script>

<%
}
%>

<script src="js/jquery.smartmenus.js" type="text/javascript"></script>

    
<!-- #main-menu config - instance specific stuff not covered in the theme -->
<style type="text/css">
	#main-menu {
		position:relative;
		z-index:9940;
		width:auto;
	}
	#main-menu ul {
		width:12em; /* fixed width only please - you can use the "subMenusMinWidth"/"subMenusMaxWidth" script options to override this if you like */
	}
	
	
	


html, body
{
	margin: 0;			/* Remove body margin/padding */
	padding: 0;
	overflow: hidden;	/* Remove scroll bars on browser window */
}


.imagescreen{  
 width: 80%;
   /* background-color: red;*/
    position: absolute;
    top:20;
    bottom: 20;
    left: 0;
    right: 0;
text-align:center;
    margin: auto;
display:none;
    z-index: 123456780;
}​




/* overlay logic */

a#overlaylaunch-inAbox {
    display: block;
    padding: 40px;
    margin: 40px;
    background-color: #efefef;
    font-size: 1.6em;
    text-decoration: none;
    text-align: center;
}
/*
#overlay-inAbox .wrapper {
    text-align: center;
}*/



/* More important stuff */

.overlay,
#overlay-shade {
    display: none;
}

#overlay-shade {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 9985;
    background-color: #000;
}

.overlay {
    position: absolute;
    top: 0;
    left: -10px;
    width: 95%;
     height: 90%;
    z-index: 9986;
    background-color: white;
    border: 10px solid #CFCFCF;
  /*  color: #fff;*/
   // box-shadow: 0 0 16px #000;
} .ie7 .overlay {
    height: 90%;
} .overlay .wrapper {
   /* padding: 15px 30px 30px;*/
}


.overlay .toolbar {
    padding: 8px;
    line-height: 1;
    text-align: right;
    overflow: hidden;
    position:absolute;
    width:97%;
    top:-25px;
} .overlay .toolbar a.close {
    display: inline-block;
        *display: inline;
         zoom: 1;
    padding: 0 8px;
    font-size: 12px;
    text-decoration: none;
    font-weight: bold;
    line-height: 18px;
    border-radius: 5px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        -o-border-radius: 5px;
    color: #999999;
    background-color: #515151;
} .overlay .toolbar a.close span {
    color: #818181;
} .overlay .toolbar a.close:hover,
  .overlay .toolbar a.close:hover span {
    background-color: #b90900;
    color: #fff;
}







/* overlay logic */

a#overlaylaunch-inAbox2 {
    display: block;
    padding: 40px;
    margin: 40px;
    background-color: #efefef;
    font-size: 1.6em;
    text-decoration: none;
    text-align: center;
}
/*
#overlay-inAbox .wrapper {
    text-align: center;
}*/



/* More important stuff */

.overlay2,
#overlay-shade2 {
    display: none;
}

#overlay-shade2 {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 9987;
    background-color: #000;
}

.overlay2 {
    position: absolute;
    top: 0;
    left: -10px;
    width: 92%;
     height: 88%;
    z-index: 9988;
    background-color: white;
    border: 10px solid #CFCFCF;
  /*  color: #fff;*/
   // box-shadow: 0 0 16px #000;
} .ie7 .overlay2 {
    height: 90%;
} .overlay2 .wrapper {
   /* padding: 15px 30px 30px;*/
}


.overlay2 .toolbar2 {
    padding: 8px;
    line-height: 1;
    text-align: right;
    overflow: hidden;
    position:absolute;
    width:97%;
    top:-25px;
} .overlay2 .toolbar2 a.close2 {
    display: inline-block;
        *display: inline;
         zoom: 1;
    padding: 0 8px;
    font-size: 12px;
    text-decoration: none;
    font-weight: bold;
    line-height: 18px;
    border-radius: 5px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        -o-border-radius: 5px;
    color: #999999;
    background-color: #515151;
} .overlay2 .toolbar2 a.close2 span {
    color: #818181;
} .overlay2 .toolbar2 a.close2:hover,
  .overlay2 .toolbar2 a.close2:hover span {
    background-color: #b90900;
    color: #fff;
}














/* overlay logic 3 */

a#overlaylaunch-inAbox3 {
    display: block;
    padding: 40px;
    margin: 40px;
    background-color: #efefef;
    font-size: 1.6em;
    text-decoration: none;
    text-align: center;
}


.overlay3,
#overlay-shade3 {
    display: none;
}

#overlay-shade3 {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 9989;
    background-color: #000;
}

.overlay3 {
    position: absolute;
    top: 0;
    left: -10px;
    width: 89%;
     height: 86%;
    z-index: 9990;
    background-color: white;
    border: 10px solid #CFCFCF;
  /*  color: #fff;*/
   // box-shadow: 0 0 16px #000;
} .ie7 .overlay3 {
    height: 90%;
} .overlay3 .wrapper {
   /* padding: 15px 30px 30px;*/
}


.overlay3 .toolbar3 {
    padding: 8px;
    line-height: 1;
    text-align: right;
    overflow: hidden;
    position:absolute;
    width:97%;
    top:-25px;
} .overlay3 .toolbar3 a.close3 {
    display: inline-block;
        *display: inline;
         zoom: 1;
    padding: 0 8px;
    font-size: 12px;
    text-decoration: none;
    font-weight: bold;
    line-height: 18px;
    border-radius: 5px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        -o-border-radius: 5px;
    color: #999999;
    background-color: #515151;
} .overlay3 .toolbar3 a.close3 span {
    color: #818181;
} .overlay3 .toolbar3 a.close3:hover,
  .overlay3 .toolbar3 a.close3:hover span {
    background-color: #b90900;
    color: #fff;
}







/* overlay logic 4 */

a#overlaylaunch-inAbox4 {
    display: block;
    padding: 40px;
    margin: 40px;
    background-color: #efefef;
    font-size: 1.6em;
    text-decoration: none;
    text-align: center;
}
/*
#overlay-inAbox .wrapper {
    text-align: center;
}*/



/* More important stuff */

.overlay4,
#overlay-shade4 {
    display: none;
}

#overlay-shade4 {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 9991;
    background-color: #000;
}

.overlay4 {
    position: absolute;
    top: 0;
    left: -10px;
    width: 86%;
     height: 84%;
    z-index: 9992;
    background-color: white;
    border: 10px solid #CFCFCF;
  /*  color: #fff;*/
   // box-shadow: 0 0 16px #000;
} .ie7 .overlay4 {
    height: 90%;
} .overlay4 .wrapper {
   /* padding: 15px 30px 30px;*/
}


.overlay4 .toolbar4 {
    padding: 8px;
    line-height: 1;
    text-align: right;
    overflow: hidden;
    position:absolute;
    width:97%;
    top:-25px;
} .overlay4 .toolbar4 a.close4 {
    display: inline-block;
        *display: inline;
         zoom: 1;
    padding: 0 8px;
    font-size: 12px;
    text-decoration: none;
    font-weight: bold;
    line-height: 18px;
    border-radius: 5px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        -o-border-radius: 5px;
    color: #999999;
    background-color: #515151;
} .overlay4 .toolbar4 a.close4 span {
    color: #818181;
} .overlay4 .toolbar4 a.close4:hover,
  .overlay4 .toolbar4 a.close4:hover span {
    background-color: #b90900;
    color: #fff;
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

    
    
    
    function WebSocketTest()
    {
      if ("WebSocket" in window)
      {
		return true;
       }
      else
      {
        // the browser doesn't support WebSockets
        alert("<%=nul.jeNull(ConPool.getPrevod_admin("1000020","Y",control.getJezik()+""))%>");
        document.getElementById("errore").innerHTML="<%=nul.jeNull(ConPool.getPrevod_admin("1000027","Y",control.getJezik()+""))%>";
        return false;
      }
    }
    
    
    
    
    
    
    
    
    
    
 /*   function getChromeVersion() {     
        var raw = navigator.userAgent.match(/Chrom(e|ium)\/([0-9]+)\./);

        return raw ? parseInt(raw[2], 10) : false;
    }
	function ie_ver(){  
		
		
		
		
		
	    var iev=0;
	    var ieold = (/MSIE (\d+\.\d+);/.test(navigator.userAgent));
	    var trident = !!navigator.userAgent.match(/Trident\/7.0/);
	    var rv=navigator.userAgent.indexOf("rv:11.0");

	    if (ieold) iev=new Number(RegExp.$1);
	    if (navigator.appVersion.indexOf("MSIE 10") != -1) iev=10;
	    if (trident&&rv!=-1) iev=11;

	    return iev;         
	}*/
    
    
function showNews() {
	

//alert(ie_ver());
	
	
	
	
<%
if (!control.getUser().equals("anonymous") && control.getPrivilegijeUporabnika().equals("U")) {
%>
parent.frames[0].document.location="news.jsp";
//parent.frames[0].document.location="task_edit1103.jsp";
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
//if ((parent.frames[2].location+"").indexOf("nic.jsp")!=-1) {
//iframedo="";
//iframeup=parent.frames[0].location+"";
//}
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
//iframedo=parent.frames[2].location+"";
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
//iframedo=parent.frames[2].location+"";
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
		
		//var panels = $('#firstNested').jqxSplitter('panels');
		
		
		
		var panels2 = $('#mainSplitter').jqxSplitter('panels');

		var z1 = getZao(panels2[0].size+"");
		var z2 = getZao(panels2[1].size+"");
		
		
	//	var z21 = getZao(panels[0].size+"");
	//	var z22 = getZao(panels[1].size+"");
	//	
	//	alert(z1);		
		//text.innerHTML = "hide";
		document.getElementById("fr1").value=z1;
		document.getElementById("fr2").value=z2;
	//	document.getElementById("fr3").value=100-Number(z1)-Number(z21);

		}


	
	return false;
} 




function getZao(up1) {
	
	
	if ((up1).indexOf(".")!=-1) {
		up1 = up1.substring(0,up1.indexOf("."))+"";
		
	}
	else if ((up1).indexOf("%")!=-1) {
		up1 = up1.substring(0,up1.indexOf("%"))+"";
		
	}
	
	return up1;
}




function setSize(fram1,fram2,fram3) {
	/*
	top.document.getElementById('ifr2').style.height = fram1+"%";
	top.document.getElementById('ifr3').style.height = fram2+"%";
	top.document.getElementById('ifr4').style.height = fram3+"%";
	
	*/
	
	//var panels = $('#firstNested').jqxSplitter('panels');
	var panels2 = $('#mainSplitter').jqxSplitter('panels');
	panels2[0].size=fram1+"%";
	panels2[1].size=fram2+"%";
//	panels[0].size=fram2+"%";
	//panels[1].size=fram3+"%";
	
	$('#mainSplitter').jqxSplitter({panels:panels2});
//	$('#firstNested').jqxSplitter({panels:panels});
	
//	startScroll() ;
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
	// url=url+"&frame3="+document.getElementById("fr3").value;
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









function openOverlay(olEl) {
    $oLay = $(olEl);
    
    if ($('#overlay-shade').length == 0){
        $('body').prepend('<div id="overlay-shade" onclick="closeOverlay()"></div>');
    }
    
    $('#overlay-shade').fadeTo(10, 0.1, function() {
        var props = {
            oLayWidth       : $oLay.width(),
            scrTop          : $(window).scrollTop(),
            viewPortWidth   : $(window).width()
        };

        var leftPos = (props.viewPortWidth - props.oLayWidth) / 2;

        $oLay
            .css({
                display : 'block',
                opacity : 0,
               /* top : '-=300',*/
                left : (leftPos-10)+'px'
            })
            .animate({
                top : props.scrTop + 40,
                opacity : 1
            }, 10);
    });
}

function closeOverlay() {
    $('.overlay').animate({
        top : '-=300',
        opacity : 0
    }, 100, function() {
        $('#overlay-shade').fadeOut(50);
        $(this).css('display','none');
    });
}
/*
$('#overlay-shade, .overlay a').live('click', function(e) {
    closeOverlay();
    if ($(this).attr('href') == '#') e.preventDefault();
});
*/

// Usage
function clickove(locationxx) {
	
	  openOverlay('#overlay-inAbox');
  // e.preventDefault();
  // alert(document.getElementById("ifro").src);
   document.getElementById("ifro").src=locationxx;
   
  return false;
}


function closeove(e) {
	
   closeOverlay();
   document.getElementById("ifro").src='nic.jsp';
 //  e.preventDefault();
   return false;
}








function openOverlay2(olEl) {
    $oLay = $(olEl);
    
    if ($('#overlay-shade2').length == 0){
        $('body').prepend('<div id="overlay-shade2" onclick="closeOverlay2()"></div>');
    }
    
    $('#overlay-shade2').fadeTo(10, 0.1, function() {
        var props = {
            oLayWidth       : $oLay.width(),
            scrTop          : $(window).scrollTop(),
            viewPortWidth   : $(window).width()
        };

        var leftPos = (props.viewPortWidth - props.oLayWidth) / 2;

        $oLay
            .css({
                display : 'block',
                opacity : 0,
                left : (leftPos-10)+'px'
            })
            .animate({
                top : props.scrTop + 50,
                opacity : 1
            }, 10);
    });
}

function closeOverlay2() {
    $('.overlay2').animate({
        top : '-=300',
        opacity : 0
    }, 100, function() {
        $('#overlay-shade2').fadeOut(50);
        $(this).css('display','none');
    });
}
// Usage
function clickove2(locationxx) {

	  openOverlay2('#overlay-inAbox2');
   document.getElementById("ifro2").src=locationxx;
   
  return false;
}


function closeove2(e) {
	
   closeOverlay2();
   document.getElementById("ifro2").src='nic.jsp';
   return false;
}









function openOverlay3(olEl) {
    $oLay = $(olEl);
    
    if ($('#overlay-shade3').length == 0){
        $('body').prepend('<div id="overlay-shade3" onclick="closeOverlay3()"></div>');
    }
    
    $('#overlay-shade3').fadeTo(10, 0.1, function() {
        var props = {
            oLayWidth       : $oLay.width(),
            scrTop          : $(window).scrollTop(),
            viewPortWidth   : $(window).width()
        };

        var leftPos = (props.viewPortWidth - props.oLayWidth) / 2;

        $oLay
            .css({
                display : 'block',
                opacity : 0,
                left : (leftPos-10)+'px'
            })
            .animate({
                top : props.scrTop + 60,
                opacity : 1
            }, 10);
    });
}

function closeOverlay3() {
    $('.overlay3').animate({
        top : '-=300',
        opacity : 0
    }, 100, function() {
        $('#overlay-shade3').fadeOut(50);
        $(this).css('display','none');
    });
}
// Usage
function clickove3(locationxx) {

	  openOverlay3('#overlay-inAbox3');
   document.getElementById("ifro3").src=locationxx;
   
  return false;
}


function closeove3(e) {
	
   closeOverlay3();
   document.getElementById("ifro3").src='nic.jsp';
   return false;
}

















function openOverlay4(olEl) {
    $oLay = $(olEl);
    
    if ($('#overlay-shade4').length == 0){
        $('body').prepend('<div id="overlay-shade4" onclick="closeOverlay4()"></div>');
    }
    
    $('#overlay-shade4').fadeTo(10, 0.1, function() {
        var props = {
            oLayWidth       : $oLay.width(),
            scrTop          : $(window).scrollTop(),
            viewPortWidth   : $(window).width()
        };

        var leftPos = (props.viewPortWidth - props.oLayWidth) / 2;

        $oLay
            .css({
                display : 'block',
                opacity : 0,
                left : (leftPos-10)+'px'
            })
            .animate({
                top : props.scrTop + 70,
                opacity : 1
            }, 10);
    });
}

function closeOverlay4() {
    $('.overlay4').animate({
        top : '-=300',
        opacity : 0
    }, 100, function() {
        $('#overlay-shade4').fadeOut(50);
        $(this).css('display','none');
    });
}
// Usage

var rteditor;
var sloko;
function clickove4(locationxx,objecto,slok) {

	sloko=slok;
	rteditor=objecto;
	  openOverlay4('#overlay-inAbox4');
   document.getElementById("ifro4").src=locationxx;
  // alert(objecto.value);
  // document.getElementById("ifro4").document.getElementById("description112").value=objecto.value;
 //  parent.frames[5].document.getElementById("description112").value=objecto.value;
  return false;
}


function closeove4(e) {
	
   closeOverlay4();
   document.getElementById("ifro4").src='nic.jsp';
   return false;
}


/// reset page block

function resetPageBlockAll() {

	if (document.getElementById("ifro")!=null && document.getElementById("ifro").contentWindow!=null && typeof document.getElementById("ifro").contentWindow.resetPageBlock === "function") { 
		document.getElementById("ifro").contentWindow.resetPageBlock();
	}

	if (document.getElementById("ifro2")!=null && document.getElementById("ifro2").contentWindow!=null && typeof document.getElementById("ifro2").contentWindow.resetPageBlock === "function") { 
		document.getElementById("ifro2").contentWindow.resetPageBlock();
	}

	if (document.getElementById("ifro3")!=null && document.getElementById("ifro3").contentWindow!=null && typeof document.getElementById("ifro3").contentWindow.resetPageBlock === "function") { 
		document.getElementById("ifro3").contentWindow.resetPageBlock();
	}
	if (document.getElementById("ifro4")!=null && document.getElementById("ifro4").contentWindow!=null && typeof document.getElementById("ifro4").contentWindow.resetPageBlock === "function") { 
		document.getElementById("ifro4").contentWindow.resetPageBlock();
	}
	
	if (document.getElementById("ifr2").contentWindow!=null && typeof document.getElementById("ifr2").contentWindow.resetPageBlock === "function") { 
		document.getElementById("ifr2").contentWindow.resetPageBlock();
	}
	if (document.getElementById("ifr3").contentWindow!=null && typeof document.getElementById("ifr3").contentWindow.resetPageBlock === "function") { 
		document.getElementById("ifr3").contentWindow.resetPageBlock();
		

	}
}





</SCRIPT>
    
    
 <body onload="WebSocketTest();inito();colla();showNews();monitor=document.getElementById('mon');<%=(!control.getUser().equals("anonymous"))?"init()":""%>">



<div id="imagescreenid" class="imagescreen"  ><img id="imageimg" onclick="document.getElementById('imagescreenid').style.display='none'" style="max-width:100%;max-height:100%;vertical-align:middle" src='#'/></div>
 
 
 <table cellspacing=0 cellpadding=0 width=100% height=100%><tr><td height=95>
 <% 
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
 %></td></tr><tr><td>

    <div id="mainSplitter">
        <div id='topp' style="background-image:url('podlaga.jpg');" id="difr2">
       
<iframe noresize="noresize"  id="ifr2" name="ifr2" src="<%=(control.nelogin3x?"nic_nolog.jsp":"nic.jsp") %>" scrolling="yes" frameborder="0"  style="width:100%;height:100%"  >b</iframe>
        </div>
    
            <div  style="background-image:url('podlaga.jpg');" id="difr3">


<iframe noresize="noresize" id="ifr3" name="ifr3" src="nic.jsp" scrolling="yes" frameborder="0" style="width:100%;height:100%"  onload="collapseL(this.contentWindow.location)"  >b</iframe>

            </div>
          

    </div>
</td></tr>
<tr><td height=10>

<!-- 
<a href="#" idd="overlaylaunch-inAbox" onclick="clickove('nictest.jsp')">Launch It!</a>
<a href="#" idd="overlaylaunch-inAbox" onclick="clickove2('m_loginu2.html')">Launch It 2!</a>-->
<jsp:include page="bottom.jsp"/>


</td></tr>

</table>
      
 <div id="overlay-inAbox" class="overlay">
    <div class="toolbar"><a class="close" href="#" onclick="closeove(event)" ><span>x</span> close</a></div>
     <div  style="width:100%;height:100%;"><table width=100% height=100% background='podlaga.jpg'><tr><td>
    <iframe noresize="noresize"  id="ifro" name="ifro" src="nic.jsp" scrolling="yes" frameborder="0"  style="width:100%;height:100%"  >x</iframe>
</td></tr></table>
    </div>
</div> 


 <div id="overlay-inAbox2" class="overlay2">
    <div class="toolbar2"><a class="close2" href="#" onclick="closeove2(event)" ><span>x</span> close</a></div>
     <div  style="width:100%;height:100%;"><table width=100% height=100% background='podlaga.jpg'><tr><td>
    <iframe noresize="noresize"  id="ifro2" name="ifro2" src="nic.jsp" scrolling="yes" frameborder="0"  style="width:100%;height:100%"  >x</iframe>
</td></tr></table>
    </div>
</div> 





 <div id="overlay-inAbox3" class="overlay3">
    <div class="toolbar3"><a class="close3" href="#" onclick="closeove3(event)" ><span>x</span> close</a></div>
     <div  style="width:100%;height:100%;"><table width=100% height=100% background='podlaga.jpg'><tr><td>
    <iframe noresize="noresize"  id="ifro3" name="ifro3" src="nic.jsp" scrolling="yes" frameborder="0"  style="width:100%;height:100%"  >x</iframe>
</td></tr></table>
    </div>
</div> 



<!-- for text editor -->
 <div id="overlay-inAbox4" class="overlay4">
    <div class="toolbar4"><a class="close4" href="#" onclick="closeove4(event)" ><span>x</span> close</a></div>
     <div  style="width:100%;height:100%;"><table width=100% height=100% background='podlaga.jpg'><tr><td>
    <iframe noresize="noresize"  id="ifro4" name="ifro4" src="nic.jsp" scrolling="yes" frameborder="0"  style="width:100%;height:100%"  >x</iframe>
</td></tr></table>
    </div>
</div> 



     </body> 
     <script language="javascript">

     $(document).ready(function () {
         var theme = 'classic';
  
         $('#mainSplitter').jqxSplitter({ theme: theme, width: '100%', height: '100%', orientation: 'horizontal', panels: [{ size: '30%',collapsible:false }, { size: '70%',collapsible:true}] });

});


     var prej = "";
     function collapseL(kajj) {
    	 
    	// panels[0][1].collapsible = true;

       // panels[0][2].collapsible = false;

     //    $('#firstNested').jqxSplitter({ panels: panels });         

     kaj = kajj+"";
     if (kaj.indexOf("nic.jsp")==-1) {
     
    	// if (prej!=kaj) {
    	 
    	// prej = kaj;
         $('#mainSplitter').jqxSplitter('expand');
    	// }
    	 
    	 
    	 
     }
     
     if (kaj.indexOf("nic.jsp")!=-1) {
    	  $('#mainSplitter').jqxSplitter('collapse');
    	 
     }
         
         
     }
     
     
     function colla() {
    	 $('#mainSplitter').jqxSplitter('collapse');
    	 
     }
     
     
     function disImage(imgge) {
    	 document.getElementById('imageimg').src=imgge;
    	 
    	 document.getElementById('imagescreenid').style.display='block';
    	 }
     
var iddx = 0;     
function dragTop(ev)  {
     
iddx=ev.target.id;

}

function allowDropTop(ev)  {
      ev.preventDefault();
 }
 
 function dropTop(ev,objecti)  {
      ev.preventDefault();
objecti.location="pgnlogclient_list1354.jsp?iddx="+iddx;
      
 }

</script>
     
</html> 
