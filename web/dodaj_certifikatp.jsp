<%@ page contentType="text/html; charset=windows-1250" %>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<%
request.setCharacterEncoding("windows-1250");

if (control.getPravica()) {

%>


<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {

parent.frames[2].location="nic.jsp";
}
</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">

<table border="1" width="100%" id="table1" height="100%" style="border-collapse: collapse" bgcolor=#C3E1FC	>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="1" width="98%" id="table2" height="92%" bordercolor="#FFFFFF" style="border-collapse: collapse">
			<tr>
				<td bgcolor="#E3F1FE" align="center">
				<table border="0" id="table3" style="font-family: Verdana; font-size: 8pt" cellpadding="3" width="404" cellspacing="1"><form ENCTYPE="multipart/form-data" METHOD="POST" ACTION="dodaj_certifikat2p.jsp">
					<tr>
						<td bgcolor="#C3E1FC" colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td bgcolor="#C3E1FC" align="right">
						<p align="center">Izberite privaten kljuc:</td>
						<td align="left" bgcolor="#A8D3FB"><input TYPE="FILE" NAME="fupload"  style="font-family: Verdana; font-size: 8pt">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" bgcolor="#C3E1FC" align="center">
						<input TYPE="submit" VALUE="Vnesi certifikat"  style="font-family: Verdana; font-size: 8pt">&nbsp;</td>
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
<% }%>
