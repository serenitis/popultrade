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
com.popultrade.model.TemplateMenun vseb =new com.popultrade.model.TemplateMenun();
com.popultrade.dao.TemplateMenunDAO dao = (com.popultrade.dao.TemplateMenunDAO)contextUtil.getBeanDao("templateMenunDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateMenun(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateMenun(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	
	
 
vseb = (com.popultrade.model.TemplateMenun)contextUtil.getPopulatedObject(vseb,request);


dao.saveTemplateMenun(vseb);





 
}
}
 
Hashtable ht =new Hashtable();


ht.put("name","name");


//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%>
 
<html><head><title>spreminjaj</title></head>
 
<style type=text/css> 
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
 
 
 
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="m_templatemenun_edit.jsp" method="post" onSubmit="return check()">
 
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


if (nul.jeNull(request.getParameter("isk")).equals("1")) {
	%>
	<input type=hidden name="isk" value="1">
	<%
}
%>
 
 
 
 
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
 <input type=hidden name="idback" value="<%=nul.jeNull(vseb.getId()+"")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
 
 <tr>
            		  
            		 <td class="opiscell" width="20%">Name: </td><td class="valuecell" width="30%">
            		 
            		  <input type="text" name="name" value="<%=nul.jeNull(vseb.getName())%>" size="35" maxlength="70" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Description: </td><td class="valuecell" width="30%">
            		 
            		   <input type="text" name="description" value="<%=nul.jeNull(vseb.getDescription())%>" size="70" maxlength="450" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr>
 
 
 
 
 
 
 
 
 
 
 
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 


function oznaci_vse(idgl) {

all = eval("document.dod.cb_0_"+idgl);
for (i=0; i<document.dod.elements.length; i++) {


if (document.dod.elements[i].name.indexOf("cb_"+idgl)!=-1) {
if (all.checked==true) {
document.dod.elements[i].checked=true;
}
else if (all.checked==false) {
document.dod.elements[i].checked=false;
}

}


//document.write("The field name is: " + document.FormName.elements[i].name + " and its value is: " + document.FormName.elements[i].value + ".<br />");


}

}







function custom() {
 
 
 return true;
}
function mom() {
parent.frames[3].location = "nic.jsp";
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
function mom() {
}
parent.frames[0].document.location = parent.frames[0].document.location;
var mon = parent.frames[1].document.location+"";
<%

String iskk= "''";
if (nul.jeNull(request.getParameter("isk")).equals("1")) {
	 iskk= "&isk=1";
}

if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
 
  parent.frames[1].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%><%=iskk%>";
 
 
}
  else {
     if (mon.indexOf("?")!=-1) {
parent.frames[1].document.location = parent.frames[1].document.location + "&idback=<%=request.getParameter("id")%><%=iskk%>";
     }
     else {
     parent.frames[1].document.location = parent.frames[1].document.location + "?idback=<%=request.getParameter("id")%><%=iskk%>";
 
     }
}
<%
}
else {
%>
parent.frames[1].document.location = parent.frames[1].document.location+<%=iskk%>;
<%
}
%>
</script>
 
<%
}
 
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>