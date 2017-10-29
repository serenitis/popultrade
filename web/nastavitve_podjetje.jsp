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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="logout.jsp"/><%
}
%>
 
<%
try {
boolean bok=false;
String napaka= "";

com.popultrade.model.Podjetja vseb =new com.popultrade.model.Podjetja();
com.popultrade.dao.PodjetjaDAO dao = (com.popultrade.dao.PodjetjaDAO)contextUtil.getBeanDao("podjetjaDAO",pageContext.getServletContext());
if (request.getParameter("akcija")==null) {
vseb = dao.getPodjetja(control.getPodjetje_id());
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
//	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getPodjetja(control.getPodjetje_id());
	
	//}
 

	
	
	
vseb = (com.popultrade.model.Podjetja)contextUtil.getPopulatedObject(vseb,request);

//vseb.setSMER(nul.jeNull(request.getParameter("SMER")).equals("1")?"1":"0");

//vseb.setRIP(nul.jeNull(request.getParameter("RIP")).equals("1")?"1":"0");

if (napaka.equals("")) {
dao.savePodjetja(vseb);
}
 
}
}
else {
	
}
 
Hashtable ht =new Hashtable();

ht.put("naziv","NAZIV");
ht.put("naslov","NASLOV");
ht.put("posta","POSTA");
ht.put("kraj","KRAJ");
ht.put("drzava","DRZAVA");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%>
 
<html><head><title>spreminjaj</title></head>
 
<style type=text/css> 
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
 
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
//alert(document.dod.OZNNAR.length);
	 if (document.dod.OZNNAR.value.length==4) {
	 xmlHttp=GetXmlHttpObject();
	 if (xmlHttp==null) {
	 alert ("Browser does not support HTTP Request");
	 return false;
	 } 

	 var url="m_chk_oznnar.jsp";
	 url=url+"?oznnar="+document.dod.OZNNAR.value;
	 url=url+"&sid="+Math.random();

	 xmlHttp.open("GET",url,false);
	 xmlHttp.send(null);
	 //alert(xmlHttp.responseText);
	 
	 if (xmlHttp.responseText.indexOf("TRUE")!=-1) {
	 
	 document.getElementById("OZNNAR1").innerHTML="<font color='red'><b>Napaka: OZNNAR ze obstaja!<b></font>";
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
 
 
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>

	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/ajax-dynamic-list.js"></script>

<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="nastavitve_podjetje.jsp" method="post" onSubmit="return check()">
 

<input type=hidden name="akcija" value="UPDATE">

 

 
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
 
            		  <tr>
            		  
             		 <td class="opiscell" width="20%">Naziv: </td><td class="valuecell" width="30%">
             		 
            		 <input type="text" name="NAZIV" maxlength='35' size='35' value="<%=nul.jeNull(vseb.getNAZIV()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
             		 
            		 <td class="opiscell" width="20%">Naslov: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="NASLOV" maxlength='35' size='35'  value="<%=nul.jeNull(vseb.getNASLOV()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr><tr>
            		  
             		 <td class="opiscell">Kraj: </td><td class="valuecell">
             		 
            		 <input type="text" name="KRAJ" maxlength='35' value="<%=nul.jeNull(vseb.getKRAJ()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
             		 
            		 <td class="opiscell">Posta: </td><td class="valuecell">
            		 
            		 <input type="text" name="POSTA" maxlength='9' value="<%=nul.jeNull(vseb.getPOSTA()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell">ID DDV: </td><td class="valuecell">
            		 
            		<%=nul.jeNull(vseb.getIDDDV()+"")%>
            		</td>
            		 
            		 <td class="opiscell">ID OE: </td><td class="valuecell">
            		 
				<%=nul.jeNull(vseb.getIDOE()+"")%>
				</td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell">DRZAVA: </td>
						<td class="valuecell" colspan="3">
			 		 	<select name="DRZAVA" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		 					<%
            				com.popultrade.dao.DrzavaDAO daosd = (com.popultrade.dao.DrzavaDAO)contextUtil.getBeanDao("drzavaDAO",pageContext.getServletContext());
					List lild = daosd.getDrzavas(new com.popultrade.model.Drzava());

					Iterator ittd = lild.iterator();

					while (ittd.hasNext()) {
						com.popultrade.model.Drzava sifr = (com.popultrade.model.Drzava)ittd.next();
						if (nul.jeNull(vseb.getDRZAVA()).equals(nul.jeNull(sifr.getOZNDRZ()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getOZNDRZ())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getOZNDRZ())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
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

 
return true;
}
function mom() {

	parent.frames[2].location = "nic.jsp";

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
PODATKI USPESNO SPREMENJENI
<%
}
else {
	%>
	<%=napaka %>
	<%
}
%>
</p></td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
 
<script language=javascript> 
var mon = parent.frames[0].document.location+"";

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
 
          if (mon.indexOf("id=")!=-1) {
          
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
     
     }
     else {
   
parent.frames[0].document.location = parent.frames[0].document.location + "&idback=<%=request.getParameter("id")%>";
     }
 
}
  else {
     if (mon.indexOf("?")!=-1) {
parent.frames[0].document.location = parent.frames[0].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "?idback=<%=request.getParameter("id")%>";
 
     }
}
<%
}
else {
%>
parent.frames[0].document.location = parent.frames[0].document.location;
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