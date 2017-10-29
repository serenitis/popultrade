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



		
	
		<%
		
		
		/// opis in naslov
		 com.popultrade.dao.GalerijaDAO damg = (com.popultrade.dao.GalerijaDAO)contextUtil.getBeanDao("galerijaDAO",pageContext.getServletContext());
		com.popultrade.model.Galerija galerija = damg.getGalerija(new Long(request.getParameter("id")));
				 
		 com.popultrade.dao.Galerija_slikeDAO dam = (com.popultrade.dao.Galerija_slikeDAO)contextUtil.getBeanDao("galerija_slikeDAO",pageContext.getServletContext());
		List l = dam.getGalerija_slikeById(request.getParameter("id"));

		Iterator it = l.iterator();

%>
	<table border="0" cellspacing="1"   style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#d3d3d3" width="480"  id="AutoNumber1" cellpadding="5">
			
	
		<tr><td height=50  background="rezback.gif" width=480><font color="8c2705" size=3><b><%=nul.jeNull(galerija.getNaslov_galerije())%></b></font></td></tr>
		
<tr><td>

<table border="0" cellspacing="2" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="495"  id="AutoNumber1" cellpadding="2">

		
			
			<tr><td colspan=4 background="bole.gif" ><font  size=1><%=nul.jeNull(galerija.getOpis_galerije())%></font></td></tr>
			<tr><td colspan=4 ><font  size=1>&nbsp;</font></td></tr>
<%
		while (it.hasNext()) {
			com.popultrade.model.Galerija_slike nj = (com.popultrade.model.Galerija_slike)it.next();
			
			
			%>
			
			
			
			<tr>
			<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika1()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika2() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika1()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
					<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika3()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika4() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika3()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
						<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika5()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika6() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika5()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
					<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika7()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika8() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika7()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
			</tr>
			
			
			
			
			
			
			
			
						<tr>
			<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika9()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika10() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika9()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
					<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika11()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika12() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika11()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
						<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika13()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika14() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika13()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
					<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika15()).equals("")) {
			%><a href="Javascript: op('<%=control.lokacijaslika + nj.getId() + "/" +nj.getUploads().getSlika16() %>')">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika15()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		<%
		}
		%>
			</td>
			</tr>
			
			
			
			
			
			
			<%
			
		//	break;
			}

%>

<%
//// video gal

			 
		 com.popultrade.dao.Galerija_videoDAO damm = (com.popultrade.dao.Galerija_videoDAO)contextUtil.getBeanDao("galerija_videoDAO",pageContext.getServletContext());
		l = damm.getGalerija_videoById(request.getParameter("id"));

		it = l.iterator();
		
		if (l.size()>0) {
		%>
		<tr><td height=20   width=480 colspan=4><font color="8c2705" size=3><b>&nbsp;</b></font></td></tr>
		<tr><td height=30  background="rezback.gif" width=480 colspan=4><font color="8c2705" size=3><b>Video galerija</b></font></td></tr>
		<tr><td height=10   width=480 colspan=4><font color="8c2705" size=3><b>&nbsp;</b></font></td></tr>
		<%
		}
int in = 0;
while (it.hasNext()) {
	com.popultrade.model.Galerija_video nj = (com.popultrade.model.Galerija_video)it.next();
	
if (in==0) {
	%>
	<tr>
	<%
}
in++;
%>	
				
			<td align=left valign=middle width="25%">
			<%
			if (nj.getUploads()!=null && !nul.jeNull(nj.getUploads().getSlika1()).equals("")) {
			%><a href="#" onClick="window.open('video_view.jsp?id=<%=nj.getId()%>','mywindow','width=495,height=370,left=0,top=100,toolbar=no,location=no,directories=no,status=no,menubar=no')">
<img src="<%="video/s"+nj.getId()+"/"+ nj.getUploads().getSlika2()%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>		


<%



		}
		%>
			</td>
	
	
	<%
	if (in==4) {
		%>
		</tr>
		<%
		in=0;
	}

}
boolean not = true;
while (in<=4) {
in++;
	%>
	<td></td>
	<%
	not = false;
}
if (!not) {
	%>
	</tr>
	<%
}

			%>
			<tr><td height=10   width=480 colspan=4><font color="8c2705" size=3><b>&nbsp;</b></font></td></tr>
		
			</table>

		</td>
		</tr>
	<tr><td height=50 colspan=3 align=center background="rezback.gif" width=480><a href="Javascript: history.go(-1)"><img src="back.gif" border=0></a></td></tr>
		
</table>


<%

}
catch (Exception ex) {
System.out.println(ex.toString());
}

%>