<%@ page contentType="text/html\;" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
boolean jetr = false;
if (jetr) { //(control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%}%><%
try {
boolean bok=false;
if (true) {
com.popultrade.dao.CarinarniceDAO doax =(com.popultrade.dao.CarinarniceDAO)contextUtil.getBeanDao("carinarniceDAO",pageContext.getServletContext());
com.popultrade.model.Carinarnice modx = new com.popultrade.model.Carinarnice();
modx.setOpis(request.getParameter("carurad")+"");
List remix=doax.getCarinarnices(modx);
if (remix.size()>0) {
Iterator itx = remix.iterator();
while (itx.hasNext()) {
com.popultrade.model.Carinarnice vsebx = (com.popultrade.model.Carinarnice)itx.next();
%><%=nul.jeNull(vsebx.getId()+"")%> ___ <%=nul.jeNull(vsebx.getOpis())%>###<%=nul.jeNull(vsebx.getId()+"")%> <%=nul.jeNull(vsebx.getOpis()+"")%> |<%
}
}
}
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%>
