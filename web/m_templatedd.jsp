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
com.popultrade.model.TemplateDD vseb =new com.popultrade.model.TemplateDD();
com.popultrade.dao.TemplateDDDAO dao = (com.popultrade.dao.TemplateDDDAO)contextUtil.getBeanDao("templateDDDAO",pageContext.getServletContext());

if (request.getParameter("idbr")!=null && !request.getParameter("idbr").equals("")) {
	
	dao.removeTemplateDD(new Long(request.getParameter("idbr")));
	
}
 
if (request.getParameter("idg")!=null && request.getParameter("akcija")==null) {
	
	
	

if (session.getAttribute("kontrola")!=null) {
vseb = dao.getTemplateDDKontrolas(nul.jeNullDefault(request.getParameter("idg")),session.getAttribute("kontrola")+"");
}
else {
	vseb = dao.getTemplateDDs(nul.jeNullDefault(request.getParameter("idg")));

}

}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
	
				
				vseb = dao.getTemplateDD(new Long(nul.jeNullDefault(request.getParameter("id"))));
			
	}
	else {
vseb.setTemplateui_id(new Long(session.getAttribute("idg")+""));
if (session.getAttribute("kontrola")!=null) {
vseb.setKontrola(session.getAttribute("kontrola")+"");
}
}

vseb = (com.popultrade.model.TemplateDD)contextUtil.getPopulatedObject(vseb,request);
 
vseb.setStatus(nul.jeNull(request.getParameter("status")).equals("1")?"1":"0");
vseb.setUporabi_dodaten_hql_pogoj(nul.jeNull(request.getParameter("uporabi_dodaten_hql_pogoj")).equals("1")?"1":"0");
vseb.setUporabi_kontrolo_rocno(nul.jeNull(request.getParameter("uporabi_kontrolo_rocno")).equals("1")?"1":"0");
vseb.setUporabi_kontrolo_vrednosti(nul.jeNull(request.getParameter("uporabi_kontrolo_vrednosti")).equals("1")?"1":"0");
vseb.setUporabi_js_db(nul.jeNull(request.getParameter("uporabi_js_db")).equals("1")?"1":"0");
dao.saveTemplateDD(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("class_name","class_name");
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
if (request.getParameter("akcija")==null && request.getParameter("idbr")==null) {
%>

<form name=dod action="m_templatedd.jsp" method="post" onSubmit="return check()">

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



<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr>
	<td colspan="4" class="opiscell">&nbsp;</td></tr>


<tr>
            		  
<td class="opiscell" width="20%">Opis:&nbsp;</td><td class="valuecell"  colspan=3>
            	
         <input type="text" name="opis" maxlength='250' size=80 value="<%=nul.jeNull(vseb.getOpis()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		    		 
</td>
</tr>
<tr>
<td class="opiscell" width="20%">Class:&nbsp;</td><td class="valuecell"  colspan=3>
  		 <select name="class_name" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					List li = templateUtil.getClasseNamesInPackage(contextUtil,this.getServletContext(),"","");
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getClass_name()))) {
					%>
					
					
					<option value="<%=nex%>" selected><%=nex%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex%>" ><%=nex%></option>
							
							
							<%	
							
							
						}
					}
					%>
					
					
					</select>
</td>
</tr>


<tr>
            		  
