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



%>
<%
String userAgent = request.getHeader( "User-Agent" );
boolean isFirefox = ( userAgent != null && userAgent.indexOf( "Firefox/" ) != -1 );
String size="0";
String scrol = "yes";
if (isFirefox) {
size="1";
scrol="auto";
}


//response.setHeader( "Vary", "User-Agent" );
%>
<html lang="en"> 
    <head> 
        <title>popultrade</title> 
    </head> 
    <script language="javascript">
    function sizeU(sm,vr1,vr2) {
    //alert((document.getElementById('ifrtd'+vr2).style.height+""));
    if (sm=='u') {
   // document.getElementById('ifr2').style.height = (Number((document.getElementById('ifr2').style.height+"").replace("%","")) + 10)+"%" ;
if ((Number((document.getElementById('ifrtd'+vr2).style.height+"").replace("%","")) - 6)>6) {

    document.getElementById('ifrtd'+vr1).style.height = (Number((document.getElementById('ifrtd'+vr1).style.height+"").replace("%","")) + 6)+"%" ;
    document.getElementById('ifrtd'+vr2).style.height = (Number((document.getElementById('ifrtd'+vr2).style.height+"").replace("%","")) - 6)+"%" ;
}    


    }
    if (sm=='d') {
   // document.getElementById('ifr2').style.height = (Number((document.getElementById('ifr2').style.height+"").replace("%","")) - 10)+"%";
   
if ((Number((document.getElementById('ifrtd'+vr1).style.height+"").replace("%","")) - 6)>6) {
 document.getElementById('ifrtd'+vr1).style.height = (Number((document.getElementById('ifrtd'+vr1).style.height+"").replace("%","")) - 6)+"%" ;
    document.getElementById('ifrtd'+vr2).style.height = (Number((document.getElementById('ifrtd'+vr2).style.height+"").replace("%","")) + 6)+"%" ;
    }

    }

    return false;
    }
    </script>
 <body >

    
    <table cellspacing="0" cellpadding="0" width="100%" height="100%">

<tr> <td height="122"><jsp:include page="up.jsp"/></td></tr><tr> <td id="ifrtd2" style="height:30%">
        <iframe id="ifr2" scrolling="yes" frameborder="1"  style="width:100%;margin:0;height:100%;">b</iframe>
</td></tr>
      <tr><td  height="5" align="right"><input  type="image" src="sized.gif"  value="sizeUP" onclick="return sizeU('u','2','3')" style="height:10"> <input  type="image" src="sizeu.gif"  value="sizeDOWN" onclick="return sizeU('d','2','3')" style="height:10"></td></tr>
      <tr> <td  style="height:30%" id="ifrtd3">
      
        <iframe id="ifr3" scrolling="yes" frameborder="1"  style="width:100%;margin:0;height:100%">b</iframe> 
</td></tr>

  <tr><td  height="5" align="right"><input type="image" src="sized.gif" value="sizeUP" onclick="return sizeU('u','3','4')" style="height:10"> <input  type="image" src="sizeu.gif"  value="sizeDOWN" onclick="return sizeU('d','3','4')" style="height:10"></td></tr>
    
<tr> <td  style="height:30%" id="ifrtd4">
        <iframe id="ifr4" scrolling="yes" frameborder="1" style="width:100%;margin:0;height:100%">b</iframe> 
</td></tr>
<tr><td height="22"><jsp:include page="bottom.jsp"/></td></tr>
      </table>


      
     </body> 
</html> 
