<%@ page contentType="text/html\;" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />


<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
boolean jetr = false;
if (jetr) { //(control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%}%><%
try {
	

	System.out.println("Start option response checker");
	com.popultrade.webapp.SendThreadOption stoo = new com.popultrade.webapp.SendThreadOption(ConPool, contextUtil, pageContext.getServletContext(),"DR",nul);
	stoo.sendFiles();
	
	
	
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
System.out.println("Error starting popultrade: "+ex.toString());
}%>
