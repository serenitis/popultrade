<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
<jsp:useBean id="generator" scope="request" class="com.popultrade.webapp.generator" />
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

String class_name="";
try {
boolean bok=false;
com.popultrade.model.TemplateGumbi vseb =new com.popultrade.model.TemplateGumbi();
com.popultrade.dao.TemplateGumbiDAO dao = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());


if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("prevod"))  {
	
	

	
	
}



if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateGumbi(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateGumbi(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		vseb.setTemplatehead_id(new Long(request.getParameter("idt")));
	}

vseb = (com.popultrade.model.TemplateGumbi)contextUtil.getPopulatedObject(vseb,request);

vseb.setVrednosti_iz_checkbox(nul.jeNull(request.getParameter("vrednosti_iz_checkbox")).equals("1")?"1":"0");
vseb.setUporabi_alert(nul.jeNull(request.getParameter("uporabi_alert")).equals("1")?"1":"0");
vseb.setPrikazi_gumb_z_js(nul.jeNull(request.getParameter("prikazi_gumb_z_js")).equals("1")?"1":"0");
vseb.setOnemogoci_gumbe(nul.jeNull(request.getParameter("onemogoci_gumbe")).equals("1")?"1":"0");

dao.saveTemplateGumbi(vseb);
 

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
/*
/// prevod pregleda
Hashtable prep = new Hashtable();
Hashtable prepd = new Hashtable();
/// prevod vnosa
Hashtable prev = new Hashtable();
Hashtable prevd = new Hashtable();
/// id prevoda_ce obstaja
Hashtable previd = new Hashtable();

/// dobim vse prevode
com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
prevo.setSifra_jez(session.getAttribute("jezikp")+"");
List limo = daop.getPrevodis(prevo);

Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodis(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	previd.put(prv.getPrevod_id()+"",prv.getId()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodisDodatno(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prevd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikp")+"");
limo = daop.getPrevodisDodatno(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prepd.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


*/



Hashtable ht =new Hashtable();
ht.put("lokacija_gumba","lokacija_gumba");
ht.put("target_gumba","target_gumba");
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
<body   style="margin: 0" <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templategumbi_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idt" value="<%=request.getParameter("idt")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		<%
            		if (!nul.jeNull(vseb.getId()+"").equals("")) {
            		%>
Prevod:<input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
            		 <%
            		}
            		 %>
            		 &nbsp;</td>
            		 
             		 <td class="opiscell" width="20%">Klici funkcijo (v primeru add je potrebno dolocit tudi gumb u, add je v bistvu insert pri gumbu u):</td><td class="valuecell" width="30%">
             		 		<select name="klici_funkcijo" style="font-family: Verdana; font-size: 8pt" >
             		 		<option></option>
					<option value="Brisi" <%=nul.jeNull(vseb.getKlici_funkcijo()).equals("Brisi")?"selected":""%>>Brisi</option>
				<option value="Add" <%=nul.jeNull(vseb.getKlici_funkcijo()).equals("Add")?"selected":""%>>Add v hint vrstici</option>
					</select>
					
					
					
					
					
					&nbsp;</td>
             		 
            		  </tr>






            		  <tr>
            		  
            		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
            		 <br>
          		 
            		 &nbsp;</td>
            		 
             		 <td class="opiscell" width="20%"><%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","D",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
             		 
             		 	<%
            		if (!nul.jeNull(vseb.getId()+"").equals("")) {
            		%>
             		 	Alert oz. js prompt pred izvedbo klika na gumb:<input type="text" name="prevod_<%=vseb.getId()%>_D_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","D",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
  	<%
            		}
  	%>
  	
  	             <input type="checkbox" name="uporabi_alert" value="1" <%=nul.jeNull(vseb.getUporabi_alert()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">Uporabi alert
  	
					</td>
             		 
            		  </tr>





		  <tr>
            		  
            		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
            		 
            		
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Custom funkcija, ki klicem ko kliknem na gumb, samo , ce je oznaceno uporabi alert, (dodas [ALERT] za prevod v parametre funkcije) : </td><td class="valuecell" width="30%">
             		 
			 <input type="text" name="uporabi_alert_fun" size="70" maxlength='500' value="<%=nul.jeNull(vseb.getUporabi_alert_fun()+"")%>" style="font-family: Verdana; font-size: 8pt">
            	<br>
            	Prevod:
            	<br>
            		 	<%
            		if (!nul.jeNull(vseb.getId()+"").equals("")) {
            		%>
            		<input type="text" size="70"  name="prevod_<%=vseb.getId()%>_J_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","J",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt"> 
					<%
            		}
					%>
					</td>
             		 
            		  </tr>




            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Opis: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="opis_gumba" size="70" maxlength='350' value="<%=nul.jeNull(vseb.getOpis_gumba()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Lokacija gumba: </td><td class="valuecell" width="30%">
             		 
					<select name="lokacija_gumba" style="font-family: Verdana; font-size: 8pt" >
					<option value="V" <%=nul.jeNull(vseb.getLokacija_gumba()).equals("V")?"selected":""%>>Vrstica</option>
					<option value="H" <%=nul.jeNull(vseb.getLokacija_gumba()).equals("H")?"selected":""%>>Hint vrstica</option>
					<option value="M" <%=nul.jeNull(vseb.getLokacija_gumba()).equals("M")?"selected":""%>>Menu miska desni gumb</option>
					<option value="U" <%=nul.jeNull(vseb.getLokacija_gumba()).equals("U")?"selected":""%>>Menu miska desni gumb v hintu</option>
					<option value="Z" <%=nul.jeNull(vseb.getLokacija_gumba()).equals("Z")?"selected":""%>>Vrstica pod gumbi (pokaze ob kliku na v)</option>
					</select>
					
					</td>
             		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Url gumba: </td><td class="valuecell" width="30%">
            		 
					<select name="url_gumba" style="font-family: Verdana; font-size: 8pt" >
					<option></option>
					<option value="h.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("h.gif")?"selected":""%>>H</option>
					<option value="i.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("i.gif")?"selected":""%>>I</option>
					<option value="pdf.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pdf.gif")?"selected":""%>>PDF</option>
					<option value="pdfs.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pdfs.gif")?"selected":""%>>PDF (siv)</option>
					<option value="x.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("x.gif")?"selected":""%>>X</option>
