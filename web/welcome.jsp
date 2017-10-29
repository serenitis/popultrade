<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
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



%>

<div id="template">
<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="475"  id="AutoNumber1" cellpadding="5">
		
		
		<%
				 
		 com.popultrade.dao.NoviceDAO daol = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
		List lil = daol.getNovices(new com.popultrade.model.Novice());

		Iterator itti = lil.iterator();

String nei = "";
boolean ino = false;
		while (itti.hasNext()) {
			com.popultrade.model.Novice nj = (com.popultrade.model.Novice)itti.next();
			
			if (nj.getUploads()!=null && nj.getUploads().getSlika1()!=null && !nj.getUploads().getSlika1().equals("")) {
				nei =nei + "'"+ nj.getId() + "',";
					
			}
			
//		System.out.println("+++++++++++++++++++++++++++++++ ::: "+nj.length);
		
		if (!ino && !nei.equals("")) {
		ino=true;
		%>
		<tr><td>
		<div style="position:relative; top:294;left:10"><font size=4 color="black"><b><%=nul.cutStringAddPoints(nul.jeNull(nj.getNaslov_novice()),37)%></b></font></div>
		<%
		if (nj.getUploads()!=null && nj.getUploads().getSlika1()!=null) {
		%>
		<a href="index.jsp?includee=novice_p.jsp?id=<%=nj.getId()%>" style="text-decoration:none">
		<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika2()%>" width=475 height=300 border="2" style="border-color:b9b9b9">
		</a>
		<%
		}
		else {
		%>
		<img src="noimage.gif" width=475 height=300 border="2" style="border-color:b9b9b9">
		
		<%
		}
		%>
		
		
		</td></tr>
		
		<%
		}
		
	}
	if (!nei.equals("")) {
	nei=nei.substring(0,nei.length()-1);
	}
		
		%>
</table>
</div>


<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 12pt;font-weight:bold" bordercolor="#111111" width="495"  id="AutoNumber1" cellpadding="5">
		
		<tr><td height=30 colspan=4><font size=3 color="8c2705" face="verdana"></font></td></tr>
		
		<tr><td height=25 colspan=4><font  color="8c2705" >REZULTATI</font></td></tr>
		</table>

<table border="1" background="rezback.gif" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#d3d3d3" width="475"  id="AutoNumber1" cellpadding="5">
	

		<tr bgcolor="8c2705" style="font-family: Verdana; font-size: 8pt;color:white; ">
	
	
		<td width=300>
		EKIPE
		</td>
		<td width=100 align=center>
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
		while (itt.hasNext()) {
			com.popultrade.model.Matches nj = (com.popultrade.model.Matches)itt.next();
			
		if (vecc<15) {
		vecc++;

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
	}

		
		%>
</table>



<script language="javascript">
var myy=new Array(<%=nei%>); 

</script>

<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 12pt;font-weight:bold" bordercolor="#111111" width="495"  id="AutoNumber1" cellpadding="5">
		
		<tr><td height=30 colspan=4><font size=3 color="8c2705" face="verdana"></font></td></tr>
		
		<tr><td height=20 colspan=4><font  color="8c2705" >GALERIJA SLIK</font></td></tr>
		</table>

<table border="0" cellspacing="2" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="495"  id="AutoNumber1" cellpadding="2">
		
	
		<%
		 
		 com.popultrade.dao.GalerijaDAO dam = (com.popultrade.dao.GalerijaDAO)contextUtil.getBeanDao("galerijaDAO",pageContext.getServletContext());
		List l = dam.getGalerijaShow(new com.popultrade.model.Galerija());

		Iterator it = l.iterator();

int ol = 0;
		while (it.hasNext()) {
			com.popultrade.model.Galerija nj = (com.popultrade.model.Galerija)it.next();

			
			if (ol==0) {
				%>
				<tr>
				<%
			}
			ol++;
	
			
			%>
			

			<td align=center valign=middle width="25%">
			<a href="index.jsp?includee=galerija_detalj.jsp?id=<%=nj.getId()%>">
<img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika1()%>" title="<%=nul.jeNull(nj.getNaslov_galerije())%>" width=100 height=75 border="2" style="border-color:b9b9b9">
</a>
</td>

<%
if (ol==4) {
	ol=0;
	%>
	</tr>
	<%
}
%>
			
			
			
			
			
			
			<%
			
			}
		boolean jem = false;
		while (ol<=4) {
			ol++;
			jem= true;
			
			%>
			<td></td>
			<%
			
		}
		if (jem) {
			
			%>
			</tr>
			<%
		}
			
			%>
			
			</table>















