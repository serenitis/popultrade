<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="stat" scope="session" class="com.popultrade.webapp.statistika" />

<%
    try {
System.out.println(request.getParameter("r")+"---------------------------------------------------------------------------------------");
stat.plusEna(request.getParameter("si"),request.getParameter("statistik"),request,request.getParameter("r"),request.getParameter("os"),request.getParameter("br"),request.getParameter("cd"),request.getParameter("re"),contextUtil,pageContext.getServletContext());
    
    }
    catch (Exception ex) {
    
      System.out.println(ex.toString());
    }

%>

