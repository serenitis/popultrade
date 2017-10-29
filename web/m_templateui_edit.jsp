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
	
	vseb.setTemplatehead_id(null);
	vseb.setTemplateui_id(new Long(request.getParameter("idn")));
}
	}

vseb = (com.popultrade.model.TemplateUi)contextUtil.getPopulatedObject(vseb,request);
vseb.setDodatna_js_kontrola_uporabi(nul.jeNull(request.getParameter("dodatna_js_kontrola_uporabi")).equals("1")?"1":"0");
vseb.setDatum_vnos_tip(nul.jeNull(request.getParameter("datum_vnos_tip")).equals("1")?"1":"0");
vseb.setJavascript_event_uporabi(nul.jeNull(request.getParameter("javascript_event_uporabi")).equals("1")?"1":"0");
vseb.setKontrola_javascript_pravilnost(nul.jeNull(request.getParameter("kontrola_javascript_pravilnost")).equals("1")?"1":"0");
vseb.setSamo_velike_crke(nul.jeNull(request.getParameter("samo_velike_crke")).equals("1")?"1":"0");
vseb.setJeslika(nul.jeNull(request.getParameter("jeslika")).equals("1")?"1":"0");
vseb.setVnos_kdaj_fiksno(nul.jeNull(request.getParameter("vnos_kdaj_fiksno")).equals("1")?"1":"0");
vseb.setDodaten_pogoj_prikaz_say(nul.jeNull(request.getParameter("dodaten_pogoj_prikaz_say")).equals("1")?"1":"0");
vseb.setUporabi_ajax_kontrolo(nul.jeNull(request.getParameter("uporabi_ajax_kontrolo")).equals("1")?"1":"0");
vseb.setHint_pomoc(nul.jeNull(request.getParameter("hint_pomoc")).equals("1")?"1":"0");
vseb.setJeslikaizbaze(nul.jeNull(request.getParameter("jeslikaizbaze")).equals("1")?"1":"0");
vseb.setLoad_sifrant_konec(nul.jeNull(request.getParameter("load_sifrant_konec")).equals("1")?"1":"0");

vseb.setKontrola_numericno(nul.jeNull(request.getParameter("kontrola_numericno")).equals("1")?"1":"0");

