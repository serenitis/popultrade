<%@ page contentType="text/html; charset=utf-8" import="java.sql.*, java.util.*, java.io.*"%>
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool" />
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<body style="font-family: Arial; font-size: 8pt"  bgcolor=E5F1FF>

<%

boolean bol;

String ipp = request.getRemoteAddr();

System.out.println("IPPPPPPPPPP ::: "+ipp);


if (!control.getPravica()) {
System.out.println("s");
// dobim geslo in uporabnika
String user = request.getParameter("user").toUpperCase();
String password = request.getParameter("password").toUpperCase();



if (control.kontrola(user,password,contextUtil,pageContext.getServletContext(),request,ConPool)) {
if (control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="index.jsp"/><%
}
else {
	control.setUser(contextUtil,pageContext.getServletContext());
	%><jsp:forward page="index.jsp"/><%
}
}


else {

	if (control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="index.jsp"/><%
	}
	else {
		control.setUser(contextUtil,pageContext.getServletContext());
		%><jsp:forward page="index.jsp"/><%
	}
}
}



else {

	if (control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="index.jsp"/><%

	}
	else {
		control.setUser(contextUtil,pageContext.getServletContext());
		%><jsp:forward page="index.jsp"/><%
	}


}
%>
