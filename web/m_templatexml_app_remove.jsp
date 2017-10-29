<%@ page contentType="text/html; " import="org.apache.commons.lang.StringUtils,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,net.sf.beanlib.api.BeanMethodCollector,java.lang.reflect.Method"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") )) {
%><jdsp:forward page="m_loginu.html"/><%
}
%>




<%

/// update vseh zaporedij

try {
	
	
	
	
	
	com.popultrade.dao.TemplateXmlelementsDAO daog = (com.popultrade.dao.TemplateXmlelementsDAO)contextUtil.getBeanDao("templateXmlelementsDAO",pageContext.getServletContext());
	
	
	/// ce gre za movanje 
	
	if (!nul.jeNull(request.getParameter("idn")).equals("")) {
	
		daog.removeTemplateXmlelements(new Long(request.getParameter("idn")));

		%>REMOVE OK
		<%
		
	}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
%>ERROR remvoing tag: <%=ex.toString()%><%

}
%>