dao.saveTemplateUi(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("stolpec_naziv","stolpec_naziv");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");

System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");

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

<form name=dod action="m_templateui_edit.jsp" method="post" onSubmit="return check()">

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
            		  
            		 <td class="opiscell" width="20%">Stolpec naziv: </td>
						<td class="valuecell" width="32%">
            		 
            		 <input type="text" name="stolpec_naziv" maxlength='70' value="<%=nul.jeNull(vseb.getStolpec_naziv()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Tip polja: </td>
						<td class="valuecell" width="27%">
             		 
					 <select name="tip_polja" style="font-family: Verdana; font-size: 8pt" >
             		 <option value="NP" <%=nul.jeNull(vseb.getTip_polja()).equals("NP")?"selected":""%>>Ni prazno polje</option>
					<option value="PR" <%=nul.jeNull(vseb.getTip_polja()).equals("PR")?"selected":""%>>Prazno polje</option>
					
					
					</select>
					
					
					</td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Zaporedje: </td>
						<td class="valuecell" width="32%">
            		 
            		 <input type="text" name="zaporedje" maxlength='3' size="4" value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell">Stolpec align: </td><td class="valuecell">
             		
             		 <select name="stolpec_align" style="font-family: Verdana; font-size: 8pt" >
					<option value="left" <%=nul.jeNull(vseb.getStolpec_align()).equals("left")?"selected":""%>>Left</option>
					<option value="right" <%=nul.jeNull(vseb.getStolpec_align()).equals("right")?"selected":""%>>Right</option>
					<option value="center" <%=nul.jeNull(vseb.getStolpec_align()).equals("center")?"selected":""%>>Center</option>
					</select></td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Stolpec metoda: </td>
						<td class="valuecell" width="32%">
            		 
            		           		  		 <select name="stolpec_metoda" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					 
					String headname="";
					
					//	if (true) {
					
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
	String modde = thead.getHead_class_name();
					
					if (thead.getHead_class_name_nosql()!=null && !thead.getHead_class_name_nosql().equals("")) {
						modde = thead.getHead_class_name_nosql();
					}
					
					
					
					
					
					headname=nul.jeNull(thead.getHead_class_name());
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+modde);
					
					//Iterator itti = li.iterator();
					int len = li.size();
					for (int i = 0; i < len; i++) {
					
						String nex =(String)li.get(i);
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
				//	}
					
					
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					%>
					
					
					</select>
            		 
            		 </td>
            		 
        		 <td class="opiscell">Stolpec format:<br>(datum: dd-MM-yyyy HH:mm)<br>(number: #####0.00)<br>V primeru, da je pri vnosu datuma ura mora imeti format tudi uro<br><b>Ne rabit, ce je format preko PP</b></td><td class="valuecell">
        		 
        		 <input type="text" name="format_stolpca"   maxlength='20' value="<%=nul.jeNull(vseb.getFormat_stolpca())%>" style="font-family: Verdana; font-size: 8pt">
        		 
        		 
        		 </td>

        		 
</tr>
  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi Hint za pomoc:</td><td class="valuecell" colspan="3">
            		  <input type="checkbox" name="hint_pomoc" value="1" <%=nul.jeNull(vseb.getHint_pomoc()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 
            		 (omogoci se vnos pomoc teksta vezanega na polje, tekst se prikaze na webu po kliku na opis polja)
      		 &nbsp;</td>
            		 
        
             		 
            		  </tr>

  <tr>
            		  
            		 <td class="opiscell" width="20%">Za dropdow iz sifranta pridobi vrednosti po kliku na potrdi:</td>
						<td class="valuecell" width="32%">
            		 	<input type="checkbox" name="load_sifrant_konec" value="1" <%=nul.jeNull(vseb.getLoad_sifrant_konec()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				  
      		 &nbsp;</td>
            		 
             		 <td class="opiscell" width="20%">Dodaten pogoj za prikaz 
						edit polja format [if (#POGOJ#) {](prikazem le say polje  <input type="checkbox" name="dodaten_pogoj_prikaz_say" value="1" <%=nul.jeNull(vseb.getDodaten_pogoj_prikaz_say()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 ):</td><td class="valuecell" width="27%">
             		 
        		 <input type="text" name="dodaten_pogoj_prikaza_edit"   maxlength='400' size="65" value="<%=nul.jeNull(vseb.getDodaten_pogoj_prikaza_edit())%>" style="font-family: Verdana; font-size: 8pt"> 
					{ </td>
             		 
            		  </tr>


  <tr>
            		  
            		 <td class="opiscell" width="20%">Javascript kontrola: </td>
						<td class="valuecell" width="32%">
            		 
      		 <select name="kontrola_javascript" style="font-family: Verdana; font-size: 8pt" >
             		 <option value="NE" <%=nul.jeNull(vseb.getKontrola_javascript()).equals("NE")?"selected":""%>>Ne</option>
					<option value="DA" <%=nul.jeNull(vseb.getKontrola_javascript()).equals("DA")?"selected":""%>>Da</option>
					
					
					</select> <br>	
					 <input type="checkbox" name="kontrola_javascript_pravilnost" value="1" <%=nul.jeNull(vseb.getKontrola_javascript_pravilnost()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 kontrola pravilnosti (Datum)
				 
				 <br>	
					 <input type="checkbox" name="kontrola_numericno" value="1" <%=nul.jeNull(vseb.getKontrola_numericno()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 kontrola le ce polje vsebuje numericne vrednosti, nepotrebno ce je ze izbrana javascript kontrola
						 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Edit polje pri: </td>
						<td class="valuecell" width="27%">
             		 
					 <select name="vnos_kdaj" style="font-family: Verdana; font-size: 8pt" >
					 <option value="" ></option>
             		 <option value="BO" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("BO")?"selected":""%>>Pri insert in update</option>
					<option value="UP" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("UP")?"selected":""%>>Le pri update</option>
					<option value="IN" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("IN")?"selected":""%>>Le pri insert</option>
					<option value="RO" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("RO")?"selected":""%>>Samo za pregled</option>
<!-- 					<option value="RR" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("RR")?"selected":""%>>Read only</option>-->
					<option value="AJ" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("AJ")?"selected":""%>>(Drop down) prikaz opisa ali dodaten parameter ki ne gre v bazo</option>
					
					
					</select>
					
					
						}   <input type="checkbox" name="vnos_kdaj_fiksno" value="1" <%=nul.jeNull(vseb.getVnos_kdaj_fiksno()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> je readonly polje
						</td>
             		 
            		  </tr>

            		    <tr>
            		  
            		 <td class="opiscell" width="20%">Samo velike crke: </td>
						<td class="valuecell" width="32%">
            		 
 <input type="checkbox" name="samo_velike_crke" value="1" <%=nul.jeNull(vseb.getSamo_velike_crke()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				      		  	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Ime parametra v primeru 'edit polja pri'='(drop down) prikaz opisa' (ime ne sme biti enako imenu v tabelah):</td>
						<td class="valuecell" width="27%">
             		 
				 <input type="text" name="parameter_drugo_ime"   maxlength='35' size="25" value="<%=nul.jeNull(vseb.getParameter_drugo_ime())%>" style="font-family: Verdana; font-size: 8pt">
  
				 
				 </td>
            		 
					
				
             		 
            		  </tr>

  <tr>
            		  
            		 <td class="opiscell" width="20%">Tab index: </td>
						<td class="valuecell" width="32%">
            	
            	<%
            	String nulla=nul.jeNull(vseb.getTab_index());
            	if (vseb==null || vseb.getId()==null) {
            	nulla="-1";
            	
            	}
            	
            	 %>
            	
            		 
<input type="text" name="tab_index"   maxlength='4' size="5" value="<%=nulla%>" style="font-family: Verdana; font-size: 8pt">
        		  	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Vnos datuma (z uro ali brez):</td>
						<td class="valuecell" width="27%">
             		 
				 <input type="checkbox" name="datum_vnos_tip" value="1" <%=nul.jeNull(vseb.getDatum_vnos_tip()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 
				 
				 </td>
            		 
					
				
             		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  

            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
   <tr>
            		  
            		 <td class="opiscell" width="20%">Stolpec sirina: </td>
						<td class="valuecell" width="32%">
            		 
<input type="text" name="stolpec_sirina"   maxlength='10' size="10" value="<%=nul.jeNull(vseb.getStolpec_sirina())%>" style="font-family: Verdana; font-size: 8pt">
        		  	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Max st. znakov v stolpcu:</td>
						<td class="valuecell" width="27%">
             		 
<input type="text" name="stolpec_max_stevilo_znakov"   maxlength='10' size="10" value="<%=nul.jeNull(vseb.getStolpec_max_stevilo_znakov())%>" style="font-family: Verdana; font-size: 8pt">
   		 
				 
				 </td>
            		 
					
				
             		 
            		  </tr>           		  
            		  
            		  
            		  
           
  <tr>
            		  
            		 <td class="opiscell" width="20%">Tip inserta vrednosti: </td>
						<td class="valuecell" width="32%">
            		 
      		 <select name="tip_inserta" style="font-family: Verdana; font-size: 8pt" >
             		 <option value="textbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("textbox")?"selected":""%>>textbox</option>
					<option value="checkbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("checkbox")?"selected":""%>>checkbox</option>
					 <option value="textarea" <%=nul.jeNull(vseb.getTip_inserta()).equals("textarea")?"selected":""%>>textarea</option>
					 <option value="etextarea" <%=nul.jeNull(vseb.getTip_inserta()).equals("etextarea")?"selected":""%>>textarea with editor</option>
					<option value="dropbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("dropbox")?"selected":""%>>dropbox</option>
					<!-- <option value="view" <%=nul.jeNull(vseb.getTip_inserta()).equals("view")?"selected":""%>>view</option>-->
					<option value="hidden" <%=nul.jeNull(vseb.getTip_inserta()).equals("hidden")?"selected":""%>>hidden</option>
						<option value="password" <%=nul.jeNull(vseb.getTip_inserta()).equals("password")?"selected":""%>>password</option>
					<option value="file" <%=nul.jeNull(vseb.getTip_inserta()).equals("file")?"selected":""%>>file (gre v bazo)</option>
					<option value="dfile" <%=nul.jeNull(vseb.getTip_inserta()).equals("dfile")?"selected":""%>>file (gre na disk)</option>
					<option value="button" <%=nul.jeNull(vseb.getTip_inserta()).equals("button")?"selected":""%>>button</option>
					<option value="divtag" <%=nul.jeNull(vseb.getTip_inserta()).equals("divtag")?"selected":""%>>div tag</option>
				
					
					</select> 		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Rows in cols (velikost ce je textarea tip inserta vrednosti): </td>
						<td class="valuecell" width="27%">
             
			Rows:<input type="text" name="rows"   maxlength='4' size="5" value="<%=nul.jeNull(vseb.getRows())%>" style="font-family: Verdana; font-size: 8pt">
Cols:<input type="text" name="cols"   maxlength='4' size="5" value="<%=nul.jeNull(vseb.getCols())%>" style="font-family: Verdana; font-size: 8pt">
  
					</td>
             		 
            		  </tr> 		  
            		  
          
          
          
          
          
          
            <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi javascript event: </td>
						<td class="valuecell" width="32%">
 <input type="checkbox" name="javascript_event_uporabi" value="1" <%=nul.jeNull(vseb.getJavascript_event_uporabi()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Javascript event (vpise se logiko celotnega klicanja eventa, ki se doda v input element): </td>
						<td class="valuecell" width="27%">
             
<textarea name="javascript_event"   cols='70' rows="1"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getJavascript_event())%></textarea>
					</td>
             		 
            		  </tr> 
          
          
          
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi dodatno javascript kontrolo: </td>
						<td class="valuecell" width="32%">
 <input type="checkbox" name="dodatna_js_kontrola_uporabi" value="1" <%=nul.jeNull(vseb.getDodatna_js_kontrola_uporabi()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Javascript event (vpise se logiko celotnega klicanja eventa, ki se doda v input element) v primeru obvestila za napako se uporabi tag [ALERT] , ki se potem avtomaticno zamenja z alertom v js: </td>
						<td class="valuecell" width="27%">
             
<textarea name="dodatna_js_kontrola"   cols='70' rows="10"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDodatna_js_kontrola())%></textarea>
					</td>
             		 
            		  </tr> 
          
          
          
           
                               <tr>
            		  
            		<td class="opiscell" width="72%" colspan=3 align=right>
			            		 
      		 	 Pogoj prikaza vrstice (format if (##POGOJ##) { ):
            		 </td>
            		 
             		 <td class=valuecell width="27%" colspan=2>
             
<textarea name="dpogojprikazg"   cols='70' rows="2"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDpogojprikazg())%></textarea>
					</td>
             		 
            		  </tr>  
            		  
            		  
            		  
            		                            <tr>
            		  
            		<td class="opiscell" width="20%"  align=right>
			            		 
      		 	 Custom class inputa:
            		 </td>
            		 
             		 <td class=valuecell width="80%" colspan=3>
             
	 <select name="ddivclasscus" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
           //  ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
            // String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
          /*   Hashtable clase = control.getCSS_names(path+"/custom.css");*/
                  String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");
             Enumeration itn = clase.keys();
             
   
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivclasscus()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
					</td>
             		 
            		  </tr>  
            		  
            		  
            		  
            		  
          
          
          
          
                    
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Polje je slika:<br>Template za prikaz slike (poslje se id kot parameter,Edit polje mora biti na: Samo za pregled): </td>
						<td class="valuecell" width="32%">
 <input type="checkbox" name="jeslika" value="1" <%=nul.jeNull(vseb.getJeslika()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
	iz baze <input type="checkbox" name="jeslikaizbaze" id="jeslikaizbaze" value="1" <%=nul.jeNull(vseb.getJeslikaizbaze()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">			            		 
      <br>	
      
      
      

	  		 <select name="templateprikazslike" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead theade =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daothe = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					//thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					theade.setHead_tip("OB");
					
					List lie = daothe.getTemplateHeads(theade, 1, 100, "", "", "");
					
					Iterator ittie = lie.iterator();

					while (ittie.hasNext()) {
					
						theade =(com.popultrade.model.TemplateHead)ittie.next();
						
						
						if (nul.jeNull(theade.getHead_tip()).equals("OB") ) {
						
						if (nul.jeNull(vseb.getTemplateprikazslike()).equals(nul.jeNull(theade.getId()+""))) {
					%>
					
					
					<option value="<%=theade.getId()%>" selected><%=theade.getHead_naziv()%> (<%=theade.getHead_class_name()%>)</option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=theade.getId()%>" ><%=theade.getHead_naziv()%> (<%=theade.getHead_class_name()%>)</option>
				
							
							<%	
							
							
						}
						}
					}
					
					}
					
					
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::cc::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
					System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");

					%>
					
					
					</select> 


      
      
      	 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Slika width:<br>Slika height:<br> </td>
						<td class="valuecell" width="27%">
             
<input type="text" name="slika_width"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getSlika_width()+"")%>" style="font-family: Verdana; font-size: 8pt"><br>
<input type="text" name="slika_height"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getSlika_height()+"")%>" style="font-family: Verdana; font-size: 8pt">
 
 




					</td>
             		 
            		  </tr> 
          
          
          
          
          
          
                 
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Ime polja v bazi za ime datoteke (ce je polje (tip inserta) file): </td>
						<td class="valuecell" width="32%">



	  		 <select name="dfilename" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
				/*	
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					*/
					 len = li.size();
					for (int i = 0; i < len; i++) {
					
						String nex =(String)li.get(i);
						
						
						if (nex.replaceAll(" ----XXX---- "," (").indexOf("[B")==-1) {
						
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getDfilename()))) {
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
					
					}
					%>
					
					
					</select> 




				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Maximalna velikost uploadane datoteke (ce je polje (tip inserta) file) v Kb: </td>
						<td class="valuecell" width="27%">
             
<input type="text" name="dfilesize"   maxlength='7' size="7" value="<%=nul.jeNull(vseb.getDfilesize()+"")%>" style="font-family: Verdana; font-size: 8pt">

 




					</td>
             		 
            		  </tr> 
          
          
          
          
                      
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Ime polja v bazi za content-type datoteke (ce je polje (tip inserta) file): </td>
						<td class="valuecell" width="32%">



	  		 <select name="dcontenttype" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
				/*	com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					*/
					 len = li.size();
					for (int i = 0; i < len; i++) {
					
						String nex =(String)li.get(i);
						
						
						if (nex.replaceAll(" ----XXX---- "," (").indexOf("[B")==-1) {
						
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getDcontenttype()))) {
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
					
					}
					%>
					
					
					</select> 




				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%"> </td>
						<td class="valuecell" width="27%">

					</td>
             		 
            		  </tr>      
          
          
          
          
          
          
          
          
          
                
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Ime polja v bazi za lokacijo datoteke, ce dam na disk datoteko: </td>
						<td class="valuecell" width="32%">



	  		 <select name="ddivname" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
				
					 len = li.size();
					for (int i = 0; i < len; i++) {
					
						String nex =(String)li.get(i);
						
						
						if (nex.replaceAll(" ----XXX---- "," (").indexOf("[B")==-1) {
						
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getDdivname()))) {
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
					
					}
					%>
					
					
					</select> 




				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%"> </td>
						<td class="valuecell" width="27%">

					</td>
             		 
            		  </tr>      
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
                                <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi AJAX kontrolo (uporabi se kontrolo po kliku na gumb potrdi, npr kontrola, ce ze obstaja vrednost v tabeli): </td><td class="valuecell" colspan=3>
 <input type="checkbox" name="uporabi_ajax_kontrolo" value="1" <%=nul.jeNull(vseb.getUporabi_ajax_kontrolo()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				          ('edit polje pri' ne sme biti izbrano 'samo za prikaz' ce je ze dd opcija ni mogoce dodati se ak opcijo)  		 
      		 	 
            		 </td>
        
             		 
            		  </tr> 
          
            		  
            	  <tr>
            		  
            		 <td class="opiscell" width="20%">Css style prevod: </td><td class="valuecell" width="30%">
            		
            		
            		
            		
            		             
	 <select name="css_translation" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             
     String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");
             
             if (true) {
             
          //   Enumeration itn = clase.keys();
             
             List tmp = Collections.list(clase.keys());
             Collections.sort(tmp);
             Iterator itn = tmp.iterator();
             
             /*
             if (vseb.getDdivclasscusin()==null && vseb.getId()==null) {
             vseb.setDdivclasscusin((vsedd!=null && vsedd.getId()!=null)?vsedd.getDinputelement():"tdefaultInput");
             }*/
             
             while (itn.hasNext()) {
             
             String okm = (String)itn.next();
              %> 
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getCss_translation()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
            		
            		
            		
            		
            		
            		
            		
            		
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Css style vrednost: </td><td class="valuecell" width="30%">
             		 
	 <select name="css_value" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             
  //   String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
           //  Hashtable clase = control.getCSS_names(path+"/custom.css");
             
             if (true) {
             
          //   Enumeration itn = clase.keys();
             
             List tmp = Collections.list(clase.keys());
             Collections.sort(tmp);
             Iterator itn = tmp.iterator();
             
             /*
             if (vseb.getDdivclasscusin()==null && vseb.getId()==null) {
             vseb.setDdivclasscusin((vsedd!=null && vsedd.getId()!=null)?vsedd.getDinputelement():"tdefaultInput");
             }*/
             
             while (itn.hasNext()) {
             
             String okm = (String)itn.next();
              %> 
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getCss_value()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
					
					
					</td>
             		 
            		  </tr>            		  


<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {


if (document.getElementById("jeslikaizbaze").checked) {

if (document.dod.templateprikazslike.value=="") {
alert("Napaka: ni izbran template za prikaz slike!");
return false;
}

}



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



parent.frames[2].document.location = "<%=session.getAttribute("retuu")%>&sid="+Math.random()+"#bottomm<%=request.getParameter("id")%>";


</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>