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
com.popultrade.model.Teksti vseb =new com.popultrade.model.Teksti();
com.popultrade.dao.TekstiDAO dao = (com.popultrade.dao.TekstiDAO)contextUtil.getBeanDao("tekstiDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTeksti(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTeksti(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
 
vseb = (com.popultrade.model.Teksti)contextUtil.getPopulatedObject(vseb,request);
dao.saveTeksti(vseb);
 
}
}
 
Hashtable ht =new Hashtable();
ht.put("tekst","text");
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
<body  topmargin="0" leftmargin="0" onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="m_teksti.jsp" method="post" onSubmit="return check()">
 
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
 
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
 <tr>
            		  
              		 <td class="opiscell">Tekst: </td><td class="valuecell" colspan=3>
            	  
   <textarea rows="6" cols="84"  name="text"    style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getText()+"")%></textarea>&nbsp;
  <br>
  <input type="button" value="HTML Editor" name="B3" style="font-family: Verdana; font-size: 10px" onclick="editor('text')">
  
  
  
  </td>
             		 
      
          		 
 
 </tr>
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>

<form name="editorr" action="m_editor.jsp" target=_blank method=post>
<input type=hidden name=ime_polja value="">
<input type=hidden name=vrednost value="">

</form>

<script language='javascript'> 


function editor(edim) {

document.editorr.ime_polja.value=edim;
document.editorr.vrednost.value = eval("document.dod."+edim).value;
document.editorr.submit();



}


function custom() {
 
 
return true;
 
}
function mom() {
parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
<%

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
function mom() {

}
<%

%>
</script>
 
<%
}
 
}
catch (Exception ex){
System.out.println("Users: "+ex.toString());
}
%>
 

	
