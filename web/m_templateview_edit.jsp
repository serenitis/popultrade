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
com.popultrade.model.TemplateView vseb =new com.popultrade.model.TemplateView();
com.popultrade.dao.TemplateViewDAO dao = (com.popultrade.dao.TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateView(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateView(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		
		
	
			vseb.setTemplatehead_id(new Long(request.getParameter("idt")));
			if (request.getParameter("idn")!=null && !request.getParameter("idn").equals("")) {
				
				vseb.setTemplatehead_id(null);
				vseb.setTemplateview_id(new Long(request.getParameter("idn")));
			}
					
//vseb.setTemplatehead_id(new Long(request.getParameter("idt")));


//vseb.setTemplateClass(null);




	}

vseb = (com.popultrade.model.TemplateView)contextUtil.getPopulatedObject(vseb,request);
vseb.setJeslika(nul.jeNull(request.getParameter("jeslika")).equals("1")?"1":"0");
vseb.setHint_pomoc(nul.jeNull(request.getParameter("hint_pomoc")).equals("1")?"1":"0");
vseb.setJeslikaizbaze(nul.jeNull(request.getParameter("jeslikaizbaze")).equals("1")?"1":"0");
dao.saveTemplateView(vseb);

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

<form name=dod action="m_templateview_edit.jsp" method="post" onSubmit="return check()">

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
					<option value="NR" <%=nul.jeNull(vseb.getTip_polja()).equals("NR")?"selected":""%>>Ni prevoda</option>
					
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
						if (true) {
					
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
	String modde = thead.getHead_class_name();
					
					if (thead.getHead_class_name_nosql()!=null && !thead.getHead_class_name_nosql().equals("")) {
						modde = thead.getHead_class_name_nosql();
					}
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+modde);
					
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
            		 
        		 <td class="opiscell">Stolpec format:<br>(datum: dd-MM-yyyy HH:mm)<br>(number: #####0.00)</td><td class="valuecell">
        		 
        		 <input type="text" name="format_stolpca"   maxlength='20' value="<%=nul.jeNull(vseb.getFormat_stolpca())%>" style="font-family: Verdana; font-size: 8pt">
        		 
        		 
        		 </td>
        		 
</tr>

                      <tr>
            		  
            		 <td class="opiscell" width="20%">Polje je slika:<br>Template za prikaz slike (poslje se id kot parameter): </td><td class="valuecell" width="30%">
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
					thead.setHead_tip("OB");
					
					List li = daoth.getTemplateHeads(thead, 1, 50, "", "head_naziv", "");
					
					//List li = daoth.getTemplateHeads(null);
					
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
            		  
            		 <td class="opiscell" width="20%">Uporabi Hint za pomoc:</td><td class="valuecell" colspan="3">
            		  <input type="checkbox" name="hint_pomoc" value="1" <%=nul.jeNull(vseb.getHint_pomoc()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				 
            		 (omogoci se vnos pomoc teksta vezanega na polje, tekst se prikaze na webu po kliku na opis polja)
      		 &nbsp;</td>
            		 
        
             		 
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


if (document.dod.jeslikaizbaze.checked) {

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
var mon = parent.frames[2].document.location+"";

<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[2].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     
     }
     else {
parent.frames[2].document.location = parent.frames[2].document.location + "&idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     }
     }
     else {
     parent.frames[2].document.location = parent.frames[2].document.location + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";

     }
}
<%
}
else {
%>
    if (mon.indexOf("id=")!=-1) {
    
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?"));
     }
     else {
    
parent.frames[2].document.location = parent.frames[2].document.location;
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