<%@ page contentType="text/html\;" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsssp:forward page="logout.jsp"/><%}%><%
StringBuffer result=new StringBuffer();
try {
	
	///////////// getting possible answers to questions
	
boolean bok=false;

result.append("Possible answer: <select name='choi' id='choi'><option value=''></option>");
if (true ) {
com.popultrade.dao.PageformpartsDAO doax = new com.popultrade.dao.PageformpartsDAO();
com.popultrade.model.Pageformparts modx = new com.popultrade.model.Pageformparts();
//modx.setId(request.getParameter("ido").substring(2));
String dod_hql="";
modx=doax.getPageformparts(request.getParameter("idi").substring(2), ConPool.getEntman());



String rezu_format="";
if (modx!=null) {
	List vsee = modx.getInterval();
	
	System.out.println("IS INTERVAL/ALERT  "+vsee.size());
	for (int i=0;i<vsee.size();i++) {
	com.popultrade.model.Interval modc = (com.popultrade.model.Interval)vsee.get(i);
	
	result.append("<option value='"+nul.jeNull(modc.getId())+"'>"+nul.getDatumFormatFromDate(modc.getDate_from(),"dd-MM-yyyy")+"/"+nul.getDatumFormatFromDate(modc.getDate_to(),"dd-MM-yyyy")+"</option>");
	
	
	}
}
}

result.append("</select>");

}
catch (Exception ex){
	System.out.println(ex.toString());
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%><%=result.toString() %>
