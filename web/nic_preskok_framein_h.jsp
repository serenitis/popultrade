<%@ page contentType="text/html; charset=windows-1250" %>
<html>
<head>
<title>

</title>

<script language="javascript">


function gom() {
	
	<%
	String okno11="";
	String okno22="";
	System.out.println(";;;;;;;;;;;;;; "+request.getParameter("lokacijaa"));
	String opi = request.getParameter("lokacijaa").substring(request.getParameter("lokacijaa").indexOf("||")+2);
	String opi0 = request.getParameter("lokacijaa").substring(0,request.getParameter("lokacijaa").indexOf("||"));
	if (opi.length()>0) {
		
		String[] kol = opi.split(":");
		okno11=kol[0].trim();
		okno22=kol[1].trim();
		
	}
	if (okno11.equals("")) {
		okno11="50";
	}
	if (okno22.equals("")) {
		okno22="50";
	}
	
	
	%>
	
	
document.location = "innerframe_h.jsp?lokacijaa=<%=opi0%>&okno11=<%=okno11%>&okno22=<%=okno22%>";

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
