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
com.popultrade.model.TemplateMailList vseb =new com.popultrade.model.TemplateMailList();
com.popultrade.dao.TemplateMailListDAO dao = (com.popultrade.dao.TemplateMailListDAO)contextUtil.getBeanDao("templateMailListDAO",pageContext.getServletContext());
if (request.getParameter("idt")!=null  && request.getParameter("akcija")==null) {
vseb = dao.getTemplateMailListByVezaId(new Long(nul.jeNullDefault(request.getParameter("idt"))));
if (vseb==null) {
	vseb =new com.popultrade.model.TemplateMailList();
	vseb.setFont_size_head(7);
	vseb.setFont_size_list(7);
	vseb.setMax_st_izpisov(250);
	vseb.setUrl_gumb("m.gif");
	defaultt=true;
	
}
} 

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateMailList(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
		

					
vseb.setTemplatehead_id(new Long(request.getParameter("idt")));




	}

vseb = (com.popultrade.model.TemplateMailList)contextUtil.getPopulatedObject(vseb,request);
//vseb.setPdf_font_width(nul.jeNull(request.getParameter("pdf_font_width")).equals("1")?"1":"0");
//vseb.setPdf_font_size_prevod_width(nul.jeNull(request.getParameter("pdf_font_size_prevod_width")).equals("1")?"1":"0");
//vseb.setPdf_header_width(nul.jeNull(request.getParameter("pdf_header_width")).equals("1")?"1":"0");
//vseb.setUporabi_page_break(nul.jeNull(request.getParameter("uporabi_page_break")).equals("1")?"1":"0");
vseb.setUporabi(nul.jeNull(request.getParameter("uporabi")).equals("1")?"1":"0");
vseb.setUporabi_excel(nul.jeNull(request.getParameter("uporabi_excel")).equals("1")?"1":"0");
vseb.setUpdate_polje_uporabi(nul.jeNull(request.getParameter("update_polje_uporabi")).equals("1")?"1":"0");

dao.saveTemplateMailList(vseb);





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
ht.put("max_st_izpisov","max_st_izpisov");
ht.put("url_gumb","url_gumb");

ht.put("target_frame","target_frame");
Hashtable htn =new Hashtable();
htn.put("max_st_izpisov","max_st_izpisov");




%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %>

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templatemaillist.jsp" method="post" onSubmit="return check()">

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
String prevod4="";

if (defaultt) {
	
	if (session.getAttribute("jezikv").equals("SL")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Rezultat iskanja poslji na moj e-mail";
		 
		 prevod3="Sporocilo je bilo uspesno poslano ";
		 prevod4="Rezultat iskanja poslji na moj e-mail v excel obliki";
	}
	else if (session.getAttribute("jezikv").equals("HR")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Spisak salji na moj e-mail";
		 prevod3="Poruka je bila uspjesno poslana ";
		 prevod4="Spisak salji na moj e-mail u excel obliki";
	}
	else if (session.getAttribute("jezikv").equals("SR")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Spisak salji na moj e-mail";
		 prevod3="Poruka je bila uspesno poslata ";
		 prevod4="Spisak salji na moj e-mail u excel obliki";
	}
	else if (session.getAttribute("jezikv").equals("EN")) {
		 prevod1="AdriaticPorts -> ";
		 prevod2="Send the search result list to my e-mail";
		 prevod3="Message was sent successfully  ";
		 prevod4="Send the search result list to my e-mail in excel format";
	}
}





%>

