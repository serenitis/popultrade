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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}


if (nul.jeNull(request.getParameter("slik"))!=null) {

session.setAttribute("slik", request.getParameter("slik"));
}
else {
session.setAttribute("slik","");
}








%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {

//parent.frames[2].location="nic.jsp";
}
</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">

<table border="0" width="100%" id="table1" height="100%"  bgcolor=#C3E1FC cellspacing=8	>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="0" width="100%" id="table2" height="100%"  cellpadding=5>
			<tr>
				<td bgcolor="#E3F1FE" align="center">
				<table border="0" id="table3" style="font-family: Verdana; font-size: 8pt" cellpadding="3" width="404" cellspacing="1">
				<form ENCTYPE="multipart/form-data" METHOD="POST" ACTION="m_upload22.jsp?slik=<%=nul.jeNull(request.getParameter("slik"))%>">
				
					<tr>
						<td bgcolor="#C3E1FC" colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td bgcolor="#C3E1FC" align="right">
						<p align="center">Izberi sliko za upload v default:</td>
						<td align="left" bgcolor="#A8D3FB"><input TYPE="FILE" NAME="fupload"  style="font-family: Verdana; font-size: 8pt">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" bgcolor="#C3E1FC" align="center">
						<input TYPE="submit" VALUE="Upload sliko"  style="font-family: Verdana; font-size: 8pt">&nbsp;</td>
					</tr>
				</form></table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>

</html>

 
 
 

