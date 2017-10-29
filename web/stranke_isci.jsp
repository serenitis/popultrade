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
	com.popultrade.model.Stranke vseb =new com.popultrade.model.Stranke();
	com.popultrade.dao.StrankeDAO dao = (com.popultrade.dao.StrankeDAO)contextUtil.getBeanDao("strankeDAO",pageContext.getServletContext());
	
	if (session.getAttribute("stranke_search")!=null) {
		vseb = (com.popultrade.model.Stranke)session.getAttribute("stranke_search");
	}
	
 %>

<html><head>

<style type=text/css> 
@import "barve.css";
</style>
</head>
<script language='javascript' src='popcalendar.js' ></script>
<script language='javascript' src='replace.js'></script>
<script language='javascript' src='datum.js' ></script>


	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/ajax-dynamic-list.js"></script>
<script language='javascript'>
function chg() {


parent.frames[2].location = "nic.jsp";
}
</script>
<body topmargin="0" leftmargin="0" background="podlaga.jpg" bgproperties="fixed" onload="chg()">

<form name="dod" method="post" action="stranke.jsp" target="ifr2" onSubjmit="return subm()">
					
					
<input type="hidden" name="isci" value="yes">

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">

  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Naziv:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="naziv" value="<%=nul.jeNull(vseb.getNaziv())%>"  size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    Naslov:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

      		<input type="text" name="naslov"  value="<%=nul.jeNull(vseb.getNaslov())%>"  size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
 
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Kraj:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="kraj" value="<%=nul.jeNull(vseb.getKraj())%>"  size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
    <td align="left" bgcolor="#C3E1FC" width="20%">
Posta:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">
	 
    <input type="text" name="posta" value="<%=nul.jeNull(vseb.getPosta())%>"  size="11" maxlength="11" style="font-family: Verdana; font-size: 8pt"></td>
 
  </tr>



  <tr>
    <td width="20%" bgcolor="#C3E1FC">Drzava:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">
    
    			 			<%
						com.popultrade.model.Drzava drz = new com.popultrade.model.Drzava();
						if (!nul.jeNull(vseb.getDrzava()).equals("")) {
						com.popultrade.dao.DrzavaDAO daolz = (com.popultrade.dao.DrzavaDAO)contextUtil.getBeanDao("drzavaDAO",pageContext.getServletContext());
						
						drz = daolz.getDrzava(vseb.getDrzava());
						}
						
						%>
						
            			 <input type="text"  autocomplete="off" id="DRZAVAA" name="DRZAVAA" value="<%=nul.jeNull(drz.getNAZIV())%>" onkeyup="ajax_showOptions(this,'getCountriesByLetters',event,'list_drzav.jsp?')" style="font-family: Verdana; font-size: 8pt">
					<input type="hidden" autocomplete="off"  value="<%=nul.jeNull(vseb.getDrzava())%>" id="DRZAVAA_hidden" name="drzava">
					
	 	&nbsp;</td>
    <td align="left" bgcolor="#C3E1FC" width="20%">
ID ddv:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">
	 
    <input type="text" name="idddv" value="<%=nul.jeNull(vseb.getIdddv())%>"  size="11" maxlength="11" style="font-family: Verdana; font-size: 8pt"></td>
 
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