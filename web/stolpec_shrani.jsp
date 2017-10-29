<%@ page contentType="text/html\;" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
boolean jetr = false;
if ((control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%}%><%
try {
boolean bok=false;
if (true ) {
	if (nul.jeNull(request.getParameter("stolpci")).equals("default")) {
		control.removeColumnsUser(contextUtil,pageContext.getServletContext(),request.getParameter("pagee"),request.getParameter("stolpci").replaceAll("PROC","%").replaceAll("th",""));

	}
else if (!nul.jeNull(request.getParameter("stolpci")).equals("")) {
control.setColumnsUser(contextUtil,pageContext.getServletContext(),request.getParameter("pagee"),request.getParameter("stolpci").replaceAll("PROC","%").replaceAll("th",""));
	}

}
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%>
