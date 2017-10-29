<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />


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
com.popultrade.model.TemplateUpload vseb =new com.popultrade.model.TemplateUpload();
com.popultrade.dao.TemplateUploadDAO dao = (com.popultrade.dao.TemplateUploadDAO)contextUtil.getBeanDao("templateUploadDAO",pageContext.getServletContext());


if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("prevod"))  {
	
	

	
	
}



if (request.getParameter("idt")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateUploadByHeadId(request.getParameter("idt"));

if (vseb==null) {
vseb =new com.popultrade.model.TemplateUpload();
}
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("idt")!=null && !request.getParameter("idt").equals("")) {
		vseb = dao.getTemplateUploadByHeadId(nul.jeNullDefault(request.getParameter("idt")));
	
	}
	else {
		vseb.setTemplatehead_id(new Long(request.getParameter("idt")));
	}

vseb = (com.popultrade.model.TemplateUpload)contextUtil.getPopulatedObject(vseb,request);

System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");


vseb.setUporabi_watermark(nul.jeNull(request.getParameter("uporabi_watermark")).equals("1")?"1":"0");


vseb.setUpload_slika_resize(nul.jeNull(request.getParameter("upload_slika_resize")).equals("1")?"1":"0");
vseb.setUpload_slika_v_resize(nul.jeNull(request.getParameter("upload_slika_v_resize")).equals("1")?"1":"0");



System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1");






dao.saveTemplateUpload(vseb);


Enumeration enn = request.getParameterNames();

while (enn.hasMoreElements()) {
	
	String str = (String)enn.nextElement();
	
	if (str!=null && str.startsWith("prevod_")) {
		
		String[] stru = str.split("_");
		com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
		com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
		
		
		prevo.setPrevod_id(new Long(stru[1]));
		prevo.setSifra_jez(session.getAttribute("jezikv")+"");
		prevo.setVrsta(stru[2]);
		if (stru.length==4 && !stru[3].equals("")) {
		//	prevo.setId(new Long(stru[3]));
			
		}
		prevo = daop.getPrevodiCopy(prevo);
		
		if (prevo==null) {
			prevo = new com.popultrade.model.Prevodi();
			prevo.setPrevod(nul.jeNull(request.getParameter(str)));
			prevo.setPrevod_id(new Long(stru[1]));
			prevo.setSifra_jez(session.getAttribute("jezikv")+"");
			prevo.setVrsta(stru[2]);
			
		}
		prevo.setPrevod(nul.jeNull(request.getParameter(str)));
		
		daop.savePrevodi(prevo);
		
		
	}
	
	
	
}





}
}
Hashtable prepc = new Hashtable();
Hashtable prevc = new Hashtable();


Hashtable prepb = new Hashtable();
Hashtable prevb = new Hashtable();
/// prevod pregleda
Hashtable prep = new Hashtable();
Hashtable prepd = new Hashtable();
/// prevod vnosa
Hashtable prev = new Hashtable();
Hashtable prevd = new Hashtable();
/// id prevoda_ce obstaja
Hashtable previd = new Hashtable();

