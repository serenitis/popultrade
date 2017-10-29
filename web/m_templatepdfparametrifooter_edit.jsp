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
com.popultrade.model.TemplatePdfParametri vseb =new com.popultrade.model.TemplatePdfParametri();
com.popultrade.dao.TemplatePdfParametriDAO dao = (com.popultrade.dao.TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO",pageContext.getServletContext());
if (request.getParameter("idt")!=null  && request.getParameter("akcija")==null) {
vseb = dao.getTemplatePdfParametriByVezaId(new Long(nul.jeNullDefault(request.getParameter("idt"))));
if (vseb==null) {
	vseb =new com.popultrade.model.TemplatePdfParametri();
}
} 

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplatePdfParametri(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		

					
vseb.setVeza_id(new Long(request.getParameter("idt")));




	}

vseb = (com.popultrade.model.TemplatePdfParametri)contextUtil.getPopulatedObject(vseb,request);
//vseb.setPdf_font_width(nul.jeNull(request.getParameter("pdf_font_width")).equals("1")?"1":"0");
//vseb.setPdf_font_size_prevod_width(nul.jeNull(request.getParameter("pdf_font_size_prevod_width")).equals("1")?"1":"0");
//vseb.setPdf_header_width(nul.jeNull(request.getParameter("pdf_header_width")).equals("1")?"1":"0");
//vseb.setUporabi_page_break(nul.jeNull(request.getParameter("uporabi_page_break")).equals("1")?"1":"0");
dao.saveTemplatePdfParametri(vseb);





if (true) {
	
	
	
	Enumeration enn = request.getParameterNames();
	
	while (enn.hasMoreElements()) {
		
		String str = (String)enn.nextElement();
		
		if (str!=null && str.startsWith("prevod_")) {
			
			String[] stru = str.split("_");
			com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
			com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
			
			
			prevo.setPrevod_id(new Long(stru[1]));
			prevo.setSifra_jez(session.getAttribute("jezikv")+"");
			prevo.setVrsta(stru[2]);
			if (stru.length==4 && !stru[3].equals("")) {
			//	prevo.setId(new Long(stru[3]));
				
			}
			prevo = daop.getPrevodiCopy(prevo);
			
			if (prevo==null) {
				prevo = new com.popultrade.model.Prevodi();
				prevo.setPrevod(nul.jeNull(request.getParameter(str)));
				prevo.setPrevod_id(new Long(stru[1]));
				prevo.setSifra_jez(session.getAttribute("jezikv")+"");
				prevo.setVrsta(stru[2]);
				
			}
			prevo.setPrevod(nul.jeNull(request.getParameter(str)));
			
			daop.savePrevodi(prevo);
			
			
		}
		
		
		
	}
	
}




}
}

Hashtable ht =new Hashtable();
ht.put("stolpec_naziv","stolpec_naziv");
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

<form name=dod action="m_templatepdfparametrifooter_edit.jsp" method="post" onSubmit="return check()">

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

/// prevod stran
Hashtable prejv = new Hashtable();
Hashtable prejh = new Hashtable();


com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();

List limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","S");
Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","S");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


Hashtable prejvd = new Hashtable();
Hashtable prejhd = new Hashtable();
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","D");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejvd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","D");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejhd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}



Hashtable prejvo = new Hashtable();
Hashtable prejho = new Hashtable();
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","O");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejvo.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","O");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejho.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}























%>

<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">
<input type=hidden name="idn" value="<%=nul.jeNull(request.getParameter("idn"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Verzija: </td><td class="valuecell" colspan=3>
            		 
            		 <input type="text" name="f_verzija" maxlength='70' size='70' value="<%=nul.jeNull(vseb.getF_verzija()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            	</td>
             		 
            		  </tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Vsebina pod crto footerja: </td><td class="valuecell" colspan=3>
   <input type="text" name="f_vrednost_pod_crto" value="<%=nul.jeNull(vseb.getF_vrednost_pod_crto()+"")%>" size="100" maxlength="400" style="font-family: Verdana; font-size: 8pt">
				          		 
            		
            		 
            		 </td>
            	
             		 
            		  </tr>


            	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (stran) : <%=nul.jeNull((String)prejh.get(request.getParameter("idt")+"")+"")%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" name="prevod_<%=request.getParameter("idt")%>_S_<%=nul.jeNull((String)prejv.get(request.getParameter("idt")+"")+"")%>" value="<%=nul.jeNull((String)prejv.get(request.getParameter("idt")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Prevod (datum) : <%=nul.jeNull((String)prejhd.get(request.getParameter("idt")+"")+"")%></td><td class="valuecell" width="30%">
            		    
            	 <input type="text" name="prevod_<%=request.getParameter("idt")%>_D_<%=nul.jeNull((String)prejvd.get(request.getParameter("idt")+"")+"")%>" value="<%=nul.jeNull((String)prejvd.get(request.getParameter("idt")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
            		 
            		 </td>
             		 
            		  </tr>   		  
            		  
            	            	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (ob) : <%=nul.jeNull((String)prejho.get(request.getParameter("idt")+"")+"")%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" name="prevod_<%=request.getParameter("idt")%>_O_<%=nul.jeNull((String)prejvo.get(request.getParameter("idt")+"")+"")%>" value="<%=nul.jeNull((String)prejvo.get(request.getParameter("idt")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
           	
            		 
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
var mon = parent.frames[0].document.location+"";

<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[0].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     
     }
     else {
parent.frames[0].document.location = parent.frames[0].document.location + "&idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     }
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";

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