<option value="search.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("search.gif")?"selected":""%>>Search</option>
<option value="u.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("u.gif")?"selected":""%>>U</option>
<option value="co.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("co.gif")?"selected":""%>>C</option>
<option value="cu.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("cu.gif")?"selected":""%>>CU</option>
<option value="dd.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("dd.gif")?"selected":""%>>DD</option>
<option value="db.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("db.gif")?"selected":""%>>DB</option>
<option value="l.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("l.gif")?"selected":""%>>L</option>
<option value="m.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("m.gif")?"selected":""%>>M</option>

<option value="p.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("p.gif")?"selected":""%>>P</option>
<option value="r.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("r.gif")?"selected":""%>>R</option>
<option value="s.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("s.gif")?"selected":""%>>S</option>
<option value="v.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("v.gif")?"selected":""%>>V</option>
<option value="edi.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("edi.gif")?"selected":""%>>EDI</option>

<option value="ediz.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("ediz.gif")?"selected":""%>>EDI (zeleno)</option>



					<option value="cnt.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("cnt.gif")?"selected":""%>>CNT</option>
					<option value="skl.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("skl.gif")?"selected":""%>>SKL</option>
					<option value="m.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("m.gif")?"selected":""%>>M</option>
					<option value="v.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("v.gif")?"selected":""%>>V</option>
<option value="z.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("z.gif")?"selected":""%>>Z</option>
<option value="o.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("o.gif")?"selected":""%>>O</option>
<option value="pb.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pb.gif")?"selected":""%>>PB</option>
<option value="pf.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pf.gif")?"selected":""%>>PF</option>
<option value="pe.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pe.gif")?"selected":""%>>PE</option>
<option value="ve.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("ve.gif")?"selected":""%>>VE</option>
<option value="vf.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("vf.gif")?"selected":""%>>VF</option>
<option value="vb.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("vb.gif")?"selected":""%>>VB</option>

<option value="vs.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("vs.gif")?"selected":""%>>VS</option>
<option value="pr.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pr.gif")?"selected":""%>>PR</option>
<option value="di.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("di.gif")?"selected":""%>>DI</option>
<option value="na.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("na.gif")?"selected":""%>>NA</option>
<option value="er.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("er.gif")?"selected":""%>>ER</option>



<option value="nn.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("nn.gif")?"selected":""%>>NN</option>
<option value="nl.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("nl.gif")?"selected":""%>>NL</option>
<option value="ns.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("ns.gif")?"selected":""%>>NS</option>

<option value="nc.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("nc.gif")?"selected":""%>>NC</option>
<option value="ni.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("ni.gif")?"selected":""%>>NI</option>
<option value="np.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("np.gif")?"selected":""%>>NP</option>

<option value="vd.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("vd.gif")?"selected":""%>>VD</option>
<option value="vs.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("vs.gif")?"selected":""%>>VS</option>
<option value="xml.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("xml.gif")?"selected":""%>>XML</option>
<option value="t.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("t.gif")?"selected":""%>>T</option>


<option value="errr.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("errr.gif")?"selected":""%>>ERR Rdec</option>
<option value="errz.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("errz.gif")?"selected":""%>>ERR Zelen</option>

<option value="doi.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("doi.gif")?"selected":""%>>DOI</option>
<option value="upload.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("upload.gif")?"selected":""%>>Upload</option>

<option value="ev.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("ev.gif")?"selected":""%>>EV</option>
<option value="stu.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("stu.gif")?"selected":""%>>STU</option>
<option value="str.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("str.gif")?"selected":""%>>STR</option>

