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

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="480" id="AutoNumber1" cellpadding="1">

<tr><td height=30><font color="8c2705" size=3><b>Rezultati</b>&nbsp;<br>&nbsp;<br></font></td></tr>
		</table>	


	<table border="1" cellspacing="1"  background="rezback.gif" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#d3d3d3" width="480"  id="AutoNumber1" cellpadding="5">
			
			<tr bgcolor="8c2705" style="font-family: Verdana; font-size: 8pt;color:white; ">
	
	
		<td width=320>
		TEKME
		</td>
	
		
		<td width=90 align=center>
		
		DATUM
		</td>
		<td width=75 align=center>
		IZID
		</td>
		
		</tr>
		
		<%
				 
		 com.popultrade.dao.MatchesDAO daoo = (com.popultrade.dao.MatchesDAO)contextUtil.getBeanDao("matchesDAO",pageContext.getServletContext());
		List li = daoo.getMatches1(new com.popultrade.model.Matches());

		Iterator itt = li.iterator();
int vecc = 0;
String sezona="";
		while (itt.hasNext()) {
			com.popultrade.model.Matches nj = (com.popultrade.model.Matches)itt.next();
			
	if (!sezona.equals(nul.jeNull(nj.getSifranti_id()+""))) {
	sezona = nul.jeNull(nj.getSifranti_id()+"");
	
	String opiss = "";
	if (nj.getSifranti_id()!=null && nj.getSifranti()!=null && nj.getSifranti().getOpis()!=null) {
	opiss = nj.getSifranti().getOpis();
	}
	
	%>
	<tr><td colspan=4 height=25 align=center><font size=2 color="8c2705"><b><%=opiss%></b></font></td></tr>
	<%
	}

		%>
		<tr>
		
		<td width=320><a href="index.jsp?includee=matches.jsp?idd=<%=nj.getId()%>" style="text-decoration:none"><font color="8c2705">
		<%=nul.jeNull(nj.getMatch_name())%></font></a>
		
				<%
		if (nj.getSo_slike()>0) {
			%>
			<img src="camera.gif" alt="Galerija slik">
			<%
		}
		%>
		<%
		if (nj.getSo_video()>0) {
			%>
			<img src="video.png" alt="Galerija video posnetkov">
			<%
		}
		%>
		
		</td>
	
		<td width=90 align=center>
		<%=nul.getDatumFormatFromDate(nj.getMatch_date(),"dd-MM-yyyy")%>
		</td>
		<td width=75 align=center>
		<%=nul.jeNull(nj.getMatch_result())%>
		</td>
		
		
		</tr>
		
		<%
		
	
	}

		
		%>

</table>


<%

}
catch (Exception ex) {
System.out.println(ex.toString());
}

%>