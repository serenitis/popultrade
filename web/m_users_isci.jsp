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

 %>

<html><head></head>
<script language='javascript' src='popcalendar.js' ></script>
<script language='javascript' src='replace.js'></script>
<script language='javascript' src='datum.js' ></script>
<script language="javascript">






</script>

<body topmargin="0" leftmargin="0" background="podlaga.jpg" bgproperties="fixed">

<form name="dod" method="post" action="m_users.jsp" target="prva" onSubjmit="return subm()">
<input type="hidden" name="isci" value="yes">

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">

  <tr>

    <td bgcolor="#C3E1FC" colspan="4">&nbsp;</td>
  </tr>


  <tr>
    <td width="20%" bgcolor="#C3E1FC">Username:</td>
    <td align="left" bgcolor="#E3F1FE" width="30%">

    <input type="text" name="username" value=""  size="28" style="font-family: Verdana; font-size: 8pt">
    
    </td>
    <td align="left" bgcolor="#C3E1FC" width="20%">

    </td>
    <td align="left" bgcolor="#E3F1FE" width="30%">
   </td>
 
  </tr>

  <tr>
    <td width="100%" colspan="4" align="right" bgcolor="#C3E1FC">
	<p align="center"><input  type=button value="Reset" style="font-family: Verdana; font-size: 8pt"> <input type=submit value="ISCI" style="font-family: Verdana; font-size: 8pt">
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