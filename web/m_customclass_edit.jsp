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
com.popultrade.model.TemplateCustomClass vseb =new com.popultrade.model.TemplateCustomClass();
com.popultrade.dao.TemplateCustomClassDAO dao = (com.popultrade.dao.TemplateCustomClassDAO)contextUtil.getBeanDao("templateCustomClassDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateCustomClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateCustomClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	
	
 
vseb = (com.popultrade.model.TemplateCustomClass)contextUtil.getPopulatedObject(vseb,request);



dao.saveTemplateCustomClass(vseb);






 
}
}
 
Hashtable ht =new Hashtable();


ht.put("class name","class_name");
ht.put("clasa","classv");


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
 
<form name=dod action="m_customclass_edit.jsp" method="post" onSubmit="return check()">
 
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
            		  
            		 <td class="opiscell" width="20%">Class name: </td><td class="valuecell" width="30%">
            		 
            		  <input type="text" name="class_name" value="<%=nul.jeNull(vseb.getClass_name())%>" size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%"> </td><td class="valuecell" width="30%">
            		
            		  </tr>
 
 
 
 <tr>
            		  
            		 <td class="opiscell">Class (vnese se claso ki se doda v jsp pod %! <br>sintaksa: public [ime clase] {[vsebina]}  <br> vsi elementi v clasi morajo imeti set in get metode ):</td>
            
            		 
            		 <td class="opiscell" colspan=3>
            		 <textarea name="classv" cols=200 rows=20 style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getClassv()) %></textarea>
            		 
            		  </td>
            		 
            		  </tr>
 
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 










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