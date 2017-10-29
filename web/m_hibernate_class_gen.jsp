<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="antexecutor" scope="request" class="com.popultrade.webapp.AntExecutor" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}

String lok_slik = control.hibernate_classes;



try {
//ServletContext scon=pageContext.getServletContext();
//String path = scon.getRealPath(lok_slik);
//System.out.println("2222222222222");

}
catch (Exception ex) {

System.out.println("Ne moram zbrisati slike default : "+ex.toString());
}









%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {


parent.frames[3].location="nic.jsp";
}




</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">

<table border="0" width="100%" cellspacing=9 id="table1" height="100%"  bgcolor=#C3E1FC	>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="0" width="100%" id="table2" height="100%" cellspacing=3 cellpadding=5  >
			
			
			
			<tr>
				<td bgcolor="#E3F1FE" align="left" valign="middle" width="99%">
		<%=antexecutor.executeAnt(control).replaceAll("\n","<br>")%>
			</td>
		
				</tr>
			
				
			
		</table>
		</td>
	</tr>
	
		<tr>
		<td align="center" valign="middle">
		</td>
		</tr>
	
	
</table>

</body>

</html>

 
 
 

