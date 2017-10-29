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
//Hashtable pre = control.getPrevodi(con,"nar_popultrade","narb_popultrade");


//////// dobim obvestila za dolocen company ter vsa, ki niso vezana na company


com.popultrade.dao.ObvestilaDAO dao = (com.popultrade.dao.ObvestilaDAO)contextUtil.getBeanDao("obvestilaDAO",pageContext.getServletContext());
 

com.popultrade.model.Obvestila sif = dao.getObvestila(new Long(request.getParameter("id")));

%>











<html><script>
//// spodaj nic.jsp

function chg() {
parent.frames[2].location="nic.jsp";
}


function godown(idd) {

parent.frames[1].location = "news_detail.jsp?id="+idd;
return false;
}
</script>
	<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" background="podlaga.jpg" bgproperties="fixed" onload="chg()">
<form name=bbbb action="printhtml.jsp" method=post target="_blank">
<input type=hidden name="oekupec" value="ATNET-OE KOPER">
<input type=hidden name="stevilka_narocila" value="3830034580011-A0001861">
<table width=100% cellspacing=1 cellpadding=1  style="border-collapse: collapse; font-family: Verdana; font-size: 8pt">

<tr ><td bgcolor="#EFEFEF" colspan="3">&nbsp;</td></tr>

<%
if (sif!=null) {
%>

<tr ><td width="2%" bgcolor="#EFEFEF"><img alt="" src="pointer.gif"/></td>
	<td width="11%" bgcolor="#C3E1FC" align="center"><a href="" onclick="return godown('<%=nul.jeNull(sif.getId()+"")%>')">
	<span style="text-decoration: none; font-weight: 700"><font color="#000000"><%=nul.getDatumFormatFromDate(sif.getDatkre(),"dd-MM-yyyy")%></font></span></td>
	<td width="87%" bgcolor="#E3F1FE"><a href="#" onclick="return godown('<%=nul.jeNull(sif.getId()+"")%>')">
	<span style="text-decoration: none; "><font color="#000000"><%=nul.jeNull(sif.getNaslov_tekst())%></font></span></td>
	</tr>
      <tr ><td width="100%" bgcolor="#EFEFEF" colspan="3">&nbsp;</td>
	</tr>

<tr ><td width="2%" bgcolor="#EFEFEF">&nbsp;</td>
	<td width="98%" bgcolor="#E3F1FE"  colspan="2">
	<table border="0" cellpadding="4" cellspacing="0" width="100%" height="100%" id="table1" style="font-family: Verdana; font-size: 8pt">
		<tr>
			<td align="center"><%=nul.jeNull(sif.getVsebina_tekst()).replaceAll("<p align=\"left\">","<p align='center'>")%></td>
		</tr>
	</table>
	</td>
	</tr>
<%
}
%>





<tr ><td bgcolor="#EFEFEF" colspan="3">&nbsp;</td></tr>

</table></form></body></html>
  </body></html>




<%
}
catch (Exception ex) {
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>
