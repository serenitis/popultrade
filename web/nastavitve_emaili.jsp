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

com.popultrade.model.Users vseb =new com.popultrade.model.Users();
com.popultrade.dao.UsersDAO dao = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
if (request.getParameter("akcija")==null) {
vseb = dao.getUsers(control.idUporabnika);
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
//	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getUsers(control.idUporabnika);
	
	//}
 

	
	
	
vseb = (com.popultrade.model.Users)contextUtil.getPopulatedObject(vseb,request);

vseb.setEmail1_aktiven(nul.jeNull(request.getParameter("email1_aktiven")).equals("1")?"1":"0");
vseb.setEmail2_aktiven(nul.jeNull(request.getParameter("email2_aktiven")).equals("1")?"1":"0");
vseb.setEmail_ppl(nul.jeNull(request.getParameter("email_ppl")).equals("1")?"1":"0");
vseb.setEmail_ppl_06(nul.jeNull(request.getParameter("email_ppl_06")).equals("1")?"1":"0");
vseb.setEmail_ppl_12(nul.jeNull(request.getParameter("email_ppl_12")).equals("1")?"1":"0");
vseb.setEmail_ppl_16(nul.jeNull(request.getParameter("email_ppl_16")).equals("1")?"1":"0");
vseb.setEmail_ppl_20(nul.jeNull(request.getParameter("email_ppl_20")).equals("1")?"1":"0");
vseb.setEmail_popultrade(nul.jeNull(request.getParameter("email_popultrade")).equals("1")?"1":"0");

vseb.setEmail_popultrade_351(nul.jeNull(request.getParameter("email_popultrade_351")).equals("1")?"1":"0");
vseb.setEmail_popultrade_361(nul.jeNull(request.getParameter("email_popultrade_361")).equals("1")?"1":"0");
vseb.setEmail_popultrade_322(nul.jeNull(request.getParameter("email_popultrade_322")).equals("1")?"1":"0");
vseb.setEmail_popultrade_329(nul.jeNull(request.getParameter("email_popultrade_329")).equals("1")?"1":"0");
vseb.setEmail_popultrade_330(nul.jeNull(request.getParameter("email_popultrade_330")).equals("1")?"1":"0");


vseb.setEmail_ecs(nul.jeNull(request.getParameter("email_ecs")).equals("1")?"1":"0");

vseb.setEmail_ecs_521(nul.jeNull(request.getParameter("email_ecs_521")).equals("1")?"1":"0");
vseb.setEmail_ecs_522(nul.jeNull(request.getParameter("email_ecs_522")).equals("1")?"1":"0");
vseb.setEmail_ecs_561(nul.jeNull(request.getParameter("email_ecs_561")).equals("1")?"1":"0");


//vseb.setRIP(nul.jeNull(request.getParameter("RIP")).equals("1")?"1":"0");

if (napaka.equals("")) {
dao.saveUsers(vseb);
}
 
}
}
else {
	
}
 
