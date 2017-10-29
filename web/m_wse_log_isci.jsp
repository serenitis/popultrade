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


if (!control.getPravica()) {
%><jsp:forward page="m_logout.jsp"/><%
}


try {
	com.popultrade.model.Wse_log_pozicije vseb =new com.popultrade.model.Wse_log_pozicije();
	com.popultrade.dao.Wse_log_pozicijeDAO dao = (com.popultrade.dao.Wse_log_pozicijeDAO)contextUtil.getBeanDao("wse_log_pozicijeDAO",pageContext.getServletContext());
	com.popultrade.model.Wse_log vsebl =new com.popultrade.model.Wse_log();
	if (session.getAttribute("wse_log_pozicije_search")!=null) {
		vseb = (com.popultrade.model.Wse_log_pozicije)session.getAttribute("wse_log_pozicije_search");
	}
	if (session.getAttribute("wse_log_search")!=null) {
		vsebl = (com.popultrade.model.Wse_log)session.getAttribute("wse_log_search");
	}
	
 %>

<html><head></head>
<script language='javascript' src='popcalendar.js' ></script>
<script language='javascript' src='replace.js'></script>
<script language='javascript' src='datum.js' ></script>

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>

<script language="javascript">



function chg() {


parent.frames[3].location = "nic.jsp";


dp_ca1 = new Epoch('epoch_popup','popup',document.dod.datum_ura1);
 
dp_ca0 = new Epoch('epoch_popup','popup',document.dod.datum_ura2);
 


}


</script>

<body topmargin="0" leftmargin="0" background="podlaga.jpg" bgproperties="fixed" onLoad="chg()">

<form name="dod" method="post" action="m_wse_log.jsp" target="prva" onSubjmit="return subm()">
<input type="hidden" name="isci" value="yes">

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">

  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Tekst v glavi:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="opis" value="<%=nul.jeNull(vsebl.getOpis())%>"  size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    Tekst v postavkah:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

      		<input type="text" name="tekst"  value="<%=nul.jeNull(vseb.getTekst())%>"  size="16" style="font-family: Verdana; font-size: 8pt"></td>
 
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Datum od:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="datum_ura1" value="<%=nul.getDatumFormatFromDate(vseb.getDatum_ura1(),"dd-MM-yyyy")%>"  size="10" maxlength="10" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    Datum do:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

      		<input type="text" name="datum_ura2"  value="<%=nul.getDatumFormatFromDate(vseb.getDatum_ura2(),"dd-MM-yyyy")%>"  size="10" maxlength="10"  style="font-family: Verdana; font-size: 8pt"></td>
 
  </tr>
  
  



  <tr>
    <td width="100%" colspan="4" align="right" bgcolor="#C3E1FC">
	<p align="center"><input  type=button  value="Reset" style="font-family: Verdana; font-size: 8pt"> <input type=submit value="ISCI" style="font-family: Verdana; font-size: 8pt">
<input type=hidden name=isci value=yes></td>
  </tr>
</table>
</form>
</body></html>







<%
}
catch (Exception ex) {
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>