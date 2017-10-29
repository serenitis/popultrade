<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);

try {

	com.popultrade.webapp.PgnClientsc	vseb = (com.popultrade.webapp.PgnClientsc)contextUtil.getPopulatedObject(vseb,request,1);
	
	System.out.println(vseb.getClient_url() + " ----------------------------- ++++++++++++ " );
	com.popultrade.webapp.ClientCheck cc = new com.popultrade.webapp.ClientCheck();
	
	%><%=cc.checkWorking(vseb, ConPool, contextUtil,pageContext.getServletContext())%><%
	
	
	
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%>