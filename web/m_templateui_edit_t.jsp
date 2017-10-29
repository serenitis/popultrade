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
System.out.println("-------------------- INSERT ---------------------");
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
vseb.setDbuttontextvisible(nul.jeNull(request.getParameter("dbuttontextvisible")).equals("1")?"1":"0");
vseb.setJeslikaizbaze(nul.jeNull(request.getParameter("jeslikaizbaze")).equals("1")?"1":"0");
vseb.setDnextto(nul.jeNull(request.getParameter("dnextto")).equals("1")?"1":"0");
vseb.setKontrola_numericno(nul.jeNull(request.getParameter("kontrola_numericno")).equals("1")?"1":"0");
vseb.setDim_sredina(nul.jeNull(request.getParameter("dim_sredina")).equals("1")?"1":"0");



dao.saveTemplateUi(vseb);
System.out.println("-------------------- INSERT 3 ---------------------");
}
}


//// default cssji

com.popultrade.dao.TemplateCssDefaultDAO daok = (com.popultrade.dao.TemplateCssDefaultDAO)contextUtil.getBeanDao("templateCssDefaultDAO",pageContext.getServletContext());
com.popultrade.model.TemplateCssDefault vsedd =new com.popultrade.model.TemplateCssDefault();

List il = daok.getTemplateCssDefaults(new com.popultrade.model.TemplateCssDefault());

if (il.size()>0) {
vsedd = (com.popultrade.model.TemplateCssDefault)il.get(0);

}







Hashtable ht =new Hashtable();
ht.put("naziv","stolpec_naziv");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
<script type="text/javascript" src="scripts/jquery.min.js"></script>
   	<script src="js/jquery.minicolors.js"></script>
	<link rel="stylesheet" href="js/jquery.minicolors.css">
    
    	<script>
		$(document).ready( function() {
			
            $('.demo').each( function() {
               
				$(this).minicolors({
					control: $(this).attr('data-control') || 'hue',
					defaultValue: $(this).attr('data-defaultValue') || '',
					inline: $(this).attr('data-inline') === 'true',
					letterCase: $(this).attr('data-letterCase') || 'lowercase',
					opacity: $(this).attr('data-opacity'),
					position: $(this).attr('data-position') || 'bottom left',
					change: function(hex, opacity) {
						var log;
						try {
							log = hex ? hex : 'transparent';
							if( opacity ) log += ', ' + opacity;
							console.log(log);
						} catch(e) {}
					},
					theme: 'default'
				});
                
            });
			
		});
	</script>

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