/// dobim vse prevode
com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
prevo.setSifra_jez(session.getAttribute("jezikp")+"");
List limo = daop.getPrevodis(prevo);

Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodis(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	previd.put(prv.getPrevod_id()+"",prv.getId()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
prevo.setVrsta("D");
limo = daop.getPrevodisDodatno(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prevd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikp")+"");
prevo.setVrsta("D");
limo = daop.getPrevodisDodatno(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prepd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}



//prevo.setSifra_jez(session.getAttribute("jezikv")+"");
//prevo.setVrsta("C");
//limo = daop.getPrevodisDodatno(prevo);
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","C");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prevc.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

//prevo.setSifra_jez(session.getAttribute("jezikp")+"");
//prevo.setVrsta("C");
//limo = daop.getPrevodisDodatno(prevo);

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","C");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prepc.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}





//prevo.setSifra_jez(session.getAttribute("jezikv")+"");
//prevo.setVrsta("B");
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","B");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prevb.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

//prevo.setSifra_jez(session.getAttribute("jezikp")+"");
//prevo.setVrsta("B");

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","B");
//limo = daop.getPrevodisDodatno(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prepb.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}






Hashtable ht =new Hashtable();
ht.put("lokacija_gumba","lokacija_gumba");
ht.put("target_gumba","target_gumba");
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

<form name=dod action="m_templateupload.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idt" value="<%=request.getParameter("idt")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prep.get(vseb.getId()+""))%> <a>(slika 1-10)</a></td><td class="valuecell" width="30%">
            		<%
            		if (!nul.jeNull(vseb.getId()+"").equals("")) {
            		%>
Prevod:<input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%> " value="<%=nul.jeNull((String)prev.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 <%
            		}
            		 %>
            		 &nbsp;</td>
            		 
             		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prepc.get(vseb.getId()+""))%> <a>(potrdi)</a></td><td class="valuecell" width="30%">
    		<%
            		if (!nul.jeNull(vseb.getId()+"").equals("")) {
            		%>
Prevod:<input type="text" name="prevod_<%=vseb.getId()%>_C_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prevc.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 <%
            		}
            		 %>            
					
					
					
					&nbsp;</td>
             		 
            		  </tr>


            		  <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prepb.get(vseb.getId()+""))%> <a>(odstrani sliko)</a></td><td class="valuecell" width="30%">
            		<%
            		if (!nul.jeNull(vseb.getId()+"").equals("")) {
            		%>
Prevod:<input type="text" name="prevod_<%=vseb.getId()%>_B_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%> " value="<%=nul.jeNull((String)prevb.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 <%
            		}
            		 %>
            		 &nbsp;</td>
            		 
             		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prepd.get(vseb.getId()+""))%> <a>(datoteke)</a></td><td class="valuecell" width="30%">
    		<%
            		if (!nul.jeNull(vseb.getId()+"").equals("")) {
            		%>
Prevod:<input type="text" name="prevod_<%=vseb.getId()%>_D_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prevd.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 <%
            		}
            		 %>            
					
					
					
					&nbsp;</td>
             		 
            		  </tr>







            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Filter upload (definiras in locis z vejico extensione, ki je mogoce upload)</td><td class="valuecell" width="30%">
             
            		 <input type="text" name="upload_filter" size="70" maxlength='100' value="<%=nul.jeNull(vseb.getUpload_filter()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            
            	</td>
            		 
             		 <td class="opiscell" width="20%">Stevilo upload (stevilo upload polj, max 10):</td><td class="valuecell" width="30%">
             		 		<select name="upload_stevilo_polj" style="font-family: Verdana; font-size: 8pt" >
             		 		
					<option value="1" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("1")?"selected":""%>>1</option>
					<option value="2" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("2")?"selected":""%>>2</option>
					<option value="3" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("3")?"selected":""%>>3</option>
					<option value="4" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("4")?"selected":""%>>4</option>
					<option value="5" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("5")?"selected":""%>>5</option>
					<option value="6" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("6")?"selected":""%>>6</option>
					<option value="7" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("7")?"selected":""%>>7</option>
					<option value="8" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("8")?"selected":""%>>8</option>
					<option value="9" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("9")?"selected":""%>>9</option>
					<option value="10" <%=nul.jeNull(vseb.getUpload_stevilo_polj()).equals("10")?"selected":""%>>10</option>
					
					
					
			
					</select>
					
					
					
					
					
					&nbsp;</td>
             		 
            		  </tr>















            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi resize upload slike za <b>malo</b> sliko: </td><td class="valuecell" width="30%">
            		 
            	             <input type="checkbox" name="upload_slika_resize" value="1" <%=nul.jeNull(vseb.getUpload_slika_resize()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">

            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Uporabi resize upload slike za <b>veliko</b> sliko:  </td><td class="valuecell" width="30%">
             		 
     <input type="checkbox" name="upload_slika_v_resize" value="1" <%=nul.jeNull(vseb.getUpload_slika_v_resize()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">

					
					</td>
             		 
            		  </tr>
            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Slika mala sirina: </td><td class="valuecell" width="30%">

					 <input type="text" name="upload_slika_width" maxlength="5" size="5" value="<%=nul.jeNull(vseb.getUpload_slika_width()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
					        		 
        		 	 </td>
            		 
             		 <td class="opiscell">Slika velika sirina: </td><td class="valuecell">
             		
             		 <input type="text" name="upload_slika_v_width" maxlength="5" size="5" value="<%=nul.jeNull(vseb.getUpload_slika_v_width()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 
        		  </tr>
        		  
        		            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Slika mala visina: </td><td class="valuecell" width="30%">

					 <input type="text" name="upload_slika_height" maxlength="5" size="5" value="<%=nul.jeNull(vseb.getUpload_slika_height()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
					        		 
        		 	 </td>
            		 
             		 <td class="opiscell">Slika velika visina: </td><td class="valuecell">
             		
             		 <input type="text" name="upload_slika_v_height" maxlength="5" size="5" value="<%=nul.jeNull(vseb.getUpload_slika_v_height()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 
        		  </tr>  
        		  
        		  
        		  
        		  
        		  
        		  <tr>
        		  
        		<td class="valuecell" colspan="4">
        		 &nbsp;
	
					
					        		 
        		 </td>
        		 </tr>




            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi watermark: </td><td class="valuecell" width="30%">
            		 
            	             <input type="checkbox" name="uporabi_watermark" value="1" <%=nul.jeNull(vseb.getUporabi_watermark()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">

            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Lokacija watermarka:  </td><td class="valuecell" width="30%">
             		 
  <input type="text" name="lokacija_watermark" maxlength="100" size="70" value="<%=nul.jeNull(vseb.getLokacija_watermark()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
					
					</td>
             		 
            		  </tr>



<tr><td colspan="4" class="opiscell" align="center">

 <input type="submit" value="Shrani prevode"  style="font-family: Verdana; font-size: 8pt">

<input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
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
function mom() {


}
<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[2].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
     
     }
     else {
parent.frames[2].document.location = parent.frames[2].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     }
     else {
     parent.frames[2].document.location = parent.frames[2].document.location + "?idback=<%=request.getParameter("id")%>";

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