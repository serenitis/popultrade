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
vseb.setTemplatehead_id(new Long(request.getParameter("idtc")));
	}
vseb = (com.popultrade.model.TemplateClass)contextUtil.getPopulatedObject(vseb,request);
dao.saveTemplateClass(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("ime pogoja","ime_pogoja");
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

<form name=dod action="m_templatefunkcija_edit2.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="sifid" value="<%=nul.jeNull(request.getParameter("sifid"))%>">


<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Ime pogoja: </td><td class="valuecell" width="30%">
            		 
            	
            		 
            		  		 <select name="ime_pogoja" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					
					//// dobim ime model clase iz headerja
			if (true) {
						com.popultrade.model.TemplateClassClass thead =new com.popultrade.model.TemplateClassClass();
						com.popultrade.dao.TemplateClassClassDAO daoth = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());
						thead = daoth.getTemplateClassClass(new Long(nul.jeNull(request.getParameter("idtc"))));
						class_name=thead.getClass_name();
}
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set").equals(nul.jeNull(vseb.getIme_pogoja()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set")%>" selected><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","set") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","set") +")"%></option>
							
							
							<%	
							
							
						}
					}
					%>
					
					
					</select>
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Vrednost pogoja: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="vrednost_pogoja" maxlength='250' value="<%=nul.jeNull(vseb.getVrednost_pogoja()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 	  		 <select name="vrednost_pogojas" style="font-family: Verdana; font-size: 8pt" onChange="preseli()" >
            		 
            		 
					<option value=""></option>
					
					
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
					
					
					
					
					
		if (nul.jeNull(session.getAttribute("glavno")+"").equals("1")) {

						
						com.popultrade.model.TemplateFunkcijaStart thead =new com.popultrade.model.TemplateFunkcijaStart();
						com.popultrade.dao.TemplateFunkcijaStartDAO daoth = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",pageContext.getServletContext());

						
						//// dobim ime model clase iz headerja
						thead = daoth.getTemplateFunkcijaStart(new Long(session.getAttribute("idp")+""));
						class_name=thead.getClass_name();
						
					}
					else {
						com.popultrade.model.TemplateClassClass thead =new com.popultrade.model.TemplateClassClass();
						com.popultrade.dao.TemplateClassClassDAO daoth = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());
						thead = daoth.getTemplateClassClass(new Long(request.getParameter("idtc")+""));
						class_name=thead.getClass_name();
					}
					
					
					
					
					
					
		
		 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
		
		 itti = li.iterator();

		while (itti.hasNext()) {
		
			String nex =(String)itti.next();
			if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getIme_pogoja()))) {
		%>
		
		
		<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>()" selected><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
		
		
		<%
		
			}
			else {
				
				%>
				
				
				<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>()"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
				
				
				<%	
				
				
			}
		}
		%>
					
					
					
					            		<%
					            		
					            	
					            		
            		if (!(session.getAttribute("idv")+"").equals("")) {
            		com.popultrade.model.TemplateClassClass sifo = new com.popultrade.model.TemplateClassClass();  		
            		
            		/// vrednosti na razpolagi
            		
            		sifo.setId_veza(new Long(session.getAttribute("idv")+""));
            		
            		
            		com.popultrade.dao.TemplateClassClassDAO daoc = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());



List lisc =null;

lisc = daoc.getTemplateClassClasss(sifo);

if (lisc.size()>0) {
sifo = (com.popultrade.model.TemplateClassClass)lisc.get(0);
}


