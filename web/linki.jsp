<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<%@page import="com.popultrade.model.Linki"%>
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
	

	 
	
	
 %>


<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="490" id="AutoNumber1" cellpadding="5">
		
		
		<tr><td height=50 colspan=2 background="rezback.gif" width=490><font color="8c2705" size=3><b>Linki</b></font></td></tr>
		
		
		<%
				 
		 com.popultrade.dao.LinkiDAO daol = (com.popultrade.dao.LinkiDAO)contextUtil.getBeanDao("linkiDAO",pageContext.getServletContext());
		List lil = daol.getLinkis(new Linki());

		Iterator itti = lil.iterator();

		while (itti.hasNext()) {
		Linki nj = (Linki)itti.next();
//		System.out.println("+++++++++++++++++++++++++++++++ ::: "+nj.length);
		
		
			%>
			
			
			<tr><td width="102" valign=middle align=center>
			
			<%
			if (nj.getUploads()!=null && nj.getUploads().getSlika1()!=null && !nj.getUploads().getSlika1().equals("")) {
				%>
				<a href="<%=nul.jeNull(nj.getLink()).indexOf("http://")!=-1?nj.getLink():"http://"+nj.getLink() %>" target="_blank" style="text-decoration:none">
				<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika1()%>" width=100  border=0 style="border-color:b9b9b9">
				</a>
				<%
				
			}
			%>
			
			</td><td valign=top><table  border="0" width=370 cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111"  id="AutoNumber1" cellpadding="5">
			
		<tr><td>
		<a href="<%=nul.jeNull(nj.getLink()).indexOf("http://")!=-1?nj.getLink():"http://"+nj.getLink() %>" target="_blank" style="text-decoration:none">
		
		<b>
		
		<font color="8c2705" size=1><%=nul.jeNull(nj.getLink())%><br></font></b></a>
				</td></tr>
		<tr><td align="left"><font size=2>

		
		<%=nul.jeNull(nj.getLink_opis()) %>
		</font></td></tr>
		
			<tr><td align="left"><font size=1>

		
&nbsp;		</font></td></tr>
		</table></td></tr>
		
		<%
		
	}
		
		%>
		
		<tr><td height=50 colspan=2 background="rezback.gif" width=480><font color="8c2705" size=3><b>&nbsp;</b></font></td></tr>
		
</table>


<%

}
catch (Exception ex) {
System.out.println(ex.toString());
}

%>