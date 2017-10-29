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
com.popultrade.model.TemplateClassClass_vrednosti vseb =new com.popultrade.model.TemplateClassClass_vrednosti();
com.popultrade.dao.TemplateClassClass_vrednostiDAO dao = (com.popultrade.dao.TemplateClassClass_vrednostiDAO)contextUtil.getBeanDao("templateClassClass_vrednostiDAO",pageContext.getServletContext());


vseb.setTemplateclassclass_id(new Long(request.getParameter("idtc")));


List vsee = dao.getTemplateClassClass_vrednostis(vseb);

Hashtable vsi = new Hashtable();
Hashtable vsii = new Hashtable();
Hashtable vsiz = new Hashtable();
Iterator enn = vsee.iterator();

while (enn.hasNext()) {
	
	com.popultrade.model.TemplateClassClass_vrednosti vsex = (com.popultrade.model.TemplateClassClass_vrednosti)enn.next();
	
	vsi.put(vsex.getVrednost()+"",vsex.getRabi_kot()+"");
	vsii.put(vsex.getVrednost()+"",vsex.getId()+"");
	vsiz.put(vsex.getVrednost()+"",vsex.getZaporedje()+"");
	
	
	System.out.println("AA :: "+vsex.getRabi_kot()+" ::: "+vsex.getZaporedje()+" :::: "+vsex.getVrednost());
	
}


if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
//vseb = dao.getTemplateClassClass_vrednosti(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	

	
	Enumeration ee = request.getParameterNames();
//	Hashtable obstaja = new Hashtable();
String obstaja = "";
	while (ee.hasMoreElements()) {
	
	String parnam = (String)ee.nextElement();
	System.out.println(parnam);
	if (parnam.startsWith("vrednost___")) {

		String iddd = parnam.substring(11,parnam.length());
	
	 dao = (com.popultrade.dao.TemplateClassClass_vrednostiDAO)contextUtil.getBeanDao("templateClassClass_vrednostiDAO",pageContext.getServletContext());

	 
	 /// kontrola, ce ze obstaja
	 vseb =new com.popultrade.model.TemplateClassClass_vrednosti();
	 
	 vseb.setTemplateclassclass_id(new Long(request.getParameter("idtc")));
	 vseb.setVrednost(iddd);
	 List lik = dao.getTemplateClassClass_vrednostis(vseb);
	 
	 
	 if (lik.size()==1) {
		 
		 com.popultrade.model.TemplateClassClass_vrednosti vsebo =(com.popultrade.model.TemplateClassClass_vrednosti)lik.get(0);	 
		 
		 obstaja+=vsebo.getId()+",";
		// obstaja.put(vsebo.getId()+"","");
		 vsebo.setTemplateclassclass_id(new Long(request.getParameter("idtc")));
		 vsebo.setVrednost(iddd);
		 if (!request.getParameter("zapo___"+iddd).equals("")) {
		 vsebo.setZaporedje(Integer.parseInt(request.getParameter("zapo___"+iddd)));
		 }
		 vsebo.setRabi_kot(request.getParameter("rabi_kot___"+iddd));
		 dao.saveTemplateClassClass_vrednosti(vsebo);
		 
	 }
	 else {
			vseb =new com.popultrade.model.TemplateClassClass_vrednosti();
			vseb.setTemplateclassclass_id(new Long(request.getParameter("idtc")));
			vseb.setVrednost(iddd);
			 if (!request.getParameter("zapo___"+iddd).equals("")) {
			vseb.setZaporedje(Integer.parseInt(request.getParameter("zapo___"+iddd)));
			 }
			vseb.setRabi_kot(request.getParameter("rabi_kot___"+iddd));

			dao.saveTemplateClassClass_vrednosti(vseb);
			 obstaja+=vseb.getId()+",";
	 }
	 
	 /// odstranim ostale, ce so
	 
	 	//// remove vseh
	
	
	 
	 
	
/*	if (request.getParameter("idd_"+iddd)!=null && !request.getParameter("idd_"+iddd).equals("")) {
		vseb = dao.getTemplateClassClass_vrednosti(new Long(nul.jeNullDefault(request.getParameter("idd_"+iddd))));
	
	}
	else {

	}*/
//vseb = (com.popultrade.model.TemplateClassClass_vrednosti)contextUtil.getPopulatedObject(vseb,request);



	}
	
	}
	dao.deleteById(request.getParameter("idtc"),obstaja+"-2");

}
}

Hashtable ht =new Hashtable();
ht.put("vrednost","vrednost");
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
<body   style="margin: 0"    <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templatefunkcija_class_vrednosti2.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idtc" value="<%=nul.jeNull(request.getParameter("idtc"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="5" class="opiscell">&nbsp;</td></tr>



					
					
					<%
					
					
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateClassClass thead =new com.popultrade.model.TemplateClassClass();
com.popultrade.dao.TemplateClassClassDAO daoth = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());

			
					//// dobim ime model clase iz headerja
					thead = daoth.getTemplateClassClass(new Long(request.getParameter("idtc")));
					List li = templateUtil.getClassMetodeImena(contextUtil,request.getServletContext(),"com.popultrade.model."+thead.getClass_name());
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
						
						%>
						
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Vrednost: </td><td class="valuecell" width="20%">
            		 
						<%
						if ( vsi.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- "))+"")) {  // (nex.substring(0,nex.indexOf(" ----XXX---- "))+"").equals(nul.jeNull(vseb.getVrednost()))) {
							%>
							<input type="hidden" name="idd_<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" value="<%=vsii.get(nex.substring(0,nex.indexOf(" ----XXX---- ")))%>">
							<input type="checkbox" name="vrednost___<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"  value="vrednost___<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" checked><%=nex.replaceAll(" ----XXX---- "," (") +")"%>
							<%	
						}
						else {
							%>
							<input type="checkbox" name="vrednost___<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" value="vrednost___<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%>
							<%	
						}
						
						%>
						      		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Uporabi kot: </td><td class="valuecell" width="20%">
            	
            		 
            		 
            		 Vrednost:
					<input type="radio" value="VR" name="rabi_kot___<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" <%=vsi.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- "))+"")?(nul.jeNull((String)vsi.get(nex.substring(0,nex.indexOf(" ----XXX---- "))+"")).equals("VR")?"checked":""):""%>>
					Parameter:<input type="radio"  value="PA" name="rabi_kot___<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" <%=vsi.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- "))+"")?(nul.jeNull((String)vsi.get(nex.substring(0,nex.indexOf(" ----XXX---- "))+"")).equals("PA")?"checked":""):""%>>
					
            		 </td>
            		<td class="valuecell"  width="20%">
            	Zaporedje:
            		 <%
            		 String zapo = "";
            		 
            		 if (vsiz.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")))) {
            			 zapo =(String) vsiz.get(nex.substring(0,nex.indexOf(" ----XXX---- ")));
            			 
            		 }
            		 %>
					<input type="text" value="<%=zapo%>" size=4 name="zapo___<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" >
				
            		 </td>
            		 
            		 
            		  </tr>
						
						<%
						
						
					}
					%>
					
			
            		 
      


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