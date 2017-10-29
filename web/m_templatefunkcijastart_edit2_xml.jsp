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


com.popultrade.model.TemplateFunkcijaStart vseb =new com.popultrade.model.TemplateFunkcijaStart();
com.popultrade.dao.TemplateFunkcijaStartDAO dao = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateFunkcijaStart(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateFunkcijaStart(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		vseb.setVeza_id(new Long(session.getAttribute("idt")+""));

	}
vseb = (com.popultrade.model.TemplateFunkcijaStart)contextUtil.getPopulatedObject(vseb,request);

vseb.setVrednosti_preko_checkbox(nul.jeNull(request.getParameter("vrednosti_preko_checkbox")).equals("1")?"1":"0");
dao.saveTemplateFunkcijaStart(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("ime_funkcije","ime_funkcije");
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

<form name=dod action="m_templatefunkcijastart_edit2.jsp" method="post" onSubmit="return check()">

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



<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>


<tr>
            		 <td class="opiscell" width="20%">Ime xml taga: </td><td class="valuecell"  colspan=3>
            		  <input type="text" size="40" name="ime_funkcije" maxlength='70' value="<%=nul.jeNull(vseb.getIme_funkcije()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            	
            		  </td>
            		 
</tr>

<tr>
            		 <td class="opiscell" width="20%">Class funkcije za xml tag: </td><td class="valuecell"  colspan=3>
            	


    		 <select name="class_name" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					List li = templateUtil.getClasseNamesInPackage(contextUtil,this.getServletContext(),"","");
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getClass_name()))) {
					%>
					
					
					<option value="<%=nex%>" selected><%=nex%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex%>" ><%=nex%></option>
							
							
							<%	
							
							
						}
					}
					%>
					
					
					</select>

            	
            		  </td>
            		 
</tr>



<tr>
            		 <td class="opiscell" width="20%">Opis taga: </td><td class="valuecell"  colspan=3>
            		  <input type="text" size="100" name="opis" maxlength='250' value="<%=nul.jeNull(vseb.getOpis()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            	
            		  </td>
            		 
</tr>


<tr>
            		 <td class="opiscell" width="20%">Zaporeje (zaporedje izpisa taga): </td><td class="valuecell"  colspan=3>
            		  <input type="text" size="4" name="zaporedje" maxlength='4' value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            	
            		  </td>
            		 
</tr>




<tr>
            		 <td class="opiscell" width="20%">Ime stolpca metode, ki se poslje preko checkboxa (le ce ima list stolpec s checkboxom) - ime brez get spredaj: </td><td class="valuecell"  colspan=3>
            		  <input type="text" size="4" name="stolpec_metoda_checkbox" maxlength='4' value="<%=nul.jeNull(vseb.getStolpec_metoda_checkbox()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		Uporabi vrednosti preko checkboxa: <input type="checkbox" name="vrednosti_preko_checkbox" value="1" <%=nul.jeNull(vseb.getVrednosti_preko_checkbox()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
	
            	
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

  parent.frames[0].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
     
     }
     else {
parent.frames[0].document.location = parent.frames[0].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "?idback=<%=request.getParameter("id")%>";

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