<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">
<input type=hidden name="idn" value="<%=nul.jeNull(request.getParameter("idn"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Maximalno stevilo izpisov (omejitev selecta): </td><td class="valuecell" >
            		 
            		 <input type="text" name="max_st_izpisov" maxlength='5' size='5' value="<%=nul.jeNull(vseb.getMax_st_izpisov()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            	</td>
             	 <td class="opiscell" width="20%">Uporabi posiljanje izpisa (HTML-Mail): </td><td class="valuecell" width="30%">
            		 
            	           		  <input type="checkbox" name="uporabi" value="1" <%=nul.jeNull(vseb.getUporabi()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
    
            		 
            	</td>	 
            		  </tr>
            		  
            		  
            		    		  <tr>
            		  
            		 <td class="opiscell" width="20%"></td><td class="valuecell" >
            		 
            		 
            		  
            	</td> 
             	 <td class="opiscell" width="20%">Uporabi posiljanje izpisa EXCEL (XLS-Mail): </td><td class="valuecell" width="30%">
            		 
            	           		  <input type="checkbox" name="uporabi_excel" value="1" <%=nul.jeNull(vseb.getUporabi_excel()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
    
            		 
            	</td>	 
            		  </tr>
            		  
            		  

            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Velikost fonta v glavi: (v aplikaciji 7)</td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="font_size_head" maxlength='3' size='3' value="<%=nul.jeNull(vseb.getFont_size_head()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            	</td>      		  
            		 <td class="opiscell" width="20%">Velikost fonta vsebine: (v aplikaciji 7) </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="font_size_list" maxlength='3' size='3' value="<%=nul.jeNull(vseb.getFont_size_list()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            	</td>
             		 
            		  </tr>

       	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (predmet sporocila) : <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","L",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_<%=request.getParameter("idt")%>_L_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=(!defaultt?nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","L",session.getAttribute("jezikv")+"")):prevod1)%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
             		 </td></tr>


          		  
            		  
            	            	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (hint gumba) : <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","K",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size="70"  name="prevod_<%=request.getParameter("idt")%>_K_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=(!defaultt?nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","K",session.getAttribute("jezikv")+"")):prevod2)%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">URL Gumb:</td><td class="valuecell" width="30%">
           	
            		             		 
					<select name="url_gumb" style="font-family: Verdana; font-size: 8pt" >
					<option></option>
					<option value="h.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("h.gif")?"selected":""%>>H</option>
					<option value="i.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("i.gif")?"selected":""%>>I</option>
					<option value="pdf.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("pdf.gif")?"selected":""%>>PDF</option>
					<option value="pdfs.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("pdfs.gif")?"selected":""%>>PDF (siv)</option>
					<option value="x.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("x.gif")?"selected":""%>>X</option>
<option value="search.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("search.gif")?"selected":""%>>Search</option>
<option value="u.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("u.gif")?"selected":""%>>U</option>
<option value="co.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("co.gif")?"selected":""%>>C</option>
<option value="cu.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("cu.gif")?"selected":""%>>CU</option>
<option value="dd.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("dd.gif")?"selected":""%>>DD</option>
<option value="db.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("db.gif")?"selected":""%>>DB</option>
<option value="l.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("l.gif")?"selected":""%>>L</option>
<option value="m.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("m.gif")?"selected":""%>>M</option>

<option value="p.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("p.gif")?"selected":""%>>P</option>
<option value="r.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("r.gif")?"selected":""%>>R</option>
<option value="s.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("s.gif")?"selected":""%>>S</option>
<option value="v.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("v.gif")?"selected":""%>>V</option>
<option value="edi.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("edi.gif")?"selected":""%>>EDI</option>

<option value="ediz.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("ediz.gif")?"selected":""%>>EDI (zeleno)</option>



					<option value="cnt.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("cnt.gif")?"selected":""%>>CNT</option>
					<option value="skl.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("skl.gif")?"selected":""%>>SKL</option>
					<option value="m.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("m.gif")?"selected":""%>>M</option>
					<option value="v.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("v.gif")?"selected":""%>>V</option>
<option value="z.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("z.gif")?"selected":""%>>Z</option>
<option value="o.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("o.gif")?"selected":""%>>O</option>
<option value="pb.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("pb.gif")?"selected":""%>>PB</option>
<option value="pf.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("pf.gif")?"selected":""%>>PF</option>
<option value="pe.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("pe.gif")?"selected":""%>>PE</option>
<option value="ve.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("ve.gif")?"selected":""%>>VE</option>
<option value="vf.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("vf.gif")?"selected":""%>>VF</option>
<option value="vb.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("vb.gif")?"selected":""%>>VB</option>

<option value="vs.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("vs.gif")?"selected":""%>>VS</option>
<option value="pr.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("pr.gif")?"selected":""%>>PR</option>
<option value="di.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("di.gif")?"selected":""%>>DI</option>
<option value="na.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("na.gif")?"selected":""%>>NA</option>
<option value="er.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("er.gif")?"selected":""%>>ER</option>



<option value="nn.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("nn.gif")?"selected":""%>>NN</option>
<option value="nl.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("nl.gif")?"selected":""%>>NL</option>
<option value="ns.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("ns.gif")?"selected":""%>>NS</option>

<option value="nc.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("nc.gif")?"selected":""%>>NC</option>
<option value="ni.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("ni.gif")?"selected":""%>>NI</option>
<option value="np.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("np.gif")?"selected":""%>>NP</option>

<option value="vd.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("vd.gif")?"selected":""%>>VD</option>
<option value="vs.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("vs.gif")?"selected":""%>>VS</option>
<option value="xml.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("xml.gif")?"selected":""%>>XML</option>
<option value="t.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("t.gif")?"selected":""%>>T</option>


<option value="errr.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("errr.gif")?"selected":""%>>ERR Rdec</option>
<option value="errz.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("errz.gif")?"selected":""%>>ERR Zelen</option>

<option value="doi.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("doi.gif")?"selected":""%>>DOI</option>


					<option value="vnos.gif" <%=nul.jeNull(vseb.getUrl_gumb()).equals("vnos.gif")?"selected":""%>>Add</option>
					</select>
            		 </td>
             		 
            		  </tr>   
            		  
            		  
            		     	       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (hint gumba excel) : <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","P",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size=70 name="prevod_<%=request.getParameter("idt")%>_P_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=(!defaultt?nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","P",session.getAttribute("jezikv")+"")):prevod4)%>" style="font-family: Verdana; font-size: 8pt">
            		
            		 </td>
            		 
             		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
             		 </td>
             		 </tr>
            		  
            		  
            		  
            		        		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (odgovor ob poslanem mailu) : <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","M",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
            		 
            		<input type="text" size=70 name="prevod_<%=request.getParameter("idt")%>_M_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=(!defaultt?nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","M",session.getAttribute("jezikv")+"")):prevod3)%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
             		 <td class="opiscell" width="20%">Target klicanja:</td><td class="valuecell" width="30%">
             			 <select name="target_frame" style="font-family: Verdana; font-size: 8pt" >
                        		 
					<option value=""></option>
