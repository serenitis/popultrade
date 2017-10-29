<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />


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
String class_name="";
session.setAttribute("glavno",request.getParameter("glavno"));


com.popultrade.model.TemplateTag vseb =new com.popultrade.model.TemplateTag();
com.popultrade.dao.TemplateTagDAO dao = (com.popultrade.dao.TemplateTagDAO)contextUtil.getBeanDao("templateTagDAO",pageContext.getServletContext());
if (request.getParameter("idv")!=null && request.getParameter("akcija")==null ) {
vseb = dao.getTemplateTagByVezaId(request.getParameter("idv"));

if (vseb==null) {
	vseb =new com.popultrade.model.TemplateTag(); 
}

}
 
else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateTagByVezaId(request.getParameter("idv"));
	
	} 
	else {
		vseb.setId_veza(new Long(request.getParameter("idv")+""));

	}
vseb = (com.popultrade.model.TemplateTag)contextUtil.getPopulatedObject(vseb,request);

vseb.setJe_attribute_taga(nul.jeNull(request.getParameter("je_attribute_taga")).equals("1")?"1":"0");
vseb.setUporabi_tag(nul.jeNull(request.getParameter("uporabi_tag")).equals("1")?"1":"0");

vseb.setTag_ima_childe(nul.jeNull(request.getParameter("tag_ima_childe")).equals("1")?"1":"0");


dao.saveTemplateTag(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("ime attribute ali taga","tag_name");
//ht.put("vrednost pogoja","vrednost_pogoja");
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
<body   style="margin: 0"  <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templatefunkcijatag_xml.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idv" value="<%=request.getParameter("idv")%>">


<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>


<tr>
            		 <td class="opiscell" width="20%">Uporabi tag: </td><td class="valuecell">
            		 <input type="checkbox" name="uporabi_tag" value="1" <%=nul.jeNull(vseb.getUporabi_tag()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
	
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Tag ali attribute ime: </td><td class="valuecell">
            		 
            		 
            		  <input type="text" size="70" name="tag_name" maxlength='120' value="<%=nul.jeNull(vseb.getTag_name()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            	
            		  </td>
            		 
</tr>



<tr>
            		 <td class="opiscell" width="20%">Je attribute parent taga: </td><td class="valuecell">
            		 <input type="checkbox" name="je_attribute_taga" value="1" <%=nul.jeNull(vseb.getJe_attribute_taga()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
	
            		 </td>
            		 
            		 <td class="opiscell" width="20%"></td><td class="valuecell">
            	
            		 
            	
            	
            		  </td>
            		 
</tr>


<tr>
            	
            		 
            		 <td class="opiscell" width="20%">Tag ima childe (ce ima childe, ki se dobijo iz dodatnih selectov, se lahko vnese tudi ime glavnega taga, ki bo vseboval childe):</td><td class="valuecell">
            		  <input type="checkbox" name="tag_ima_childe" value="1" <%=nul.jeNull(vseb.getTag_ima_childe()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		  </td>
            		  
            		  
            		  	 <td class="opiscell" width="20%">Ime glavnega taga, ce ima childe: </td><td class="valuecell">
            	<input type="text" size="70" name="tag_name_parent" maxlength='120' value="<%=nul.jeNull(vseb.getTag_name_parent()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            		 </td>
            		 
</tr>




<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {


return true;
}



function mom() {

top.parent.frames[3].document.location = "nic.jsp";
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
var mon = parent.frames[0].document.location+"";

<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[0].document.location = mon.substring(0,mon.indexOf("idback")-1)+"";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?")) + "";
     
     }
     else {
parent.frames[0].document.location = parent.frames[0].document.location + "";
     }
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "";

     }
}
<%
}
else {
%>
    if (mon.indexOf("id=")!=-1) {
    
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?"));
     }
     else {
    
parent.frames[0].document.location = parent.frames[0].document.location;
}
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