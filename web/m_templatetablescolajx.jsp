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
if (true ) {
	
	
%><select  id="h_connection_column2"  name="h_connection_column2"   class="inputIEx"   tabindex='65' onchange="document.dod.h_connection_column.value=document.dod.h_connection_column2.value" >
					<option value=""></option>
					<%
					com.popultrade.dao.TemplateTablesColDAO daotc = (com.popultrade.dao.TemplateTablesColDAO)contextUtil.getBeanDao("templateTablesColDAO",pageContext.getServletContext());
					 com.popultrade.model.TemplateTablesCol remo = new com.popultrade.model.TemplateTablesCol();
					 remo.setId_nad(new Long(request.getParameter("id_nad")));
					 List li  = daotc.getTemplateTablesCols(remo,1,150,"","field_name","asc");
					 Iterator itti = li.iterator();
					while (itti.hasNext()) {
						com.popultrade.model.TemplateTablesCol nex =(com.popultrade.model.TemplateTablesCol)itti.next();
						if (nex!=null && nex.getField_name().equals(nul.jeNull(request.getParameter("trenutni")))) {
					%>
					<option value="<%=nex.getField_name()%>" selected><%=nex.getField_name()%></option>
					<%
						}
						else {
							%>
							<option value="<%=nex.getField_name()%>" ><%=nex.getField_name()%></option>
							<%	
						}
					}
					%>
</select><%

}
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%>