<form name=dod action="m_templateui_edit_t.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="pozicija" value="<%=nul.jeNull(request.getParameter("pozicija"))%>">
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">
<input type=hidden name="idn" value="<%=nul.jeNull(request.getParameter("idn"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Opis (naziv): </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="stolpec_naziv" maxlength='70' value="<%=nul.jeNull(vseb.getStolpec_naziv()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Tip polja: </td><td class="valuecell" width="30%">
             		 
					 <select name="tip_polja" style="font-family: Verdana; font-size: 8pt" >
             		 <option value="NP" <%=nul.jeNull(vseb.getTip_polja()).equals("NP")?"selected":""%>>Ni prazno polje</option>
					<!-- <option value="PR" <%=nul.jeNull(vseb.getTip_polja()).equals("PR")?"selected":""%>>Prazno polje</option>
					 -->
					
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
					if (true) {
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
					}
					%>
					
					
					</select>
            		 
            		 </td>
            		 
        		 <td class="opiscell">Stolpec format:<br>(datum: dd-MM-yyyy HH:mm)<br>(number: #####0.00)<br>V primeru, da je pri vnosu datuma ura mora imeti format tudi uro</td><td class="valuecell">
        		 
        		 <input type="text" name="format_stolpca"   maxlength='20' value="<%=nul.jeNull(vseb.getFormat_stolpca())%>" style="font-family: Verdana; font-size: 8pt">
        		 
        		 
        		 </td>

        		 
</tr>
  <tr>
            		  
            		 <td class="opiscell" width="20%"></td><td class="valuecell" colspan="3">
            		 
      		 &nbsp;</td>
            		 
        
             		 
            		  </tr>

  <tr>
            		  
            		 <td class="opiscell" width="20%">&nbsp;</td><td class="valuecell" width="30%">
            		 
      		 &nbsp;</td>
            		 
             		 <td class="opiscell" width="20%">Dodaten pogoj za prikaz 
						edit polja format [if (#POGOJ#) {](prikazem le say polje  <input type="checkbox" name="dodaten_pogoj_prikaz_say" value="1" <%=nul.jeNull(vseb.getDodaten_pogoj_prikaz_say()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 ):</td><td class="valuecell" width="30%">
             		 <textarea name="dodaten_pogoj_prikaza_edit"   cols='65' rows="2"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDodaten_pogoj_prikaza_edit())%></textarea>
				 
        				{ </td>
             		 
            		  </tr>


  <tr>
            		  
            		 <td class="opiscell" width="20%">Javascript kontrola: </td><td class="valuecell" width="30%">
            		 
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
            		 
             		 <td class="opiscell" width="20%">Edit polje pri: </td><td class="valuecell" width="30%">
             		 
					 <select name="vnos_kdaj" style="font-family: Verdana; font-size: 8pt" >
					 <option value="" ></option>
             		 <option value="BO" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("BO")?"selected":""%>>Pri insert in update</option>
					<option value="UP" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("UP")?"selected":""%>>Le pri update</option>
					<option value="IN" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("IN")?"selected":""%>>Le pri insert</option>
					<option value="RO" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("RO")?"selected":""%>>Samo za pregled</option>
					<option value="RR" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("RR")?"selected":""%>>Read only</option>
					<option value="AJ" <%=nul.jeNull(vseb.getVnos_kdaj()).equals("AJ")?"selected":""%>>(Drop down) prikaz opisa ali dodaten parameter ki ne gre v bazo</option>
					
					
					</select>
					
					
						}   <input type="checkbox" name="vnos_kdaj_fiksno" value="1" <%=nul.jeNull(vseb.getVnos_kdaj_fiksno()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> je readonly polje
						</td>
             		 
            		  </tr>

            		    <tr>
            		  
            		 <td class="opiscell" width="20%">Samo velike crke: </td><td class="valuecell" width="30%">
            		 
 <input type="checkbox" name="samo_velike_crke" value="1" <%=nul.jeNull(vseb.getSamo_velike_crke()+"").equals("1")?"checked":""%> onclick="setDefaultCSS()" style="font-family: Verdana; font-size: 8pt">
				      		  	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Ime parametra v primeru 'edit polja pri'='(drop down) prikaz opisa' (ime ne sme biti enako imenu v tabelah) pri button se uporabi kot id:</td><td class="valuecell" width="30%">
             		 
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
            		  
            		 <td class="opiscell" width="20%">Tip : </td><td class="valuecell" width="30%">
            		 
      		 <select name="tip_inserta" style="font-family: Verdana; font-size: 8pt" onchange="setOpenedtr()" >
             		 <option value="textbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("textbox")?"selected":""%>>textbox</option>
					<option value="checkbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("checkbox")?"selected":""%>>checkbox</option>
					 <option value="textarea" <%=nul.jeNull(vseb.getTip_inserta()).equals("textarea")?"selected":""%>>textarea</option>
					<option value="dropbox" <%=nul.jeNull(vseb.getTip_inserta()).equals("dropbox")?"selected":""%>>dropbox</option>
					<option value="view" <%=nul.jeNull(vseb.getTip_inserta()).equals("view")?"selected":""%>>view</option>
					<option value="hidden" <%=nul.jeNull(vseb.getTip_inserta()).equals("hidden")?"selected":""%>>hidden</option>
						<option value="password" <%=nul.jeNull(vseb.getTip_inserta()).equals("password")?"selected":""%>>password</option>
						
						<option value="file" <%=nul.jeNull(vseb.getTip_inserta()).equals("file")?"selected":""%>>file (gre v bazo)</option>
						
					<option value="buttoni" <%=nul.jeNull(vseb.getTip_inserta()).equals("buttoni")?"selected":""%>>button (input)</option>
					 <option value="tbutton" <%=nul.jeNull(vseb.getTip_inserta()).equals("tbutton")?"selected":""%>>button touch</option>
					<option value="tlistarea" <%=nul.jeNull(vseb.getTip_inserta()).equals("tlistarea")?"selected":""%>>list area touch</option>
					 <option value="ttextarea" <%=nul.jeNull(vseb.getTip_inserta()).equals("ttextarea")?"selected":""%>>text div area touch</option>
					<option value="timage" <%=nul.jeNull(vseb.getTip_inserta()).equals("timage")?"selected":""%>>image</option>
					
					
					
					</select> <br>
					
					 View ali hidden nima prevoda (view se premakne desno):<input type="checkbox" name="tip_inserta_p" value="1" <%=nul.jeNull(vseb.getTip_inserta_p()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
					
					
							 	 
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
          
          
          
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi dodatno javascript kontrolo: </td><td class="valuecell" width="30%">
 <input type="checkbox" name="dodatna_js_kontrola_uporabi" value="1" <%=nul.jeNull(vseb.getDodatna_js_kontrola_uporabi()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Javascript event (vpise se logiko celotnega klicanja eventa, ki se doda v input element) v primeru obvestila za napako se uporabi tag [ALERT] , ki se potem avtomaticno zamenja z alertom v js: </td><td class="valuecell" width="30%">
             
<textarea name="dodatna_js_kontrola"   cols='70' rows="10"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDodatna_js_kontrola())%></textarea>
					</td>
             		 
            		  </tr> 
          
          
          
          
          
          
          
          
                    
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Polje je slika:<br>Template za prikaz slike (poslje se id kot parameter,Edit polje mora biti na: Samo za pregled): </td><td class="valuecell" width="30%">
 <input type="checkbox" name="jeslika" value="1" <%=nul.jeNull(vseb.getJeslika()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
	iz baze <input type="checkbox" name="jeslikaizbaze" value="1" <%=nul.jeNull(vseb.getJeslikaizbaze()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">			            		 
      <br>	
      
      
      

	  		 <select name="templateprikazslike" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					//thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = daoth.getTemplateHeads(null);
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						thead =(com.popultrade.model.TemplateHead)itti.next();
						
						
						if (nul.jeNull(thead.getHead_tip()).equals("OB") ) {
						
						if (nul.jeNull(vseb.getTemplateprikazslike()).equals(nul.jeNull(thead.getId()+""))) {
					%>
					
					
					<option value="<%=thead.getId()%>" selected><%=thead.getHead_naziv()%> (<%=thead.getHead_class_name()%>)</option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=thead.getId()%>" ><%=thead.getHead_naziv()%> (<%=thead.getHead_class_name()%>)</option>
				
							
							<%	
							
							
						}
						}
					}
					
					}
					%>
					
					
					</select> 


      
      
      	 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Slika width:<br>Slika height:<br> </td><td class="valuecell" width="30%">
             
<input type="text" name="slika_width"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getSlika_width()+"")%>" style="font-family: Verdana; font-size: 8pt"><br>
<input type="text" name="slika_height"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getSlika_height()+"")%>" style="font-family: Verdana; font-size: 8pt">
 
 




					</td>
             		 
            		  </tr> 
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
                                <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi AJAX kontrolo (uporabi se kontrolo po kliku na gumb potrdi, npr kontrola, ce ze obstaja vrednost v tabeli): </td><td class="valuecell" colspan=3>
 <input type="checkbox" name="uporabi_ajax_kontrolo" value="1" <%=nul.jeNull(vseb.getUporabi_ajax_kontrolo()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				          ('edit polje pri' ne sme biti izbrano 'samo za prikaz' ce je ze dd opcija ni mogoce dodati se ak opcijo)  		 
      		 	 
            		 </td>
        
             		 
            		  </tr> 
            		  
            		  
            		  
            		            <tr> 
            		  
            		 <td class="opiscell" width="20%">Razporeditev next-to jev: </td><td class="valuecell" width="30%">

	 <select name="dnexttodir" style="font-family: Verdana; font-size: 8pt" >
					<option value="" ></option>
             		 <option value="1" <%=nul.jeNull(vseb.getDnexttodir()).equals("1")?"selected":""%>>Vertical --- </option>
					<option value="2" <%=nul.jeNull(vseb.getDnexttodir()).equals("2")?"selected":""%>>Horizontal | </option>
				
					
					</select>

			            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Lahko ima next to polje (velja le ce je objekt ze next to): </td><td class="valuecell" width="30%">
             
 <input type="checkbox" name="dnextto" value="1" <%=nul.jeNull(vseb.getDnextto()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
	
					</td>
             		 
            		  </tr> 
            		  
          
            		  
            		          <tr>
            		  
            		 <td class="opiscell" colspan=4>Opcije za dimenzioniranje objekta
					</td>
             		 
            		  </tr>   
            		  
            		  
            		            <tr> 
            		  
            		 <td class="opiscell" width="20%">Width (v primeru slike je to sirina): </td><td class="valuecell" width="30%">
<input type="text" name="dwidth"   maxlength='8' size="8" value="<%=nul.jeNull(vseb.getDwidth()+"")%>" style="font-family: Verdana; font-size: 8pt">
 			            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Height (v primeru slike je to visina): </td><td class="valuecell" width="30%">
             
<input type="text" name="dheight"   maxlength='8' size="8" value="<%=nul.jeNull(vseb.getDheight()+"")%>" style="font-family: Verdana; font-size: 8pt">
 
					</td>
             		 
            		  </tr> 
            		  
            		  
            		  
            		       		            <tr> 
            		  
            		 <td class="opiscell" width="20%">Table cell width (vsi tip-inserta so dani znotraj cell tabele tu definiras dimenzijo v % za tabele npr: 25%):<br> visina cell (za napolnit z vsebino div daj na height 100%): </td><td class="valuecell" width="30%">
<input type="text" name="dtablewidth"   maxlength='8' size="8" value="<%=nul.jeNull(vseb.getDtablewidth()+"")%>" style="font-family: Verdana; font-size: 8pt"><br>
<input type="text" name="dim_zgoraj"   maxlength='8' size="8" value="<%=nul.jeNull(vseb.getDim_zgoraj()+"")%>" style="font-family: Verdana; font-size: 8pt">
 			            		 
      		 	  
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Colspan (stevilo stolpcev, ki zavzame element - ne vec kot parameter dcolnums)</td><td class="valuecell" width="30%">
          <input type="text" name="dspan"   maxlength='2' size="3" value="<%=nul.jeNull(vseb.getDspan()+"")%>" style="font-family: Verdana; font-size: 8pt">   

					</td>
             		 
            		  </tr> 
            		  
            		  		            <tr>
            		  
            		 <td class="opiscell" colspan=4>Samo v primeru da je tip edit (text, select,...)
					</td>
             		 
            		  </tr>   
            		  
            		  
            		        <tr> 
            		  
            		 <td class="opiscell" width="20%">Sirina dela prevoda: </td><td class="valuecell" width="30%">


		<input type="text" name="dinputsl"   maxlength='6' size="8" value="<%=nul.jeNull(vseb.getDinputsl()+"")%>" style="font-family: Verdana; font-size: 8pt">
 	            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Sirina dela input tagov :<Br>Visina select/input tagov: </td><td class="valuecell" width="30%">
              
<input type="text" name="dinputsd"   maxlength='6' size="8" value="<%=nul.jeNull(vseb.getDinputsd()+"")%>" style="font-family: Verdana; font-size: 8pt">
 <br><input type="text" name="dinputh"   maxlength='6' size="8" value="<%=nul.jeNull(vseb.getDinputh()+"")%>" style="font-family: Verdana; font-size: 8pt">
					</td>
             		 
            		  </tr> 
            		  
            		  
            		  
            		  		            <tr> 
            		  
            		 <td class="opiscell" width="20%">Class rocni za koncni element (npr. input) : </td><td class="valuecell" width="30%">


<input type="text" name="rocni_css"   maxlength='70' size="45" value="<%=nul.jeNull(vseb.getRocni_css()+"")%>" style="font-family: Verdana; font-size: 8pt">
 

			            		 
      		 	 
            		 </td>
            		 
             	      		 
             		 <td class="opiscell" width="20%">Style (CSS) iz custom.css datoteke za input elemente: </td><td class="valuecell" width="30%">
             
	 <select name="ddivclasscusin" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             
     String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");
             
             if (true) {
            // ServletContext scon=pageContext.getServletContext();

			/* String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");*/
             
             Enumeration itn = clase.keys();
             
             if (vseb.getDdivclasscusin()==null && vseb.getId()==null) {
             
             
             
             
             vseb.setDdivclasscusin((vsedd!=null && vsedd.getId()!=null)?vsedd.getDinputelement():"tdefaultInput");
             
             
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %> 
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivclasscusin()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>

					
					</td>
             		 
            		  </tr> 
            		  
    
            		  
            		  
            		  		            <tr> 
            		  
            		 <td class="opiscell" width="20%">Pozicija objekta (relativna/absolutna v css style): </td><td class="valuecell" width="30%">

	 <select name="dposition" style="font-family: Verdana; font-size: 8pt" >
					
             		 <option value="relative" <%=nul.jeNull(vseb.getDposition()).equals("relative")?"selected":""%>>Relative</option>
					<option value="absolute" <%=nul.jeNull(vseb.getDposition()).equals("absolute")?"selected":""%>>Absolute</option>
				
					
					</select> V primeru absolute se div imenuje |ime parametra|_div

			            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Style (CSS) rocno za div element : </td><td class="valuecell" width="30%">
             
<input type="text" name="dstyle"   maxlength='450' size="80" value="<%=nul.jeNull(vseb.getDstyle()+"")%>" style="font-family: Verdana; font-size: 8pt">
 
					</td>
             		 
            		  </tr> 
            		  
            		  
            		  
            		        <tr> 
            		  
            		 <td class="opiscell" width="20%">Style (CSS) fonti:</td><td class="valuecell" width="30%">

	 <select name="ddivclasscusf" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
           //  ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
        /*   String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");*/
             
             Enumeration itn = clase.keys();
             
             if (vseb.getDdivclasscusf()==null && vseb.getId()==null) {
             
             
              vseb.setDdivclasscusf((vsedd!=null && vsedd.getId()!=null)?vsedd.getDfonts():"tnic");
             
           //  vseb.setDdivclasscusf("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivclasscusf()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
			            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Style (CSS) iz custom.css datoteke za div element: </td><td class="valuecell" width="30%">
             
	 <select name="ddivclasscus" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
           //  ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
            // String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
          /*   Hashtable clase = control.getCSS_names(path+"/custom.css");*/
             
             Enumeration itn = clase.keys();
             
             if (vseb.getDdivclasscus()==null && vseb.getId()==null) {
             
             
                vseb.setDdivclasscus((vsedd!=null && vsedd.getId()!=null)?vsedd.getDdivelement():"tnic");
             
            // vseb.setDdivclasscus("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivclasscus()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
Uporabi div v kodi: 
 <input type="checkbox" name="dim_sredina" value="1" <%=nul.jeNull(vseb.getDim_sredina()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
ne rabit pri spacing 0


					
					</td>
             		 
            		  </tr> 
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		        <tr> 
            		  
            		 <td class="opiscell" width="20%">Style (CSS) iz custom.css datoteke za table element znotraj div containerja  (|tr||td||table||tr||td||div||table -ta css-|)  :</td><td class="valuecell" width="30%">

			           	 <select name="ddivfirsttable" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
           //  ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
           /*  String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");*/
             
             Enumeration itn = clase.keys();
             
             if (vseb.getDdivfirsttable()==null && vseb.getId()==null) {
             
             
              
             vseb.setDdivfirsttable("tdefaulttable");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivfirsttable()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>	 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Style (CSS) iz custom.css datoteke za td element : </td><td class="valuecell" width="30%">
             
	 <select name="ddivclasscustd" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
          //   ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
         /*   String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");*/
             
             Enumeration itn = clase.keys();
             
             if (vseb.getDdivclasscustd()==null && vseb.getId()==null) {
             
              vseb.setDdivfirsttable((vsedd!=null && vsedd.getId()!=null)?vsedd.getDtdelement():"tnic");
           //  vseb.setDdivclasscustd("tnic");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivclasscustd()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>

					
					</td>
             		 
            		  </tr> 	  
            		  
            		  
            		  
            		  
            		  
            	        <tr> 
            		  
            		 <td class="opiscell" width="20%">Style (CSS) iz custom.css takoj za td-jem glavne tabele (|tr||td||table -ta style-|)  :</td><td class="valuecell" width="30%">

			           	 <select name="ddivcontainer" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
           //  ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
           /*  String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");*/
              
             Enumeration itn = clase.keys();
             
             if (vseb.getDdivcontainer()==null && vseb.getId()==null) {
             
             
              
             vseb.setDdivcontainer("");
             }
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getDdivcontainer()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>	 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%"> </td><td class="valuecell" width="30%">
             
	

					
					</td>
             		 
            		  </tr> 	 
            		  
            		  
            		  		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            	 
            		            <tr>
            		  
            		 <td class="opiscell" colspan=4>Target objekta oz. kaj objekt naredi ob kliku, ce je vneseno eno izmed polj se onclick uporablja, parametri se dodajo preko 'v' gumba. Pri JS rocno.
					</td>
             		 
            		  </tr>    
            		  
            		    
           	            <tr> 
            		  
            		 <td class="opiscell" width="20%">Target (v primeru over top, rabi samo za prenos podatkov): </td><td class="valuecell" width="30%">
			            		 
      		 	  <select name="dtarget" style="font-family: Verdana; font-size: 8pt" >
                        		 
					<option value=""></option>
					
					
							<%
            		if (true) {
            		com.popultrade.dao.TemplateUiDAO daog = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
            		com.popultrade.dao.TemplateHeadDAO daoh = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		
            		List lisg = daog.getTemplateUis(new com.popultrade.model.TemplateUi());
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateUi vsebg = (com.popultrade.model.TemplateUi)(itg.next());
            		
            		if (nul.jeNull(vsebg.getTip_inserta()).equals("tlistarea") &&  vsebg.getDdivname()!=null && !vsebg.getDdivname().equals("")) {
            		
            		com.popultrade.model.TemplateHead vseh = (com.popultrade.model.TemplateHead)daoh.getTemplateHead(vsebg.getTemplatehead_id());
            		
            		%>
						<option value="<%=vsebg.getDdivname()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getDtargettemp()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getDdivname()) + "("+vseh.getHead_naziv()+")"%></option>
            		<%
            		}
            		
            		
            		}
            		}
            		%>
            		
            		
            		
	<option value="document.location" <%=nul.jeNull(vseb.getDtarget()).equals("document.location")?"selected":""%>>document.location</option>
					
					
<option value="parent.frames[0].location" <%=nul.jeNull(vseb.getDtarget()).equals("parent.frames[0].location")?"selected":""%>>parent.frames[0].location</option>
	<option value="parent.frames[1].location" <%=nul.jeNull(vseb.getDtarget()).equals("parent.frames[1].location")?"selected":""%>>parent.frames[1].location</option>
	<option value="parent.frames[2].location" <%=nul.jeNull(vseb.getDtarget()).equals("parent.frames[2].location")?"selected":""%>>parent.frames[2].location</option>
	<option value="top.parent.frames[0].location" <%=nul.jeNull(vseb.getDtarget()).equals("top.parent.frames[0].location")?"selected":""%>>top.parent.frames[0].location</option>
	<option value="top.parent.frames[1].location" <%=nul.jeNull(vseb.getDtarget()).equals("top.parent.frames[1].location")?"selected":""%>>top.parent.frames[1].location</option>
	<option value="top.parent.frames[2].location" <%=nul.jeNull(vseb.getDtarget()).equals("top.parent.frames[2].location")?"selected":""%>>top.parent.frames[2].location</option>
				
			<option value="overtop_div" <%=nul.jeNull(vseb.getDtarget()).equals("overtop_div")?"selected":""%>>overtop div</option>
	
					</select>
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Template: </td><td class="valuecell" width="30%">
             
	<select name="dtargettemp" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
            		
            		<%
            		if (true) {
            		com.popultrade.dao.TemplateHeadDAO daog = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		
            		List lisg = daog.getTemplateHeads(new com.popultrade.model.TemplateHead(),1,1000);
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateHead vsebg = (com.popultrade.model.TemplateHead)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getDtargettemp()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getHead_naziv())%></option>
            		<%
            		
            		
            		
            		}
            		}
            		%>
            		
            		
            		</select>
					</td> 
             		 
            		  </tr>  	
            		       <tr> 
            		  
            		 <td class="opiscell" width="20%">Rocen target (jsp page, parametri preko gumb 'v'): </td><td class="valuecell" width="30%">
<input type="text" name="dtargetroc"     maxlength='150' size="50" value="<%=nul.jeNull(vseb.getDtargetroc()+"")%>" style="font-family: Verdana; font-size: 8pt">
 			            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Rocen target javascript (klice se funkcijo narejeno v dodatnih pogojih): </td><td class="valuecell" width="30%">
             <textarea name="dtargetrocjs"     rows='3' cols="50" style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDtargetrocjs()+"")%></textarea>
 
	
					</td>
             		 
            		  </tr>  
            		  
            		  
            		            <tr>
            		  
            		 <td class="opiscell" colspan=4><input type="button" id="botbutton"  onclick="opentr('otbutton1','');opentr('otbutton2','');opentr('otbutton3','');opentr('otbutton4','')" value="OPEN" style="font-family: Verdana; font-size: 7pt"> Samo v primeru da je tipa gumb touch 
					</td>
             		 
            		  </tr>   
            		  
           	            <tr id="otbutton1" style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">Barva gumba : </td><td class="valuecell" width="30%">
<input type="text" name="dbarvag"  id="hue-demo" class="demo" data-control="hue"   maxlength='7' size="7" value="<%=nul.jeNull(vseb.getDbarvag()+"")%>" style="font-family: Verdana; font-size: 8pt">
 			            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Barva gumba click: </td><td class="valuecell" width="30%">
             
<input type="text" name="dbarvagc"  id="hue-demo" class="demo" data-control="hue"   maxlength='7' size="7" value="<%=nul.jeNull(vseb.getDbarvagc()+"")%>" style="font-family: Verdana; font-size: 8pt">
 	
					</td>
             		 
            		  </tr>  		  
            		  
            		  
            		         <tr id="otbutton3" style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">Gumb nima viden opis : </td><td class="valuecell" width="30%">
	 <input type="checkbox" name="dbuttontextvisible" value="1" <%=nul.jeNull(vseb.getDbuttontextvisible()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
							            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
 	
					</td>
             		 
            		  </tr>  	
            		  
            		  
            		  
            		     		         <tr id="otbutton4" style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">Pogoj prikaza gumba : </td><td class="valuecell" colspan=3>
	
	
	     		 
    <textarea cols=100 rows=2 name="dpogojprikazg"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDpogojprikazg()) %></textarea>
	 
	
	(pogoj se prepise kot je vpisan v polju (npr: if () {). Gumb se vseeno prikaze samo je disablan.)
            		 </td>
            		 
             		
             		 
            		  </tr>  	
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
                        		  
           	            <tr id="otbutton2" style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">Slika gumba :<br>
            		 
            		 <div id="imgslik" style="display:<%=(nul.jeNull(vseb.getDslikag()).equals("")?"none":"block")%>;"><img id="slikoo" src="<%=control.lokacija_default_slik %><%=nul.jeNull(vseb.getDslikag())%>"></div>
            		 
            		  </td><td class="valuecell" colspan=3>
<input type="text" name="dslikag"   maxlength='25' size="18" value="<%=nul.jeNull(vseb.getDslikag()+"")%>" style="font-family: Verdana; font-size: 8pt"><input type="button" onclick="hidem()" value="#"  style="font-family: Verdana; font-size: 8pt"	>
 			     
 			     <div id="skrit" style="width:100%;height:100%;display:none;">
 			     
 			     <iframe  scrolling="yes" frameborder="1"  style="width:100%;height:100%" src="m_upload_d.jsp?op=add"></iframe>
 			     
 			     </div>
 			      
      		 	 
            		 </td>
            		 
             		
             		 
            		  </tr>  			  
            		  
            		  
            		  
            		  	            <tr>
            		  
            		 <td class="opiscell" colspan=4><input type="button" id="bobuttoni" onclick="opentr('obuttoni','')" value="OPEN" style="font-family: Verdana; font-size: 7pt"> Samo v primeru da je tipa button input  
					</td>
             		 
            		  </tr>   
            		  
            		  
            		        <tr id="obuttoni" style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">Tip gumba : </td><td class="valuecell" width="30%">
	 <select name="dtipbutton" style="font-family: Verdana; font-size: 8pt" >
					
             		 <option value="button" <%=nul.jeNull(vseb.getDtipbutton()).equals("button")?"selected":""%>>Button</option>
					<option value="submit" <%=nul.jeNull(vseb.getDtipbutton()).equals("submit")?"selected":""%>>Submit</option>
				
					
					</select>		            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%"> </td><td class="valuecell" width="30%">
             
	
					</td>
             		 
            		  </tr>  
            		  
            		  
            		  
            		  
            		    
            		     		            <tr>
            		  
            		 <td class="opiscell" colspan=4><input type="button" id="botimage"  onclick="opentr('otimage','')" value="OPEN" style="font-family: Verdana; font-size: 7pt"> Samo v primeru da je tip image
					</td>
             		 
            		  </tr>   
            		  
            		
            		  
            	       <tr id="otimage"  style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">Slika (v primeru , da ne izberes stolpca metode, v nasprotnem primeru, da sliko iz vrednosti v bazi):<br>
            		 
            		 <div id="imgslik2" style="display:<%=(nul.jeNull(vseb.getDimage()).equals("")?"none":"block")%>;"><img id="slikoo2" src="<%=control.lokacija_splosno_slik %><%=nul.jeNull(vseb.getDimage())%>"></div>
            		 
            		  </td><td class="valuecell" colspan=3>
<input type="text" name="dimage"   maxlength='25' size="18" value="<%=nul.jeNull(vseb.getDimage()+"")%>" style="font-family: Verdana; font-size: 8pt"><input type="button" onclick="hidem2()" value="#"  style="font-family: Verdana; font-size: 8pt"	>
 			     
 			     <div id="skrit2" style="width:100%;height:100%;display:none;">
 			     
 			     <iframe  scrolling="yes" frameborder="1"  style="width:100%;height:100%" src="m_upload_d.jsp?op=add&slik=splosne"></iframe>
 			     
 			     </div>
 			      
      		 	 
            		 </td>
            		 
             		
             		 
            		  </tr>  	
            		  
            		  
            		  
          		           <tr>
            		  
            		 <td class="opiscell" colspan=4><input type="button" id="botlisttouch" onclick="opentr('otlisttouch','')" value="OPEN" style="font-family: Verdana; font-size: 7pt"> Samo v primeru da je tip 'list area touch'
					</td>
             		 
            		  </tr>   
            		  
            		  
            		  		            <tr id="otlisttouch"  style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">Src div-a: </td><td class="valuecell" width="30%">

<textarea name="ddivsrc" rows=2 cols=77 style="font-family: Verdana; font-size: 8pt" ><%=nul.jeNull(vseb.getDdivsrc()+"")%></textarea>


			            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Id/Name div-a : </td><td class="valuecell" width="30%">
              
<input type="text" name="ddivname"   maxlength='35' size="22" value="<%=nul.jeNull(vseb.getDdivname()+"")%>" style="font-family: Verdana; font-size: 8pt">
 
					</td>
             		 
            		  </tr>   		  
            		  
            		  
            		  
            		  
            		  
            		           <tr>
            		  
            		 <td class="opiscell" colspan=4><input type="button" id="bofile" onclick="opentr('ofile2','');opentr('ofile1','')" value="OPEN" style="font-family: Verdana; font-size: 7pt"> Samo v primeru da je tip 'file'
					</td>
             		 
            		  </tr>   
            		  
            		  
            		  		            <tr id="ofile2"  style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">: </td><td class="valuecell" width="30%">


	  		 <select name="dfilename" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						
						
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
            		 
             		 <td class="opiscell" width="20%">Id/Name div-a : </td><td class="valuecell" width="30%">
              
<input type="text" name="dfilesize"   maxlength='7' size="7" value="<%=nul.jeNull(vseb.getDfilesize()+"")%>" style="font-family: Verdana; font-size: 8pt">
 
					</td>
             		 
            		  </tr>   	     
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
                <tr id="ofile1"  style="display:none"> 
            		  
            		 <td class="opiscell" width="20%">: </td><td class="valuecell" width="30%">

	 <select name="dcontenttype" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						
						
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
            		 
             		 <td class="opiscell" width="20%"> </td><td class="valuecell" width="30%">
              

					</td>
             		 
            		  </tr>   	         		  	 
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		      		  	 


<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>


function setDefaultCSS() {


if (document.dod.samo_velike_crke.checked) {

document.dod.ddivclasscusin.value='tdefaultInputVC';


}
else {
document.dod.ddivclasscusin.value='tdefaultInput';

}



}




function setOpenedtr() {

if (document.dod.tip_inserta.value=="buttoni") {
opentr("obuttoni","open");
}
else {
opentr("obuttoni","close");
}

if (document.dod.tip_inserta.value=="timage") {
opentr("otimage","open");
}
else {
opentr("otimage","close");
}

if (document.dod.tip_inserta.value=="tlistarea") {
opentr("otlisttouch","open");
}
else {
opentr("otlisttouch","close");
}


if (document.dod.tip_inserta.value=="tbutton") {
opentr("otbutton1","open");
opentr("otbutton2","open");
opentr("otbutton3","open");
opentr("otbutton4","open");


}
else {
opentr("otbutton1","close");
opentr("otbutton2","close");
opentr("otbutton3","close");
opentr("otbutton4","close");
}


if (document.dod.tip_inserta.value=="file") {
opentr("ofile1","open");
opentr("ofile2","open");

}
else {
opentr("ofile1","close");
opentr("ofile2","close");

}

}




/// open/close tr odvisno od tipa elementa
function opentr(idop,oc) {

var clost ="b"+ idop;

if (idop.substring(idop.length,idop.length-1)=="1" || idop.substring(idop.length,idop.length-1)=="2" || idop.substring(idop.length,idop.length-1)=="3" || idop.substring(idop.length,idop.length-1)=="4") {

clost ="b"+ idop.substring(0,idop.length-1);
}



if (oc=="") {
if( document.getElementById(idop).style.display=='none' ){
   document.getElementById(idop).style.display = '';
   document.getElementById(clost).value="CLOSE";
 }
 
 else{
   document.getElementById(idop).style.display = 'none';
   document.getElementById(clost).value="OPEN";
   
 }
 }
else if (oc=="close") {
document.getElementById(idop).style.display = 'none';
document.getElementById(clost).value="OPEN";
}
else if (oc=="open") {
document.getElementById(idop).style.display = '';
document.getElementById(clost).value="CLOSE";
}

}




function hidem() {

if ( document.getElementById('skrit').style.display == 'block') {
    document.getElementById('skrit').style.display = 'none';
}
else {
    document.getElementById('skrit').style.display = 'block';
}

}


function setImage2( imgname) {
document.dod.dimage.value=imgname;
document.getElementById("slikoo2").src="<%=control.lokacija_splosno_slik%>"+imgname;
document.getElementById('imgslik2').style.display = 'block';
 document.getElementById('skrit2').style.display = 'none';
}


function hidem2() {

if ( document.getElementById('skrit2').style.display == 'block') {
    document.getElementById('skrit2').style.display = 'none';
}
else {
    document.getElementById('skrit2').style.display = 'block';
}

}


function setImage( imgname) {
document.dod.dslikag.value=imgname;
document.getElementById("slikoo").src="default_slike/"+imgname;
document.getElementById('imgslik').style.display = 'block';
 document.getElementById('skrit').style.display = 'none';
}

function custom() {


return true;
}
function mom() {
setOpenedtr();

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