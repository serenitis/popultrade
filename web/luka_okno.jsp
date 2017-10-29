<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>

<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
 <%


if (!control.getPravica()) {

%><jsp:forward page="logout.jsp"/><%

}




try {

%>

<html>

<head>

<title>

Port

</title>

</head>

<script language=javascript>

function loh() {


window.opener.document.dod.<%=request.getParameter("polje_baza")%>.value=document.pot.prenos.value;
ev = eval("document.pot."+document.pot.prenos.value+"")
window.opener.document.dod.<%=request.getParameter("imeu")%>.value=ev.value;

window.close();

}

function prenesi() {

document.pot.prenos.value=window.opener.document.dod.<%=request.getParameter("polje_baza")%>.value;
}

</script>

<body bgcolor="#ffffff" topmargin="0" leftmargin="0" >

<table width=100% cellspacing=1  style="border-collapse: collapse; font-family: Verdana; font-size: 8pt">

<form name=pot onSubmit="loh()">

<tr>



<td colspan="3" bgcolor="#C3E1FC"> <%=request.getParameter("ime_prikaz")%></td></tr>



                     <tr><td colspan="3" bgcolor="#E3F1FE" align="center">





                        <select name="prenos" style="font-family: Verdana; font-size: 10px; width:230" size="16">
                    <%
//////////// dobim sifrante


com.popultrade.model.Luka vseb =new com.popultrade.model.Luka();
com.popultrade.dao.LukaDAO dao = (com.popultrade.dao.LukaDAO)contextUtil.getBeanDao("lukaDAO",pageContext.getServletContext());


List lis =null;  

lis = dao.getLukaPoDrzavi(request.getParameter("drzava"));


Hashtable htt = new Hashtable();
int zap =0;
Iterator it = lis.iterator();


while (it.hasNext()){  // while start
	
	vseb = (com.popultrade.model.Luka)(it.next());

zap++;
if (request.getParameter("luka").equals(vseb.getLUKA())) {
%>
<option value="<%=vseb.getLUKA()%>" selected><%=vseb.getLUKA()%> - <%=vseb.getNAZIV()%></option>

<%
}
else {
%>
<option value="<%=vseb.getLUKA()%>"><%=vseb.getLUKA()%> - <%=vseb.getNAZIV()%></option>
<%
}
htt.put(zap+"","<input type=\"hidden\" name=\""+vseb.getLUKA()+"\" value=\""+nul.jeNull(vseb.getNAZIV())+"\">");

}
%>
</select>
<%
Enumeration en = htt.keys();

while (en.hasMoreElements()) {

%>
<%=htt.get(en.nextElement()) %>
<%
}

%>

</td>

<tr><td bgcolor="#C3E1FC" align=center>
	<input type=submit value=POTRDI style="font-family: Verdana; font-size: 10px"></td></tr>

</form></table>



</body>

</html>
<%
  }
catch (Exception ex) {
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>
