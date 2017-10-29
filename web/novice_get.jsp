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


<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="475"  id="AutoNumber1" cellpadding="5">
		
		
		<%
				 
		 com.popultrade.dao.NoviceDAO daol = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
		List lil = daol.getNovice1(request.getParameter("idd"));

		Iterator itti = lil.iterator();


		while (itti.hasNext()) {
			com.popultrade.model.Novice nj = (com.popultrade.model.Novice)itti.next();
			
		
//		System.out.println("+++++++++++++++++++++++++++++++ ::: "+nj.length);
		
		
		%>
		<tr><td>
		<div style="position:relative; top:294;left:10"><font size=4 color="black"><b><%=nul.jeNull(nj.getNaslov_novice())%></b></font></div>
		<%
		if (nj.getUploads()!=null && nj.getUploads().getSlika1()!=null) {
		%>
			<a href="index.jsp?includee=novice_p.jsp?id=<%=nj.getId()%>" style="text-decoration:none"><img src="<%=control.lokacijaslika+nj.getId()+"/"+ nj.getUploads().getSlika2()%>" width=475 height=300 border="2" style="border-color:b9b9b9">
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

		
		%>
</table>





