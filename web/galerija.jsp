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



	<table border="0" cellspacing="1"   style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#d3d3d3" width="480"  id="AutoNumber1" cellpadding="5">
			
	
		<tr><td height=50  background="rezback.gif" width=480><font color="8c2705" size=3><b>Foto Galerije</b></font></td></tr>
		
<tr><td>

		
	
		<%
				 
		 com.popultrade.dao.GalerijaDAO dam = (com.popultrade.dao.GalerijaDAO)contextUtil.getBeanDao("galerijaDAO",pageContext.getServletContext());
		List l = dam.getGalerijaShow(new com.popultrade.model.Galerija());

		Iterator it = l.iterator();


		while (it.hasNext()) {
			com.popultrade.model.Galerija nj = (com.popultrade.model.Galerija)it.next();
			
			
			%>
			
			<table border="0" cellspacing="2" background="bole.gif"  style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="495"  id="AutoNumber1" cellpadding="2">
			
			<tr  ><td  width=105 rowspan=2 valign=top>
			
			<a href="index.jsp?includee=galerija_detalj.jsp?id=<%=nj.getId()%>">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika1()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>
			</td><td  height=30 align=left valign=top><font color="8c2705" size=2><b><%=nul.jeNull(nj.getNaslov_galerije())%></b></font>
			<br>
			<%=nul.cutString(nj.getOpis_galerije(),250)%>
			
			</td></tr>
			
			<tr><td  align=right><font  size=1>&nbsp;</font><a href="index.jsp?includee=galerija_detalj.jsp?id=<%=nj.getId()%>"><img src="moree.gif" border=0></a></td></tr>
			
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			
				</table>
			<%
			
		//	break;
			}
			%>
			
		

		</td>
		</tr>
	<tr><td height=50 colspan=3 background="rezback.gif" width=480><font color="8c2705" size=3><b></b></font></td></tr>
		
</table>


<%

}
catch (Exception ex) {
System.out.println(ex.toString());
}

%>