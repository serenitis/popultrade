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


com.popultrade.model.TemplateGumbiParametri vseb =new com.popultrade.model.TemplateGumbiParametri();
com.popultrade.dao.TemplateGumbiParametriDAO dao = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateGumbiParametri(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateGumbiParametri(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplategumb_id(new Long(session.getAttribute("idg")+""));
	}
vseb = (com.popultrade.model.TemplateGumbiParametri)contextUtil.getPopulatedObject(vseb,request);
dao.saveTemplateGumbiParametri(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("stolpec_metoda","stolpec_metoda");
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

<form name=dod action="m_templategumbiparametri_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idg" value="<%=nul.jeNull(request.getParameter("idg"))%>">

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		<tr>
            		 <td class="opiscell" width="20%">Parameter: </td><td class="valuecell" width="30%" >
            		
            	<textarea cols=90 rows=1  name="stolpec_metoda"  id="stolpec_metoda" style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getStolpec_metoda())%></textarea><br>
            		 	  		 <select name="stolpec_metoda2"  id="stolpec_metoda2" value="" style="font-family: Verdana; font-size: 8pt" onChange="prenos()" >
            		 
            		 
					<option value=""></option>
					
				
					<%
					
			
			
						com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
						com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

						
						//// dobim ime model clase iz headerja
						thead = daoth.getTemplateHead(new Long(session.getAttribute("idt")+""));
						class_name=thead.getHead_class_name();
						
		
					
					
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" <%=nul.jeNull(vseb.getStolpec_metoda()).equals(nex.substring(0,nex.indexOf(" ----XXX---- ")))?"selected":""%>><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
				
				
						if (!nul.jeNull(thead.getVeza_gumb()+"").equals("")) {
						
						com.popultrade.model.TemplateGumbiParametri tgp = new com.popultrade.model.TemplateGumbiParametri();
						com.popultrade.dao.TemplateGumbiParametriDAO dah = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
						
						tgp.setTemplategumb_id(thead.getVeza_gumb());
						
						List limo = dah.getTemplateGumbiParametris(tgp);
						
						Iterator imo = limo.iterator();
						
						while (imo.hasNext()) {
							com.popultrade.model.TemplateGumbiParametri slur = (com.popultrade.model.TemplateGumbiParametri)imo.next();
							String primeri = nul.jeNull(slur.getStolpec_metoda());
							if (nul.jeNull(slur.getStolpec_metoda()).indexOf("request.getParameter")==-1) {
							primeri = nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')";
							}
							if (!nul.jeNull(slur.getDugacno_ime_parametra()).equals("")) {
								primeri = "request.getParameter(\'"+slur.getDugacno_ime_parametra()+"\')";
							}
							
							
						
						%>
						
						<option value="<%=primeri%>" <%=primeri.equals(nul.jeNull(vseb.getStolpec_metoda()))?"selected":""%>><%=primeri%> (vrednost preko pred gumba)</option>
					
						
						<%
						}
					}
					
					%>
					</select>
					
            		 </td>
            		  <td class="opiscell" width="20%">Drugacno ime parametra, ki posljem naprej: </td><td class="valuecell" width="30%" >
            		  
            		  <input type="text" name="dugacno_ime_parametra"  size=60  maxlength='55'  value="<%=nul.jeNull(vseb.getDugacno_ime_parametra())%>" style="font-family: Verdana; font-size: 8pt" >
            		  
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
document.dod.vrednost_pogoja.value =document.dod.vrednost_pogoja.value+ " nul.jeNull('+document.dod.vrednost_pogojas.value+ '()+'') ";

}

function prenos() {
	
		document.getElementById("stolpec_metoda").value = document.getElementById("stolpec_metoda2").value;

	
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
var mon = parent.frames[0].document.location+"";

<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[0].document.location = mon.substring(0,mon.indexOf("idback"))+"idback=<%=request.getParameter("id")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          
parent.frames[0].document.location = parent.frames[0].document.location + "&idback=<%=request.getParameter("id")%>";
     
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "?idback=<%=request.getParameter("id")%>";

     }
}
<%
}
else {
%>
  
    
parent.frames[0].document.location = parent.frames[0].document.location;

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