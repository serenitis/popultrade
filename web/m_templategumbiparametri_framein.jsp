<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>


  <jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />


<%

if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
	%><jsp:forward page="m_loginu.html"/><%
	}
	
String userAgent = request.getHeader( "User-Agent" );
boolean isFirefox = ( userAgent != null && userAgent.indexOf( "Firefox/" ) != -1 );
String size="0";
String scrol = "yes";
if (isFirefox) {
size="1";
scrol="auto";
}

session.setAttribute("idg",request.getParameter("idg"));
session.setAttribute("idt",request.getParameter("idt"));
%>

<html>




 <frameset rows="50%,50%" framespacing="0" border="<%=size%>" frameborder="<%=size%>">
  <frame name="prvain" target="drugain"  marginheight="1"  scrolling="<%=scrol %>"   src="m_templategumbiparametri.jsp?idt=<%=request.getParameter("idt") %>&sifid=<%=request.getParameter("sifid") %>&idp=<%=request.getParameter("idp") %>&idg=<%=request.getParameter("idg") %>&glavno=<%=request.getParameter("glavno") %>"   style="border-style: solid; border-width: 1">

  <frame name="drugain" target="prvain" src="nic.jsp"  marginheight="1"   scrolling="<%=scrol %>"   style="border-style: solid; border-width: 1">
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
