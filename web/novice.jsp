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
	

	 
	
	
 %>


<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="415" id="AutoNumber1" cellpadding="5">
		
		
		<tr><td height=50 background="rezback.gif" width=415 colspan=2><font color="8c2705" size=3><b>Novice</b></font></td></tr>
		<tr><td>
		<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="415" id="AutoNumber1" cellpadding="5">
		
		<%
			//	 System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaa");
	 com.popultrade.dao.NoviceDAO daol = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
		List lil = daol.getNovices(new com.popultrade.model.Novice());

		Iterator itti = lil.iterator();
		//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbb");
		int las = 5;
		while (itti.hasNext()) {
			
			
		Novice nj = (Novice)itti.next();
		if (las>0) {
			las--;
		
//		System.out.println("+++++++++++++++++++++++++++++++ ::: "+nj.length);
		
		
			%>
		<tr><td><b><font size=2><%=nul.getDatumFormatFromDate(nj.getDatum_novice(),"dd-MM-yyyy")%></font>
		<font color="8c2705" size=2><%=nul.cutStringAddPoints(nul.jeNull(nj.getNaslov_novice()),200)%><br>&nbsp;<br></font></b>
		<font size=2>

		
		<%=nul.jeNull(nj.getOpis_novice()) %>
		</font><br>
		</td></tr>
		<tr><td align="right"><a href="index.jsp?includee=novice_p.jsp?id=<%=nj.getId()%>"><img src="more.gif" border=0></a></td></tr>
		
		<tr><td align="right"><hr></td></tr>
		
		
		<%
		}
		else {
			break;
		}
	}
		
		%>
		
		</table></td>
		
		<td valign=top>
								<table border="0" background="rezback.gif"  width="60" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 7pt" bordercolor="#111111"  id="AutoNumber1" cellpadding="3">

				
																<tr>
						<td background="rezback.gif" >
														<font color="8c2705" size=1><b>ARHIV</b></font>
					</td>
					
					</tr>
							
					

 <%
 /// dobim arhiv [po mesecih
 
 
 List l = daol.getArhiv();

Iterator itf = l.iterator();
//System.out.println(" SSSSSSSSSS "+l.size());

while (itf.hasNext()) {

Object[] aa = (Object[])itf.next();

//System.out.println(" SSSSSSSSSS "+l.size());

 
 %>

														<tr>
														<td height=18 style="font-family: Verdana; font-size: 8pt" colspan=2 ><a href="index.jsp?includee=novice_p2.jsp?monthh=<%=nul.jeNull(aa[0]+"")%>&yearr=<%=nul.jeNull(aa[1]+"")%>"><span style="text-decoration: none"><font color="#000000"><%=nul.jeNull(aa[0]+"")%>-<%=nul.jeNull(aa[1]+"")%></font></span></a></td>
													</tr>
													<%
													}
													%>
													
													
													
													
													
													</table>
		</td>
		</tr>
		
		
		<tr><td height=50 colspan=2 background="rezback.gif" width=415><font color="8c2705" size=3><b>&nbsp;</b></font></td></tr>
		
</table>

	
						

<%

}
catch (Exception ex) {
System.out.println(ex.toString());
}

%>