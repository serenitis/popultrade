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

<script type="text/javascript" language="JavaScript">



</script>
 <table  border="0" width="184" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111"  id="AutoNumber1" cellpadding="0">


<tr><td>
<table border="0" width="184" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="5">
		
		
		<%
		
		//int yea = Integer.parseInt(nul.getDatumFormat("yyyy"));
		//nul.
	//	int leto = 
		
		 com.popultrade.dao.SifrantiDAO sezd =(com.popultrade.dao.SifrantiDAO)contextUtil.getBeanDao("sifrantiDAO",pageContext.getServletContext());
			
		
		com.popultrade.model.Sifranti sifra = sezd.getLastSezona();
		
		
				int max = 1; 
		 com.popultrade.dao.PlayersSezonaDAO daol = (com.popultrade.dao.PlayersSezonaDAO)contextUtil.getBeanDao("playersSezonaDAO",pageContext.getServletContext());
	
		int imo=1;
	
		
			List lil = daol.getPlayersSezonaBySezona(sifra.getId_zap()+"");

		Iterator itti = lil.iterator();
		
			%>
		<tr><td colspan=2 align="center"><font size=4 color="d4481a" face="verdana"><b><%=nul.jeNull(sifra.getOpis())%></b></font></td></tr>
		<%
		
int yu=0;
		while (itti.hasNext()) {
			System.out.println("cast "+lil.size());
			com.popultrade.model.PlayersSezona nj = (com.popultrade.model.PlayersSezona)itti.next();
			
			
			
//		System.out.println("+++++++++++++++++++++++++++++++ ::: "+nj.length);
		
	
	if (nj.getPlayers_id()!=null && nj.getPlayers()!=null && nj.getPlayers().getName()!=null) {
	if (yu==0) {
	
	%>
	
	<tr>
	<%
	}
	yu++;
		%>
		
		
		
		
		<td align="center"><a href="index.jsp?includee=players.jsp?id=<%=nj.getPlayers().getId()%>">
		<%
		if (nj.getPlayers().getUploads()!=null && nj.getPlayers().getUploads().getSlika1()!=null) {
		%>
		
		<img title="<%=nul.jeNull(nj.getPlayers().getName())%> <%=nul.jeNull(nj.getPlayers().getSurname())%>" src="<%=control.lokacijaslika+nj.getPlayers().getId()+"/"+ nj.getPlayers().getUploads().getSlika1()%>" width=61 height=72 border="2" style="border-color:b9b9b9">
		
		<%
		}
		else {
		%>
		<img title="<%=nul.jeNull(nj.getPlayers().getName())%> <%=nul.jeNull(nj.getPlayers().getSurname())%>"  src="noimage.gif" width=61 height=72 border="2" style="border-color:b9b9b9">
		
		<%
		}
		%>
		</a>
		
		</td>
		
		<%
		if (yu==2) {
		yu=0;
		%>
		</tr>
		<%
		}
		%>
		
		
		<%
	}
	}
	
	
	
		
		%>
</table>
</td></tr>
</table>





