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
com.popultrade.model.TemplateDDPogoji vseb =new com.popultrade.model.TemplateDDPogoji();
com.popultrade.dao.TemplateDDPogojiDAO dao = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",pageContext.getServletContext());


if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateDDPogoji(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateDDPogoji(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplatedd_id(new Long(session.getAttribute("idd")+""));
vseb.setTip("V");
	}
vseb = (com.popultrade.model.TemplateDDPogoji)contextUtil.getPopulatedObject(vseb,request);




vseb.setUporabi_format_vrednost(nul.jeNull(request.getParameter("uporabi_format_vrednost")).equals("1")?"1":"0");
vseb.setUporabi_kontrola_vrednost(nul.jeNull(request.getParameter("uporabi_kontrola_vrednost")).equals("1")?"1":"0");

dao.saveTemplateDDPogoji(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("ime_metode","ime_metode");
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

<form name=dod action="m_templateddpp_edit.jsp" method="post" onSubmit="return check()">

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

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>

            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Ime metode iz glavne clase: </td><td class="valuecell" width="30%">
            		 
            	
            		 
            		  		 <select name="ime_metode" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
			<%
			
			//// dobim ime model clase iz headerja
			
			com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daothi = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


			thead = daothi.getTemplateHead(new Long(session.getAttribute("idt")+""));
			
			
			
			List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
			
			Iterator itti = li.iterator();

			while (itti.hasNext()) {
			
				String nex =(String)itti.next();
				if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getIme_metode()))) {
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
			
			com.popultrade.dao.TemplateUiDAO daox = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());

			com.popultrade.model.TemplateUi sif = new com.popultrade.model.TemplateUi();
			sif.setTemplatehead_id(new Long(session.getAttribute("idt")+""));
			List lis =null;

			lis = daox.getTemplateUis(sif);
			
			
			Iterator inn = lis.iterator();
			//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAA " +session.getAttribute("idt") );
			
			while (inn.hasNext()) {
				com.popultrade.model.TemplateUi sic = (com.popultrade.model.TemplateUi)inn.next();
				
				
				if (!nul.jeNull(sic.getParameter_drugo_ime()).equals("")) {
					%>
					<option value="<%=nul.jeNull(sic.getParameter_drugo_ime())%>" <%=nul.jeNull(vseb.getIme_metode()).equals(nul.jeNull(sic.getParameter_drugo_ime()))?"selected":""%>><%=nul.jeNull(sic.getParameter_drugo_ime())%></option>
					
					<%
				}
				
				
				Iterator podime = sic.getTemplateuis().iterator();
				
				while (podime.hasNext()) {
					com.popultrade.model.TemplateUi sicc = (com.popultrade.model.TemplateUi)podime.next();
					
					
					if (!nul.jeNull(sicc.getParameter_drugo_ime()).equals("")) {
						%>
						<option value="<%=nul.jeNull(sicc.getParameter_drugo_ime())%>" <%=nul.jeNull(vseb.getIme_metode()).equals(nul.jeNull(sicc.getParameter_drugo_ime()))?"selected":""%>><%=nul.jeNull(sicc.getParameter_drugo_ime())%></option>
						
						<%
					}
					
				}
				
			}
			
			
			
			
			
			
			
			
			
				com.popultrade.dao.TemplatePPDAO daop = (com.popultrade.dao.TemplatePPDAO)contextUtil.getBeanDao("templatePPDAO",pageContext.getServletContext());

			com.popultrade.model.TemplatePP sifp = new com.popultrade.model.TemplatePP();
			sifp.setTemplatehead_id(new Long(session.getAttribute("idt")+""));
			List lisp =null;

			lisp = daop.getTemplatePPs(sifp);
			
			
			Iterator innp = lisp.iterator();
			//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAA " +session.getAttribute("idt") );
			
			while (innp.hasNext()) {
				com.popultrade.model.TemplatePP sic = (com.popultrade.model.TemplatePP)innp.next();
				
				
				if (!nul.jeNull(sic.getRazlicno_ime_inputa()).equals("")) {
					%>
					<option value="<%=nul.jeNull(sic.getRazlicno_ime_inputa())%>" <%=nul.jeNull(vseb.getIme_metode()).equals(nul.jeNull(sic.getRazlicno_ime_inputa()))?"selected":""%>><%=nul.jeNull(sic.getRazlicno_ime_inputa())%></option>
					
					<%
				}
				
				
			
				
			}
			
			
			
			
			
			
			
			
			
			%>
				
					
					
					</select>
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Vrednost metode: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="rezultat_metode" maxlength='250' value="<%=nul.jeNull(vseb.getRezultat_metode()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 	  		 <select name="rezultat_metodes" style="font-family: Verdana; font-size: 8pt" onChange="preseli()" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					
	
					
					 li = templateUtil.getKonstantePriLogu();
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getRezultat_metode()))) {
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
					
					
					
			/// dodam sepogoje, ce ima gumbe
					
					
					
					com.popultrade.model.TemplateDD theadi =new com.popultrade.model.TemplateDD();
com.popultrade.dao.TemplateDDDAO daoth = (com.popultrade.dao.TemplateDDDAO)contextUtil.getBeanDao("templateDDDAO",pageContext.getServletContext());


					theadi = daoth.getTemplateDD(new Long(session.getAttribute("idd")+""));
					
					
					
					 li = templateUtil.getClassMetodeImenaSPodclasami(contextUtil,this.getServletContext(),"com.popultrade.model."+theadi.getClass_name(),"get",3);
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceFirst("get","").equals(nul.jeNull(vseb.getRezultat_metode()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceFirst("get","")%>" selected><%=nex.replaceAll(" ----XXX---- "," (").replaceFirst("get","") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceFirst("get","")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceFirst("get","") +")"%></option>
							
							
							<%	
							
							
						}
					}
					
	
					
					
					
				
					
					%>
					</select>
            		 
            		 </td>
            		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  <tr>
            		  
<td class="opiscell" width="20%">Zaporedje: </td><td class="valuecell" width="30%">
     		 
     		 <input type="text" name="zaporedje" maxlength='4' size="4" value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
   		 
   		 </td>
            		 
            		       		  
   <td class="opiscell" width="20%">Uporabi za: </td><td class="valuecell" width="30%">
     		 
     	<select name="prikazi_vrednost" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value="1" <%=nul.jeNull(vseb.getPrikazi_vrednost()).equals("1")?"selected":""%>>Prenos vrednosti in prikaz v DD</option>
					
					<option value="2" <%=nul.jeNull(vseb.getPrikazi_vrednost()).equals("2")?"selected":""%>>Prenos vrednosti iz dropdown</option>
					
					<option value="3" <%=nul.jeNull(vseb.getPrikazi_vrednost()).equals("3")?"selected":""%>>Prikaz vrednosti iz dropdown</option>
					</select>
   		 </td>         		  
            		  
            		  
            		  
            		  
            		  
            		  </tr>
            		  
            		          	            		    <tr>
            		  
            		 <td class="opiscell" width="20%">Kontrola je vrednost v text field: </td><td class="valuecell" colspan=3>
            		 
 <input type="checkbox" name="uporabi_kontrola_vrednost" value="1" <%=nul.jeNull(vseb.getUporabi_kontrola_vrednost()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				     Dela samo za gumb AK (obkljukano , vrednost se prenese le v primeru, da v text fieldu ni vrednosti ) 		  	  
            		 </td>
  
             		 
            		  </tr>	  
            		  
            		  
            		  
            		  
            	            		    <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi format vrednosti: </td><td class="valuecell" colspan=3>
            		 
 <input type="checkbox" name="uporabi_format_vrednost" value="1" <%=nul.jeNull(vseb.getUporabi_format_vrednost()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				     (uporabi se spodaj format vrednosti v java kodi prefiks metode je vsebx, nezananka ki je rezultat formata je imenovana rezu_format, treba jo je resetirat v primeru uporabe vec formatov [rezu_format=""; NATO KODA FORMATA]) 		  	  
            		 </td>
  
             		 
            		  </tr>	  
            		  
            		   
                      	            		    <tr>
            		  
            		 <td class="opiscell" width="20%">Format vrednosti: </td><td class="valuecell" colspan=3>
            		 <textarea  style="font-family: Verdana; font-size: 8pt" cols=80 rows=10 name="format_vrednost"><%=nul.jeNull(vseb.getFormat_vrednost()+"")%></textarea>		  	  
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
document.dod.rezultat_metode.value = document.dod.rezultat_metodes.value;

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