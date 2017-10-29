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
	
	
	
	
	
	com.popultrade.dao.TemplateXmlDAO daog = (com.popultrade.dao.TemplateXmlDAO)contextUtil.getBeanDao("templateXmlDAO",pageContext.getServletContext());
	
	
	/// ce gre za movanje 
	
	if (nul.jeNull(request.getParameter("kaj")).equals("2")) {
/// update zaporedja bulk
daog.updateZaporedja(new Long(request.getParameter("idnad")), request.getParameter("zaporedje"));
/// update zaporedja dropanega objekta
System.out.println("idnad::: "+request.getParameter("idnad")+" ::: "+request.getParameter("zaporedje"));

com.popultrade.model.TemplateXml txml = daog.getTemplateXml(new Long(request.getParameter("idn")));

txml.setZaporedje(Integer.parseInt(request.getParameter("zaporedje"))+1);
System.out.println("idn::: "+request.getParameter("idn")+" ::: "+request.getParameter("zaporedje"));

daog.saveTemplateXml(txml);

	}
	/// ce gre za copy ali attach, dam zaporedje zadnje
	if (nul.jeNull(request.getParameter("kaj")).equals("1") || nul.jeNull(request.getParameter("kaj")).equals("0")) {

		
		com.popultrade.model.TemplateXml txmlx = daog.getTemplateXml(new Long(request.getParameter("idn")));
		
		com.popultrade.model.TemplateXml txml = new com.popultrade.model.TemplateXml();
		txml.setId_nad(new Long(request.getParameter("idnad")));
		List maxzap = daog.getTemplateXmls(txml,1,1, "zaporedje", "desc", "");
		
		if (maxzap.size()>0) {
			com.popultrade.model.TemplateXml tx = (com.popultrade.model.TemplateXml)maxzap.get(0);
			
			/// update
			txmlx.setZaporedje(tx.getZaporedje()+3);
			
			daog.saveTemplateXml(txmlx);
			
			
		}
		
		
	}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>