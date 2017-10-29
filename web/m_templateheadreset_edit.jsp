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


com.popultrade.model.TemplateHeadReset vseb =new com.popultrade.model.TemplateHeadReset();
com.popultrade.dao.TemplateHeadResetDAO dao = (com.popultrade.dao.TemplateHeadResetDAO)contextUtil.getBeanDao("templateHeadResetDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateHeadReset(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateHeadReset(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplatehead_id(new Long(request.getParameter("idt")+""));
	}
vseb = (com.popultrade.model.TemplateHeadReset)contextUtil.getPopulatedObject(vseb,request);
dao.saveTemplateHeadReset(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("reset_lokacija","reset_lokacija");
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
<body   style="margin: 0" <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateheadreset_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">


<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		<tr>
            		 <td class="opiscell" width="20%">Reset frame: </td><td class="valuecell" width="30%" >
            		  <input type="text" name="reset_lokacija"  size="55"  maxlength='55'  value="<%=nul.jeNull(vseb.getReset_lokacija())%>" style="font-family: Verdana; font-size: 8pt" >
            		 
            	
            		 	  		 <select name="reset_lokacija2" style="font-family: Verdana; font-size: 8pt" onchange="preseli()"  >
            		 
            		 
					<option value=""></option>
<option value="parent.frames[0].location" <%=nul.jeNull(vseb.getReset_lokacija()).equals("parent.frames[0].location")?"selected":""%>>parent.frames[0].location</option>
	<option value="parent.frames[1].location" <%=nul.jeNull(vseb.getReset_lokacija()).equals("parent.frames[1].location")?"selected":""%>>parent.frames[1].location</option>
	<option value="parent.frames[2].location" <%=nul.jeNull(vseb.getReset_lokacija()).equals("parent.frames[2].location")?"selected":""%>>parent.frames[2].location</option>
	<option value="top.parent.frames[0].location" <%=nul.jeNull(vseb.getReset_lokacija()).equals("top.parent.frames[0].location")?"selected":""%>>top.parent.frames[0].location</option>
	<option value="top.parent.frames[1].location" <%=nul.jeNull(vseb.getReset_lokacija()).equals("top.parent.frames[1].location")?"selected":""%>>top.parent.frames[1].location</option>
	<option value="top.parent.frames[2].location" <%=nul.jeNull(vseb.getReset_lokacija()).equals("top.parent.frames[2].location")?"selected":""%>>top.parent.frames[2].location</option>
				
		
				
	
					
					
					</select>
					
            		 </td>
            		  <td class="opiscell" width="20%">Lokacija reseta oz jsp ali html page, ki se pokaze: </td><td class="valuecell" width="30%" >
            		  
            		  <input type="text" name="reset_page"    maxlength='255' size='55' value="<%=nul.jeNull(vseb.getReset_page()).equals("")?"nic.jsp":nul.jeNull(vseb.getReset_page())%>" style="font-family: Verdana; font-size: 8pt" >
            		  
            		  </td>
            		  
            		  </tr>
            		

<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {


return true;
}

function dodajreset() {
document.dod.hql1.value="";
document.dod.hql2.value="";
document.dod.hql3.value="";
document.dod.hql35.value="";

document.dod.hql5.value="";

document.dod.hql7.value="";
}
function dodaj() {
document.dod.dodaten_hql_pogoj.value = document.dod.dodaten_hql_pogoj.value + " "+
document.dod.hql1.value + " "+
document.dod.hql2.value + " "+(document.dod.hql35.value=='nequals'?'!':'')+ ((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"nul.jeNull(":'')+
document.dod.hql3.value+ ((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"+'') ":"")+((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?".equals('":document.dod.hql35.value)+
document.dod.hql5.value+((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"')":"")+
document.dod.hql7.value;

}

function dodajv() {
document.dod.vrednost_pogoja.value = document.dod.vrednost_pogoja.value + " "+
document.dod.hv1.value + " nul.jeNull("+
document.dod.hv2.value + "()+'') "+
document.dod.hv3.value;

}

function preseli() {
document.dod.reset_lokacija.value =document.dod.reset_lokacija2.value;

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
var mon = parent.frames[2].document.location+"";

<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[2].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idt=<%=request.getParameter("idt")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?")) + "?idt=<%=request.getParameter("idt")%>";
     
     }
     else {
parent.frames[2].document.location = parent.frames[2].document.location + "&idt=<%=request.getParameter("idt")%>";
     }
     }
     else {
     parent.frames[2].document.location = parent.frames[2].document.location + "?idt=<%=request.getParameter("idt")%>";

     }
}
<%
}
else {
%>
    if (mon.indexOf("id=")!=-1) {
    
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?"));
     }
     else {
    
parent.frames[2].document.location = parent.frames[2].document.location;
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