<option value="copyplav.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("copyplav.gif")?"selected":""%>>Copy play</option>
					<option value="vnos.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("vnos.gif")?"selected":""%>>Add</option>
					
					
						
						<option value="sprem.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("sprem.gif")?"selected":""%>>Sprem</option>
					<option value="restow.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("restow.gif")?"selected":""%>>Restow</option>
					
										
						<option value="vlm.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("vlm.gif")?"selected":""%>>Vlm</option>
					<option value="p315.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("p315.gif")?"selected":""%>>315 Plav</option>
					<option value="p615.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("p615.gif")?"selected":""%>>615 Plav</option>
					<option value="p507.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("p507.gif")?"selected":""%>>507 Plav</option>
						<option value="p007.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("p007.gif")?"selected":""%>>007 Rdec</option>
					<option value="p044.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("p044.gif")?"selected":""%>>044 Rdec</option>
					
					<option value="pdfm.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pdfm.gif")?"selected":""%>>PDF M (rdec)</option>
					<option value="pdfmsiv.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pdfmsiv.gif")?"selected":""%>>PDF M (siv)</option>
					<option value="nizelen.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("nizelen.gif")?"selected":""%>>NI (zelen)</option>
					
					
						<option value="utxt.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("utxt.gif")?"selected":""%>>Upload txt </option>
				<option value="uxsl.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("uxsl.gif")?"selected":""%>>Upload xsl </option>
					<option value="uxml.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("uxml.gif")?"selected":""%>>Upload xml </option>
					<option value="xls.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("xls.gif")?"selected":""%>>XLS </option>
					<option value="pp007.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pp007.gif")?"selected":""%>>007 Plav </option>
					
					<option value="a.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("a.gif")?"selected":""%>>A Plav </option>
					<option value="pdfc.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pdfc.gif")?"selected":""%>>PDF C </option>
					<option value="nu.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("nu.gif")?"selected":""%>>NU Plav </option>
					
					
					<option value="r440red.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("r440red.gif")?"selected":""%>>440 Rdec </option>
					<option value="r442red.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("r442red.gif")?"selected":""%>>442 Rdec </option>
					<option value="add.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("add.gif")?"selected":""%>>ADD (navaden) </option>
					<option value="pdfpp.gif" <%=nul.jeNull(vseb.getUrl_gumba()).equals("pdfpp.gif")?"selected":""%>>PDF P </option>
					</select>
					
					        		 
        		 	 </td>
            		 
            		 
            		 
            		   		 <td class="opiscell" width="20%">Url gumba po menjavi: </td><td class="valuecell" width="30%">
            		 
					<select name="zamenjaj_url_gumba" style="font-family: Verdana; font-size: 8pt" >
					<option></option>
					<option value="h.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("h.gif")?"selected":""%>>H</option>
					<option value="i.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("i.gif")?"selected":""%>>I</option>
					<option value="pdf.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pdf.gif")?"selected":""%>>PDF</option>
					<option value="pdfs.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pdfs.gif")?"selected":""%>>PDF (siv)</option>
					<option value="x.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("x.gif")?"selected":""%>>X</option>
<option value="search.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("search.gif")?"selected":""%>>Search</option>
<option value="u.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("u.gif")?"selected":""%>>U</option>
<option value="co.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("co.gif")?"selected":""%>>C</option>
<option value="cu.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("cu.gif")?"selected":""%>>CU</option>
<option value="dd.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("dd.gif")?"selected":""%>>DD</option>
<option value="db.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("db.gif")?"selected":""%>>DB</option>
<option value="l.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("l.gif")?"selected":""%>>L</option>
<option value="m.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("m.gif")?"selected":""%>>M</option>

<option value="p.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("p.gif")?"selected":""%>>P</option>
<option value="r.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("r.gif")?"selected":""%>>R</option>
<option value="s.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("s.gif")?"selected":""%>>S</option>
<option value="v.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("v.gif")?"selected":""%>>V</option>
<option value="edi.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("edi.gif")?"selected":""%>>EDI</option>

<option value="ediz.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("ediz.gif")?"selected":""%>>EDI (zeleno)</option>



					<option value="cnt.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("cnt.gif")?"selected":""%>>CNT</option>
					<option value="skl.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("skl.gif")?"selected":""%>>SKL</option>
					<option value="m.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("m.gif")?"selected":""%>>M</option>
					<option value="v.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("v.gif")?"selected":""%>>V</option>
<option value="z.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("z.gif")?"selected":""%>>Z</option>
<option value="o.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("o.gif")?"selected":""%>>O</option>
<option value="pb.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pb.gif")?"selected":""%>>PB</option>
<option value="pf.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pf.gif")?"selected":""%>>PF</option>
<option value="pe.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pe.gif")?"selected":""%>>PE</option>
<option value="ve.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("ve.gif")?"selected":""%>>VE</option>
<option value="vf.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("vf.gif")?"selected":""%>>VF</option>
<option value="vb.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("vb.gif")?"selected":""%>>VB</option>

