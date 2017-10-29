<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>

 <jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />

<%

request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="logout.jsp"/><%
}

%>

<html>

<head>

</head>


 <frameset cols="270,*" framespacing="0" border="0" frameborder="0">
  <frame name="prvaini" target="drugaini"  src="news_slika.jsp"  scrolling="no" style="border-style: solid; border-width: 0">

  <frame name="drugaini" target="prvaini" src="news.jsp"  scrolling="yes" style="border-style: solid; border-width: 0">
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>



</html>