<option value="parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_frame()).equals("parent.frames[0].location")?"selected":""%>>parent.frames[0].location</option>
	<option value="parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_frame()).equals("parent.frames[1].location")?"selected":""%>>parent.frames[1].location</option>
	<option value="parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_frame()).equals("parent.frames[2].location")?"selected":""%>>parent.frames[2].location</option>
	<option value="top.parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_frame()).equals("top.parent.frames[0].location")?"selected":""%>>top.parent.frames[0].location</option>
	<option value="top.parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_frame()).equals("top.parent.frames[1].location")?"selected":""%>>top.parent.frames[1].location</option>
	<option value="top.parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_frame()).equals("top.parent.frames[2].location")?"selected":""%>>top.parent.frames[2].location</option>
				
		
					</select> </td></tr>
            		  
            		  
                       		  <tr>
            		  
            		 <td class="opiscell" width="20%">Update polja uporabi (update polja izpisanih recordov):</td><td class="valuecell" width="30%">
 <input type="checkbox" name="update_polje_uporabi" value="1" <%=nul.jeNull(vseb.getUpdate_polje_uporabi()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		 
            	</td>      		  
            		 <td class="opiscell" width="20%">Pogoj za uporabo update izpisanih recordov (format if (###pogoj###)) </td><td class="valuecell" width="30%">
            		 <input type="text" name="upload_pogoj" maxlength='100' size='60' value="<%=nul.jeNull(vseb.getUpload_pogoj()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            	</td>
             		 
            		  </tr>     		  
            		  
            		  
            		  
             		  <tr>
            		  
            		 <td class="opiscell" width="20%">Update polje:</td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="update_polje" maxlength='35' size='35' value="<%=nul.jeNull(vseb.getUpdate_polje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            	</td>      		  
            		 <td class="opiscell" width="20%">Vrednost , ki se vnese v updatano polje: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="update_polje_vrednost" maxlength='70' size='35' value="<%=nul.jeNull(vseb.getUpdate_polje_vrednost()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            	</td>
             		 
            		  </tr>           		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            	            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Target ob koncanem klicanju:</td><td class="valuecell" width="30%">
            		            		 <select name="target_funkcija" style="font-family: Verdana; font-size: 8pt" >
                        		 
					<option value=""></option>
<option value="parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0].location")?"selected":""%>>parent.frames[0].location</option>
	<option value="parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1].location")?"selected":""%>>parent.frames[1].location</option>
	<option value="parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2].location")?"selected":""%>>parent.frames[2].location</option>
	<option value="top.parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0].location")?"selected":""%>>top.parent.frames[0].location</option>
	<option value="top.parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1].location")?"selected":""%>>top.parent.frames[1].location</option>
	<option value="top.parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2].location")?"selected":""%>>top.parent.frames[2].location</option>
				
		 
					</select></td>
            		 
             		 <td class="opiscell">Pojdi na template po uspesno poslanem: </td><td class="valuecell">
             				  		 <select name="target_funkcija_url" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
            		
            		<%
            		if (true) {
            		com.popultrade.dao.TemplateHeadDAO daog = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		
            		List lisg = daog.getTemplateHeads(new com.popultrade.model.TemplateHead(),1,1000);
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateHead vsebg = (com.popultrade.model.TemplateHead)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getTarget_funkcija_url()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getHead_naziv())%></option>
            		<%
            		
            		
            		
            		}
            		}
            		%>
            		
            		
            		</select>
             		 
             		 </td>
             		 
            		  </tr>	  
            		  
            		  	   
        		  <tr>
        		  
        		 <td class="opiscell">Mail - gumb tekst: </td><td class="valuecell" colspan="3">
        		 
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
        		  
        		 <td class="opiscell">Excel slika: </td><td class="valuecell" colspan="3">
        		 
 <input type="text" name="tekst_gumb_p" maxlength='15' size="16" value="<%=nul.jeNull(vseb.getTekst_gumb_p()+"")%>" style="font-family: Verdana; font-size: 8pt">
    Style: 
    <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("silver")) {
    checked=true;
    }
     %><img src="ssilver.gif" border=0>
    <input type="radio" value="silver" name="style_gumb_p" <%=checked?"checked":"" %>>     
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("red")) {
    checked=true;
    }
     %><img src="sred.gif" border=0>
    <input type="radio" value="red" name="style_gumb_p" <%=checked?"checked":"" %>>    		 					
		  <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("blue")) {
    checked=true;
    }
     %><img src="sblue.gif" border=0>
    <input type="radio" value="blue" name="style_gumb_p" <%=checked?"checked":"" %>>    	
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("green")) {
    checked=true;
    }
     %><img src="sgreen.gif" border=0>
    <input type="radio" value="green" name="style_gumb_p" <%=checked?"checked":"" %>>    
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("yellow")) {
    checked=true;
    }
     %><img src="syellow.gif" border=0>
    <input type="radio" value="yellow" name="style_gumb_p" <%=checked?"checked":"" %>>  
        <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("purple")) {
    checked=true;
    }
     %><img src="spurple.gif" border=0>
    <input type="radio" value="purple" name="style_gumb_p" <%=checked?"checked":"" %>>    
       <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("orange")) {
    checked=true;
    }
     %><img src="sorange.gif" border=0>
    <input type="radio" value="orange" name="style_gumb_p" <%=checked?"checked":"" %>>   	  	
         <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("blued")) {
    checked=true;
    }
     %><img src="sblued.gif" border=0>
    <input type="radio" value="blued" name="style_gumb_p" <%=checked?"checked":"" %>>   	
        <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("redb")) {
    checked=true;
    }
     %><img src="sredb.gif" border=0>
    <input type="radio" value="redb" name="style_gumb_p" <%=checked?"checked":"" %>>     	  
      <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("greenb")) {
    checked=true;
    }
     %><img src="sgreenb.gif" border=0>
    <input type="radio" value="greenb" name="style_gumb_p" <%=checked?"checked":"" %>>       
    
         <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("silverb")) {
    checked=true;
    }
     %><img src="ssilverb.gif" border=0>
    <input type="radio" value="silverb" name="style_gumb_p" <%=checked?"checked":"" %>>          
    
         <%
     checked=false;
    if (nul.jeNull(vseb.getStyle_gumb_p()+"").equals("blueb")) {
    checked=true;
    }
     %><img src="sblueb.gif" border=0>
    <input type="radio" value="blueb" name="style_gumb_p" <%=checked?"checked":"" %>>    		 
        		 </td>
        		 </tr>
        		  	  
        		  
        		  
        		   		  
    
   	       		  <tr>

<td class="opiscell" width="20%">Alert za html mail : <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","F",session.getAttribute("jezikp")+""))%></td><td class="valuecell" width="30%">
 
<input type="text" size=70 name="prevod_<%=request.getParameter("idt")%>_F_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=(!defaultt?nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","F",session.getAttribute("jezikv")+"")):"")%>" style="font-family: Verdana; font-size: 8pt">

</td>

 <td class="opiscell" width="20%">Alert za Excel mail : <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","G",session.getAttribute("jezikp")+""))%>
 </td><td class="valuecell" width="30%">
 <input type="text" size=70 name="prevod_<%=request.getParameter("idt")%>_G_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=(!defaultt?nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","G",session.getAttribute("jezikv")+"")):"")%>" style="font-family: Verdana; font-size: 8pt">
 
 </td>
 </tr>          
            		  
            		  
            		  
            		  		  


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