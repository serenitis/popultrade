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
com.popultrade.model.TemplateDDPogoji vseb =new com.popultrade.model.TemplateDDPogoji();
com.popultrade.dao.TemplateDDPogojiDAO dao = (com.popultrade.dao.TemplateDDPogojiDAO)contextUtil.getBeanDao("templateDDPogojiDAO",pageContext.getServletContext());


if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateDDPogoji(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateDDPogoji(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplatedd_id(new Long(session.getAttribute("idd")+""));
vseb.setTip("P");
	}
vseb = (com.popultrade.model.TemplateDDPogoji)contextUtil.getPopulatedObject(vseb,request);


vseb.setVrednost_fiksna(nul.jeNull(request.getParameter("vrednost_fiksna")).equals("1")?"1":"0");
vseb.setPosreduj_vrednost(nul.jeNull(request.getParameter("posreduj_vrednost")).equals("1")?"1":"0");

dao.saveTemplateDDPogoji(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("ime_metode","ime_metode");
//ht.put("vrednost pogoja","vrednost_pogoja");
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
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateddp_edit.jsp" method="post" onSubmit="return check()">

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
            		  
            		 <td class="opiscell" width="20%">Ime metode: </td><td class="valuecell" width="30%">
            		 
            	
            		 
            		  		 <select name="ime_metode" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					<%
					
					com.popultrade.model.TemplateDD theadi =new com.popultrade.model.TemplateDD();
com.popultrade.dao.TemplateDDDAO daoth = (com.popultrade.dao.TemplateDDDAO)contextUtil.getBeanDao("templateDDDAO",pageContext.getServletContext());


					theadi = daoth.getTemplateDD(new Long(session.getAttribute("idd")+""));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+theadi.getClass_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set").equals(nul.jeNull(vseb.getIme_metode()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set")%>" selected><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","set") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","set") +")"%></option>
							
							
							<%	
							
							
						}
					}
					
					
				
					
					%>
				
					
					
					</select>
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Vrednost metode: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="vrednost_metode" maxlength='250' value="<%=nul.jeNull(vseb.getVrednost_metode()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 	  		 <select name="vrednost_metodes" style="font-family: Verdana; font-size: 8pt" onChange="preseli()" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					
	
					
					 li = templateUtil.getKonstantePriLogu();
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getVrednost_metode()))) {
					%>
					
					
					<option value="<%=nex%>" selected><%=nex%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex%>"><%=nex%></option>
							
							
							<%	
							
							
						}
					}
					
					
					
			/// dodam sepogoje, ce ima gumbe
					
						
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daothi = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daothi.getTemplateHead(new Long(session.getAttribute("idt")+""));
					
					
					
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","").equals(nul.jeNull(vseb.getIme_metode()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","")%>" selected><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","") +")"%></option>
							
							
							<%	
							
							
						}
					}
					
					
					
					%>
					
					
					</select><br>
            		 Vrednost je fiksna (v primeru, da vrednost ne dobim iz forme, brez navednic):
            		  <input type="checkbox" name="vrednost_fiksna" value="1" <%=nul.jeNull(vseb.getVrednost_fiksna()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
    
            		 </td>
            		 
            		  </tr>



        		  <tr>
            		  
            		 <td class="opiscell" width="20%">Pogoj uporabe (format if (##POGOJ##)) pogoj gre preko requesta, potrebno ga je dodati pod gumb pogoji za prikaz classe: </td><td class="valuecell" colspan=3>
            		 <input type="text" name="pogoj_uporabe" maxlength='500' size="70" value="<%=nul.jeNull(vseb.getPogoj_uporabe()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		  
            		 </td></tr>

		  <tr>
            		  
            		 <td class="opiscell" width="20%">Posreduj vrednost kot pogoj: </td><td class="valuecell" colspan=3>
            		  <input type="checkbox" name="posreduj_vrednost" value="1" <%=nul.jeNull(vseb.getPosreduj_vrednost()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
    
            		 </td></tr>

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
document.dod.vrednost_metode.value = document.dod.vrednost_metodes.value;

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