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
com.popultrade.model.Stranke vseb =new com.popultrade.model.Stranke();
com.popultrade.dao.StrankeDAO dao = (com.popultrade.dao.StrankeDAO)contextUtil.getBeanDao("strankeDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getStranke(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getStranke(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
 
vseb = (com.popultrade.model.Stranke)contextUtil.getPopulatedObject(vseb,request);

vseb.setOznnar(control.getPodjetje());
vseb.setStatus("1");
dao.saveStranke(vseb);
 
}
}
 
Hashtable ht =new Hashtable();
ht.put("naziv","naziv");
ht.put("naslov","naslov");
ht.put("kraj","kraj");
ht.put("posta","posta");




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
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/ajax-dynamic-list.js"></script>



<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="stranke_edit.jsp" method="post" onSubmit="return check()">
 
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
 
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
 
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Naziv: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="naziv" maxlength='35' size="35" value="<%=nul.jeNull(vseb.getNaziv()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Naslov: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="naslov" maxlength='35' size="35" value="<%=nul.jeNull(vseb.getNaslov()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Kraj: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="kraj" maxlength='35' size="35" value="<%=nul.jeNull(vseb.getKraj()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Posta: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="posta" maxlength='9' size="9" value="<%=nul.jeNull(vseb.getPosta()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Drzava: </td><td class="valuecell" width="30%">
            		 	<select name="drzava" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		 					<%
            				com.popultrade.dao.DrzavaDAO daosd = (com.popultrade.dao.DrzavaDAO)contextUtil.getBeanDao("drzavaDAO",pageContext.getServletContext());
					List lild = daosd.getDrzavas(new com.popultrade.model.Drzava());

					Iterator ittd = lild.iterator();

					while (ittd.hasNext()) {
						com.popultrade.model.Drzava sifr = (com.popultrade.model.Drzava)ittd.next();
						if (nul.jeNull(vseb.getDrzava()).equals(nul.jeNull(sifr.getOZNDRZ()))) {
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
					
				
            		 &nbsp;</td>
            		 
             		 <td class="opiscell" width="20%">&nbsp;</td><td class="valuecell" width="30%">
             		 
					&nbsp;</td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Idddv: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="idddv" maxlength='17' size="17" value="<%=nul.jeNull(vseb.getIdddv()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
              		 <td class="opiscell">Komentar: </td><td class="valuecell">
              		 
 					<textarea rows="6" cols="47"  name="komentar"   style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getKomentar()+"")%></textarea>&nbsp;
 
 					
 					</td>
              		 
            		  </tr>         		 
 
 
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 
function custom() {
 
 

 
return true;
}
function mom() {
 
parent.frames[2].location = "nic.jsp";
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
 
  parent.frames[0].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
 
 
}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
     
     }
     else {
parent.frames[0].document.location = parent.frames[0].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "?idback=<%=request.getParameter("id")%>";
 
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