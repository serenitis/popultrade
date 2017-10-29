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

vseb.setPdf_header(nul.jeNull(request.getParameter("pdf_header")).equals("1")?"1":"0");
vseb.setJeslika(nul.jeNull(request.getParameter("jeslika")).equals("1")?"1":"0");
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

<form name=dod action="m_templateview_pdf_edit.jsp" method="post" onSubmit="return check()">

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
					

					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+session.getAttribute("classname"));
					
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
            		  
            		 <td class="opiscell" width="20%">Je header (v primeru, da gre za header oz naslov dokumenta mora biti naslednje polje definirano kot prazno polje ter polje header mora biti na levi strani, header se lahko uporabi le v prvem view): </td><td class="valuecell" width="30%">
   <input type="checkbox" name="pdf_header" value="1" <%=nul.jeNull(vseb.getPdf_header()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
				          		 
            		
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Tip sume oz sestevka vrednosti (tip polja mora biti numericno):</td><td class="valuecell" width="30%">
            	 	  		 <select name="tip_sestevka" style="font-family: Verdana; font-size: 8pt" >
            		  
            		 <option value=""></option>
					<option value="COUNT" <%=nul.jeNull(vseb.getTip_sestevka()).equals("COUNT")?"selected":""%>>Sestej</option>
					<option value="SUM" <%=nul.jeNull(vseb.getTip_sestevka()).equals("SUM")?"selected":""%>>Sumiraj</option>
					</select>
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