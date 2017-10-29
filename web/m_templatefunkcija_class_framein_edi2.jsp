<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>

<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
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

if (!nul.jeNull(request.getParameter("idp")).equals("")) {
session.setAttribute("idp",request.getParameter("idp"));
}/*
System.out.println("::::::::::::: "+request.getParameter("idg"));
session.setAttribute("idg",request.getParameter("idg"));
session.setAttribute("idt",request.getParameter("idt"));*/
session.setAttribute("predpona",request.getParameter("predpona"));
session.setAttribute("glavno",request.getParameter("glavno"));
session.setAttribute("classo",request.getParameter("classo"));
session.setAttribute("idv",nul.jeNull(request.getParameter("idv")));
%>

<html>




 <frameset rows="50%,50%" framespacing="0" border="<%=size%>" frameborder="<%=size%>">
  <frame name="prvain" target="drugain"  marginheight="1"  scrolling="<%=scrol %>"   src="m_templatefunkcija_class_edi2.jsp?idt=<%=request.getParameter("idt") %>&sifid=<%=request.getParameter("sifid") %>&idp=<%=request.getParameter("idp") %>&idg=<%=request.getParameter("idg") %>&glavno=<%=request.getParameter("glavno") %>"   style="border-style: solid; border-width: 1">

  <frame name="drugain" target="prvain" src="nic.jsp"  marginheight="1"   scrolling="<%=scrol %>"   style="border-style: solid; border-width: 1">
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
