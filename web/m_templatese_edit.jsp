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
com.popultrade.model.TemplateUi vseb =new com.popultrade.model.TemplateUi();
com.popultrade.dao.TemplateUiDAO dao = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateUi(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateUi(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplatehead_id(new Long(request.getParameter("idt")));
if (request.getParameter("idn")!=null && !request.getParameter("idn").equals("")) {
	
	
	vseb.setTemplateui_id(new Long(request.getParameter("idn")));
}
	}

vseb = (com.popultrade.model.TemplateUi)contextUtil.getPopulatedObject(vseb,request);
vseb.setDodatna_js_kontrola_uporabi(nul.jeNull(request.getParameter("dodatna_js_kontrola_uporabi")).equals("1")?"1":"0");
vseb.setDatum_vnos_tip(nul.jeNull(request.getParameter("datum_vnos_tip")).equals("1")?"1":"0");
vseb.setJavascript_event_uporabi(nul.jeNull(request.getParameter("javascript_event_uporabi")).equals("1")?"1":"0");
vseb.setKontrola_javascript_pravilnost(nul.jeNull(request.getParameter("kontrola_javascript_pravilnost")).equals("1")?"1":"0");
vseb.setSamo_velike_crke(nul.jeNull(request.getParameter("samo_velike_crke")).equals("1")?"1":"0");
dao.saveTemplateUi(vseb);

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
<body   style="margin: 0" <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templatese_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idn" value="<%=nul.jeNull(request.getParameter("idn"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Stolpec naziv: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="stolpec_naziv" maxlength='70' value="<%=nul.jeNull(vseb.getStolpec_naziv()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Tip polja: </td><td class="valuecell" width="30%">
             		 
					 <select name="tip_polja" style="font-family: Verdana; font-size: 8pt" >
             		 <option value="NP" <%=nul.jeNull(vseb.getTip_polja()).equals("NP")?"selected":""%>>Ni prazno polje</option>
					<option value="PR" <%=nul.jeNull(vseb.getTip_polja()).equals("PR")?"selected":""%>>Prazno polje</option>
					
					
					</select>
					
					
					</td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Zaporedje: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="zaporedje" maxlength='3' size="4" value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell">Stolpec align: </td><td class="valuecell">
             		
             		 <select name="stolpec_align" style="font-family: Verdana; font-size: 8pt" >
					<option value="left" <%=nul.jeNull(vseb.getStolpec_align()).equals("left")?"selected":""%>>Left</option>
					<option value="right" <%=nul.jeNull(vseb.getStolpec_align()).equals("right")?"selected":""%>>Right</option>
					<option value="center" <%=nul.jeNull(vseb.getStolpec_align()).equals("center")?"selected":""%>>Center</option>
					</select></td>
             		 
            		  </tr><tr>
            		  
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
					%>
					
					
					</select>
            		 
            		 </td>
            		 
       		 <td class="opiscell">Stolpec format:<br>(datum: dd-MM-yyyy HH:mm)<br>(number: #####0.00)<br>V primeru, da je pri vnosu datuma ura mora imeti format tudi uro</td><td class="valuecell">
        		 
        		 <input type="text" name="format_stolpca"   maxlength='20' value="<%=nul.jeNull(vseb.getFormat_stolpca())%>" style="font-family: Verdana; font-size: 8pt">
        		 
        		 
        		 </td>

        		 
</tr>


  <tr>
            		  
            		 <td class="opiscell" width="20%"> </td><td class="valuecell" width="30%">
            		 
      	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Uporabi polje: </td><td class="valuecell" width="30%">
             		 
					 <select name="vnos_kdaj" style="font-family: Verdana; font-size: 8pt" >
					 <option value="" ></option>
            <option value="BO" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("BO")?"selected":""%>>Za search</option>
					<option value="RO" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("RO")?"selected":""%>>Samo za pregled</option>
					<option value="AJ" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("AJ")?"selected":""%>>(Drop down) prikaz opisa ali dodaten parameter ki ne gre v bazo</option>
					</select>
					
					
					</td>
             		 
            		  </tr>

            		    <tr>
            		  
            		 <td class="opiscell" width="20%">Samo velike crke: </td><td class="valuecell" width="30%">
            		 
 <input type="checkbox" name="samo_velike_crke" value="1" <%=nul.jeNull(vseb.getSamo_velike_crke()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				      		  	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Ime parametra v primeru 'edit polja pri'='(drop down) prikaz opisa' (ime ne sme biti enako imenu v tabelah):</td><td class="valuecell" width="30%">
             		 
				 <input type="text" name="parameter_drugo_ime"   maxlength='35' size="25" value="<%=nul.jeNull(vseb.getParameter_drugo_ime())%>" style="font-family: Verdana; font-size: 8pt">
  
				 
				 </td>
            		 
					
				
             		 
            		  </tr>

  <tr>
            		  
            		 <td class="opiscell" width="20%">Tab index: </td><td class="valuecell" width="30%">
            		      	<%
            	String nulla=nul.jeNull(vseb.getTab_index());
            	if (vseb==null || vseb.getId()==null) {
            	nulla="-1";
            	
            	}
            	
            	 %>
<input type="text" name="tab_index"   maxlength='4' size="5" value="<%=nulla%>" style="font-family: Verdana; font-size: 8pt">
        		  	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Vnos datuma (z uro ali brez):</td><td class="valuecell" width="30%">
             		 
				 <input type="checkbox" name="datum_vnos_tip" value="1" <%=nul.jeNull(vseb.getDatum_vnos_tip()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 
				 
				 </td>
            		 
					
				
             		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  

            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
   <tr>
            		  
            		 <td class="opiscell" width="20%">Stolpec sirina: </td><td class="valuecell" width="30%">
            		 
<input type="text" name="stolpec_sirina"   maxlength='10' size="10" value="<%=nul.jeNull(vseb.getStolpec_sirina())%>" style="font-family: Verdana; font-size: 8pt">
        		  	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Max st. znakov v stolpcu:</td><td class="valuecell" width="30%">
             		 
<input type="text" name="stolpec_max_stevilo_znakov"   maxlength='10' size="10" value="<%=nul.jeNull(vseb.getStolpec_max_stevilo_znakov())%>" style="font-family: Verdana; font-size: 8pt">
   		 
				 
				 </td>
            		 
					
				
             		 
            		  </tr>           		  
            		  
            		  
            		  
           
  <tr>
            		  
            		 <td class="opiscell" width="20%">Tip inserta vrednosti: </td><td class="valuecell" width="30%">
            		 
      		 <select name="tip_inserta" style="font-family: Verdana; font-size: 8pt" >
             		 <option value="textbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("textbox")?"selected":""%>>textbox</option>
					<option value="checkbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("checkbox")?"selected":""%>>checkbox</option>
					 <option value="textarea" <%=nul.jeNull(vseb.getTip_inserta()).equals("textarea")?"selected":""%>>textarea</option>
					<option value="dropbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("dropbox")?"selected":""%>>dropbox</option>
			<option value="hidden" <%=nul.jeNull(vseb.getTip_inserta()).equals("hidden")?"selected":""%>>hidden</option>
					
					</select> 		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Rows in cols (velikost ce je textarea tip inserta vrednosti): </td><td class="valuecell" width="30%">
             
			Rows:<input type="text" name="rows"   maxlength='4' size="5" value="<%=nul.jeNull(vseb.getRows())%>" style="font-family: Verdana; font-size: 8pt">
Cols:<input type="text" name="cols"   maxlength='4' size="5" value="<%=nul.jeNull(vseb.getCols())%>" style="font-family: Verdana; font-size: 8pt">
  
					</td>
             		 
            		  </tr> 		  
            		  
          
          
          
          
          
          
            <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi javascript event: </td><td class="valuecell" width="30%">
 <input type="checkbox" name="javascript_event_uporabi" value="1" <%=nul.jeNull(vseb.getJavascript_event_uporabi()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Javascript event (vpise se logiko celotnega klicanja eventa, ki se doda v input element): </td><td class="valuecell" width="30%">
             
<textarea name="javascript_event"   cols='70' rows="1"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getJavascript_event())%></textarea>
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
parent.frames[2].document.location = parent.frames[2].document.location+"";


</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>