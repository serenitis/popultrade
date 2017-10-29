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

String class_name="";
try {
boolean bok=false;
com.popultrade.model.TemplateSearch vseb =new com.popultrade.model.TemplateSearch();
com.popultrade.dao.TemplateSearchDAO dao = (com.popultrade.dao.TemplateSearchDAO)contextUtil.getBeanDao("templateSearchDAO",pageContext.getServletContext());


if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("prevod"))  {
	
	

	
	
}



if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateSearch(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateSearch(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		vseb.setTemplatelist_id(new Long(request.getParameter("idt")));
	}

vseb = (com.popultrade.model.TemplateSearch)contextUtil.getPopulatedObject(vseb,request);

vseb.setSelike(nul.jeNull(request.getParameter("selike")).equals("1")?"1":"0");
vseb.setSelikel(nul.jeNull(request.getParameter("selikel")).equals("1")?"1":"0");
vseb.setSeliked(nul.jeNull(request.getParameter("seliked")).equals("1")?"1":"0");
vseb.setSeupper(nul.jeNull(request.getParameter("seupper")).equals("1")?"1":"0");
vseb.setSelower(nul.jeNull(request.getParameter("selower")).equals("1")?"1":"0");

dao.saveTemplateSearch(vseb);
 






}
}
/*
/// prevod pregleda
Hashtable prep = new Hashtable();
Hashtable prepd = new Hashtable();
/// prevod vnosa
Hashtable prev = new Hashtable();
Hashtable prevd = new Hashtable();
/// id prevoda_ce obstaja
Hashtable previd = new Hashtable();

/// dobim vse prevode
com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
prevo.setSifra_jez(session.getAttribute("jezikp")+"");
List limo = daop.getPrevodis(prevo);

Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodis(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	previd.put(prv.getPrevod_id()+"",prv.getId()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodisDodatno(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prevd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikp")+"");
limo = daop.getPrevodisDodatno(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prepd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


*/



Hashtable ht =new Hashtable();
ht.put("stolpec_metoda","stolpec_metoda");

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

<form name=dod action="m_templatelist_search_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idt" value="<%=request.getParameter("idt")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>








            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Stolpec metoda: </td><td class="valuecell" width="30%">
            		 
            		 <select name="stolpec_metoda" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						
						if (nex.indexOf("().")==-1 && nex.indexOf("String")!=-1) {
						
						
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getStolpec_metoda()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" selected><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							
							
							<%	
							
							
						}
						
						
						}
						
						
					}
					%>
					
					
					</select>
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Isci po like: </td><td class="valuecell" width="30%">
             		 
				  <input type="checkbox" name="selike" value="1" <%=nul.jeNull(vseb.getSelike()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
  	
					
					</td>
             		 
            		  </tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Isci po like z leve: </td><td class="valuecell" width="30%">
            		 
            	  <input type="checkbox" name="selikel" value="1" <%=nul.jeNull(vseb.getSelikel()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
  		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Isci po like z desne: </td><td class="valuecell" width="30%">
             		 
				  <input type="checkbox" name="seliked" value="1" <%=nul.jeNull(vseb.getSeliked()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
  	
					
					</td>
             		 
            		  </tr>


            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Isci po like uppercase: </td><td class="valuecell" width="30%">
            		 
            	  <input type="checkbox" name="seupper" onclick="unchk(1)" value="1" <%=nul.jeNull(vseb.getSeupper()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
  		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Isci po like lowercase: </td><td class="valuecell" width="30%">
             		 
				  <input type="checkbox" name="selower" onclick="unchk(2)" value="1" <%=nul.jeNull(vseb.getSelower()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
  	
					
					</td>
             		 
            		  </tr>


<tr><td colspan="4" class="opiscell" align="center">


<input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {


return true;
}



function unchk(kij) {

if (kij==2) {

if (document.dod.seupper.checked) {
document.dod.seupper.checked=false;
}

}
else if (kij==1) {

if (document.dod.selower.checked) {
document.dod.selower.checked=false;
}

}

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
function mom() {


}
<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[2].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
     
     }
     else {
parent.frames[2].document.location = parent.frames[2].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     }
     else {
     parent.frames[2].document.location = parent.frames[2].document.location + "?idback=<%=request.getParameter("id")%>";

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