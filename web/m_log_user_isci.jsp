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
	com.popultrade.model.Wse_prijave vseb =new com.popultrade.model.Wse_prijave();
	com.popultrade.dao.Wse_prijaveDAO dao = (com.popultrade.dao.Wse_prijaveDAO)contextUtil.getBeanDao("wse_prijaveDAO",pageContext.getServletContext());
	
	if (session.getAttribute("wse_prijave_search")!=null) {
		vseb = (com.popultrade.model.Wse_prijave)session.getAttribute("wse_prijave_search");
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


dp_ca1 = new Epoch('epoch_popup','popup',document.dod.datum_odjave1);
 
dp_ca0 = new Epoch('epoch_popup','popup',document.dod.datum_odjave2);
 
dp_ca2 = new Epoch('epoch_popup','popup',document.dod.datum_prijave1);
 
dp_ca3 = new Epoch('epoch_popup','popup',document.dod.datum_prijave2);
 

}


</script>

<body topmargin="0" leftmargin="0" background="podlaga.jpg" bgproperties="fixed" onLoad="chg()">

<form name="dod" method="post" action="m_log_user.jsp" target="prva" onSubjmit="return subm()">
<input type="hidden" name="isci" value="yes">

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">

  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Username:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="username" value="<%=nul.jeNull(vseb.getUsername())%>"  size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    IP:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

      		<input type="text" name="ip"  value="<%=nul.jeNull(vseb.getIp())%>"  size="16" style="font-family: Verdana; font-size: 8pt"></td>
 
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Datum prijave od:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="datum_prijave1" value="<%=nul.getDatumFormatFromDate(vseb.getDatum_prijave1(),"dd-MM-yyyy")%>"  size="10" maxlength="10" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    Datum prijave do:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

      		<input type="text" name="datum_prijave2"  value="<%=nul.getDatumFormatFromDate(vseb.getDatum_prijave2(),"dd-MM-yyyy")%>"  size="10" maxlength="10"  style="font-family: Verdana; font-size: 8pt"></td>
 
  </tr>
  
  
  
  <tr>
    <td width="20%" bgcolor="#C3E1FC">Datum odjave od:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="datum_odjave1" value="<%=nul.getDatumFormatFromDate(vseb.getDatum_odjave1(),"dd-MM-yyyy")%>"  size="10" maxlength="10" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    Datum odjave do:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

      		<input type="text" name="datum_odjave2"  value="<%=nul.getDatumFormatFromDate(vseb.getDatum_odjave2(),"dd-MM-yyyy")%>"  size="10" maxlength="10"  style="font-family: Verdana; font-size: 8pt"></td>
 
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