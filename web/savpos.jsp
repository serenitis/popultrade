<%@ page contentType="text/html\;" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsssp:forward page="logout.jsp"/><%}%><%
try {
boolean bok=false;
if (true ) {
com.popultrade.dao.ChaptersDAO doax = new com.popultrade.dao.ChaptersDAO();
com.popultrade.model.Chapters modx = new com.popultrade.model.Chapters();
//modx.setId(request.getParameter("ido").substring(2));
String dod_hql="";
modx=doax.getChapters(request.getParameter("ido").substring(2), ConPool.getEntman());
String rezu_format="";
if (modx!=null) {

	modx.setTop_position(request.getParameter("top_position"));
	modx.setLeft_position(request.getParameter("left_position"));
	
	doax.saveChapters(modx, ConPool.getEntman());
	System.out.println("POSTION FOR ID "+request.getParameter("ido")+" SAVED!");
	
}
}
}
catch (Exception ex){
	System.out.println(ex.toString());
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%>
