<%@ page contentType="text/html; charset=windows-1250" %>
<html>
<head>
<title>

</title>

<script language="javascript">
function gom() {
document.location = "<%=request.getParameter("lokacijaa").replaceAll("QUE","?").replaceAll("AND","&")%>";

}
</script>
</head>
<body  background="podlaga.jpg" bgproperties="fixed" onload="gom()">
<table width="100%" height="100%">
<tr><td align="center" valign="middle"><img alt="" src="loadingg.gif"/></td>
</tr>
</table>
</body>
</html>
