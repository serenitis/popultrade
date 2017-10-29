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
String napaka = "";
com.popultrade.model.Ladjar vseb =new com.popultrade.model.Ladjar();
com.popultrade.dao.LadjarDAO dao = (com.popultrade.dao.LadjarDAO)contextUtil.getBeanDao("ladjarDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getLadjar(nul.jeNullDefault(request.getParameter("id")));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getLadjar(nul.jeNullDefault(request.getParameter("id")));
	
	}
 
vseb = (com.popultrade.model.Ladjar)contextUtil.getPopulatedObject(vseb,request);


//// kontrola ce ze obstaja z oznnar in ni enak trenutnemu
if (request.getParameter("OZNLADJAR")!=null && !request.getParameter("OZNLADJAR").equals("")) {
boolean jeze = dao.getLadjarZeObstaja(request.getParameter("OZNLADJAR")); 
if (jeze) {
napaka = "Napaka: ladjar z vnesenim OZNLADJAR ze obstaja, ladjar ni bil vnesen!";
}
}


if (napaka.equals("")) {
dao.saveLadjar(vseb);
}
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
 
 
 
  <script language="javascript">
 
 
 function GetXmlHttpObject() {

	 var objXMLHttp=null;

	 if (window.XMLHttpRequest) {
	 objXMLHttp=new XMLHttpRequest();
	 }
	 else if (window.ActiveXObject){
	 objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
	 }
	 return objXMLHttp;
	 }

 function chkOZNNAR() {
//alert(document.dod.OZNLADJAR.length);
	 if (document.dod.OZNLADJAR.value.length==3) {
	 xmlHttp=GetXmlHttpObject();
	 if (xmlHttp==null) {
	 alert ("Browser does not support HTTP Request");
	 return false;
	 } 

	 var url="m_chk_oznladjar.jsp";
	 url=url+"?oznnar="+document.dod.OZNLADJAR.value;
	 url=url+"&sid="+Math.random();

	 xmlHttp.open("GET",url,false);
	 xmlHttp.send(null);
	 //alert(xmlHttp.responseText);
	 
	 if (xmlHttp.responseText.indexOf("TRUE")!=-1) {
	 
	 document.getElementById("OZNNAR1").innerHTML="<font color='red'><b>Napaka: OZNAKA LADJAR ze obstaja!<b></font>";
	 }
	 else {
		 document.getElementById("OZNNAR1").innerHTML="";
		 }
	 }
	 else {
		 document.getElementById("OZNNAR1").innerHTML="";
		 }
	 return false;

	 }
 
 
 </script>
 
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="m_ladjar_edit.jsp" method="post" onSubmit="return check()">
 
<%
if (vseb.getOZNLADJAR()!=null && !vseb.getOZNLADJAR().equals("")) {
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
 
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getOZNLADJAR()+"")%>">
 <input type=hidden name="idback" value="<%=nul.jeNull(vseb.getOZNLADJAR()+"")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
   <tr>
            		  
            		 <td class="opiscell">OZNAKA LADJAR: </td>
						<td class="valuecell" colspan="3">
            		 
            		 <%
if (vseb.getOZNLADJAR()!=null && !vseb.getOZNLADJAR().equals("")) {
%>
  <%=nul.jeNull(vseb.getOZNLADJAR()+"")%>
  <%
}
else {
  %>
            		 <input type="text" name="OZNLADJAR" onkeyup="return chkOZNNAR()" size="5" maxlength='3' value="<%=nul.jeNull(vseb.getOZNLADJAR()+"")%>" style="font-family: Verdana; font-size: 8pt">
      <%
}
      %>&nbsp;      <span id="OZNNAR1"></span>		 
            		 
            		 </td>
            		 
            		  </tr>
            		  <tr>
            		  
            		 <td class="opiscell">NAZIV: </td><td class="valuecell">
            		 
            		 <input type="text" name="NAZIV" maxlength='60' size='60' value="<%=nul.jeNull(vseb.getNAZIV()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell">MESTO: </td><td class="valuecell">
            		 
            		 <input type="text" name="MESTO" maxlength='15' value="<%=nul.jeNull(vseb.getMESTO()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
            		  </tr>
 
 
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 
function custom() {
 
 <%
if (vseb.getOZNLADJAR()!=null && !vseb.getOZNLADJAR().equals("")) {
}
else {
%>
	 if (document.dod.OZNLADJAR.value.length!=3) {
alert("Napaka: OZNAKA LADJAR mora vsebovati tri znake!");
return false;
	 }
	 
	 <%
}
	 %>
 
return true;
}
function mom() {
 
parent.frames[3].location = "nic.jsp";
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
if (napaka.equals("")) {
%>
PODATKI VNESENI/SPREMENJENI
<%
}
else {
	%>
	<%=napaka %>
	<%
}
%>
</p>

</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
 
<script language=javascript> 
var mon = parent.frames[1].document.location+"";
 <%
if (!napaka.equals("")) {
%>
alert("<%=napaka %>");
<%
}
%>
<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
 
  parent.frames[1].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
 
 
}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
          
     parent.frames[1].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
     
     }
     else {
   
parent.frames[1].document.location = parent.frames[1].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     }
     else {
     parent.frames[1].document.location = parent.frames[1].document.location + "?idback=<%=request.getParameter("id")%>";
 
     }
}
<%
}
else {
%>
    if (mon.indexOf("id=")!=-1) {
    
     parent.frames[1].document.location = mon.substring(0,mon.indexOf("?"));
     }
     else {
    
parent.frames[1].document.location = parent.frames[1].document.location;
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

