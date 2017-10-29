<%@ page contentType="text/html; charset=utf-8" import="java.sql.*, java.util.*, java.io.*"%>
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool" />
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<body style="font-family: Arial; font-size: 8pt"  bgcolor=E5F1FF>

<%
try {
boolean bol;

String ipp = request.getRemoteAddr();

System.out.println("IPPPPPPPPPP ::: "+ipp);
String naprej = control.prvi_page;
String error = "";
if (request.getParameter("forw")!=null && !request.getParameter("forw").equals("")) {
naprej = request.getParameter("forw");
}
if (request.getParameter("nlo")!=null && !request.getParameter("nlo").equals("")) {
	error = request.getParameter("nlo");
}

if (!control.getPravica()) {
System.out.println("s");
// dobim geslo in uporabnika
String user = request.getParameter("user").toUpperCase();
String password = request.getParameter("password").toUpperCase();



if (control.kontrola(user,password,contextUtil,pageContext.getServletContext(),request,ConPool)) {
if (control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="<%=naprej %>"/><%
}
else {
	control.setUser(contextUtil,pageContext.getServletContext());

	%><jsp:forward page="<%=error %>"/><%
}
}


else {

	if (control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="<%=naprej %>"/><%
	}
	else {
		control.setUser(contextUtil,pageContext.getServletContext());

		%><jsp:forward page="<%=error %>"/><%
	}
}
}



else {

	if (control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="<%=naprej %>"/><%

	}
	else {
		control.setUser(contextUtil,pageContext.getServletContext());

		%><jsp:forward page="<%=error %>"/><%
	}


}
}
catch (Exception em) {
	%><jsp:forward page="indexne.jsp"/><%
}
%>
