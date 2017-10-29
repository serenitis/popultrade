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
	com.popultrade.model.Ladja vseb =new com.popultrade.model.Ladja();
	com.popultrade.dao.LadjaDAO dao = (com.popultrade.dao.LadjaDAO)contextUtil.getBeanDao("ladjaDAO",pageContext.getServletContext());
	
	if (session.getAttribute("ladja_search")!=null) {
		vseb = (com.popultrade.model.Ladja)session.getAttribute("ladja_search");
	}
	
 %>

<html><head></head>
<script language='javascript' src='popcalendar.js' ></script>
<script language='javascript' src='replace.js'></script>
<script language='javascript' src='datum.js' ></script>
<script language="javascript">






</script>

<body topmargin="0" leftmargin="0" background="podlaga.jpg" bgproperties="fixed">

<form name="dod" method="post" action="m_ladja.jsp" target="prva" onSubjmit="return subm()">
<input type="hidden" name="isci" value="yes">

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">

  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Sifra:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="LADJA" value="<%=nul.jeNull(vseb.getLADJA())%>"  size="4" maxlength="4" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    Ime:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

      		<input type="text" name="IMELAD"  value="<%=nul.jeNull(vseb.getIMELAD())%>"  size="35" style="font-family: Verdana; font-size: 8pt"></td>
 
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Ladjar:&nbsp;</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">
			<select name="LDR_OZNLADJAR" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					
					
							
							<%
            				com.popultrade.dao.LadjarDAO daosi = (com.popultrade.dao.LadjarDAO)contextUtil.getBeanDao("ladjarDAO",pageContext.getServletContext());
					List lil = daosi.getLadjars(new com.popultrade.model.Ladjar());

					Iterator itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Ladjar sifr = (com.popultrade.model.Ladjar)itti.next();
						if (nul.jeNull(vseb.getLDR_OZNLADJAR()).equals(nul.jeNull(sifr.getOZNLADJAR()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getOZNLADJAR())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getOZNLADJAR())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
							<%
						}
					}
					%>
					
					
					
					</select>
    &nbsp;</td>
    <td align="left" bgcolor="#C3E1FC" width="20%">
Drzava:
    &nbsp;</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">
	 	<select name="DZV_OZNDRZ" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		 					<%
            				com.popultrade.dao.DrzavaDAO daosd = (com.popultrade.dao.DrzavaDAO)contextUtil.getBeanDao("drzavaDAO",pageContext.getServletContext());
					List lild = daosd.getDrzavas(new com.popultrade.model.Drzava());

					Iterator ittd = lild.iterator();

					while (ittd.hasNext()) {
						com.popultrade.model.Drzava sifr = (com.popultrade.model.Drzava)ittd.next();
						if (nul.jeNull(vseb.getDZV_OZNDRZ()).equals(nul.jeNull(sifr.getOZNDRZ()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getOZNDRZ())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getOZNDRZ())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
							<%
						}
					}
					%>
            		 </select>
      		&nbsp;</td>
 
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