Hashtable ht =new Hashtable();


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


 
 
 </script>
 
 
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>

	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/ajax-dynamic-list.js"></script>
	
	
	<script language="javascript">
	
	function eMail1() {
	
	if (document.dod.email1_aktiven.checked) {
	document.dod.email1.readOnly=false;
	}
	else {
	document.dod.email1.readOnly=true;
	document.dod.email1.value="";
	}
	
	}
	
	function eMail2() {
	
	if (document.dod.email2_aktiven.checked) {
	document.dod.email2.readOnly=false;
	}
	else {
	document.dod.email2.readOnly=true;
	document.dod.email2.value="";
	}
	
	}
	
	
	
	function eMailppl() {
	
	if (document.dod.email_ppl.checked) {
	document.dod.email_ppl_06.disabled=false;
	document.dod.email_ppl_12.disabled=false;
	document.dod.email_ppl_16.disabled=false;
	document.dod.email_ppl_20.disabled=false;
	}
	else {
	document.dod.email_ppl_06.disabled=true;
	document.dod.email_ppl_12.disabled=true;
	document.dod.email_ppl_16.disabled=true;
	document.dod.email_ppl_20.disabled=true;
	
	document.dod.email_ppl_06.checked=false;
	document.dod.email_ppl_12.checked=false;
	document.dod.email_ppl_16.checked=false;
	document.dod.email_ppl_20.checked=false;
	
	}
	
	
	
	}
	
	
	
	
		function eMailpopultrade() {
	
	if (document.dod.email_popultrade.checked) {
	document.dod.email_popultrade_351.disabled=false;
	document.dod.email_popultrade_361.disabled=false;
	document.dod.email_popultrade_322.disabled=false;
	document.dod.email_popultrade_329.disabled=false;
	document.dod.email_popultrade_330.disabled=false;
	}
	else {
	document.dod.email_popultrade_351.disabled=true;
	document.dod.email_popultrade_361.disabled=true;
	document.dod.email_popultrade_322.disabled=true;
	document.dod.email_popultrade_329.disabled=true;
	document.dod.email_popultrade_330.disabled=true;
	
	document.dod.email_popultrade_351.checked=false;
	document.dod.email_popultrade_361.checked=false;
	document.dod.email_popultrade_322.checked=false;
	document.dod.email_popultrade_329.checked=false;
	document.dod.email_popultrade_330.checked=false;
	
	}
	
	}
	
	function eMailecs() {
	
	if (document.dod.email_ecs.checked) {
	document.dod.email_ecs_521.disabled=false;
	document.dod.email_ecs_522.disabled=false;
	document.dod.email_ecs_561.disabled=false;
	}
	else {
	document.dod.email_ecs_521.disabled=true;
	document.dod.email_ecs_522.disabled=true;
	document.dod.email_ecs_561.disabled=true;
	
	document.dod.email_ecs_521.checked=false;
	document.dod.email_ecs_522.checked=false;
	document.dod.email_ecs_561.checked=false;
	
	}
	
	}
	
	
	
	
	function check2() {
	if (document.dod.email1_aktiven.checked) {
	if (trim(document.dod.email1.value).indexOf("@")==-1 || trim(document.dod.email1.value).indexOf(".")==-1) {
	alert("Napaka: email 1 je napacno vnesen!");
	return false;
	}
	}
	if (document.dod.email2_aktiven.checked) {
	if (trim(document.dod.email2.value).indexOf("@")==-1 || trim(document.dod.email2.value).indexOf(".")==-1) {
	alert("Napaka: email 2 je napacno vnesen!");
	return false;
	}
	}
	}

	</script>
	
	

<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="nastavitve_emaili.jsp" method="post" onSubmit="return check2()">
 

