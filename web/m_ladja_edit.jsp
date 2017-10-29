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
String napaka="";
com.popultrade.model.Ladja vseb =new com.popultrade.model.Ladja();
com.popultrade.dao.LadjaDAO dao = (com.popultrade.dao.LadjaDAO)contextUtil.getBeanDao("ladjaDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getLadja(nul.jeNullDefault(request.getParameter("id")));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getLadja(nul.jeNullDefault(request.getParameter("id")));
	
	}
 
	//// kontrola ce ze obstaja z oznnar in ni enak trenutnemu
	if (request.getParameter("LADJA")!=null && !request.getParameter("LADJA").equals("")) {
	boolean jeze = dao.getLadjaZeObstaja(request.getParameter("LADJA"));
	if (jeze) {
	napaka = "Napaka: ladja z vnesenim LADJA ze obstaja, ladja ni bila vnesena!";
	}
	}
	
	
vseb = (com.popultrade.model.Ladja)contextUtil.getPopulatedObject(vseb,request);


vseb.setUGREZ(Double.parseDouble(request.getParameter("UGREZ")));




System.out.println("u: "+vseb.getUGREZ());
System.out.println("t: "+vseb.getTIP());
System.out.println("b: "+vseb.getBT());
System.out.println("l: "+vseb.getLADJA());
System.out.println("o: "+vseb.getIMELAD());


System.out.println("imo: "+vseb.getIMO());
System.out.println("dol: "+vseb.getDOLZINA());
System.out.println("str: "+vseb.getSTRGROT());


if (napaka.equals("")) {
dao.saveLadja(vseb);
} 
}
}
 
Hashtable ht =new Hashtable();
ht.put("ime ladje","IMELAD");
ht.put("ladjar","LDR_OZNLADJAR");


