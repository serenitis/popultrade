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


com.popultrade.model.TemplateClass vseb =new com.popultrade.model.TemplateClass();
com.popultrade.dao.TemplateClassDAO dao = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplatehead_id(new Long(request.getParameter("idp")));
	}
vseb = (com.popultrade.model.TemplateClass)contextUtil.getPopulatedObject(vseb,request);
dao.saveTemplateClass(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("vrednost_pogoja","vrednost_pogoja");
ht.put("zaporedje","zaporedje");
Hashtable htn =new Hashtable();
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
<body   style="margin: 0"   <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templatehead_edit_proc.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idp" value="<%=nul.jeNull(request.getParameter("idp"))%>">
<input type=hidden name="sifid" value="<%=nul.jeNull(request.getParameter("sifid"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Zaporedje pogojev pri klicanju procedure: </td><td class="valuecell" width="30%">
            		 
            	
    
            		 
            		  <input type="text" name="zaporedje" maxlength='2' size="3" value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Vrednost pogoja: </td><td class="valuecell" width="30%">
            		 
            		
            		 
            		 <textarea name="vrednost_pogoja" rows=2 cols="90"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getVrednost_pogoja()+"")%></textarea>
            		 
            		 
            		 <br>
            		 	  		 <select name="vrednost_pogojas" style="font-family: Verdana; font-size: 8pt"  onchange="preseli()" >
            		 
            		 
					<option value=""></option>
					
					
<%
					    				
										if (true) {
											
											com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
											com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


																thead = daoth.getTemplateHead(new Long(request.getParameter("idp")+""));
											
											/// dodam sepogoje, ce ima gumbe
													
													if (!nul.jeNull(thead.getVeza_gumb()+"").equals("")) {
														
														com.popultrade.model.TemplateGumbiParametri tgp = new com.popultrade.model.TemplateGumbiParametri();
														com.popultrade.dao.TemplateGumbiParametriDAO dah = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
														
														tgp.setTemplategumb_id(thead.getVeza_gumb());
														
														List limo = dah.getTemplateGumbiParametris(tgp);
														
														Iterator imo = limo.iterator();
														
														while (imo.hasNext()) {
															com.popultrade.model.TemplateGumbiParametri slur = (com.popultrade.model.TemplateGumbiParametri)imo.next();
														
														%>
														
														<option value="<%=nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')"%>" <%=(nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')").equals(nul.jeNull(vseb.getVrednost_pogoja()))?"selected":""%>><%=nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')"%> (vrednost preko gumba)</option>
														
														
														<%
														}
													}
											
													
													/// pogoji iz predpage, ce je
													
													
													if (thead.getTemplatePPs()!=null && thead.getTemplatePPs().size()>0) {
														Iterator itf = thead.getTemplatePPs().iterator();
														
														while (itf.hasNext()) {
															com.popultrade.model.TemplatePP tpp = (com.popultrade.model.TemplatePP)itf.next();
															
															%>
															
															<option value="<%=nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')"%>" <%=(nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')").equals(nul.jeNull(vseb.getVrednost_pogoja()))?"selected":""%>><%=nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')"%> (vrednost preko predhode strani)</option>
															
															
															<%
															
														}
														
														
														
														
													}
											
										}





List li = templateUtil.getKonstantePriLogu();

Iterator itti = li.iterator();

while (itti.hasNext()) {

	String nex =(String)itti.next();
	if (nex!=null && nex.equals(nul.jeNull(vseb.getVrednost_pogoja()))) {
%>


<option value="<%=nex%>" selected><%=nex%></option>


<%

	}
	else {
		
		%>
		
		
		<option value="<%=nex%>"><%=nex%></option>
		
		
		<%	
		
		
	}
}
%>

					
					
					
					</select>
            		 
            		 </td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Opis pogoja: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="opis_pogoja" maxlength='70' size="35" value="<%=nul.jeNull(vseb.getOpis_pogoja()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Vrsta parametra (type), rabim za definicijo parametra ko klicem proceduro:</td><td class="valuecell" width="30%">
             		  <select name="vrsta_pogoja" style="font-family: Verdana; font-size: 8pt" >
					<option value="Int" <%=nul.jeNull(vseb.getVrsta_pogoja()).equals("Int")?"selected":""%>>Integer</option>
					<option value="Long" <%=nul.jeNull(vseb.getVrsta_pogoja()).equals("Long")?"selected":""%>>Long</option>
						<option value="String"  <%=nul.jeNull(vseb.getVrsta_pogoja()).equals("String")?"selected":""%>>String</option>
					<option value="Double"  <%=nul.jeNull(vseb.getVrsta_pogoja()).equals("Double")?"selected":""%>>Double</option>
				
					</select>
					&nbsp;</td>
             		 
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
document.dod.hql4.value="";
document.dod.hql5.value="";
document.dod.hql6.value="";
document.dod.hql7.value="";
}
function dodaj() {
document.dod.dodaten_hql_pogoj.value = document.dod.dodaten_hql_pogoj.value + " "+
document.dod.hql1.value + " "+
document.dod.hql2.value + " "+
document.dod.hql3.value+ " "+
document.dod.hql35.value+ " "+
document.dod.hql4.value+
document.dod.hql5.value+
document.dod.hql6.value+
document.dod.hql7.value;

}
function preseli() {
document.dod.vrednost_pogoja.value = document.dod.vrednost_pogojas.value;

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
var mon = top.parent.frames[1].frames[1].document.location+"";


    
top.parent.frames[1].frames[1].document.location = "m_templatehead_edit.jsp?id=<%=request.getParameter("idp")%>";

</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>