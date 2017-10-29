<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,java.util.Date"  contentType="text/html; charset=utf-8"%>

<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="generator" scope="request" class="com.popultrade.webapp.generator" />

<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
} 

    



/// setam kam da frame slike
control.frame="1";

%>

<html>

<head>

<title>New Page 1</title>
</head>




  <frameset cols="50%,50%">
    <frame name="a1" src="m_upload_1v.jsp?sifra=<%=request.getParameter("sifra")%>&sifraor=null&stsl=22&back=&fram=1"  scrolling="yes" style="border-style: solid; border-width: 1" >
    <frame name="a2" src=""  scrolling="yes" style="border-style: solid; border-width: 1">
  </frameset>




 <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>
<!--
<iframe id=prva width="100%" marginwidth="0" marginheight="0" name="prvi" scrolling="yes" style="border-style: solid; border-width: 1; padding: 0" src="postavke.jsp?id=<%=request.getParameter("id")%>"
height=50%>
x</iframe>
</td></tr><tr><td>

<iframe id=druga width="100%" marginwidth="0" marginheight="0" name="drugi" scrolling="yes" style="border-style: solid; border-width: 1; padding: 0" height="50%" src="nic.jsp">
x</iframe>
-->


</html>
