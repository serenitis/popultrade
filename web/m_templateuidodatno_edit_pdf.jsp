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
com.popultrade.model.TemplateUiDodatno vseb =new com.popultrade.model.TemplateUiDodatno();
com.popultrade.dao.TemplateUiDodatnoDAO dao = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());



if (request.getParameter("idt")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateUiDodatnos(nul.jeNullDefault(request.getParameter("idt")));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateUiDodatno(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplateui_id(new Long(request.getParameter("idt")));

	}

vseb = (com.popultrade.model.TemplateUiDodatno)contextUtil.getPopulatedObject(vseb,request);


dao.saveTemplateUiDodatno(vseb);


//// update clob za 

//dao.updateClob(request.getParameter("id"),"dodatno_java_updateinsert",nul.jeNull(request.getParameter("dodatno_java_updateinsert")));



}
}








//Hashtable ht =new Hashtable();
//ht.put("id","id");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<!--%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %-->
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateuidodatno_edit.jsp" method="post" onSudbmit="return check()">

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
	<td colspan="2" class="opiscell">&nbsp;</td></tr>





<tr>
            		  
 <td class="opiscell" width="20%">Dodatno java (uporabi se za pridobivanje class iz drugih tabel,
  ki se potem uporabi za setiranje vrednosti, doda se v pdf v isti obliki kot je tu napisano, 
  za parametre, ki se pridobi iz selecta za pdf se uporabi format XpredponaX primer XpredponaX.getId() . Vrednost, ki se dobi iz teh pogojev se setira z "rezu=" ):&nbsp;
  </td><td class="valuecell" width="30%"><textarea name="dodatno_java_rocno" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_java_rocno()+"")%></textarea></td>
            		 
        		 
</tr>

<tr>
            		  
 <td class="opiscell" width="20%">Dodatno pogoj za prikaz vrstice (pogoj za prikaz celotne vrstice v pdfju, levi in desni pdf, format: if (##POGOJ##) { , zaklepaj se doda avtomaticno):&nbsp;
  </td><td class="valuecell" width="30%"><textarea name="dodatno_java" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_java()+"")%></textarea></td>
            		 
        		 
</tr>



<tr><td colspan="2" class="opiscell" align="center"><input type=button value="Repository" onclick="window.open('<%=ConPool.getRepository_url() %>code?pagena=<%=ConPool.extractPageNameFromURLString(request.getRequestURI()) %>', 'PgRepository','menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes')" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr>

<tr><td colspan="2" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
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

</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>