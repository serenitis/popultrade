<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="logout.jsp"/><%
}


int stvrstic = 0;


try {


//////// dobim obvestila za dolocen company ter vsa, ki niso vezana na company
com.popultrade.dao.ObvestilaDAO dao = (com.popultrade.dao.ObvestilaDAO)contextUtil.getBeanDao("obvestilaDAO",pageContext.getServletContext());
 

com.popultrade.model.Obvestila sif = new com.popultrade.model.Obvestila();


sif.setJzk_sifra_jezik(control.getJezik());
sif.setStatus("1");


List news = dao.getObvestilasp(sif,1,50);





%>











<html><script>




function godown(idd) {

top.parent.frames[1].location = "news_detail.jsp?id="+idd;
return false;
}
</script>
	<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" background="podlaga.jpg" bgproperties="fixed" onload="return chg()">
<table width=100% height=100% cellspacing=1 cellpadding=1  style="border-collapse: collapse; font-family: Verdana; font-size: 8pt">
<tr>
<td width=270 align=center valign=middle  bgcolor="#EFEFEF">
<img src="news.jpg" border=0>
</td>
<td>
<table width=100% height=100% cellspacing=1 cellpadding=1  style="border-collapse: collapse; font-family: Verdana; font-size: 8pt">

<tr ><td bgcolor="#EFEFEF" colspan="3">&nbsp;</td></tr>

<%
String firstid = "";
boolean bom = true;
int stem = 1;
String b11 = "C3E1FC";


Iterator it = news.iterator();


while (it.hasNext()) {
	
	
	com.popultrade.model.Obvestila obv = (com.popultrade.model.Obvestila)it.next();

	
if (bom) {
bom=false;

firstid=obv.getId()+"";
}
%>

<tr ><td width="1%" bgcolor="#EFEFEF"><img alt="" src="pointer.gif"/></td>
	<td width="11%" bgcolor="#C3E1FC" align="center" id="dat<%=stem%>" onclick="obarvaj('<%=stem%>','<%=nul.jeNull(obv.getId()+"")%>')"><a href="" onclick="return godown('<%=nul.jeNull(obv.getId()+"")%>')">
	<span style="text-decoration: none; font-weight: 700"><font color="#000000"><%=nul.getDatumFormatFromDate(obv.getDatkre(),"dd-MM-yyyy")%></font></span></a></td>
	<td width="87%" bgcolor="#<%=b11%>" id="nas<%=stem%>" onclick="obarvaj('<%=stem%>','<%=nul.jeNull(obv.getId()+"")%>')"><a href="#" onclick="return godown('<%=nul.jeNull(obv.getId()+"")%>')">
	<span style="text-decoration: none; "><font color="#000000"><%=nul.jeNull(obv.getNaslov_tekst())%></font></span></a></td>
	</tr>

<%
stem++;
if (b11.equals("C3E1FC")) {
b11 = "E3F1FE";
}
}

if (bom) {
%>

<tr ><td width="1%" bgcolor="#EFEFEF"><img alt="" src="pointer.gif"/></td>
	<td width="99%" bgcolor="#E3F1FE" align="center" colspan="2">
	<span style="text-decoration: none; font-weight: 700"><font color="#000000">Ni obvestil!</font></span></td>
	</tr>

<%
}

%>


<tr ><td bgcolor="#EFEFEF" colspan="3">&nbsp;</td></tr>

</table>
</td></tr></table>
<script>
//// spodaj nic.jsp
var prv = 1;
function obarvaj(tdd,idd) {
//  if (prv!=0) {
  document.getElementById("dat"+prv).style.background="C3E1FC";
  document.getElementById("nas"+prv).style.background="E3F1FE";
//  }

document.getElementById("dat"+tdd).style.background="C3E1FC";
document.getElementById("nas"+tdd).style.background="C3E1FC";
//tdd.style.background-color="red";
prv=tdd;
godown(idd);
}



function chg() {

  <%
  if (!firstid.equals("")) {
  %>
top.parent.frames[1].location="news_detail.jsp?id=<%=firstid%>";
<%
}
else {
%>
top.parent.frames[1].location="nic.jsp";
<%
}
%>


//// set dimenzij framov

<%

if (control.getFrames().containsKey("news.jsp")) {
	
	com.popultrade.webapp.FrameSizeClass fss = (com.popultrade.webapp.FrameSizeClass)control.getFrames().get("news.jsp");
	
	%>
	
	top.setSize(<%=fss.getFrame1()%>,<%=fss.getFrame2()%>,<%=fss.getFrame3()%>);
	
	<%
}

%>

return false;
}
</script>
</body></html>





<%
}
catch (Exception ex) {
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>
