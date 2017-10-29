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
boolean defaultt = false;


 if (request.getParameter("akcija")!=null)  {





if (true) {
	
	
	
	Enumeration enn = request.getParameterNames();
	
	while (enn.hasMoreElements()) {
		
		String str = (String)enn.nextElement();
		
		if (str!=null && str.startsWith("prevod_")) {
			
			String[] stru = str.split("_");
			com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
			com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
			
			
			prevo.setPrevod_id(new Long(stru[1]));
			prevo.setSifra_jez(session.getAttribute("jezikv")+"");
			prevo.setVrsta(stru[2]);
			if (stru.length==4 && !stru[3].equals("")) {
			//	prevo.setId(new Long(stru[3]));
				
			}
			prevo = daop.getPrevodiCopy(prevo);
			
			if (prevo==null) {
				prevo = new com.popultrade.model.Prevodi();
				prevo.setPrevod(nul.jeNull(request.getParameter(str)));
				prevo.setPrevod_id(new Long(stru[1]));
				prevo.setSifra_jez(session.getAttribute("jezikv")+"");
				prevo.setVrsta(stru[2]);
				
			}
			prevo.setPrevod(nul.jeNull(request.getParameter(str)));
			
			daop.savePrevodi(prevo);
			ConPool.setPrevod_admin(stru[1],stru[2],session.getAttribute("jezikv")+"",nul.jeNull(request.getParameter(str)),prevo.getId()+"");
			
			
		}
		
		
		
	
	
}


}


}
 else {
	 session.setAttribute("jezikp",request.getParameter("jezikp"));
	 session.setAttribute("jezikv",request.getParameter("jezikv"));
 }

Hashtable ht =new Hashtable();



%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  >
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_dodatniprevodi.jsp" method="post" >


	<input type=hidden name="akcija" value="NEW">
	<%	


/// prevod stran
Hashtable prejv = new Hashtable();
Hashtable prejh = new Hashtable();

/*
com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();

List limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","S");
Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","S");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


Hashtable prejvd = new Hashtable();
Hashtable prejhd = new Hashtable();
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","D");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejvd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","D");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejhd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}



Hashtable prejvo = new Hashtable();
Hashtable prejho = new Hashtable();
limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","O");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejvo.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","O");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejho.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}











*/




%>

<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>

