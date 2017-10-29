<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<%@page import="com.popultrade.model.Novice"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
  
 
 
<%  
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ; 
response.addDateHeader("Expires", 0);


try {

				 
		 com.popultrade.dao.TekstiDAO daoo = (com.popultrade.dao.TekstiDAO)contextUtil.getBeanDao("tekstiDAO",pageContext.getServletContext());

com.popultrade.model.Teksti nj = daoo.getTeksti(new Long("1"));



		%>



	<table border="0" cellspacing="1"   style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#d3d3d3" width="480"  id="AutoNumber1" cellpadding="5">
			
	
		<tr><td height=50 colspan=2 background="rezback.gif" width=480><font color="8c2705" size=3><b>KONTAKTI</b></font></td></tr>
		<tr><td height=10 colspan=2  width=480>&nbsp;</td></tr>
		

		<tr><td height=10 colspan=2  width=480><%=nul.jeNull(nj.getText())%></td></tr>
	

	
		<tr><td height=10 colspan=2  width=480>&nbsp;</td></tr>
	<tr><td height=50 colspan=2 background="rezback.gif" width=480 align=center><a href="Javascript: history.go(-1)"><img src="back.gif" border=0></a></td></tr>
		
</table>


<%

}
catch (Exception ex) {
System.out.println(ex.toString());
}

%>