//ht.put("id","id");
Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");


	htn.put("LETO IZDELAVE","LETOIZD");
	
	htn.put("STRGROT","STRGROT");
	
	htn.put("NOSILNOST","NOSILNOST");
	
	htn.put("UGREZ","UGREZ");
	
	htn.put("BT","BT");
	
	htn.put("DOLZINA","DOLZINA");
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

	 if (document.dod.LADJA.value.length==4) {
	 xmlHttp=GetXmlHttpObject();
	 if (xmlHttp==null) {
	 alert ("Browser does not support HTTP Request");
	 return false;
	 } 

	 var url="m_chk_ladja.jsp";
	 url=url+"?oznnar="+document.dod.LADJA.value;
	 url=url+"&sid="+Math.random();

	 xmlHttp.open("GET",url,false);
	 xmlHttp.send(null);
	 //alert(xmlHttp.responseText);
	 
	 if (xmlHttp.responseText.indexOf("TRUE")!=-1) {
	 
	 document.getElementById("OZNNAR1").innerHTML="<font color='red'><b>Napaka: LADJA ze obstaja!<b></font>";
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
<%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %>
 
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="m_ladja_edit.jsp" method="post" onSubmit="return check()">
 
<%
if (vseb.getLADJA()!=null && !vseb.getLADJA().equals("")) {
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
 
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getLADJA()+"")%>">
 <input type=hidden name="idback" value="<%=nul.jeNull(vseb.getLADJA()+"")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
 
            		  <tr>
            		  
            		 <td class="opiscell">LADJA:</td><td class="valuecell">
            		 
            		 
            		             		 <%
if (vseb.getLADJA()!=null && !vseb.getLADJA().equals("")) {
%>
  <%=nul.jeNull(vseb.getLADJA()+"")%>
  <%
}
else {
  %>
            		 <input type="text" name="LADJA" maxlength='4'  onkeyup="return chkOZNNAR()"  size="5" value="<%=nul.jeNull(vseb.getLADJA()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
           <%
}
           %>&nbsp; <span id="OZNNAR1"></span>	
            		 
            		 </td>
            		 
             		 <td class="opiscell">&nbsp;</td><td class="valuecell">
             		 
					&nbsp;</td>
             		 
            		  </tr>
 
 
 
            		  <tr>
            		  
            		 <td class="opiscell">IME LADJE: </td><td class="valuecell">
            		 
            		 
            		 
            		 <input type="text" name="IMELAD" maxlength='30' value="<%=nul.jeNull(vseb.getIMELAD()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell">LADJAR: </td><td class="valuecell">
             		 
					<select name="LDR_OZNLADJAR" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					
					
							
							<%
            				com.popultrade.dao.LadjarDAO daosi = (com.popultrade.dao.LadjarDAO)contextUtil.getBeanDao("ladjarDAO",pageContext.getServletContext());
					List lil = daosi.getLadjars(new com.popultrade.model.Ladjar());

					Iterator itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Ladjar sifr = (com.popultrade.model.Ladjar)itti.next();
						if (nul.jeNull(vseb.getLDR_OZNLADJAR()).equals(nul.jeNull(sifr.getOZNLADJAR()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getOZNLADJAR())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getOZNLADJAR())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
							<%
						}
					}
					%>
					
					
					
					</select>
					
					</td>
             		 
            		  </tr><tr>
            		  
              		 <td class="opiscell">DOLZINA: </td><td class="valuecell">
              		
              		 <input type="text" name="DOLZINA"  value="<%=nul.jeNull(vseb.getDOLZINA()+"")%>" style="font-family: Verdana; font-size: 8pt">
              		
              		 
              		 </td>
              		 
             		 <td class="opiscell">BT: </td><td class="valuecell">
             		
             		 <input type="text" name="BT"  value="<%=nul.jeNull(vseb.getBT()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 
            		  </tr><tr>
            		  
             		 <td class="opiscell">UGREZ: </td><td class="valuecell">
             		
             		 <input type="text" name="UGREZ"  value="<%=nul.jeNull(vseb.getUGREZ()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 
            		 <td class="opiscell">TIP: </td><td class="valuecell">
            		 
            		 
            		 
            		 	<select name="TIP" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					
					
															<%
				com.popultrade.dao.SifrantopisDAO daol = (com.popultrade.dao.SifrantopisDAO)contextUtil.getBeanDao("sifrantopisDAO",pageContext.getServletContext());
										
											
				List lis = daol.getSifrantopisBySifrantAndJezik("L19",control.getJezik());
 
					Iterator itts = lis.iterator();

					while (itts.hasNext()) {
						com.popultrade.model.Sifrantopis sifr = (com.popultrade.model.Sifrantopis)itts.next();
						if (nul.jeNull(vseb.getTIP()).equals(nul.jeNull(sifr.getSFT_SIFRA()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getSFT_SIFRA())%>"><%=nul.jeNull(sifr.getSFT_SIFRA())%> - <%=nul.jeNull(sifr.getOPIS())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getSFT_SIFRA())%>"><%=nul.jeNull(sifr.getSFT_SIFRA())%> - <%=nul.jeNull(sifr.getOPIS())%></option>
							<%
						}
					}
					%>
					</select>
            		 
            		 </td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell">OPISTIPA: </td><td class="valuecell">
            		 
            		 <input type="text" name="OPISTIPA" maxlength='30' size='30' value="<%=nul.jeNull(vseb.getOPISTIPA()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell">DRZAVA: </td><td class="valuecell">
            		 
            		 
            		 	<select name="DZV_OZNDRZ" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		 					<%
            				com.popultrade.dao.DrzavaDAO daosd = (com.popultrade.dao.DrzavaDAO)contextUtil.getBeanDao("drzavaDAO",pageContext.getServletContext());
					List lild = daosd.getDrzavas(new com.popultrade.model.Drzava());

					Iterator ittd = lild.iterator();

					while (ittd.hasNext()) {
						com.popultrade.model.Drzava sifr = (com.popultrade.model.Drzava)ittd.next();
						if (nul.jeNull(vseb.getDZV_OZNDRZ()).equals(nul.jeNull(sifr.getOZNDRZ()))) {
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
            		 
            		  </tr><tr>
            		  
             		 <td class="opiscell">NOSILNOST: </td><td class="valuecell">
             		
             		 <input type="text" name="NOSILNOST"  value="<%=nul.jeNull(vseb.getNOSILNOST()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 
            		 <td class="opiscell">OPISDVIG: </td><td class="valuecell">
            		 
            		 <input type="text" name="OPISDVIG" maxlength='15' value="<%=nul.jeNull(vseb.getOPISDVIG()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
            		  </tr><tr>
            		  
             		 <td class="opiscell">STRGROT: </td><td class="valuecell">
             		
             		 <input type="text" name="STRGROT"  value="<%=nul.jeNull(vseb.getSTRGROT()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 
             		 <td class="opiscell">LETOIZD: </td><td class="valuecell">
             		
             		 <input type="text" name="LETOIZD"  value="<%=nul.jeNull(vseb.getLETOIZD()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             		 
             		 </td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell">IMO: </td><td class="valuecell">
            		 
            		 <input type="text" name="IMO" maxlength='10' value="<%=nul.jeNull(vseb.getIMO()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
              		 <td class="opiscell"> </td><td class="valuecell">
            	  
    </td>
             		 
        		  </tr>
        		 
 
 
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 
function custom() {
 
 <%
if (vseb.getLADJA()!=null && !vseb.getLADJA().equals("")) {
}
else {
%>
	 if (document.dod.LADJA.value.length!=4) {
alert("Napaka: LADJA mora vsebovati stiri znake!");
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
     parent.frames[1].document.location = mon.substring(0,mon.indexOf("?")-1) + "?idback=<%=request.getParameter("id")%>";
     
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