<option value="vs.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("vs.gif")?"selected":""%>>VS</option>
<option value="pr.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pr.gif")?"selected":""%>>PR</option>
<option value="di.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("di.gif")?"selected":""%>>DI</option>
<option value="na.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("na.gif")?"selected":""%>>NA</option>
<option value="er.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("er.gif")?"selected":""%>>ER</option>



<option value="nn.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("nn.gif")?"selected":""%>>NN</option>
<option value="nl.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("nl.gif")?"selected":""%>>NL</option>
<option value="ns.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("ns.gif")?"selected":""%>>NS</option>

<option value="nc.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("nc.gif")?"selected":""%>>NC</option>
<option value="ni.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("ni.gif")?"selected":""%>>NI</option>
<option value="np.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("np.gif")?"selected":""%>>NP</option>

<option value="vd.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("vd.gif")?"selected":""%>>VD</option>
<option value="vs.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("vs.gif")?"selected":""%>>VS</option>
<option value="xml.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("xml.gif")?"selected":""%>>XML</option>
<option value="t.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("t.gif")?"selected":""%>>T</option>


<option value="errr.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("errr.gif")?"selected":""%>>ERR Rdec</option>
<option value="errz.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("errz.gif")?"selected":""%>>ERR Zelen</option>

<option value="doi.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("doi.gif")?"selected":""%>>DOI</option>
<option value="upload.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("upload.gif")?"selected":""%>>Upload</option>

<option value="ev.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("ev.gif")?"selected":""%>>EV</option>

