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
com.popultrade.model.Obvestila vseb =new com.popultrade.model.Obvestila();
com.popultrade.dao.ObvestilaDAO dao = (com.popultrade.dao.ObvestilaDAO)contextUtil.getBeanDao("obvestilaDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getObvestila(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getObvestila(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		vseb.setDatkre(new Date());
	}
 
vseb = (com.popultrade.model.Obvestila)contextUtil.getPopulatedObject(vseb,request);


vseb.setStatus(nul.jeNull(request.getParameter("status")).equals("1")?"1":"0");

dao.saveObvestila(vseb);
 
}
}
 
Hashtable ht =new Hashtable();
ht.put("naslov tekst","naslov_tekst");
ht.put("vsebina tekst","vsebina_tekst");
ht.put("jezik","jzk_sifra_jezik");

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
<body   style="margin: 0"  onload="mom()">
<%
if (request.getParameter("akcija")==null) {
%>
 
<form name=dod action="m_obvestila_edit.jsp" method="post" onSubmit="return check()">
 
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
            		  
            		 <td class="opiscell" width="20%">Naslov tekst: </td>
						<td class="valuecell" width="30%" colspan="3">
            		 
            		 <input type="text" name="naslov_tekst" maxlength='250' size=120 value="<%=nul.jeNull(vseb.getNaslov_tekst()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 &nbsp;
 
 					
 					 </td>
            		 
            		  </tr><tr>
            		  
              		 <td class="opiscell">Vsebina tekst: </td>
						<td class="valuecell" colspan="3">
            	  
 					<textarea rows="10" cols="117"  name="vsebina_tekst"   style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getVsebina_tekst()+"")%></textarea></td>
             		 
            		  </tr><tr>
            		  
              		 <td class="opiscell">Datum v od: </td><td class="valuecell">
            	  
            	  <input type="text" name="datum_v_od" readonly value="<%=nul.getDatumFormatFromDateNoTime(vseb.getDatum_v_od())%>" size="10"  style="font-family: Verdana; font-size: 8pt">
	 </td>
             		 
              		 <td class="opiscell">Datum v do: </td><td class="valuecell">
            	  
            	  <input type="text" name="datum_v_do" readonly value="<%=nul.getDatumFormatFromDateNoTime(vseb.getDatum_v_do())%>" size="10"  style="font-family: Verdana; font-size: 8pt">
	 </td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Status: </td><td class="valuecell" width="30%">
            		 
            		  <input type="checkbox" name="status" value="1" <%=nul.jeNull(vseb.getStatus()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		  
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Podjetje: </td><td class="valuecell" width="30%">
            		 
            		 
            		    		 
        		 <select name="usp_oznnar" style="font-family: Verdana; font-size: 8pt" >
            			<option value=""></option>
        		 			<%
            				com.popultrade.dao.PodjetjaDAO daosp = (com.popultrade.dao.PodjetjaDAO)contextUtil.getBeanDao("podjetjaDAO",pageContext.getServletContext());
					List li = daosp.getPodjetjas(new com.popultrade.model.Podjetja());

					Iterator itt = li.iterator();

					while (itt.hasNext()) {
						com.popultrade.model.Podjetja sifr = (com.popultrade.model.Podjetja)itt.next();
						if (nul.jeNull(vseb.getUsp_oznnar()).equals(nul.jeNull(sifr.getOZNNAR()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getOZNNAR())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getOZNNAR())%>"><%=nul.jeNull(sifr.getNAZIV())%></option>
							<%
						}
					}
					%>
        		 </select>
            		 
            		 
            		 
            		 </td>
            		 
            		  </tr><tr>
            		  
             		 <td class="opiscell" width="20%">Drzava: </td><td class="valuecell" width="30%">
             		 
					 		 	<select name="dzv_ozndrz" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		 					<%
            				com.popultrade.dao.DrzavaDAO daosd = (com.popultrade.dao.DrzavaDAO)contextUtil.getBeanDao("drzavaDAO",pageContext.getServletContext());
					List lild = daosd.getDrzavas(new com.popultrade.model.Drzava());

					Iterator ittd = lild.iterator();

					while (ittd.hasNext()) {
						com.popultrade.model.Drzava sifr = (com.popultrade.model.Drzava)ittd.next();
						if (nul.jeNull(vseb.getDzv_ozndrz()).equals(nul.jeNull(sifr.getOZNDRZ()))) {
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
             		 
        		 <td class="opiscell">Jezik: </td><td class="valuecell">
        		 
        		 
        		 
        		 	<select name="jzk_sifra_jezik" style="font-family: Verdana; font-size: 8pt" >
            			<option value=""></option>
            			<%
            				com.popultrade.dao.JezikiDAO daosi = (com.popultrade.dao.JezikiDAO)contextUtil.getBeanDao("jezikiDAO",pageContext.getServletContext());
					List lil = daosi.getJezikis(new com.popultrade.model.Jeziki());

					Iterator itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Jeziki sifr = (com.popultrade.model.Jeziki)itti.next();
						if (nul.jeNull(vseb.getJzk_sifra_jezik()).equals(nul.jeNull(sifr.getSIFRA_JEZ()))) {
						%>
						
						<option selected value="<%=nul.jeNull(sifr.getSIFRA_JEZ())%>"><%=nul.jeNull(sifr.getOPIS_JEZ())%></option>
					<%
						}
						else {
							%>
							<option  value="<%=nul.jeNull(sifr.getSIFRA_JEZ())%>"><%=nul.jeNull(sifr.getOPIS_JEZ())%></option>
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
 
 
if (document.dod.datum_v_do.value!="" && !checkdatum(document.dod.datum_v_do.value)) {
alert("Datum datum_v_do je nepravilno vnesen! (Pravilen format datuma je: xx-xx-xxxx)");
return false;}
 
if (document.dod.datum_v_od.value!="" && !checkdatum(document.dod.datum_v_od.value)) {
alert("Datum datum_v_od je nepravilno vnesen! (Pravilen format datuma je: xx-xx-xxxx)");
return false;}
 
return true;
}
function mom() {
 
parent.frames[3].location = "nic.jsp";
<%
if (request.getParameter("akcija")==null) {
%>
 
 
dp_ca1 = new Epoch('epoch_popup','popup',document.dod.datum_v_do);
 
dp_ca0 = new Epoch('epoch_popup','popup',document.dod.datum_v_od);
 
 
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
var mon = parent.frames[1].document.location+"";
 
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