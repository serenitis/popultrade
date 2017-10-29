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
com.popultrade.model.TemplateList vseb =new com.popultrade.model.TemplateList();
com.popultrade.dao.TemplateListDAO dao = (com.popultrade.dao.TemplateListDAO)contextUtil.getBeanDao("templateListDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateList(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateList(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplatehead_id(new Long(request.getParameter("idt")));
//vseb.setTemplateClass(null);
	}

vseb = (com.popultrade.model.TemplateList)contextUtil.getPopulatedObject(vseb,request);
vseb.setStolpec_checkbox(nul.jeNull(request.getParameter("stolpec_checkbox")).equals("1")?"1":"0");
vseb.setUporabi_onmouseover_prikaz(nul.jeNull(request.getParameter("uporabi_onmouseover_prikaz")).equals("1")?"1":"0");
vseb.setStolpec_max_width_uporabi(nul.jeNull(request.getParameter("stolpec_max_width_uporabi")).equals("1")?"1":"0");

vseb.setStolpec_fiksen(nul.jeNull(request.getParameter("stolpec_fiksen")).equals("1")?"1":"0");
vseb.setStolpec_sekundaren(nul.jeNull(request.getParameter("stolpec_sekundaren")).equals("1")?"1":"0");
vseb.setStolpec_primaren(nul.jeNull(request.getParameter("stolpec_primaren")).equals("1")?"1":"0");
vseb.setStolpec_order(nul.jeNull(request.getParameter("stolpec_order")).equals("1")?"1":"0");
vseb.setStolpec_prikazi_mail(nul.jeNull(request.getParameter("stolpec_prikazi_mail")).equals("1")?"1":"0");
vseb.setUporabi_div_vrednost(nul.jeNull(request.getParameter("uporabi_div_vrednost")).equals("1")?"1":"0");
vseb.setJeslika(nul.jeNull(request.getParameter("jeslika")).equals("1")?"1":"0");
dao.saveTemplateList(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("stolpec_naziv","stolpec_naziv");
ht.put("stolpec_metoda","stolpec_metoda");
ht.put("stolpec_width","stolpec_width");
//Hashtable htn =new Hashtable();
//htn.put("stolpec_width","stolpec_width");
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

<form name=dod action="m_templatelist_edit_t.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idtf" value="<%=nul.jeNull(request.getParameter("idtf"))%>">


<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Stolpec naziv: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="stolpec_naziv" maxlength='70' value="<%=nul.jeNull(vseb.getStolpec_naziv()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Stolpec width (enota % ali px): </td><td class="valuecell" width="30%">
             		 
					<input type="text" name="stolpec_width" maxlength='5' size="6" value="<%=nul.jeNull(vseb.getStolpec_width()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
             		 
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
            		 
        		 <td class="opiscell">Stolpec format:<br>(datum: dd-MM-yyyy HH:mm)<br>(number: #####0.00)</td><td class="valuecell">
        		 
        		 <input type="text" name="format_stolpca"   maxlength='20' value="<%=nul.jeNull(vseb.getFormat_stolpca())%>" style="font-family: Verdana; font-size: 8pt">
        		 
        		 
        		 </td>
        		 
</tr>

  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi maximalno sirino stolpca: </td><td class="valuecell" width="30%">
 <input type="checkbox" name="stolpec_max_width_uporabi" value="1" <%=nul.jeNull(vseb.getStolpec_max_width_uporabi()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Maximalna sirina stolpca(vecje stevilo znakov v vrednosti od vnesene vrednosti se poreze): </td><td class="valuecell" width="30%">
             		 
					<input type="text" name="stolpec_max_width" maxlength='3' size="3" value="<%=nul.jeNull(vseb.getStolpec_max_width()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
             		 
            		  </tr>
            		  
            		  
            		  
            		  
    <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi stolpec kot checkbox: </td><td class="valuecell" colspan=3>
 <input type="checkbox" name="stolpec_checkbox" value="1" <%=nul.jeNull(vseb.getStolpec_checkbox()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
		 V primeru da zelimo izbrati vec recordov hkrati se doda checkbox stolpec. Vrednost v Stolpec metoda se poda kot parameter za nadaljno obdelavo (podobno kot parametri preko gumba). Pri kreaciji gumba je treba oznacit , da dobi parametre preko checkboxa ter ime iz Stolpec metoda.
            	<br>Gumb je lahko le v hint vrstici!	 
            		 </td>
            		 
             	
            		  </tr>          		  
            		  
            		  
            		                        <tr>
            		  
            		 <td class="opiscell" width="20%">Polje je slika: </td><td class="valuecell" width="30%">
 <input type="checkbox" name="jeslika" value="1" <%=nul.jeNull(vseb.getJeslika()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				            		 
      		 	 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Slika width:<br>Slika height:<br> </td><td class="valuecell" width="30%">
             
<input type="text" name="slika_width"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getSlika_width()+"")%>" style="font-family: Verdana; font-size: 8pt"><br>
<input type="text" name="slika_height"   maxlength='4' size="4" value="<%=nul.jeNull(vseb.getSlika_height()+"")%>" style="font-family: Verdana; font-size: 8pt">
 
 




					</td>
             		 
            		  </tr> 
            		  
            		          		  
            		  		  
            		  
            		  
            		  
     <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi span okoli vrednosti (za spremembe preko JS): </td><td class="valuecell" width="30%">
            		 
 <input type="checkbox" name="uporabi_div_vrednost" value="1" <%=nul.jeNull(vseb.getUporabi_div_vrednost()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Ime span-a okoli vrednosti (ime span-a je to polje + id recorda): </td><td class="valuecell" width="30%">
             		 
					<input type="text" name="uporabi_div_ime" maxlength='35' size="30" value="<%=nul.jeNull(vseb.getUporabi_div_ime()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
             		 
            		  </tr>         		  
            		  
            		  
               <tr>
            		  
            		 <td class="opiscell" width="20%"><!-- Stolpec uporabi samo pri posiljanju mailov:  --></td><td class="valuecell" width="30%">
     <!--        		 
 <input type="checkbox" name="stolpec_prikazi_mail" value="1" <%=nul.jeNull(vseb.getStolpec_prikazi_mail()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
  -->
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Pogoj za prikaz stolpca format (if (###POGOJ###) {) </td><td class="valuecell" width="30%">
             		 <textarea cols="100" name="pogoj_prikaz_stolpec" rows="4" style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getPogoj_prikaz_stolpec()).replaceAll("\'","\"")%></textarea></td>
             		 
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
var mon = parent.frames[2].document.location+"";

  
parent.frames[2].document.location = parent.frames[2].document.location;

</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>