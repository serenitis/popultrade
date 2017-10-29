<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>


  <jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />


<%

if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {

%><jsp:forward page="login.html"/><%

}

%>

<html>




 <frameset cols="50%,50%" framespacing="0" border="0" frameborder="0">
  <frame name="prvain" target="drugain"  src="m_users_ladjarji_ima.jsp?id=<%=request.getParameter("id")%>"  scrolling="yes" style="border-style: solid; border-width: 1">

  <frame name="drugain" target="prvain" src="nic.jsp"  scrolling="yes" style="border-style: solid; border-width: 1">
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