<td class="opiscell" width="20%">Status (uporabi da/ne):&nbsp;</td><td class="valuecell"  colspan=3>
            	
        <input type="checkbox" name="status" value="1" <%=nul.jeNull(vseb.getStatus()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		   		    		 
</td>
</tr>




<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatni pogoji (order by, ime parametra vedno z veliko zacetnico oz. kot je v Class datoteki):</td><td class="valuecell" colspan=3>
            	
            	<input type="text" name="head_select_dodatni_pogoji" maxlength='35' size="35" value="<%=nul.jeNull(vseb.getHead_select_dodatni_pogoji()+"")%>" style="font-family: Verdana; font-size: 8pt">
            	
            		 <select name="order_by_smer" style="font-family: Verdana; font-size: 8pt" >
            		 <option></option>
					<option value="asc" <%=nul.jeNull(vseb.getOrder_by_smer()).equals("asc")?"selected":""%>>Ascending</option>
					<option value="desc" <%=nul.jeNull(vseb.getOrder_by_smer()).equals("desc")?"selected":""%>>Descending</option>
				
					</select>
            	
            	</td>
            	 
            	</tr>
<tr>
            		  
<td class="opiscell" width="20%">Minimalno stveilo znakov:&nbsp;</td><td class="valuecell"  colspan=3>
            	
        <input type="text" name="min_st_znakov" maxlength='2' size=2 value="<%=nul.jeNull(vseb.getMin_st_znakov()+"")%>" style="font-family: Verdana; font-size: 8pt">
     (minimalno stevilo znakov, ki je potrebno vnesti v polje preden se izvede iskanje v bazi)         		   		    		 
</td>
</tr>


<tr>
            		  
<td class="opiscell" width="20%">Prenesi vrednost le, ce je textbox prazen:&nbsp;</td><td class="valuecell"  colspan=3>
            	
        <input type="checkbox" name="uporabi_kontrolo_vrednosti" value="1" <%=nul.jeNull(vseb.getUporabi_kontrolo_vrednosti()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
         (oznaceno -> prenese vrednost v textbox polje le ce je polje prazno)   		   		    		 
</td>
</tr>




<tr>
            		  
<td class="opiscell" width="20%">Dodaten HQL pogoj (uporabi da/ne):&nbsp;</td><td class="valuecell"  colspan=3>
            	
        <input type="checkbox" name="uporabi_dodaten_hql_pogoj" value="1" <%=nul.jeNull(vseb.getUporabi_dodaten_hql_pogoj()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		   		    		 
</td>
</tr>


<tr>
            		  
<td class="opiscell" width="20%">Uporabi JS DB:&nbsp;</td><td class="valuecell"  colspan=3>
            	
        <input type="checkbox" name="uporabi_js_db" value="1" <%=nul.jeNull(vseb.getUporabi_js_db()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
      (uporabi javascript database za prikaz dropdown, tabela mora biti izbrana pod JS database menijem)      		   		    		 
</td>
</tr>


<tr>
            		  
<td class="opiscell" width="20%">Pogoj za uporabo dodatnega HQL (format if (###FORMAT###)):&nbsp;</td><td class="valuecell"  colspan=3>
            	
        <textarea name="pogoj_za_uporabo_hql" maxlength='350' cols=80 rows=2 style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getPogoj_za_uporabo_hql()+"")%></textarea>
              		    		 
</td>
</tr>
<tr>
            		  
<td class="opiscell" width="20%">Dodaten HQL pogoj:&nbsp;</td><td class="valuecell"  colspan=3>
            	
         <textarea  name="dodaten_hql_pogoj" maxlength='350' cols=80 rows=2 style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDodaten_hql_pogoj()+"")%></textarea>
            		    		 
</td>
</tr>

<%
if (!nul.jeNull(vseb.getKontrola()+"").equals("")) {
	%>
<tr>
            		  
<td class="opiscell" width="20%">Kontrola JS rocno ali avtomaticno (ce je oznaceno, se klice funkcijo le, ce je dodano rocno pod JS kontrolo ["check"+ime classe+id template dd kontrole]):&nbsp;</td><td class="valuecell"  colspan=3>
            	
       <input type="checkbox" name="uporabi_kontrolo_rocno" value="1" <%=nul.jeNull(vseb.getUporabi_kontrolo_rocno()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
         <Br> ime js function: check<%=nul.jeNull(vseb.getClass_name()).toLowerCase()%><%=nul.jeNull(vseb.getId()) %>()<Br>
          ime jsp-ja: <%=nul.jeNull(vseb.getClass_name()).toLowerCase()%><%=nul.jeNull(vseb.getId()) %>_kon.jsp  		    		 
</td>
</tr>
<%
}
%>
<tr><td colspan="4" class="opiscell" align="center">


<%
if (!nul.jeNull(vseb.getId()+"").equals("")) {
	%>


<input type="button" value="Pogoji za prikaz clase" onclick="parent.frames[1].location='m_templateddp_framein.jsp?idd=<%=vseb.getId()%>'" style="font-family: Verdana; font-size: 8pt">

<input type="button" value="Rezultati iz clase" onclick="parent.frames[1].location='m_templateddpp_framein.jsp?idd=<%=vseb.getId()%>'" style="font-family: Verdana; font-size: 8pt">


<%	
}
%>



<input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr>


<%
if (!nul.jeNull(vseb.getId()+"").equals("")) {
	%>


<tr><td colspan="4" class="opiscell" align="center">
<input type=button value="Brisi ajax" onclick="remo('<%=vseb.getId()%>')" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr>

<%	
}
%>






</table></form>
<script language='javascript'>


function remo(sss) {

document.location = "m_templatedd.jsp?idbr="+sss;
}


function dodajv() {
document.dod.dodatno_insert.value = document.dod.dodatno_insert.value + " "+
document.dod.im1.value + "('"+ 
document.dod.im2.value + "');\n";

}


function dodajv2() {
document.dod.dodatno_update.value = document.dod.dodatno_update.value + " "+
document.dod.im11.value + "('"+ 
document.dod.im22.value + "');\n";

}

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
<p align="center">
<%
if (request.getParameter("idbr")==null) {
%>
PODATKI VNESENI/SPREMENJENI
<%
}
else {
	%>
	PODTKI ZBRISANI
	<%
}
%>
</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>

<script language=javascript>

</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>