<option value="stu.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("stu.gif")?"selected":""%>>STU</option>
<option value="str.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("str.gif")?"selected":""%>>STR</option>
<option value="copyplav.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("copyplav.gif")?"selected":""%>>Copy play</option>


					<option value="vnos.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("vnos.gif")?"selected":""%>>Add</option>
					
						<option value="sprem.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("sprem.gif")?"selected":""%>>Sprem</option>
					<option value="restow.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("restow.gif")?"selected":""%>>Restow</option>
					
												
						<option value="vlm.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("vlm.gif")?"selected":""%>>Vlm</option>
					<option value="p315.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("p315.gif")?"selected":""%>>315 Plav</option>
					<option value="p615.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("p615.gif")?"selected":""%>>615 Plav</option>
					<option value="p507.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("p507.gif")?"selected":""%>>507 Plav</option>
					
							<option value="p007.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("p007.gif")?"selected":""%>>007 Rdec</option>
					<option value="p044.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("p044.gif")?"selected":""%>>044 Rdec</option>
					<option value="pdfm.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pdfm.gif")?"selected":""%>>PDF M (rdec)</option>
					
					<option value="pdfmsiv.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pdfmsiv.gif")?"selected":""%>>PDF M (siv)</option>
					<option value="nizelen.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("nizelen.gif")?"selected":""%>>NI (zelen)</option>
					
					
							<option value="utxt.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("utxt.gif")?"selected":""%>>Upload txt </option>
				<option value="uxsl.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("uxsl.gif")?"selected":""%>>Upload xsl </option>
					<option value="uxml.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("uxml.gif")?"selected":""%>>Upload xml </option>
					<option value="xls.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("xls.gif")?"selected":""%>>XLS </option>
					<option value="pp007.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pp007.gif")?"selected":""%>>007 Plav </option>
					<option value="a.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("a.gif")?"selected":""%>>A Plav </option>
					<option value="pdfc.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pdfc.gif")?"selected":""%>>PDF C </option>
					
					
					<option value="nu.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("nu.gif")?"selected":""%>>NU Plav </option>
					
					<option value="r440red.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("r440red.gif")?"selected":""%>>440 Rdec </option>
					<option value="r442red.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("r442red.gif")?"selected":""%>>442 Rdec </option>
					<option value="add.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("add.gif")?"selected":""%>>ADD (navaden) </option>
					
					
						<option value="pdfpp.gif" <%=nul.jeNull(vseb.getZamenjaj_url_gumba()).equals("pdfpp.gif")?"selected":""%>>PDF P </option>
					</select>
					(V primeru vrednosti se ob kliku na gumb (iz url gumba polja) prikaze izbrani gumb iz tega polja, dela le za gumbe v vrsticah)
					        		 
        		 	 </td>
            		 
    
             		 
        		  </tr>
        		  
        		  
        		  
        		  <tr>
        		  
        		 <td class="opiscell">Ne slika - gumb tekst: </td><td class="valuecell" colspan="3">
        		 
 <input type="text" name="tekst_gumb" maxlength='15' size="16" value="<%=nul.jeNull(vseb.getTekst_gumb()+"")%>" style="font-family: Verdana; font-size: 8pt">
    Style: 
    <%
    boolean checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("silver")) {
    checked=true;
    }
     %><img src="ssilver.gif" border=0>
    <input type="radio" value="silver" name="style_gumb" <%=checked?"checked":"" %>>     
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("red")) {
    checked=true;
    }
     %><img src="sred.gif" border=0>
    <input type="radio" value="red" name="style_gumb" <%=checked?"checked":"" %>>    		 					
		  <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("blue")) {
    checked=true;
    }
     %><img src="sblue.gif" border=0>
    <input type="radio" value="blue" name="style_gumb" <%=checked?"checked":"" %>>    	
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("green")) {
    checked=true;
    }
     %><img src="sgreen.gif" border=0>
    <input type="radio" value="green" name="style_gumb" <%=checked?"checked":"" %>>    
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("yellow")) {
    checked=true;
    }
     %><img src="syellow.gif" border=0>
    <input type="radio" value="yellow" name="style_gumb" <%=checked?"checked":"" %>>  
        <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("purple")) {
    checked=true;
    }
     %><img src="spurple.gif" border=0>
    <input type="radio" value="purple" name="style_gumb" <%=checked?"checked":"" %>>    
       <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("orange")) {
    checked=true;
    }
     %><img src="sorange.gif" border=0>
    <input type="radio" value="orange" name="style_gumb" <%=checked?"checked":"" %>>   	
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("blued")) {
    checked=true;
    }
     %><img src="sblued.gif" border=0>
    <input type="radio" value="blued" name="style_gumb" <%=checked?"checked":"" %>>     	
     <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("redb")) {
    checked=true;
    }
     %><img src="sredb.gif" border=0>
    <input type="radio" value="redb" name="style_gumb" <%=checked?"checked":"" %>>     
         <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("greenb")) {
    checked=true;
    }
     %><img src="sgreenb.gif" border=0>
    <input type="radio" value="greenb" name="style_gumb" <%=checked?"checked":"" %>>    	
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("silverb")) {
    checked=true;
    }
     %><img src="ssilverb.gif" border=0>
    <input type="radio" value="silverb" name="style_gumb" <%=checked?"checked":"" %>>    
       <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("blueb")) {
    checked=true;
    }
     %><img src="sblueb.gif" border=0>
    <input type="radio" value="blueb" name="style_gumb" <%=checked?"checked":"" %>>    	        		 
        		 </td>
        		 </tr>
        		  
        		  
        		  
        		  
        		  
        		  
        		    
        		  
        		  
        		  
        		  
        		  <tr>
        		  
        		 <td class="opiscell">Ne slika - gumb tekst po kliku na gumb: </td><td class="valuecell" colspan="3">
        		 
 <input type="text" name="tekst_gumb_p" maxlength='15' size="16" value="<%=nul.jeNull(vseb.getTekst_gumb_p()+"")%>" style="font-family: Verdana; font-size: 8pt">
    Style: 
    <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("silver")) {
    checked=true;
    }
     %><img src="ssilver.gif" border=0>
    <input type="radio" value="silver" name="style_gumb_p" <%=checked?"checked":"" %>>     
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("red")) {
    checked=true;
    }
     %><img src="sred.gif" border=0>
    <input type="radio" value="red" name="style_gumb_p" <%=checked?"checked":"" %>>    		 					
		  <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("blue")) {
    checked=true;
    }
     %><img src="sblue.gif" border=0>
    <input type="radio" value="blue" name="style_gumb_p" <%=checked?"checked":"" %>>    	
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("green")) {
    checked=true;
    }
     %><img src="sgreen.gif" border=0>
    <input type="radio" value="green" name="style_gumb_p" <%=checked?"checked":"" %>>    
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("yellow")) {
    checked=true;
    }
     %><img src="syellow.gif" border=0>
    <input type="radio" value="yellow" name="style_gumb_p" <%=checked?"checked":"" %>>  
        <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("purple")) {
    checked=true;
    }
     %><img src="spurple.gif" border=0>
    <input type="radio" value="purple" name="style_gumb_p" <%=checked?"checked":"" %>>    
       <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("orange")) {
    checked=true;
    }
     %><img src="sorange.gif" border=0>
    <input type="radio" value="orange" name="style_gumb_p" <%=checked?"checked":"" %>>   	  	
         <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("blued")) {
    checked=true;
    }
     %><img src="sblued.gif" border=0>
    <input type="radio" value="blued" name="style_gumb_p" <%=checked?"checked":"" %>>   	
        <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("redb")) {
    checked=true;
    }
     %><img src="sredb.gif" border=0>
    <input type="radio" value="redb" name="style_gumb_p" <%=checked?"checked":"" %>>     	  
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("greenb")) {
    checked=true;
    }
     %><img src="sgreenb.gif" border=0>
    <input type="radio" value="greenb" name="style_gumb_p" <%=checked?"checked":"" %>>       
    
         <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("silverb")) {
    checked=true;
    }
     %><img src="ssilverb.gif" border=0>
    <input type="radio" value="silverb" name="style_gumb_p" <%=checked?"checked":"" %>>          
    
         <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb()+"").equals("blueb")) {
    checked=true;
    }
     %><img src="sblueb.gif" border=0>
    <input type="radio" value="blueb" name="style_gumb_p" <%=checked?"checked":"" %>>    		 
        		 </td>
        		 </tr>
        		  	  
        		  
        		  
        		  
        		  
        		  
        		  
        		  
        		  
        		  
        		  
        		  
        		  
        		  <tr>
        		  
        		 <td class="opiscell">Target gumba: </td><td class="valuecell" colspan="3">
        		 
					<select name="target_gumba" style="font-family: Verdana; font-size: 8pt" >
					<option value="0" <%=nul.jeNull(vseb.getTarget_gumba()).equals("0")?"selected":""%>>parent.frames[0]</option>
					<option value="1" <%=nul.jeNull(vseb.getTarget_gumba()).equals("1")?"selected":""%>>parent.frames[1]</option>
					<option value="2" <%=nul.jeNull(vseb.getTarget_gumba()).equals("2")?"selected":""%>>parent.frames[2]</option>
					
					
					
					
					
					
					<option value="O" <%=nul.jeNull(vseb.getTarget_gumba()).equals("O")?"selected":""%>>Overlay</option>
					<option value="F" <%=nul.jeNull(vseb.getTarget_gumba()).equals("F")?"selected":""%>>Overlay over overlay</option>
					<option value="G" <%=nul.jeNull(vseb.getTarget_gumba()).equals("G")?"selected":""%>>Overlay over overlay last</option>
					<option value="B" <%=nul.jeNull(vseb.getTarget_gumba()).equals("B")?"selected":""%>>_blank</option>
					
					<option value="3" <%=nul.jeNull(vseb.getTarget_gumba()).equals("3")?"selected":""%>>parent.frames[0] razdeli na dva dela vodoravno</option>
					<option value="4" <%=nul.jeNull(vseb.getTarget_gumba()).equals("4")?"selected":""%>>parent.frames[1] razdeli na dva dela vodoravno</option>
					<option value="5" <%=nul.jeNull(vseb.getTarget_gumba()).equals("5")?"selected":""%>>parent.frames[2] razdeli na dva dela vodoravno</option>
					
					
					<option value="6" <%=nul.jeNull(vseb.getTarget_gumba()).equals("6")?"selected":""%>>parent.frames[0] razdeli na dva dela navpicno</option>
					<option value="7" <%=nul.jeNull(vseb.getTarget_gumba()).equals("7")?"selected":""%>>parent.frames[1] razdeli na dva dela navpicno</option>
					<option value="8" <%=nul.jeNull(vseb.getTarget_gumba()).equals("8")?"selected":""%>>parent.frames[2] razdeli na dva dela navpicno</option>
					
					
				<option value="9" <%=nul.jeNull(vseb.getTarget_gumba()).equals("9")?"selected":""%>>Vpisi rocno</option>
					
					
					
					</select>
					
					      
					      Ce se frame razdeli na 2, sirina/visina frame 1:  
					      <input type="text" name="size_left" maxlength="4" size="5" value="<%=nul.jeNull(vseb.getSize_left()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		sirina/visina frame 2:  
					      <input type="text" name="size_right" maxlength="4" size="5" value="<%=nul.jeNull(vseb.getSize_right()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		rocni target:  
					      <input type="text" name="target_rocni" maxlength="90" size="65" value="<%=nul.jeNull(vseb.getTarget_rocni()+"")%>" style="font-family: Verdana; font-size: 8pt"> (ce vpises top.* se doda targetu zraven top, npr top.parent..., ce ni rocni target ali blank)
             		
					      
					        		 
        		 </td>
        		 </tr>




