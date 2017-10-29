<%@ page contentType="text/html; charset=utf-8" %>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<html>
<head>
<title>

</title>
</head>
<script language="javascript">


function xx() {
<%
if (!control.getUser().equals("anonymous") && !control.getUser().equals("") &&   !control.getPrivilegijeUporabnika().equals("A") ) {
%>
top.window.hideFrame();
<%
}
%>
}
history.forward();

</script>
<body  background="podglaga.jpg" bgproperties="fixed" onload="xx()">
<a href="#" idd="overlaylaunch-inAbox" onclick="top.clickove2('m_loginu2.html')">Launch It 2!</a>
</body>
</html>
