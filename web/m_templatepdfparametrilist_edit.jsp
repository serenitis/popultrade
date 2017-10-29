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
com.popultrade.model.TemplatePdfParametri vseb =new com.popultrade.model.TemplatePdfParametri();
com.popultrade.dao.TemplatePdfParametriDAO dao = (com.popultrade.dao.TemplatePdfParametriDAO)contextUtil.getBeanDao("templatePdfParametriDAO",pageContext.getServletContext());
if (request.getParameter("idt")!=null  && request.getParameter("akcija")==null) {
vseb = dao.getTemplatePdfParametriByVezaId(new Long(nul.jeNullDefault(request.getParameter("idt"))));
if (vseb==null) {
	vseb =new com.popultrade.model.TemplatePdfParametri();
}
} 

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplatePdfParametri(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		

					
vseb.setVeza_id(new Long(request.getParameter("idt")));




	}

vseb = (com.popultrade.model.TemplatePdfParametri)contextUtil.getPopulatedObject(vseb,request);
vseb.setPdf_list_okvir(nul.jeNull(request.getParameter("pdf_list_okvir")).equals("1")?"1":"0");
vseb.setPdf_head_glava_lista_font_width(nul.jeNull(request.getParameter("pdf_head_glava_lista_font_width")).equals("1")?"1":"0");
vseb.setPdf_list_brez_head(nul.jeNull(request.getParameter("pdf_list_brez_head")).equals("1")?"1":"0");

dao.saveTemplatePdfParametri(vseb);

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

<form name=dod action="m_templatepdfparametrilist_edit.jsp" method="post" onSubmit="return check()">

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
            		  
            		 <td class="opiscell" width="20%">Pdf font size header lista: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="pdf_head_glava_lista_font_size" maxlength='5' size='5' value="<%=nul.jeNull(vseb.getPdf_head_glava_lista_font_size()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Pdf font size header lista debelina (bold): </td><td class="valuecell" width="30%">
            		 
            		 <input type="checkbox" name="pdf_head_glava_lista_font_width" value="1" <%=nul.jeNull(vseb.getPdf_head_glava_lista_font_width()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
		 
            		 
            		 </td>
             		 
            		  </tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prikazi okvir lista (okvir okoli tabele): </td><td class="valuecell" width="30%">
   <input type="checkbox" name="pdf_list_okvir" value="1" <%=nul.jeNull(vseb.getPdf_list_okvir()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				          		 
            		
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Pdf font size za vrednost:</td><td class="valuecell" width="30%">
            	 <input type="text" name="pdf_font_size" maxlength='5' size='5' value="<%=nul.jeNull(vseb.getPdf_font_size()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
             		 
            		  </tr>



       	
            		  
                   		  <tr>
            		  
            		 <td class="opiscell" width="20%">Ne prikazi opis stolpcev: </td><td class="valuecell" width="30%">
   <input type="checkbox" name="pdf_list_brez_head" value="1" <%=nul.jeNull(vseb.getPdf_list_brez_head()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				          		 
            		
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Margin (presledek pred zgornjim elementom): </td><td class="valuecell" width="30%">
            		  <input type="text" name="margin_top" maxlength='5' size='5' value="<%=nul.jeNull(vseb.getMargin_top()+"")%>" style="font-family: Verdana; font-size: 8pt">
            	
            		 </td>
             		 
            		  </tr>     		  
            		  
            		  
                 		  <tr>
            		  
            		 <td class="opiscell" width="20%">Pdf header padding: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="pdf_header_padding" maxlength='2' size='2' value="<%=nul.jeNull(vseb.getPdf_header_padding()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Pdf header spacing: </td><td class="valuecell" width="30%">
            		   <input type="text" name="pdf_header_spacing" maxlength='2' size='2' value="<%=nul.jeNull(vseb.getPdf_header_spacing()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            	 
            		 
            		 </td>
             		 
            		  </tr>  		  
            		  
            		  


 <tr>
            		  
            		 <td class="opiscell" width="20%">Padding top (brez pt, kot vse, rabi ket padding ne uposteva top opcije): </td><td class="valuecell" width="30%">
            		 
            		    <input type="text" name="padding_top" maxlength='2' size='2' value="<%=nul.jeNull(vseb.getPadding_top()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Barva header lista (format: #E6E6E6): </td><td class="valuecell" width="30%">

  <input type="text" name="pdf_header_bgcolor_prevod" maxlength='6' size='6' value="<%=nul.jeNull(vseb.getPdf_header_bgcolor_prevod()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		

	 
            		 </td>
             		 
            		  </tr>  




 <tr>
            		  
            		 <td class="opiscell" width="20%">Line height (brez pt enote): </td><td class="valuecell" width="30%">
            		 
            		    <input type="text" name="line_height" maxlength='2' size='2' value="<%=nul.jeNull(vseb.getLine_height()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
                   		 
             		 <td class="opiscell" width="20%">Padding: </td><td class="valuecell" width="30%">

<input type="text" name="padding" maxlength='2' size='2' value="<%=nul.jeNull(vseb.getPadding()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
	 
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
var mon = parent.frames[0].document.location+"";

<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[0].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     
     }
     else {
parent.frames[0].document.location = parent.frames[0].document.location + "&idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     }
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";

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