<tr>
	 <td class="opiscell">Vrednosti preko checkboxa ali le submit vsebine lista (ce gre za vrednosti pridobljene preko checkboxa): </td><td class="valuecell" colspan=3>
             		
              <input type="checkbox" name="vrednosti_iz_checkbox" value="1" <%=nul.jeNull(vseb.getVrednosti_iz_checkbox()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
	<br>
	Specificirat je potrebno na parametrih katera vrednost je pridobljena preko checkbox (stolpec metoda). Gumb mora biti v hint vrstici! V primeru vec submit gumbov se target/action rabi iz zadnjega.
             		 
             		 </td>
             		 
        		  </tr>
        		  
        		  <tr>
	 <td class="opiscell">Dodaten javascript (klice se pred submitom): </td><td class="valuecell" colspan=3>
             		
<textarea cols=70 rows=1 name="dodaten_js_function" maxlength="70"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDodaten_js_function()+"")%></textarea>
	<br>
	Doda se funkcijo, ki se klice pred submitom lista. Naredi funkcijo pod dodatnimi pogoji (Javascript funkcije). Ce gumb nima templateja definiraj action za form preko funkcije.
             		 
             		 </td>
             		 
        		  </tr>
        		  
        		  

<tr>
	 <td class="opiscell">Onemogoci gumbe (ob kliku na ta gumb onemogocis ostale - v primeru, da je potrditveno okno): </td><td class="valuecell" >
             		
              <input type="checkbox" name="onemogoci_gumbe" value="1" <%=nul.jeNull(vseb.getOnemogoci_gumbe()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
         		 
             		 </td>
             		   		 
            		 
            		 
             		 <td class="opiscell">Zaporedje: </td><td class="valuecell">
             		
             		 <input type="text" name="zaporedje" maxlength="3" size="4" value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
             		
             	
             		 </td>
        		  </tr>





            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Pogoj za prikaz url gumba po prijavi namesto url gumba (format if (##pogoji##)): </td><td class="valuecell" width="30%" colspan="3">
            		 
            		  <input type="text" name="zamenjaj_uporabi_pogoj" maxlength='400' size="100" value="<%=nul.jeNull(vseb.getZamenjaj_uporabi_pogoj()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		  
            		  
            		  <br>
            		  
            		  
            		<select name="hql1" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="(">(</option>
            		  </select>
            		  
            		  <select name="hql2" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="&&">AND</option>
            		  <option value="||">OR</option>
            		  </select>
            		  
            	  		<select name="hql3" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
					com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

					
					//// dobim ime model clase iz headerja
					thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("idt"))));
					class_name=thead.getHead_class_name();
					//// dobim ime model clase iz headerja
					//thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("sifid"))));
					 List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>()"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
					
					
					
					
					
					
					
					
					
					
					
			if (!nul.jeNull(thead.getVeza_gumb()+"").equals("")) {
						
						com.popultrade.model.TemplateGumbiParametri tgp = new com.popultrade.model.TemplateGumbiParametri();
						com.popultrade.dao.TemplateGumbiParametriDAO dah = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
						
						tgp.setTemplategumb_id(thead.getVeza_gumb());
						
						List limo = dah.getTemplateGumbiParametris(tgp);
						
						Iterator imo = limo.iterator();
						
						while (imo.hasNext()) {
							com.popultrade.model.TemplateGumbiParametri slur = (com.popultrade.model.TemplateGumbiParametri)imo.next();
							
							String primeri = nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')";
							if (!nul.jeNull(slur.getDugacno_ime_parametra()).equals("")) {
								primeri = "request.getParameter(\'"+slur.getDugacno_ime_parametra()+"\')";
							}
							
							
						
						%>
						
						<option value="<%=primeri%>" ><%=primeri%> (vrednost preko pred gumba)</option>
					
						
						<%
						}
					}
					
					
			 li = templateUtil.getKonstantePriLogu();
				
			 itti = li.iterator();

			while (itti.hasNext()) {
			
				String nex =(String)itti.next();

					
					%>
					
					
					<option value="<%=nex%>"><%=nex%></option>
					
					
					<%	
					
					
				
			}
					
					
					
					
					%>
					</select>
					  	<select name="hql35" style="font-family: Verdana; font-size: 8pt" >
				<option value=""></option>
            		  <option value="=">=</option>
            		  <option value="!=">!=</option>
            		  <option value="&gt;=">&gt;=</option>
            		  <option value="&lt;=">&lt;=</option>
            		    <option value="&gt;">&gt;</option>
            		  <option value="&lt;">&lt;</option>
            		  <option value="equals">equals (v primeru, da je polje string)</option>
            		 <option value="nequals">not equals (v primeru, da je polje string)</option>
            		  </select>
					
					<input type="text" size=20 name="hql5"  style="font-family: Verdana; font-size: 8pt">
					
            		  	<select name="hql7" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value=")">)</option>
            		  </select>
            		  
            		  <input type="button" value="DODAJ" onclick="dodaj()" style="font-family: Verdana; font-size: 8pt"> 
            		  
            		  
            		  <input type="button" value="RESET" onclick="dodajreset()" style="font-family: Verdana; font-size: 8pt"> 
            		  </td>
            		 
