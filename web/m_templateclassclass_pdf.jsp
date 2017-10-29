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
com.popultrade.model.TemplateClassClass vseb =new com.popultrade.model.TemplateClassClass();
com.popultrade.dao.TemplateClassClassDAO dao = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateClassClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateClassClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}

vseb = (com.popultrade.model.TemplateClassClass)contextUtil.getPopulatedObject(vseb,request);
dao.saveTemplateClassClass(vseb);

}
}

//Hashtable ht =new Hashtable();
//ht.put("vrednost","vrednost");
//ht.put("vrednost pogoja","vrednost_pogoja");
Hashtable htn =new Hashtable();
htn.put("max_st_izpisov","max_st_izpisov");
%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %>

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"    <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateclassclass_pdf.jsp" method="post" onSubbmit="return check()">

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

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Order by: </td><td class="valuecell" width="30%">
            	<textarea rows="1" cols="55" name="head_select_dodatni_pogoji" style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getHead_select_dodatni_pogoji()+"")%></textarea>	 
    
            	
            		 <select name="order_by_smer" style="font-family: Verdana; font-size: 8pt" >
            		 <option></option>
					<option value="asc" <%=nul.jeNull(vseb.getOrder_by_smer()).equals("asc")?"selected":""%>>Ascending</option>
					<option value="desc" <%=nul.jeNull(vseb.getOrder_by_smer()).equals("desc")?"selected":""%>>Descending</option>
				
					</select>
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Max. stevilo recordov v izpisu: </td><td class="valuecell" width="30%">
 	<input type="text" name="max_st_izpisov" maxlength='5' size="5" value="<%=nul.jeNull(vseb.getMax_st_izpisov()+"")%>" style="font-family: Verdana; font-size: 8pt">
       
            		 </td>
            		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Dodaten HQL pogoj: </td><td class="valuecell" width="30%" colspan=3>
       
       
       <textarea name="dodatni_hql_pogoji" cols='150' rows='1' style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDodatni_hql_pogoji()+"")%></textarea>
       
       
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
document.dod.vrednost_pogoja.value = document.dod.vrednost_pogojas.value;

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

</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>