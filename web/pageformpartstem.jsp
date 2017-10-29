<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<jsp:useBean id="parametrii" scope="session" class="com.popultrade.webapp.Parametri" />



<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("max-age", 0); 
response.addDateHeader("Expires",0); 
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jssp:forward page="m_loginu.html"/><%
}

%>

<html>
<body style="margin:0;">


<div id="come" style="width:100%;display:block;">
<div id="center" style="margin: 0 auto; display: table;">

<table cellpadding="8">
<tr><td><a href="" onclick="return setTem('te1','1')"><img src="te1.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te2','1')"><img src="te2.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te3','1')"><img src="te3.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te4','5')"><img src="te4.jpg"></a></td></tr><!-- alert inside page -->
<tr><td><a href="" onclick="return setTem('te5','1')"><img src="te5.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te12','6')"><img src="te12.jpg"></a></td></tr><!-- button for movement between pages and chapters -->
<tr><td><a href="" onclick="return setTem('te11','4')"><img src="te11.jpg"></a></td></tr><!-- target of questions and intervals -->
<tr><td><a href="" onclick="return setTem('te6','1')"><img src="te6.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te7','1')"><img src="te7.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te8','1')"><img src="te8.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te9','2')"><img src="te9.jpg"></a></td></tr>
<tr><td><a href="" onclick="return setTem('te10','3')"><img src="te10.jpg"></a></td></tr>

</table>



</div>

</div>





</body>
</html>
