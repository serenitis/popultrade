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
%>

<style type=text/css>

@import "barve.css";

</style>

<script language='javascript' src='colors.js' ></script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">


<jsp:include page="glavast.jsp"/>
<%
 
//get list from daoobject
com.popultrade.dao.GlavnaStatistikaDAO dao = (com.popultrade.dao.GlavnaStatistikaDAO)contextUtil.getBeanDao("glavnaStatistikaDAO",pageContext.getServletContext());
 
 
//if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	//dao.removeGlavnaStatistika(new Long(request.getParameter("id")));
 
	
//}
com.popultrade.model.GlavnaStatistika sif = new com.popultrade.model.GlavnaStatistika();
 
List lis =null;
 




    String query;
String sifra="";
//String dan="";
String imestatistike="";
String kategorijastatistike = "";

ResultSet rs=null;

String a = "1";
String b="100";

if (request.getParameter("a")!=null && !request.getParameter("a").equals("")) {
a = request.getParameter("a");
}
if (request.getParameter("b")!=null && !request.getParameter("b").equals("")) {
b = request.getParameter("b");
}


String datem = "";

  try {


int ins=0;
if (request.getParameter("sifraa")!=null && !request.getParameter("sifraa").equals("")) {
/*
query = "select * from glavna_statistika where sifra='"+request.getParameter("sifraa")+"' "+datem+" order by datum desc  limit "+a+"," + b;
String count = "select count(*) from glavna_statistika where sifra='"+request.getParameter("sifraa")+"' "+datem+" order by datum desc";

System.out.println(query);*/

lis = dao.getGlavnaStatistikas(sif,request,Integer.parseInt(a),100);

       
                ins = lis.size();
       



%>




 <table cellspacing=1 cellpadding=2 width=100% style="font-family: Verdana; font-size: 10px; border-collapse: collapse" bordercolor="#111111">
 <tr><td colspan=11 bgcolor="#646D87" align=center><b><font color=white><%=request.getParameter("imee")%></font></b></td></tr>


<tr>

<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080" size="1">Datum-obiska </font></b>
</td>
<font size="1" style="font-size: 9pt">
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">IP </font></b>
</td>
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">Drzava </font></b>
</td>
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">Kljucne besede </font></b>
</td>
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">Referrer </font></b>
</td>
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">Cas </font></b>
</td>
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">Resolucija </font></b>
</td>
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">Operativni sis. </font></b>
</td>
<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080">Col. </font></b>
</td>

<td bgcolor="#E8E8E8" align="center">
<b><font color="#000080" size="1">Browser </font></b>
</td>


</tr>


<%
String en="";
String[] colo={"plava1","plava2"};
int k = 0;

Iterator it = lis.iterator();

while (it.hasNext()) {
	
	com.popultrade.model.GlavnaStatistika gla = (com.popultrade.model.GlavnaStatistika)it.next();
%>
<%
if (k==1) {
k=0;
}
else {
k=1;
}

%>
<tr class="<%=colo[k]%>">

<td>
<%=nul.getDatumFormatFromDate(gla.getDatum(),"dd-MM-yyyy HH:mm")%>
</td>
<td >
<%=nul.jeNull(gla.getIpresolv())%>
</td>
<td align="center" >


<%
if (gla.getDrzava()!=null && gla.getDrzava().indexOf("-")!=-1) {
en = gla.getDrzava().substring(0,gla.getDrzava().indexOf("-"));
%>
<img src="flags/<%=en.toLowerCase()%>.gif" border="0" alt="<%=gla.getDrzava()%>">
<%

}
else {
%>
<%=gla.getDrzava()%>
<%
}
%>

</td>
<td>
<%=nul.cutString(nul.jeNull(gla.getKljubesede()),25)%>
</td>
<td><a href="<%=nul.jeNull(gla.getReferel())%>" target="_blank" style="text-decoration: none">
<%=nul.cutString(nul.jeNull(gla.getReferel()),55)%></a>
</td>
<td>
<%=nul.jeNull(gla.getCasnastrani()+"")%>
</td>
<td >
<%=nul.jeNull(gla.getResolucija())%>
</td>
<td>
<%=nul.jeNull(gla.getOs())%>
</td>
<td >
<%=nul.jeNull(gla.getColor())%>
</td>
<td >
<%=nul.jeNull(gla.getBrowser())%>
</td>


</tr>


<%
}
%>




<%



}

%>
</table>

 <table cellspacing=1 cellpadding=1  style="border-collapse: collapse; font-family: Verdana; font-size: 7pt" >
<tr>

<%



int mod = ins%100;

int vse = ins/100;
int stem = 0;
String dod = "";
if (request.getParameter("leto")!=null && request.getParameter("mesec")!=null && request.getParameter("dan")!=null) {
dod = "&leto="+request.getParameter("leto")+"&mesec="+request.getParameter("mesec")+"&dan="+request.getParameter("dan");
}


if (ins > 100) {
%>
<td bgcolor=767F97>Stevilo obiskov: <%=ins%>&nbsp;</td>
<%
int last=0;
for (int d = 0; d<vse;d++) {
stem++;
if ((d*100) != ins) {
	last++;
%>

<td bgcolor=EFEFEF><a href="imenakatego.jsp?a=<%=d%>&b=<%=100%>&kategorija=<%=request.getParameter("kategorija")%>&sifraa=<%=request.getParameter("sifraa")%>&imee=<%=request.getParameter("imee")%><%=dod%>"><%=d+1%></a></td>
<%
if (stem==30) {
  stem=0;
%>
</tr><tr><td></td>
<%
}
}
}
if (mod !=0) {
%>


<td bgcolor=EFEFEF colspan="<%=vse-35%>"><a href="imenakatego.jsp?a=<%=(last+1)%>&b=100&kategorija=<%=request.getParameter("kategorija")%>&sifraa=<%=request.getParameter("sifraa")%>&imee=<%=request.getParameter("imee")%><%=dod%>"><%=vse+1%></a></td>
<%
}
%>
</tr>
</table>
<%
}

%>






</body></html>				<%
}
catch (Exception ex) {
System.out.println(ex.toString());
}



%>