<tr><td colspan="4" class="valuecell">Dodatni opisi, ki se uporabljajo v aplikaciji</td></tr>


       	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (nastavitve) : <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_<%=request.getParameter("idt")%>_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		 
             		 Prevod (zahtevo za izpis PDFja ste ze podali, za izpis novega morate pocakati da se trenutna zahteva izvede) : <%=nul.jeNull(ConPool.getPrevod_admin("1000000","Y",session.getAttribute("jezikp")+""))%>
             		 
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		 	<input type="text" size="70"  name="prevod_1000000_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000000"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000000","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            	
             		 </td></tr>


          		  
            		       	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Spodaj levo : <%=nul.jeNull(ConPool.getPrevod_admin("1000001","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000001_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000001"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000001","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		 
             		 Spodaj sredina : <%=nul.jeNull(ConPool.getPrevod_admin("1000002","Y",session.getAttribute("jezikp")+""))%>
             		 
             		 </td> 
             		 
             		 <td class="valuecell" width="30%">
             		 	<input type="text" size="70"  name="prevod_1000002_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000002"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000002","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            	
             		 </td></tr>  
 
            		  
            		        		       	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Spodaj sredina 2 : <%=nul.jeNull(ConPool.getPrevod_admin("1000003","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000003_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000003"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000003","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		 
             	 Spodaj desno : <%=nul.jeNull(ConPool.getPrevod_admin("1000004","Y",session.getAttribute("jezikp")+""))%>
            		 
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		 	<input type="text" size="70"  name="prevod_1000004_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000004"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000004","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>  
            		  
            		  
            		  
            		         		        		       	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">User login : <%=nul.jeNull(ConPool.getPrevod_admin("1100004","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1100004_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1100004"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1100004","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		 
             	 Geslo login : <%=nul.jeNull(ConPool.getPrevod_admin("1000005","Y",session.getAttribute("jezikp")+""))%>
            		 
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		 	<input type="text" size="70"  name="prevod_1000005_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000005"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000005","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>  
            		  
            		  
            		        		         		        		       	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Login : <%=nul.jeNull(ConPool.getPrevod_admin("1000006","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000006_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000006"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000006","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		 
             	 Logout : <%=nul.jeNull(ConPool.getPrevod_admin("1000007","Y",session.getAttribute("jezikp")+""))%>
            		 
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		 	<input type="text" size="70"  name="prevod_1000007_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000007"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000007","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>  
            		  
            		  
            		  
       <tr>
            		  
            		 <td class="opiscell" width="20%">Nastavitve so shranjene : <%=nul.jeNull(ConPool.getPrevod_admin("1000008","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000008_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000008"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000008","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		 Verzija (uporabi se za refresh js datotek) : <%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",session.getAttribute("jezikp")+""))%>
             		 
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		 	<input type="text" size="70"  name="prevod_1000009_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000009"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            	
             		 </td></tr>        		  
            		  
            		  
            		  
              <tr>
            		  
            		 <td class="opiscell" width="20%">Sumniki za dropdown menije (ne menjat vrstnega reda, samo za SL) : <%=nul.jeNull(ConPool.getPrevod_admin("1000010","Y","SL"))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="35"  name="prevod_1000010_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000010"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000010","Y","SL"))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		Odstrani sliko (obkljukaj):
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		 <input type="text" size="35"  name="prevod_1000011_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000011"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000011","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>       		  
            		  
            		  
            		  
            		  
                      <tr>
            		  
            		 <td class="opiscell" width="20%">Velikost dokument presega dovoljeno velikost : <%=nul.jeNull(ConPool.getPrevod_admin("1000012","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="35"  name="prevod_1000012_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000012"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000012","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		Verzija DB javascript:
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		<input type="text" size="35"  name="prevod_1000018_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000018"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000018","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>        		  
            		  
            		  
            	           <tr>
            		  
            		 <td class="opiscell" width="20%">Vas spletni brskalnik ne podpira vseh funkcionalnosti aplikacije. Za uporabo aplikacije potrebujete vsaj Internet Explorer 10, FireFox 11 ali Chrome 5.0.375 : <%=nul.jeNull(ConPool.getPrevod_admin("1000020","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000020_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000020"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000020","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		Maksimalno stevilo poskusov logina presezeno! <%=nul.jeNull(ConPool.getPrevod_admin("1000021","Y",session.getAttribute("jezikp")+""))%>
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		<input type="text" size="70"  name="prevod_1000021_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000021"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000021","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>   	  	
             		 
             		 	  
  <tr>
            		  
            		 <td class="opiscell" width="20%">Brskalnik ni podprt! : <%=nul.jeNull(ConPool.getPrevod_admin("1000027","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000027_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000027"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000027","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		Ni najdenih zapisov za trenutno izbiro! <%=nul.jeNull(ConPool.getPrevod_admin("1000033","Y",session.getAttribute("jezikp")+""))%>
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		<input type="text" size="70"  name="prevod_1000033_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000033"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000033","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>  
             		 
             		 
             		 
      <tr>
            		  
            		 <td class="opiscell" width="20%">Ni zadetkov. <%=nul.jeNull(ConPool.getPrevod_admin("1000044","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000044_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000044"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000044","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             		Prenesi datoteko. <%=nul.jeNull(ConPool.getPrevod_admin("1000045","Y",session.getAttribute("jezikp")+""))%>
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		<input type="text" size="70"  name="prevod_1000045_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000045"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000045","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		
             		 </td></tr>   
             		 
             		       <tr>
            		  
            		 <td class="opiscell" width="20%">Export vsebuje prvih 100 zadetkov. <%=nul.jeNull(ConPool.getPrevod_admin("1000046","Y",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_1000046_Y_<%=nul.jeNull(ConPool.getPrevod_admin_id("1000046"))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin("1000046","Y",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">
             	
             		 </td>
             		 
             		 <td class="valuecell" width="30%">
             		
             		 </td></tr>            		 
             		  

<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
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