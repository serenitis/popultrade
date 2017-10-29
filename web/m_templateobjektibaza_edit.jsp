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
com.popultrade.model.TemplateObjektiBaza vseb =new com.popultrade.model.TemplateObjektiBaza();
com.popultrade.dao.TemplateObjektiBazaDAO dao = (com.popultrade.dao.TemplateObjektiBazaDAO)contextUtil.getBeanDao("templateObjektiBazaDAO",pageContext.getServletContext());
if (request.getParameter("idt")!=null  && request.getParameter("akcija")==null) {
vseb = dao.getTemplateObjektiBazaByVezaId(new Long(nul.jeNullDefault(request.getParameter("idt"))));
if (vseb==null) { 
	vseb =new com.popultrade.model.TemplateObjektiBaza();
	/*vseb.setFont_size_head(7);
	vseb.setFont_size_list(7);
	vseb.setMax_st_izpisov(250);
	vseb.setUrl_gumb("m.gif");*/
	defaultt=true;
	
}
} 

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateObjektiBaza(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		

					
vseb.setTemplatehead_id(new Long(request.getParameter("idt")));




	}

vseb = (com.popultrade.model.TemplateObjektiBaza)contextUtil.getPopulatedObject(vseb,request);

dao.saveTemplateObjektiBaza(vseb);





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
}

Hashtable ht =new Hashtable();
ht.put("baza_polje_objekt","baza_polje_objekt");

//ht.put("content_type_extension","content_type_extension");




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
<body   style="margin: 0"  <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateobjektibaza_edit.jsp" method="post" onSubmit="return check()">

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




String prevod1="";
String prevod2="";
String prevod3="";
/*
if (defaultt) {
	
	if (session.getAttribute("jezikv").equals("SL")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Rezultat iskanja poslji na moj e-mail";
		 prevod3="Sporocilo je bilo uspesno poslano ";
	}
	else if (session.getAttribute("jezikv").equals("HR")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Spisak salji na moj e-mail";
		 prevod3="Poruka je bila uspjesno poslana ";
	}
	else if (session.getAttribute("jezikv").equals("SR")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Spisak salji na moj e-mail";
		 prevod3="Poruka je bila uspesno poslata ";
	}
	else if (session.getAttribute("jezikv").equals("EN")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Send the search result list to my e-mail";
		 prevod3="Message was sent successfully  ";
	}
}*/





%>

<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Blob polje v bazi: </td><td class="valuecell" >
            		 
            		 
            		 
            		 
            			           		  		 <select name="baza_polje_objekt" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						
						
						if (nex.replaceAll(" ----XXX---- "," (").indexOf("[B")!=-1) {
						
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getBaza_polje_objekt()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" selected><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							
							
							<%	
							
							
						}
						}
					}
					
					}
					%>
					
					
					</select> 
            		 
            		 
            		 
            	</td>
             	 <td class="opiscell" width="20%">Content-Type - polje v bazi: </td><td class="valuecell" width="30%">
            		 
            	            		  		 <select name="baza_content_type" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						
						
						if (nex.replaceAll(" ----XXX---- "," (").indexOf("[B")==-1) {
						
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getBaza_content_type()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" selected><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							
							
							<%	
							
							
						}
						}
					}
					
					}
					%>
					
					
					</select> 
            		 
            		 
            	</td>	 
            		  </tr>
            		  
            		  
            		  
            		  
            		  

            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Content-Type rocno (ce ni polja v bazi):</td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="content_type_rocno" maxlength='80' size='50' value="<%=nul.jeNull(vseb.getContent_type_rocno()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            	</td>      		  
            		 <td class="opiscell" width="20%">Extension datoteke ki se generira iz baze (ce je npr. content-type: image/jpeg je extension jpg) </td><td class="valuecell" width="30%">
            		 
            	  <input type="text" name="content_type_extension" maxlength='8' size='9' value="<%=nul.jeNull(vseb.getContent_type_extension()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            		 
            	</td>
             		 
            		  </tr>

       	       		

           		  <tr>
            		  
            		 <td class="opiscell" width="20%">Polje v bazi z imenom datoteke (opcijsko, ce ni extension-a):</td><td class="valuecell" width="30%">
            		 
            		
            		 
            		 
            		 
            		 
            		 
            		 		  		 <select name="baza_ime_file" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						
						
						if (nex.replaceAll(" ----XXX---- "," (").indexOf("[B")==-1) {
						
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getBaza_ime_file()))) {
					%>
					
					
					<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>" selected><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							
							
							<%	
							
							
						}
						}
					}
					
					}
					%>
					
					
					</select> 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            	</td>      		  
            		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
            		 
       
            		
            		 
            	</td>
             		 
            		  </tr>     		  
            		  
            	            	       	
            		  
            		  
            		  
            		  
            		  		  


<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {


if (document.dod.content_type_extension.value=="" && document.dod.baza_ime_file.value=="") {

alert("Napaka: Polje v bazi z imenom datoteke ali extension mora biti vnesen!");
return false;
}

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