if (sifo.getId()!=null) {

List vredn = sifo.getTemplateClassClass_vrednostis();

Iterator iu = vredn.iterator();

while (iu.hasNext()) {
	
	com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)iu.next();
	%>
	<option value="<%=nul.jeNull(tcv.getVrednost())%>()-----V"><%=nul.jeNull(tcv.getVrednost())%> (vrednost)</option>
	
	<%
}
}


            		}
            		
            		%>
					
										 	<%
            		 	/// rezultat je lahko funkcija
            		 		com.popultrade.model.TemplateFunkcijaStart tfun =new com.popultrade.model.TemplateFunkcijaStart();
					com.popultrade.dao.TemplateFunkcijaStartDAO daof = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",pageContext.getServletContext());

					 li = daof.getTemplateFunkcijaStarts(tfun,1,1000);
				//	 System.out.println("FUNKK ::: "+li.size());
					 itti = li.iterator();
					while (itti.hasNext()) {
						com.popultrade.model.TemplateFunkcijaStart tfu = (com.popultrade.model.TemplateFunkcijaStart)itti.next();
            		 	%>
            		 	<option value="[F<%=tfu.getId()%>] <%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%>)"><%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%> (FUNKCIJA))</option>
            		 	
            		 	<%
					}
            		 	%>	
					
					</select>
            		 <input type="text" size="1" readonly style="font-family: Verdana; font-size: 8pt"  name="izvor_vrednosti" value="<%=nul.jeNull(vseb.getIzvor_vrednosti()+"")%>">
            		 </td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Opis pogoja: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="opis_pogoja" maxlength='70' size="35" value="<%=nul.jeNull(vseb.getOpis_pogoja()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">&nbsp;</td><td class="valuecell" width="30%">
             		 
					&nbsp;</td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">HQL pogoj (samo Alen): </td><td class="valuecell" width="30%" colspan="3">
            		 
            		  <input type="text" name="dodaten_hql_pogoj" maxlength='500' size="130" value="<%=nul.jeNull(vseb.getDodaten_hql_pogoj()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		  
            		  
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
					
					
								if (true) {
						com.popultrade.model.TemplateClassClass thead =new com.popultrade.model.TemplateClassClass();
						com.popultrade.dao.TemplateClassClassDAO daoth = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());
						thead = daoth.getTemplateClassClass(new Long(nul.jeNull(request.getParameter("idtc"))));
						class_name=thead.getClass_name();
}
					
					
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","") +")"%></option>
							<%	
					}
					
					
					
					
            		
					if (!(session.getAttribute("idv")+"").equals("")) {
					com.popultrade.model.TemplateClassClass sifo = new com.popultrade.model.TemplateClassClass();  		

					/// vrednosti na razpolagi

					sifo.setId_veza(new Long(session.getAttribute("idv")+""));


					com.popultrade.dao.TemplateClassClassDAO daoc = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());



					List lisc =null;

					lisc = daoc.getTemplateClassClasss(sifo);

					if (lisc.size()>0) {
					sifo = (com.popultrade.model.TemplateClassClass)lisc.get(0);
					}


					if (sifo.getId()!=null) {

					List vredn = sifo.getTemplateClassClass_vrednostis();

					Iterator iu = vredn.iterator();

					while (iu.hasNext()) {

					com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)iu.next();
					%>
					<option value="<%=nul.jeNull(tcv.getVrednost())%>()----V"><%=nul.jeNull(tcv.getVrednost())%> (vrednost)</option>

					<%
					}
					}


					}
					
					
					%>
					
					
					
					
					
					</select><input type="text" size="1" readonly name="izvor_vrednosti_pogoj" value="<%=nul.jeNull(vseb.getIzvor_vrednosti_pogoj()+"")%>" style="font-family: Verdana; font-size: 8pt" >
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
						  	<select name="hql4" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="'">'</option>
            		  </select>
					<input type="text" size=20 name="hql5"  style="font-family: Verdana; font-size: 8pt">
							  	<select name="hql6" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="'">'</option>
            		  </select>
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


vredi = document.dod.hql3.value;

if (document.dod.hql3.value.indexOf("----V")!=-1) {
//alert(vredi);
vredi = vredi.substring(0,vredi.indexOf("----"));
//alert(vredi);
document.dod.izvor_vrednosti_pogoj.value = "V";
}
else {
document.dod.izvor_vrednosti_pogoj.value = "O";
}


document.dod.dodaten_hql_pogoj.value = document.dod.dodaten_hql_pogoj.value + " "+
document.dod.hql1.value + " "+
document.dod.hql2.value + " "+(document.dod.hql35.value=='nequals'?'!':'')+ ((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"nul.jeNull(":'')+
vredi+ ((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"+'')":"")+((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?".equals('":document.dod.hql35.value)+
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


vredi = document.dod.vrednost_pogojas.value;

if (document.dod.vrednost_pogojas.value.indexOf("-----V")!=-1) {
//alert(vredi);
vredi = vredi.substring(0,vredi.indexOf("----"));
//alert(vredi);
document.dod.izvor_vrednosti.value = "V";
}
else {
document.dod.izvor_vrednosti.value = "O";
}



document.dod.vrednost_pogoja.value = vredi;

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