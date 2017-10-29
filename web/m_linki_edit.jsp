<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}
%>
 
<%
try {
boolean bok=false;
com.popultrade.model.Linki vseb =new com.popultrade.model.Linki();
com.popultrade.dao.LinkiDAO dao = (com.popultrade.dao.LinkiDAO)contextUtil.getBeanDao("linkiDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getLinki(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getLinki(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
 
vseb = (com.popultrade.model.Linki)contextUtil.getPopulatedObject(vseb,request);
dao.saveLinki(vseb);
 
}
}
 
Hashtable ht =new Hashtable();
ht.put("link","link");
Hashtable htn =new Hashtable();
htn.put("kolicina","kol_kg");
	htn.put("zaporedje","zaporedje");
%>
 
<html><head><title>spreminjaj</title></head>
 
<style type=text/css> 
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
 
 
 
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %>
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body  topmargin="0" leftmargin="0" onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="m_linki_edit.jsp" method="post" onSubmit="return check()">
 
<%
if (vseb.getId()!=null && !vseb.getId().equals("")) {
%>
<input type=hidden name="akcija" value="UPDATE">
<%
}
else {
	%>
	<input type=hidden name="akcija" value="NEW">
	<%	
}
%>
 
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
 
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
 
            		  <tr>
            		   <td class="opiscell">Link: </td><td class="valuecell">
            		 
            		 <input type="text" name="link" maxlength='100' value="<%=nul.jeNull(vseb.getLink()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
              		 <td class="opiscell">Link opis: </td><td class="valuecell">
              		 
 					<textarea rows="6" cols="47"  name="link_opis"   style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getLink_opis()+"")%></textarea>&nbsp;
 
 					
 					</td>
              		 
            		
            		 
        		  </tr><tr>
        		  
         		 <td class="opiscell">Zaporedje: </td><td class="valuecell" colspan=3>
         		
         		 <input type="text" name="zaporedje" maxlength='7' value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
         		
         		 
         		 </td>
         		 
 
 </tr>
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 
function custom() {
 
 
 return true;
}
function mom() {
<%
if (request.getParameter("akcija")==null) {
%>
 
 
 
<%
}
%>
}
</script>
<%
}
 
else {
%>
 
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">PODATKI VNESENI/SPREMENJENI</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
 
<script language=javascript> 
var mon = parent.frames[1].document.location+"";
<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
 
  parent.frames[1].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("idback")%>";
 
 
}
  else {
     if (mon.indexOf("?")!=-1) {
parent.frames[1].document.location = parent.frames[1].document.location + "&idback=<%=request.getParameter("idback")%>";
     }
     else {
     parent.frames[1].document.location = parent.frames[1].document.location + "?idback=<%=request.getParameter("idback")%>";
 
     }
}
<%
}
else {
%>
parent.frames[1].document.location = parent.frames[1].document.location;
<%
}
%>
</script>
 
<%
}
 
}
catch (Exception ex){
System.out.println("Users: "+ex.toString());
}
%>
 

	