<input type=hidden name="akcija" value="UPDATE">

 

 
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr>
	<td colspan="5" class="opiscell">&nbsp;</td></tr>
 
 
 
            		  <tr>
            		  
             		 <td class="opiscell" width="20%">Email 1 aktiven: </td>
						<td class="valuecell" width="30%" colspan="2">
             		 <input type="checkbox" onclick="eMail1()" name="email1_aktiven" value="1" <%=nul.jeNull(vseb.getEmail1_aktiven()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		              		 
            		 </td>
             		 
            		 <td class="opiscell" width="20%">Email 1: </td>
						<td class="valuecell" width="30%">
            		 <%
            		 String disa = "readonly";
            		 if (nul.jeNull(vseb.getEmail1_aktiven()).equals("1")) {
            			 disa="";
            		 }
            		 
            		 %>
            		 <input type="text" <%=disa%> name="email1" maxlength='200' size="50" value="<%=nul.jeNull(vseb.getEmail1()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
            		  </tr><tr>
            		  
             		 <td class="opiscell">Email 2 aktiven: </td>
						<td class="valuecell" colspan="2">
             		 
            		  <input type="checkbox" onclick="eMail2()" name="email2_aktiven" value="1" <%=nul.jeNull(vseb.getEmail2_aktiven()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		            		 </td>
             		 
            		 <td class="opiscell">Email 2: </td>
						<td class="valuecell">
            		 	 <%
            		 disa = "readonly";
            		 if (nul.jeNull(vseb.getEmail2_aktiven()).equals("1")) {
            			 disa="";
            		 }
            		 
            		 %>
            		 <input type="text" <%=disa%> name="email2" maxlength='200' size="50" value="<%=nul.jeNull(vseb.getEmail2()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 </td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" valign="top">Plan prihodov ladij:</td><td class="valuecell" valign="top">
            		 
             		 <input type="checkbox"  onclick="eMailppl()"  name="email_ppl" value="1" <%=nul.jeNull(vseb.getEmail_ppl()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="valuecell">
            		 
            		 
            		 	 	 <%
            		 disa = "disabled='disabled'";
            		 if (nul.jeNull(vseb.getEmail_ppl()).equals("1")) {
            			 disa="";
            		 }
            		 
            		 %>
            		 
             		 <input type="checkbox" <%=disa%> name="email_ppl_06" value="1" <%=nul.jeNull(vseb.getEmail_ppl_06()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						6:30<br>
             		 <input type="checkbox" <%=disa%>  name="email_ppl_12" value="1" <%=nul.jeNull(vseb.getEmail_ppl_12()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						12:30<br>
             		 <input type="checkbox" <%=disa%>  name="email_ppl_16" value="1" <%=nul.jeNull(vseb.getEmail_ppl_16()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						16:30<br>
             		 <input type="checkbox" <%=disa%>  name="email_ppl_20" value="1" <%=nul.jeNull(vseb.getEmail_ppl_20()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						20:30</td>
            		 
            		 <td class="valuecell" colspan="2">&nbsp;</td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" valign="top">popultrade:</td><td class="valuecell" valign="top">
            		 
             		 <input type="checkbox" name="email_popultrade" onclick="eMailpopultrade()"  value="1" <%=nul.jeNull(vseb.getEmail_popultrade()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="valuecell" colspan="3">
            		 	 	 	 <%
            		 disa = "disabled='disabled'";
            		 if (nul.jeNull(vseb.getEmail_popultrade()).equals("1")) {
            			 disa="";
            		 }
            		 
            		 %>
             		 <input type="checkbox"  <%=disa%> name="email_popultrade_351" value="1" <%=nul.jeNull(vseb.getEmail_popultrade_351()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						351 (Najava kontrole pred potrditvijo prihoda ladje)<br>
            		 
             		 <input type="checkbox"  <%=disa%> name="email_popultrade_361" value="1" <%=nul.jeNull(vseb.getEmail_popultrade_361()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						361 (Najava kontrole ob potrditvi prihoda ladje)<br>
            		 
             		 <input type="checkbox"  <%=disa%> name="email_popultrade_322" value="1" <%=nul.jeNull(vseb.getEmail_popultrade_322()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						322 (Zavrnitev vstopa VSD)<br>
            		 
             		 <input type="checkbox"  <%=disa%> name="email_popultrade_329" value="1" <%=nul.jeNull(vseb.getEmail_popultrade_329()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						329 (Potrditev VSD s pripombami)<br>
            		 
             		 <input type="checkbox" <%=disa%>  name="email_popultrade_330" value="1" <%=nul.jeNull(vseb.getEmail_popultrade_330()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						330 (Potrditev VSD brez pripomb)</td>
            		 
            		  </tr>
        		 
 
 
 
 
	<tr>
            		  
            		 <td class="opiscell" valign="top">ECS:</td><td class="valuecell" valign="top">
            		 
             		 <input type="checkbox" name="email_ecs" onclick="eMailecs()"  value="1" <%=nul.jeNull(vseb.getEmail_ecs()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="valuecell" colspan="3">
            		 	 	 	 	 <%
            		 disa = "disabled='disabled'";
            		 if (nul.jeNull(vseb.getEmail_ecs()).equals("1")) {
            			 disa="";
            		 }
            		 
            		 %>
             		 <input type="checkbox"  <%=disa%>  name="email_ecs_521" value="1" <%=nul.jeNull(vseb.getEmail_ecs_521()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						521 (Zavrnitev izstopa)<br>
            		 
             		 <input type="checkbox"  <%=disa%>  name="email_ecs_522" value="1" <%=nul.jeNull(vseb.getEmail_ecs_522()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						522 (Zavrnitev izstopa)<br>
            		 
             		 <input type="checkbox"  <%=disa%>  name="email_ecs_561" value="1" <%=nul.jeNull(vseb.getEmail_ecs_561()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"> 
						561 (Napoved kontrole ECS)</td>
            		 
            		  </tr>
        		 
 
 
 
 
<tr><td colspan="5" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
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