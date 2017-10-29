<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,java.util.Date"  contentType="text/html; charset=utf-8"%>
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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}
 

    String query;
String sifra="";
//String dan="";
String imestatistike="";
String kategorijastatistike = "";

 



 
  try {


	  com.popultrade.dao.GlavnaStatistikaImenaDAO dao = (com.popultrade.dao.GlavnaStatistikaImenaDAO)contextUtil.getBeanDao("glavnaStatistikaImenaDAO",pageContext.getServletContext());

	

      List li = dao.getGlavnaStatistikaImenaByKategorija(request.getParameter("kategorija"));


%>



<STYLE>
   
    A{color:black; text-decoration:none;}
</STYLE>




 <table cellspacing=1 cellpadding=2 width="100%" style="font-family: Verdana; font-size: 8pt; border-collapse: collapse" bordercolor="#111111">
 <tr><td colspan=8 bgcolor="#646D87" align=center><b><font color=white><%=request.getParameter("kategorija")%></font></b></td></tr>
<tr bgcolor="">
<%
Iterator it = li.iterator();
while (it.hasNext()) {
	com.popultrade.model.GlavnaStatistikaImena sif = (com.popultrade.model.GlavnaStatistikaImena)it.next();
	
%>



<td bgcolor="#E8E8E8" width="267">
<B><a href="imenakatego.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>"><%=nul.jeNull(sif.getIme_statistike())%></a></b>
</td>
<td bgcolor="yellow" width="155" align=center>
<B><a href="podatki.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>">Obiski</a></b>
</td>

<td bgcolor="yellow" width="155" align=center>
 <B><a href="kljucne_ref.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>">Referer</a></b></td>

<td bgcolor="yellow" width="155" align=center>
  <B><a href="drzave_iz.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>">Drzave</a></b></td>

<td bgcolor="yellow" width="155" align=center>
   <B><a href="resolucija.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>">Resolucija</a></b></td>

<td bgcolor="yellow" width="156" align=center>
   <B><a href="browser.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>">Browser</a></b></td>

<td bgcolor="yellow" width="156" align=center>
   <B><a href="kljucne.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>">Kljucne besede</a></b></td>

<td bgcolor="yellow" width="156" align=center>
<!--    <B><a href="ure.jsp?kategorija=<%=nul.jeNull(sif.getKategorija_statistike())%>&sifraa=<%=nul.jeNull(sif.getSifra_statistike())%>&imee=<%=nul.jeNull(sif.getIme_statistike())%>">Obiski po urah</a></b>--></td>

</tr>
<tr>



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