</tr>

<%

String tabn ="";
if (true) {
	com.popultrade.model.TemplateHead vsebx =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daox = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
if (request.getParameter("idt")!=null && request.getParameter("akcija")==null) {
vsebx = daox.getTemplateHead(new Long(nul.jeNullDefault(request.getParameter("idt"))));
}

tabn = vsebx.getHead_class_name();

}

%>


         <tr>
            		  
            		 <td class="opiscell" width="20%">Rocni url, v primeru, da se url target za gumb definira rocno (deluje le v hintu, parametri se definirajo preko gumba v): </td><td class="valuecell" width="30%" colspan="3">
            		 <textarea cols="100" rows="2" name="rocni_url" style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getRocni_url()+"")%></textarea>
            		<input type="button" value="+" onclick="(document.getElementById('helpo').style.display=='inline'?document.getElementById('helpo').style.display='none':document.getElementById('helpo').style.display='inline')" style="font-family: Verdana; font-size: 8pt">
            		<input type="button" value="Uporabi copiranje" onclick="document.dod.rocni_url.value='m_templategen_copy.jsp?modelname=<%=tabn %>&modelid=<%=generator.getKodo6() %>&id=<\%=vseb.getId() \%>&target='+document.dod.target_gumba.value" style="font-family: Verdana; font-size: 8pt">
            		<br><span id=helpo name=helpo style="display:none;">V primeru kopiranja recorda uporabi sledece:<br> m_templategen_copy.jsp
            		<br>?modelname=[ime classe] --- isto ime kot v hibernate pazi na upper in lower case
            		<br>&modelid=[opcijski rocni id v primeru vec gumbov za kopiranje iste classe]
            		<br>&[dodatno setiranje parametrov npr. &id=|vrednost idja|&status=1] -- iz teh parametrov najde v bazi recorde in kopira najdene
            		<br>&[dodatno setiranje default vrednosti] -- npr. ce hoces da kopiran record ima status 1 das _tt[ime classe]_Sstatus=1 (predpone (npr _S) so obvezne in ime po predponi mora biti enako imenu v hibernate ) (_tt za root strukture _t za veje)
            		<br> ostale predpone: _S=> string , _I=>integer, _D=double, _L=long, _T=date
            		<br>&[setiranja tabel/class ki se ne kopira po tree strukturi &imeclasse=yes] -- ce naprimer hoces kopirat userja in ne privilegij ki so vezani na userja
            		<br> primer za kopiranje istega recorda (za class Users): m_templategen_copy.jsp?modelname=Users&modelid=cop1&id=2345 --- kopiralo bo celotnega userja z vsemi tabelami vezanimi na userja
            		<br> primer za kopiranje istega recorda ter setiranje statusa na 1: m_templategen_copy.jsp?modelname=Users&modelid=cop2&id=2345&_Sstatus=1 --- kopiralo bo celotnega userja z vsemi tabelami vezanimi na userja
            		</span>
            		 
            		 </td></tr>   






