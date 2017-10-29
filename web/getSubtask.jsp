<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,sun.net.ftp.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%
 request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
 
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="logout.jsp"/><%
}
 
try {
boolean bok=false;
if (true ) {
com.popultrade.dao.TeemplatetasksDAO doax =(com.popultrade.dao.TeemplatetasksDAO)contextUtil.getBeanDao("teemplatetasksDAO",pageContext.getServletContext());
com.popultrade.model.Teemplatetasks modx = new com.popultrade.model.Teemplatetasks();
modx.setId_template(new Long(request.getParameter("idtem")));
String dod_hql="";
List remix=doax.getTeemplatetaskss(modx,"","");
String rezu_format="";
if (remix.size()>0) {
%><select name="tasks" id="tasks"  class="inputIEx" ><%
int vss = 0;
Iterator itx = remix.iterator();
while (itx.hasNext()) {
com.popultrade.model.Teemplatetasks vsebx = (com.popultrade.model.Teemplatetasks)itx.next();
vss++;
%><option value="<%=vsebx.getId()%>"><%=nul.jeN(vsebx.getName()) %></option><%
}
%></select><%}
}
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%>
