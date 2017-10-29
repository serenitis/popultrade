<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,sun.net.ftp.*"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%request.setCharacterEncoding(control.encoding);response.setContentType("text/html; charset="+control.encoding);response.addHeader("Pragma" , "No-cache") ;response.addHeader("Cache-Control", "no-cache") ;response.addDateHeader("Expires", 0);if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="logout.jsp"/><%}try {
boolean bok=false;
if (true ) {
com.popultrade.dao.TemplateRepositoryDAO doax =(com.popultrade.dao.TemplateRepositoryDAO)contextUtil.getBeanDao("templateRepositoryDAO",pageContext.getServletContext());
com.popultrade.model.TemplateRepository modx = doax.getTemplateRepository(new Long(request.getParameter("idrepo")));%><%=nul.jeN(modx.getContent()) %><%
}
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%>