<tr>
	 <td class="opiscell">Dodaj gumb v div tag za prikaz oz. hide gumba preko JS (viden je ce ustreza pogoju za prikaz gumba ce ne je hidden): </td><td class="valuecell" >
             		
              <input type="checkbox" name="prikazi_gumb_z_js" value="1" <%=nul.jeNull(vseb.getPrikazi_gumb_z_js()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
         		 
             		 </td>
             		   		 <td class="opiscell" width="20%">Ime diva za prikaz oz. hide gumba preko JS (ime + id recorda): </td><td class="valuecell" width="30%">
      
  <input type="text" name="prikazi_gumb_ime" maxlength='35' size="36" value="<%=nul.jeNull(vseb.getPrikazi_gumb_ime()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 					        		 
        		 	 </td>
        		  </tr>


















<tr><td colspan="4" class="opiscell" align="center">

 <input type="submit" value="Shrani prevode"  style="font-family: Verdana; font-size: 8pt">

<input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {


return true;
}




function dodajreset() {
document.dod.hql1.value="";
document.dod.hql2.value="";
document.dod.hql3.value="";
document.dod.hql35.value="";

document.dod.hql5.value="";

document.dod.hql7.value="";
}
function dodaj() {
document.dod.zamenjaj_uporabi_pogoj.value = document.dod.zamenjaj_uporabi_pogoj.value + " "+
document.dod.hql1.value + " "+
document.dod.hql2.value + " "+(document.dod.hql35.value=='nequals'?'!':'')+ ((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"nul.jeNull(":'')+
document.dod.hql3.value+ ((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"+'')":"")+((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?".equals('":document.dod.hql35.value)+
document.dod.hql5.value+((document.dod.hql35.value=='nequals' || document.dod.hql35.value=='equals')?"')":"")+
document.dod.hql7.value;

}

function dodajv() {
document.dod.vrednost_pogoja.value = document.dod.vrednost_pogoja.value + " "+
document.dod.hv1.value + " nul.jeNull("+
document.dod.hv2.value + "()+'') "+
document.dod.hv3.value;

}

function preseli() {
document.dod.vrednost_pogoja.value =document.dod.vrednost_pogoja.value+ ' nul.jeNull('+document.dod.vrednost_pogojas.value+ '()+"") ';

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
var mon = parent.frames[2].document.location+"";
function mom() {


}
<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
  if (mon.indexOf("?")!=-1) {
    parent.frames[2].document.location = mon.substring(0,mon.indexOf("idback")-1)+"&idback=<%=request.getParameter("id")%>";
  }
  else {
  parent.frames[2].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
}

}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
     
     }
     else {
parent.frames[2].document.location = parent.frames[2].document.location + "&idback=<%=request.getParameter("id")%>";
     }
     }
     else {
     parent.frames[2].document.location = parent.frames[2].document.location + "?idback=<%=request.getParameter("id")%>";

     }
}
<%
}
else {
%>
    if (mon.indexOf("id=")!=-1) {
    
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?"));
     }
     else {
    
parent.frames[2].document.location = parent.frames[2].document.location;
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