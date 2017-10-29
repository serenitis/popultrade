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
vseb.setTemplatehead_id(new Long(request.getParameter("idg")));
	}
vseb = (com.popultrade.model.TemplateClass)contextUtil.getPopulatedObject(vseb,request);
dao.saveTemplateClass(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("predpona_pogoja","predpona_pogoja");
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
<body   style="margin: 0"   <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateclass_pogoj_xml_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="sifid" value="<%=nul.jeNull(request.getParameter("sifid"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Predpona pogoja: </td><td class="valuecell" width="30%" >
            		 
            	
            		 
            		  		 <select name="predpona_pogoja" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
			<option value="IF" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("IF")?"selected":""%>>IF</option>
				<option value="ELSE IF" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("ELSE IF")?"selected":""%>>ELSE IF</option>	
					<option value="ELSE" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("ELSE")?"selected":""%>>ELSE</option>	
					<option value="VALUE" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("VALUE")?"selected":""%>>VALUE IZ DRUGE CLASS-E</option>	
					<option value="FORMAT" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("FORMAT")?"selected":""%>>SAMO FORMAT</option>
					<option value="LIST" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("LIST")?"selected":""%>>LIST</option>
					</select>
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 
            		 <td class="opiscell" width="20%">Zaporedje: </td><td class="valuecell" width="30%" >
            		 <input type="text" name="zaporedje" maxlength='3' size=4 value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
            		 </tr><tr>
            		 <td class="opiscell" width="20%">Vrednost pogoja (v primeru tagov oklepaje loci z //// znaki npr ////>) (<i>v primeru, da je predpona pogoja VALUE se vrednost prepise pred vrednostjo ki se dobi iz classe</i>): </td><td class="valuecell" width="30%" colspan=3>
            		 
            		 <input type="text" name="vrednost_pogoja" maxlength='250' size=50 value="<%=nul.jeNull(vseb.getVrednost_pogoja()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 	  		 <select name="vrednost_pogojas" style="font-family: Verdana; font-size: 8pt" onChange="preseli()" >
            		 
            		 
					<option value=""></option>
					
				
					<%
					
			
					

					
					
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+session.getAttribute("classname"));
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
					%>
				
					<%
					
					
	
					
					 li = templateUtil.getKonstantePriLogu();
					
					 itti = li.iterator();

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
					
					
					</select><br>
					
					 <input type="text" name="hv1" maxlength='100' size="20" value="" style="font-family: Verdana; font-size: 8pt">
            		  
					     		<select name="hv2" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					//// dobim ime model clase iz headerja
				//	thead = daoth.getTemplateHead(new Long(request.getParameter("sifid")));
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+session.getAttribute("classname"));
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
					%>
					</select>
					
					<input type="text" name="hv3" maxlength='100' size="20" value="" style="font-family: Verdana; font-size: 8pt">
            		 <input type="button" value="V VREDNOST" onclick="dodajv()" style="font-family: Verdana; font-size: 8pt">
            		 </td>
            		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  <tr>
            		 <td class="opiscell" width="20%">Format vrednosti s pomocjo funkcij: </td>
            		 
            		 <td class="valuecell" colspan=3>
            		 
            		 
            		 
            		<select name="funkcija_formata1" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					//// dobim ime model clase iz headerja
				//	thead = daoth.getTemplateHead(new Long(request.getParameter("sifid")));
					
					Hashtable htm = templateUtil.getFunkcijeZaFormat();
					Enumeration enu = htm.keys();

					while (enu.hasMoreElements()) {
						String nex =(String)enu.nextElement();
							%>
							<option value="<%=nex%>" <%=nex.equals(nul.jeNull(vseb.getFunkcija_formata1()+""))?"selected":""%>><%=htm.get(nex)%></option>
							<%	
					}
					%>
					</select>
            		 
            		 <br>
            		 
            		<select name="funkcija_formata2" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					//// dobim ime model clase iz headerja
				//	thead = daoth.getTemplateHead(new Long(request.getParameter("sifid")));
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+session.getAttribute("classname"));
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" <%=nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getFunkcija_formata2()+""))?"selected":""%>><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
					%>
					</select> vrednost iz classe
            		 
            		 
            		<br><input type="text" name="funkcija_formata3" maxlength='60' size=60 value="<%=nul.jeNull(vseb.getFunkcija_formata3()+"")%>" style="font-family: Verdana; font-size: 8pt">vnese se dodatne parametre, ki potrebuje funkcija
            		 
            		 </td>
            		 </tr>
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Pogoj: </td><td class="valuecell" width="30%" colspan="3">
            		 
            		  <input type="text" name="dodaten_hql_pogoj" maxlength='500' size="100" value="<%=nul.jeNull(vseb.getDodaten_hql_pogoj()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		  
            		  
            		  <br>
            		  
            		  
            		<select name="hql1" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="(">(</option>
            		  </select>
            		  
            		  <select name="hql2" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="AND">AND</option>
            		  <option value="OR">OR</option>
            		  </select>
            		  
            		<select name="hql3" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					//// dobim ime model clase iz headerja
					//thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("sifid"))));
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+session.getAttribute("classname"));
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>()"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
					%>
					</select>
					  	<select name="hql35" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="=">=</option>
            		  <option value="!=">!=</option>
            		  <option value="&gt;=">&gt;=</option>
            		  <option value="&lt;=">&lt;=</option>
            		    <option value="&gt;">&gt;</option>
            		  <option value="&lt;">&lt;</option>
            		  <option value="equals">equals (v primeru, da je polje string)</option>
            		 <option value="nequals">not equals (v primeru, da je polje string)</option>
            		  </select>
					
					<input type="text" size=20 name="hql5"  style="font-family: Verdana; font-size: 8pt">
						
            		  	<select name="hql7" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value=")">)</option>
            		  </select>
            		  
            		  <input type="button" value="DODAJ" onclick="dodaj()" style="font-family: Verdana; font-size: 8pt"> 
            		  
            		  
            		  <input type="button" value="RESET" onclick="dodajreset()" style="font-family: Verdana; font-size: 8pt"> 
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
document.dod.hql3.value+ ((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"+'')":"")+((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?".equals('":document.dod.hql35.value)+
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
document.dod.vrednost_pogoja.value =document.dod.vrednost_pogoja.value+ " nul.jeNull("+document.dod.vrednost_pogojas.value+ "()+'') ";

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