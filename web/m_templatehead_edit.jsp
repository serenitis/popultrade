<%@ page contentType="text/html; " import="org.apache.commons.lang.StringUtils,java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,net.sf.beanlib.api.BeanMethodCollector,java.lang.reflect.Method"%>
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
	
	
	
	if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("prevod"))  {
		

		
		
		
	}
	
	if (request.getParameter("kaj")!=null && request.getParameter("kaj").equals("pogoji"))  {
		
		com.popultrade.dao.TemplateClassDAO dao = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

		dao.removeTemplateClass(new Long(request.getParameter("idd")));

		
	}
	
	
	
	
	
	
	
	
boolean bok=false;
com.popultrade.model.TemplateHead vseb =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO dao = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateHead(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		 
		
		
		
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
				
				
			}
			
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		vseb = dao.getTemplateHead(new Long(nul.jeNullDefault(request.getParameter("id"))));
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	}
	else { 
	
		
	}
	vseb = (com.popultrade.model.TemplateHead)contextUtil.getPopulatedObject(vseb,request);
	vseb.setUporabi_count(nul.jeNull(request.getParameter("uporabi_count")).equals("1")?"1":"0");
	vseb.setUporabi_cas_refresh(nul.jeNull(request.getParameter("uporabi_cas_refresh")).equals("1")?"1":"0");
	vseb.setUporabi_count_ld(nul.jeNull(request.getParameter("uporabi_count_ld")).equals("1")?"1":"0");
	vseb.setProcedura_podatki_checkbox(nul.jeNull(request.getParameter("procedura_podatki_checkbox")).equals("1")?"1":"0");
	vseb.setParsaj_excel(nul.jeNull(request.getParameter("parsaj_excel")).equals("1")?"1":"0");
	 vseb.setUporabi_nove_gumbe(nul.jeNull(request.getParameter("uporabi_nove_gumbe")).equals("1")?"1":"0");
	 
	vseb.setStruktura_tree(nul.jeNull(request.getParameter("struktura_tree")).equals("1")?"1":"0");
	vseb.setStruktura_tree_head(nul.jeNull(request.getParameter("struktura_tree_head")).equals("1")?"1":"0");
	vseb.setCustom_gen(nul.jeNull(request.getParameter("custom_gen")).equals("1")?"1":"0");
	vseb.setPdf_dolg(nul.jeNull(request.getParameter("pdf_dolg")).equals("1")?"1":"0");
	vseb.setNosql(nul.jeNull(request.getParameter("nosql")).equals("1")?"1":"0");
	vseb.setZakleni_vse(nul.jeNull(request.getParameter("zakleni_vse")).equals("1")?"1":"0");
	vseb.setLogall(nul.jeNull(request.getParameter("logall")).equals("1")?"1":"0");
	vseb.setDate_mobile(nul.jeNull(request.getParameter("date_mobile")).equals("1")?"1":"0");
	vseb.setNologinneeded(nul.jeNull(request.getParameter("nologinneeded")).equals("1")?"1":"0");
	vseb.setPageisindependent(nul.jeNull(request.getParameter("pageisindependent")).equals("1")?"1":"0");
	vseb.setOverraid_update_default(nul.jeNull(request.getParameter("overraid_update_default")).equals("1")?"1":"0");
	
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		
	}
	else {
		if (request.getParameter("idtg")!=null && !request.getParameter("idtg").equals("")) {
			vseb.setVeza_gumb(new Long(request.getParameter("idtg")));
		}
	}

dao.saveTemplateHead(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("head_naziv","head_naziv");
ht.put("head_class_name","head_class_name");


if (nul.jeNull(vseb.getHead_tip()).equals("EX")) { 
	
	ht.put("lokacija exporta","lokacija_exporta");
	
}

if (nul.jeNull(vseb.getHead_tip()).equals("UR")) { 
	
	ht.put("lokacija upload","upload_lokacija");
	
	ht.put("upload extension","upload_extension");
	
	
	
}



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
<body   style="margin: 0"  <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templatehead_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idtg" value="<%=nul.jeNull(request.getParameter("idtg"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Ime template: </td><td class="valuecell" width="30%">
            		 
            	<input type="text" name="head_naziv" maxlength='35' value="<%=nul.jeNull(vseb.getHead_naziv()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Class name (tip custom samo za list pri touch opciji, samo za graficni pregled):<Br>
            		 Class name nosql v primeru, da je class name embeddable tipa - (E):<Br><!-- 
            		 Embeddable Class 2 nosql v primeru, da je embeddable 2 znotraj embeddable:<Br>
            		 Embeddable Class 3 nosql v primeru, da je embeddable 3 znotraj embeddable 2:<Br>-->
            		 
            		  </td><td class="valuecell" width="30%">
            		 
            		 <select name="head_class_name" style="font-family: Verdana; font-size: 8pt" > 
					<option value=""></option>
					<%
					List li = templateUtil.getClasseNamesInPackage(contextUtil,this.getServletContext(),"","");
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getHead_class_name()))) {
					%>
					<option value="<%=nex%>" selected><%=nex%> <%=templateUtil.isEmbeddable(nex)?" (E)":"" %></option>
					<%
						}
						else {
							%>
							<option value="<%=nex%>" ><%=nex%> <%=templateUtil.isEmbeddable(nex)?" (E)":"" %></option>
							<%	
						}
					}
					%>
					</select><Br>
					
							 
            		 <select name="head_class_name_nosql" style="font-family: Verdana; font-size: 8pt" > 
					<option value=""></option>
					<%
					 li = templateUtil.getClasseNamesInPackage(contextUtil,this.getServletContext(),"","");
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getHead_class_name_nosql()))) {
					%>
					<option value="<%=nex%>" selected><%=nex%> <%=templateUtil.isEmbeddable(nex)?" (E)":"" %></option>
					<%
						}
						else {
							%>
							<option value="<%=nex%>" ><%=nex%> <%=templateUtil.isEmbeddable(nex)?" (E)":"" %></option>
							<%	
						}
					}
					%>
					</select> Vedno poslji <b>id</b> z imenom <b>idem</b> preko gumba!!!!<Br>
					
					<!-- 
						 <select name="head_class_name_nosql2" style="font-family: Verdana; font-size: 8pt" > 
					<option value=""></option>
					<%
					 li = templateUtil.getClasseNamesInPackageEmbeddable(contextUtil,this.getServletContext(),"","");
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getHead_class_name_nosql2()))) {
					%>
					<option value="<%=nex%>" selected><%=nex%> (E)</option>
					<%
						}
						else {
							%>
							<option value="<%=nex%>" ><%=nex%> (E)</option>
							<%	
						}
					}
					%>
					</select><br>
					
					
							
						 <select name="head_class_name_nosql3" style="font-family: Verdana; font-size: 8pt" > 
					<option value=""></option>
					<%
					// li = templateUtil.getClasseNamesInPackageNoEmbeddable(contextUtil,this.getServletContext(),"","");
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getHead_class_name_nosql3()))) {
					%>
					<option value="<%=nex%>" selected><%=nex%> (E)</option>
					<%
						}
						else {
							%>
							<option value="<%=nex%>" ><%=nex%> (E)</option>
							<%	
						}
					}
					%>
					</select><br>-->
					
					
					</td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Tip uporabe:</td><td class="valuecell" width="30%">
            		 
            		 <select name="head_tip" style="font-family: Verdana; font-size: 8pt" >
					<option value="LI" <%=nul.jeNull(vseb.getHead_tip()).equals("LI")?"selected":""%>>List</option>
					<option value="HE" <%=nul.jeNull(vseb.getHead_tip()).equals("HE")?"selected":""%>>Head</option>
						<option value="UI"  <%=nul.jeNull(vseb.getHead_tip()).equals("UI")?"selected":""%>>Update/Insert</option>
					<option value="SE"  <%=nul.jeNull(vseb.getHead_tip()).equals("SE")?"selected":""%>>Search</option>
					<option value="FU"  <%=nul.jeNull(vseb.getHead_tip()).equals("FU")?"selected":""%>>Funkcija</option>
					<option value="PR"  <%=nul.jeNull(vseb.getHead_tip()).equals("PR")?"selected":""%>>Procedura (PlSql)</option>
					<option value="PD"  <%=nul.jeNull(vseb.getHead_tip()).equals("PD")?"selected":""%>>Izpis PDF</option>
					<option value="UP"  <%=nul.jeNull(vseb.getHead_tip()).equals("UP")?"selected":""%>>Upload datoteke</option>
					<option value="UR"  <%=nul.jeNull(vseb.getHead_tip()).equals("UR")?"selected":""%>>Upload dat. za parsanje</option>
					<option value="EX"  <%=nul.jeNull(vseb.getHead_tip()).equals("EX")?"selected":""%>>Export XML</option>
					<option value="EE"  <%=nul.jeNull(vseb.getHead_tip()).equals("EE")?"selected":""%>>Export EDI</option>
					
					<option value="LT" <%=nul.jeNull(vseb.getHead_tip()).equals("LT")?"selected":""%>>List (Touch)</option>
					<option value="HT" <%=nul.jeNull(vseb.getHead_tip()).equals("HT")?"selected":""%>>Head/Update/Insert (Touch)</option>
					<option value="OB" <%=nul.jeNull(vseb.getHead_tip()).equals("OB")?"selected":""%>>Object iz baze</option>
					</select></td>
            		 
             		 <td class="opiscell">Zaporedje: </td><td class="valuecell">
             		
             		 <input type="text" name="zaporedje"  value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" size="5" style="font-family: Verdana; font-size: 8pt">
             		
             		 </td>
             		 
            		  </tr>
            		  
            		  
            		  
            		  
            		 
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Logiraj uporabo template:</td><td class="valuecell" width="30%">
            		  <input type="checkbox" name="logall" value="1" <%=nul.jeNull(vseb.getLogall()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
    
            		</td>
            		 
             		 <td class="opiscell"> Class/tabela je v NoSQL bazi :</td><td class="valuecell">
             		
             		
            	           		  <input type="checkbox" name="nosql" value="1" <%=nul.jeNull(vseb.getNosql()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
    (v izdelavi - samo za list,update,header)
             		 </td>
             		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  
            		  
            		  <tr>
            		  
            		  
            		  
            		 <td class="opiscell" width="20%">Dodatni pogoji (order by, ime parametra vedno kot je v Class datoteki, ce je order po vec poljih je potrebno dodajat vejico (primer: zapst asc,ime desc)):</td><td class="valuecell" width="30%">
            		 
            	<input type="text" name="head_select_dodatni_pogoji" maxlength='55' size="35" value="<%=nul.jeNull(vseb.getHead_select_dodatni_pogoji()+"")%>" style="font-family: Verdana; font-size: 8pt">
            	
            		 <select name="order_by_smer" style="font-family: Verdana; font-size: 8pt" >
            		 <option></option>
					<option value="asc" <%=nul.jeNull(vseb.getOrder_by_smer()).equals("asc")?"selected":""%>>Ascending</option>
					<option value="desc" <%=nul.jeNull(vseb.getOrder_by_smer()).equals("desc")?"selected":""%>>Descending</option>
				
					</select>
            	
            	</td>
            		 
             		 <td class="opiscell">
             		 
             		 <%
             		 if (!nul.jeNull(vseb.getId()+"").equals("") && (!nul.jeNull(vseb.getHead_tip()).equals("LT") && !nul.jeNull(vseb.getHead_tip()).equals("HT"))) {
             			 %>
             			 Reset ostalih frame ob prikazu tega:
             			 
             			 <%
             		 }
             		 %>
             		 
             		 &nbsp;</td><td class="valuecell">
             			 <%
             		 if (!nul.jeNull(vseb.getId()+"").equals("") && (!nul.jeNull(vseb.getHead_tip()).equals("LT") && !nul.jeNull(vseb.getHead_tip()).equals("HT"))) {
             			 %>
	<input type="button" value="Reset ostalih frame" onclick="goDown('m_templateheadreset.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt"> 
             	
             			 
             			 <%
             		 }
             		 %>
             		 &nbsp;</td>
             		 
            		  </tr>
            		  
            		  
            		            		             <%
           
           if (nul.jeNull(vseb.getHead_tip()).equals("HT") || nul.jeNull(vseb.getHead_tip()).equals("LT") || nul.jeNull(vseb.getHead_tip()).equals("FU") || nul.jeNull(vseb.getHead_tip()).equals("PR") || nul.jeNull(vseb.getHead_tip()).equals("UP") || nul.jeNull(vseb.getHead_tip()).equals("UR")) { //// kam redirectam po koncanju funkcije
        	   
           
           
           %> 
            		  
            		  
            		  
            		  <tr>
            		  <td class="opiscell" width="20%">
            		      		 Ne refresh-aj frametov po potrditvi:
                           		 </td>
                           		 
                           	<td class="valuecell" width="30%" colspan=3>
                           	<input type="checkbox" name="uporabi_count_ld"  value="1" <%=nul.jeNull(vseb.getUporabi_count_ld()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	</td></tr>
            		  
            		  
            		  
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
					<option value="parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0][0].location")?"selected":""%>>parent.frames[0][0].location</option>
	<option value="parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1][0].location")?"selected":""%>>parent.frames[1][0].location</option>
	<option value="parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2][0].location")?"selected":""%>>parent.frames[2][0].location</option>
	<option value="parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0][1].location")?"selected":""%>>parent.frames[0][1].location</option>
	<option value="parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1][1].location")?"selected":""%>>parent.frames[1][1].location</option>
	<option value="parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2][1].location")?"selected":""%>>parent.frames[2][1].location</option>
				
			<option value="top.parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0][0].location")?"selected":""%>>top.parent.frames[0][0].location</option>
	<option value="top.parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1][0].location")?"selected":""%>>top.parent.frames[1][0].location</option>
	<option value="top.parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2][0].location")?"selected":""%>>top.parent.frames[2][0].location</option>
	<option value="top.parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0][1].location")?"selected":""%>>top.parent.frames[0][1].location</option>
	<option value="top.parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1][1].location")?"selected":""%>>top.parent.frames[1][1].location</option>
	<option value="top.parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2][1].location")?"selected":""%>>top.parent.frames[2][1].location</option>
	
		
					</select></td>
            		 
             		 <td class="opiscell">Pojdi na template: </td><td class="valuecell">
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
            		  
            		  
            		<%
            		
           }
            	
            		  
if (nul.jeNull(vseb.getHead_tip()).equals("PR")) { //// kam redirectam po koncanju funkcije
 
    
      
    %> 
    
           		           	  <tr>
            		  
            		 <td class="opiscell" width="20%">Procedura dobi podatke preko checkboxov: </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="procedura_podatki_checkbox"  value="1" <%=nul.jeNull(vseb.getProcedura_podatki_checkbox()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Ime parametra, ki posljem preko checkboxa (nrp: id): </td>
						<td class="valuecell" >
            		 
            		 <input type="text" name="procedura_zacetno_ime_cb" maxlength='35' value="<%=nul.jeNull(vseb.getProcedura_zacetno_ime_cb()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 </tr>  
         		      
    
    <tr>
            
            		 
            		 		 <td class="opiscell" width="20%" colspan="3" >Ime neznanke ki vsebuje trenutno vrednost checkboxa (neznanko se nato da kot parameter v proceduro): </td>
						<td class="valuecell" >
            		 
            		 <input type="text" name="procedura_ime_neznanke" maxlength='35' value="<%=nul.jeNull(vseb.getProcedura_ime_neznanke()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 </tr>  
            		  
            		           	  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi refresh po n sekundah :<br>Pocaka se n sekund za refresh rezultata strani, ce je napaka. </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="uporabi_cas_refresh"  value="1" <%=nul.jeNull(vseb.getUporabi_cas_refresh()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">N sekund ki caka pred refreshom: </td>
						<td class="valuecell" >
            		 
            		 <input type="text" name="uporabi_cas_refresh_n" maxlength='2' value="<%=nul.jeNull(vseb.getUporabi_cas_refresh_n()+"")%>" size="5" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 </tr>  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" colspan="4">	
            		 
            		 Procedura, ki se klice ob kliku na gumb za proceduro, prvo polje vsebuje prvi del procedure do vprasanja, srednji del so parametri, ki jih posljem preko gumba, zadnji del je vsebina po vprasanjih:
            		 	  		
	 <table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	 
	 
<tr>
<td  class="opiscell">
	<input type="text" name="zacetek_procedure" maxlength='150' size="55" value="<%=nul.jeNull(vseb.getZacetek_procedure()+"")%>" style="font-family: Verdana; font-size: 8pt">
</td>

<td  class="valuecell">

	<%
	if (!nul.jeNull(vseb.getId()+"").equals("")) {
	%>
	
	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	
<%
//// pogoji

List lio = vseb.getTemplateClasss();


Iterator iter = lio.iterator();





while (iter.hasNext()) {
	
	com.popultrade.model.TemplateClass temc =(com.popultrade.model.TemplateClass)iter.next();
	
	%>
	<tr><td class="opiscell" ><%=nul.jeNull(temc.getVrednost_pogoja())%>
	</td><td></td><td class="opiscell"></td>
	<td>
	
	 <a href="Javascript:PGAPP()" onCLick="return goDown('m_templatehead_edit_proc.jsp?idp=<%=request.getParameter("id")%>&idd=<%=temc.getId()%>&id=<%=temc.getId()%>&sifid=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=temc.getId()%>')"><img src="u.gif" border=0  title="Spremeni parameter"></a>
	 <a onClick="return vprasaj()" href="m_templatehead_edit.jsp?id=<%=request.getParameter("id")%>&idp=<%=request.getParameter("id")%>&akcija=DELETE&idd=<%=temc.getId()%>&sifid=<%=vseb.getId()%>&kaj=pogoji"><img src="x.gif" border=0 title="Brisi"></a>
	
	
	</td>
	
	</tr>
	<%
}



%>


<tr><td></td><td></td><td></td><td>


<a onClick="return goDown('m_templatehead_edit_proc.jsp?idp=<%=request.getParameter("id")%>&opcija=new&siframm=new&sifrant=null&sifid=<%=vseb.getId()%>&idtc=<%=vseb.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj novi parameter" border="0" src="vnos.gif" /></a>
 

</td></tr>
</table>

<%
	}
	
	Hashtable prep = new Hashtable();
	Hashtable previd = new Hashtable();
	/// prevod vnosa
	Hashtable prev = new Hashtable();
	
	Hashtable prep2 = new Hashtable();
	Hashtable prev2 = new Hashtable();
	/// dobim vse prevode
	com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
	com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
	
	List limo = daop.getPrevodis(prevo);

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","Z");
	Iterator itep = limo.iterator();

	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","Z");
	itep = limo.iterator();


	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
		previd.put(prv.getPrevod_id()+"",prv.getId()+"");
	}
	
	
	
	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","Y");
	itep = limo.iterator();

	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prep2.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","Y");
	itep = limo.iterator();


	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prev2.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}
	
	
	
	
	
	
	
	
	
	
	
%>
</td>


<td  class="opiscell">
	<input type="text" name="konec_procedure" maxlength='150' size="15" value="<%=nul.jeNull(vseb.getKonec_procedure()+"")%>" style="font-family: Verdana; font-size: 8pt">
</td>


</tr>

</table>

            		
	 </td>
	 
  </tr>
  
      		  <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prep.get(vseb.getId()+""))%> </td><td class="valuecell" colspan=3>
            	 Prevod ok procedura:   	 
<input type="text" name="prevod_<%=vseb.getId()%>_Z_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prev.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">
         
            		 
            		 </td>
            		 </tr>
            		 
            		 
            		 
            		       		  <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prep2.get(vseb.getId()+""))%> </td><td class="valuecell" colspan=3>
       Prevod ni ok procedura:     		 
<input type="text" name="prevod_<%=vseb.getId()%>_Y_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prev2.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">
         
            		 
            		 </td>
            		 </tr>
            		 
<%

}



	  
if (nul.jeNull(vseb.getHead_tip()).equals("UR")) { //// kam redirectam po koncanju funkcije
 
    
    
    %> 
            		  
                   		  <tr>
            		  
            		 <td class="opiscell" width="20%">Datoteke za upload (dovoljeni extension, ce vec loci z vejico): </td><td class="valuecell" width="30%">
            		 
            	<input type="text" name="upload_extension" maxlength='35' value="<%=nul.jeNull(vseb.getUpload_extension()+"")%>" style="font-family: Verdana; font-size: 8pt">
            	
            	</td>
            		 
            		 <td class="opiscell" width="20%">Lokacija kam upload datoteko: </td><td class="valuecell" width="30%">
            		           		 
            	<input type="text" name="upload_lokacija" maxlength='45' value="<%=nul.jeNull(vseb.getUpload_lokacija()+"")%>" style="font-family: Verdana; font-size: 8pt">
            	
            		 </td>
            		 </tr>    
            		 
            		 
            		 
            		 
            		                    		  <tr>
            		  
            		 <td class="opiscell" width="20%">Upload tabela (tabela v katero dam vsebino datoteke, brez vrednosti se datoteka shrani samo na disk): </td><td class="valuecell" width="30%">
            		 
            
            	
            	   		 <select name="upload_tabela" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					 li = templateUtil.getClasseNamesInPackage(contextUtil,this.getServletContext(),"","");
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getUpload_tabela()))) {
					%>
					
					
					<option value="<%=nex%>" selected><%=nex%></option>
					
					
					<%
					
						}
						else {
							
							%>
							
							
							<option value="<%=nex%>" ><%=nex%></option>
							
							
							<%	
							
							
						}
					}
					%>
					
					
					</select>
            	
            	</td>
            		 <td class="opiscell" width="20%">Upload tabela stolpec (stolpec v katero dam vsebino datoteke): </td><td class="valuecell" width="30%">
            		 
            	<input type="text" name="upload_tabela_stolpec" maxlength='35' value="<%=nul.jeNull(vseb.getUpload_tabela_stolpec()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		
            		 </tr>    
            		 
            		 
            		 
            		 
            	        		  <tr>
            		  
            		 <td class="opiscell" width="20%">Datoteka je EXCEL (oznaceno parsa datoteko v txt datoteko): </td><td class="valuecell" width="30%">
            		 
            	 <input type="checkbox" name="parsaj_excel"  value="1" <%=nul.jeNull(vseb.getParsaj_excel()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		
            	
            	</td>
            		 <td class="opiscell" width="20%"></td><td class="valuecell" width="30%">
            		 
            	</td>
            		
            		 </tr>   	 
            		 
            		 
            		 
            		 
            		  		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" colspan="4">	
            		 
            		 Procedura, ki se klice po upload datoteke, prvo polje vsebuje prvi del procedure do vprasanja, srednji del so parametri, ki jih posljem preko gumba, zadnji del je vsebina po vprasanjih:
            		 	  		
	 <table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	 
	 
<tr>
<td  class="opiscell">
	<input type="text" name="zacetek_procedure" maxlength='150' size="55" value="<%=nul.jeNull(vseb.getZacetek_procedure()+"")%>" style="font-family: Verdana; font-size: 8pt">
</td>

<td  class="valuecell">

	<%
	if (!nul.jeNull(vseb.getId()+"").equals("")) {
	%>
	
	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	
<%
//// pogoji

List lio = vseb.getTemplateClasss();


Iterator iter = lio.iterator();





while (iter.hasNext()) {
	
	com.popultrade.model.TemplateClass temc =(com.popultrade.model.TemplateClass)iter.next();
	
	%>
	<tr><td class="opiscell" ><%=nul.jeNull(temc.getVrednost_pogoja())%>
	</td><td></td><td class="opiscell"></td>
	<td>
	
	 <a href="Javascript:PGAPP()" onCLick="return goDown('m_templatehead_edit_proc.jsp?idp=<%=request.getParameter("id")%>&idd=<%=temc.getId()%>&id=<%=temc.getId()%>&sifid=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=temc.getId()%>')"><img src="u.gif" border=0  title="Spremeni parameter"></a>
	 <a onClick="return vprasaj()" href="m_templatehead_edit.jsp?id=<%=request.getParameter("id")%>&idp=<%=request.getParameter("id")%>&akcija=DELETE&idd=<%=temc.getId()%>&sifid=<%=vseb.getId()%>&kaj=pogoji"><img src="x.gif" border=0 title="Brisi"></a>
	
	
	</td>
	
	</tr>
	<%
}



%>


<tr><td></td><td></td><td></td><td>


<a onClick="return goDown('m_templatehead_edit_proc.jsp?idp=<%=request.getParameter("id")%>&opcija=new&siframm=new&sifrant=null&sifid=<%=vseb.getId()%>&idtc=<%=vseb.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj novi parameter" border="0" src="vnos.gif" /></a>
 

</td></tr>
</table>

<%
	}
	
	Hashtable prep = new Hashtable();
	Hashtable previd = new Hashtable();
	/// prevod vnosa
	Hashtable prev = new Hashtable();
	
	Hashtable prep2 = new Hashtable();
	Hashtable prev2 = new Hashtable();
	
	Hashtable prep3 = new Hashtable();
	Hashtable prev3 = new Hashtable();
	Hashtable prep4 = new Hashtable();
	Hashtable prev4 = new Hashtable();
	
	/// dobim vse prevode
	com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
	com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
	
	List limo = daop.getPrevodis(prevo);

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","Z");
	Iterator itep = limo.iterator();

	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","Z");
	itep = limo.iterator();


	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
		previd.put(prv.getPrevod_id()+"",prv.getId()+"");
	}
	
	
	
	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","Y");
	itep = limo.iterator();

	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prep2.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","Y");
	itep = limo.iterator();


	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prev2.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}
	
	
	
	
	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","C");
	itep = limo.iterator();

	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prep3.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","C");
	itep = limo.iterator();


	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prev3.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}
	
	
	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","V");
	itep = limo.iterator();

	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prep4.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}

	limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","V");
	itep = limo.iterator();


	while (itep.hasNext()) {
		com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
		prev4.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	}
	
	
	
	
	
%>
</td>


<td  class="opiscell">
	<input type="text" name="konec_procedure" maxlength='150' size="15" value="<%=nul.jeNull(vseb.getKonec_procedure()+"")%>" style="font-family: Verdana; font-size: 8pt">
</td>


</tr>

</table>

            		
	 </td>
	 
  </tr>
  
      		  <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prep3.get(vseb.getId()+""))%> </td><td class="valuecell" colspan=3>
            	 Prevod (upload datoteko) - gumb:   	 
<input type="text" name="prevod_<%=vseb.getId()%>_C_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prev3.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">

            		 </td>
            		 </tr>
 <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prep4.get(vseb.getId()+""))%> </td><td class="valuecell" colspan=3>
       Prevod (Izberi datoteko z vsebino za parsat):     		 
<input type="text" name="prevod_<%=vseb.getId()%>_V_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prev4.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">

            		 </td>
            		 </tr>
            		 
            		  <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prep.get(vseb.getId()+""))%> </td><td class="valuecell" colspan=3>
            	 Prevod ok procedura:   	 
<input type="text" name="prevod_<%=vseb.getId()%>_Z_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prev.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">

            		 </td>
            		 </tr>
 <tr>
            		  
            		 <td class="opiscell" width="20%"><%=nul.jeNull((String)prep2.get(vseb.getId()+""))%> </td><td class="valuecell" colspan=3>
       Prevod ni ok procedura:     		 
<input type="text" name="prevod_<%=vseb.getId()%>_Y_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prev2.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">

            		 </td>
            		 </tr>      		 
                              		  <tr>
            		  
            		 <td class="opiscell" width="20%" colspan=4>
            		 
            		 Po upload parametri (vsi parametri so dostopni preko session.getAttribute('ime parametra')):<br>
            		 Ime datoteke : upload_file<br>
            		 Ime datoteke z pathom: upload_file_path<br>
            		 Id po vnosu v bazo: upload_id
            		 </td>
            		 
            	
            		 </tr>     		  
            		 
            		 
<%

}



            		  
if (nul.jeNull(vseb.getHead_tip()).equals("UI") || nul.jeNull(vseb.getHead_tip()).equals("PD")) { //// kam redirectam po koncanju funkcije
        	   
           
           
%> 
            		  
            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Target ob koncanem klicanju update, insert ali potrdi predhodni page od PDF:</td><td class="valuecell" width="30%">
            		            		 <select name="target_funkcija" style="font-family: Verdana; font-size: 8pt" >
                        		 
					<option value=""></option>
					
				<%
				if ( !nul.jeNull(vseb.getHead_tip()).equals("PD")) {
				%>
<option value="parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0].location")?"selected":""%>>parent.frames[0].location</option>
	<option value="parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1].location")?"selected":""%>>parent.frames[1].location</option>
	<option value="parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2].location")?"selected":""%>>parent.frames[2].location</option>
	<option value="top.parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0].location")?"selected":""%>>top.parent.frames[0].location</option>
	<option value="top.parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1].location")?"selected":""%>>top.parent.frames[1].location</option>
	<option value="top.parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2].location")?"selected":""%>>top.parent.frames[2].location</option>
		<option value="parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0][0].location")?"selected":""%>>parent.frames[0][0].location</option>
	<option value="parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1][0].location")?"selected":""%>>parent.frames[1][0].location</option>
	<option value="parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2][0].location")?"selected":""%>>parent.frames[2][0].location</option>
	<option value="parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0][1].location")?"selected":""%>>parent.frames[0][1].location</option>
	<option value="parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1][1].location")?"selected":""%>>parent.frames[1][1].location</option>
	<option value="parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2][1].location")?"selected":""%>>parent.frames[2][1].location</option>
				
			<option value="top.parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0][0].location")?"selected":""%>>top.parent.frames[0][0].location</option>
	<option value="top.parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1][0].location")?"selected":""%>>top.parent.frames[1][0].location</option>
	<option value="top.parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2][0].location")?"selected":""%>>top.parent.frames[2][0].location</option>
	<option value="top.parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0][1].location")?"selected":""%>>top.parent.frames[0][1].location</option>
	<option value="top.parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1][1].location")?"selected":""%>>top.parent.frames[1][1].location</option>
	<option value="top.parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2][1].location")?"selected":""%>>top.parent.frames[2][1].location</option>
				<%
				}
				else {
					%>
						<option value="_blank" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("_blank")?"selected":""%>>(_blank) odpre novo okno</option>
	
					<%
				}
				%>
		
					</select></td>
            		 
             		 <td class="opiscell"> 
             	<%
				if ( nul.jeNull(vseb.getHead_tip()).equals("UI")) {
				%>
				Drugi parameter za setiranje idja (Long):
             	<%
				}
				%> 
             		 </td><td class="valuecell">
             			
             		            	<%
				if ( nul.jeNull(vseb.getHead_tip()).equals("UI")) {
				%>
 <input type="text" maxlength=70 size=45 name="zacetek_procedure" value="<%=nul.jeNull(vseb.getZacetek_procedure())%>" style="font-family: Verdana; font-size: 8pt">
 
             	<%
				}
				%> 
             		 
             		 </td>
             		 
            		  </tr>
            		  
            		  
            		<%
            		
           }
            		            		   if (nul.jeNull(vseb.getHead_tip()).equals("EX") || nul.jeNull(vseb.getHead_tip()).equals("EE")) { //// kam redirectam po koncanju funkcije
        	   
           
           
           %> 
            		  
            		            		  
            		  
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
			<option value="parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0][0].location")?"selected":""%>>parent.frames[0][0].location</option>
	<option value="parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1][0].location")?"selected":""%>>parent.frames[1][0].location</option>
	<option value="parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2][0].location")?"selected":""%>>parent.frames[2][0].location</option>
	<option value="parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[0][1].location")?"selected":""%>>parent.frames[0][1].location</option>
	<option value="parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[1][1].location")?"selected":""%>>parent.frames[1][1].location</option>
	<option value="parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("parent.frames[2][1].location")?"selected":""%>>parent.frames[2][1].location</option>
				
			<option value="top.parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0][0].location")?"selected":""%>>top.parent.frames[0][0].location</option>
	<option value="top.parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1][0].location")?"selected":""%>>top.parent.frames[1][0].location</option>
	<option value="top.parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2][0].location")?"selected":""%>>top.parent.frames[2][0].location</option>
	<option value="top.parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[0][1].location")?"selected":""%>>top.parent.frames[0][1].location</option>
	<option value="top.parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[1][1].location")?"selected":""%>>top.parent.frames[1][1].location</option>
	<option value="top.parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_funkcija()).equals("top.parent.frames[2][1].location")?"selected":""%>>top.parent.frames[2][1].location</option>
			
		
					</select></td>
            		 
             		 <td class="opiscell">Pojdi na template: </td><td class="valuecell">
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
            		  
            		 <td class="opiscell" width="20%">Lokacija na disku kamor polozim exportan file:</td><td class="valuecell" colspan=3>
            		        
 <input type="text" maxlength=250 size=70 name="lokacija_exporta" value="<%=nul.jeNull(vseb.getLokacija_exporta())%>" style="font-family: Verdana; font-size: 8pt">
            		        
            		        </td>
            		 
             
             		 
            		  </tr>
            		  
            		  
            		              		  <tr>
            		  
            		 <td class="opiscell" width="20%">Tip exporta:</td><td class="valuecell" colspan=3>
            		        
	 <select name="tip_exporta" style="font-family: Verdana; font-size: 8pt" >
                        		 
					<option value=""></option>
<option value="DI" <%=nul.jeNull(vseb.getTip_exporta()).equals("DI")?"selected":""%>>Export na disk za nadaljno obdelavo</option>
	<option value="DO" <%=nul.jeNull(vseb.getTip_exporta()).equals("DO")?"selected":""%>>Export za download na webu</option>
			
		
					</select>          		        
            		        </td>
            		 
             
             		 
            		  </tr>
            		  
            	            		              		  <tr>
            		  
            		 <td class="opiscell" width="20%">Lokacija export datoteke za download (v primeru da je tip exporta za export na webu, lokacija mora biti znotraj tomacat patha do web aplikacije):</td><td class="valuecell" colspan=3>
            		        
	      		                  		        
 <input type="text" maxlength=250 size=70 name="lokacija_exporta_web" value="<%=nul.jeNull(vseb.getLokacija_exporta_web())%>" style="font-family: Verdana; font-size: 8pt">
    
            		        </td>
            		 
             
             		 
            		  </tr>	  
            		  
            		  
            		<%
            		
           }
            		%>
            		  
            		  
            		  
            		   
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		             <%
           
           if (nul.jeNull(vseb.getHead_tip()).equals("SE")) {
        	   
           
           
           %>
            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Target iskanja (kam naj se odpre iskanje):</td><td class="valuecell" width="30%" >
            		 
            
            		 <select name="target_isci" style="font-family: Verdana; font-size: 8pt" >
                        		 
					<option value=""></option>
<option value="parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[0].location")?"selected":""%>>parent.frames[0].location</option>
	<option value="parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[1].location")?"selected":""%>>parent.frames[1].location</option>
	<option value="parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[2].location")?"selected":""%>>parent.frames[2].location</option>
	<option value="top.parent.frames[0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[0].location")?"selected":""%>>top.parent.frames[0].location</option>
	<option value="top.parent.frames[1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[1].location")?"selected":""%>>top.parent.frames[1].location</option>
	<option value="top.parent.frames[2].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[2].location")?"selected":""%>>top.parent.frames[2].location</option>
			<option value="parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[0][0].location")?"selected":""%>>parent.frames[0][0].location</option>
	<option value="parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[1][0].location")?"selected":""%>>parent.frames[1][0].location</option>
	<option value="parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[2][0].location")?"selected":""%>>parent.frames[2][0].location</option>
	<option value="parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[0][1].location")?"selected":""%>>parent.frames[0][1].location</option>
	<option value="parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[1][1].location")?"selected":""%>>parent.frames[1][1].location</option>
	<option value="parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("parent.frames[2][1].location")?"selected":""%>>parent.frames[2][1].location</option>
				
			<option value="top.parent.frames[0][0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[0][0].location")?"selected":""%>>top.parent.frames[0][0].location</option>
	<option value="top.parent.frames[1][0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[1][0].location")?"selected":""%>>top.parent.frames[1][0].location</option>
	<option value="top.parent.frames[2][0].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[2][0].location")?"selected":""%>>top.parent.frames[2][0].location</option>
	<option value="top.parent.frames[0][1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[0][1].location")?"selected":""%>>top.parent.frames[0][1].location</option>
	<option value="top.parent.frames[1][1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[1][1].location")?"selected":""%>>top.parent.frames[1][1].location</option>
	<option value="top.parent.frames[2][1].location" <%=nul.jeNull(vseb.getTarget_isci()).equals("top.parent.frames[2][1].location")?"selected":""%>>top.parent.frames[2][1].location</option>
			
		
					</select>
            	
            	</td>
            		 
              <td class="opiscell" width="20%">Target searcha (rocno, ce ga ni da avtomaticno (iz parent)):</td><td class="valuecell" >
              
              
              <textarea  name="target_search_rocno" cols="50" rows="1"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getTarget_search_rocno())%></textarea>
              
              
 
              
              </td>
             		 
            		  </tr>
            		  
            		  
            		  <%
            		  
           }
            		  %>
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">
            		 
            		 
            		      <%
           
           if (nul.jeNull(vseb.getHead_tip()).equals("UR")) {
        	   
           
           
           %>
            		 Dodatni parametri za refresh (primer ?par1=vred1&par2=vred2): 
			
			<%
           }    else    if (nul.jeNull(vseb.getHead_tip()).equals("PD")) {	      
       	    %>
          		Ime datoteke pdf (prepise se isto v kodo - java) : 
   		
   		<%      
          }	
           else {
        	    %>
       		Opis template: 
		
		<%
           }
			%>
			</td>
						<td class="valuecell" colspan=3  >
            		 
            		 <textarea   name="opis" maxlength='350' cols='110' rows='1' style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getOpis()+"")%></textarea>
            	  
            		 </td>
            		 
       
            		 </tr>
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		     		     <%
           
           if (nul.jeNull(vseb.getHead_tip()).equals("LI") || nul.jeNull(vseb.getHead_tip()).equals("UI") || nul.jeNull(vseb.getHead_tip()).equals("SE")
        		   || nul.jeNull(vseb.getHead_tip()).equals("HE")  || nul.jeNull(vseb.getHead_tip()).equals("FU")  || nul.jeNull(vseb.getHead_tip()).equals("PR")) {

           %>
            				  <tr>
            		  
            		 <td class="opiscell" width="20%">
            		 
            		Druga grafika za gumbe css:
			</td>
						<td class="valuecell"  >
            		 
        
           
           <select name="target_search_rocno"  style="font-family: Verdana; font-size: 8pt">
           <option></option>
           		<%
			
			int stej = 0;
           String path = control.css_datoteke;
           Vector ve = new Vector();
               try {

                 //  System.out.println("Dzs dir:"+direktorij + " "+extension);
                 File dir = new File(path);
                 String[] fileti = dir.list();
                 for (int h = 0; h < fileti.length; h++) {
                //   System.out.println(fileti[h] + " len> " + fileti.length);
                   if (fileti[h].toString().indexOf(".")!=-1 && (fileti[h].toString().indexOf("css")!=-1)) { //////// najdem vse datoteke
                     ve.add(fileti[h]);

                   }
                 }
               }
               catch (Exception ex) {
                 System.out.println("Napaka pri branju filov: "+ex.toString());
               }

           
           
           
			for (int i=0;i<ve.size();i++) {
			
			stej++;
			 %>
           
           <option value="<%=nul.jeNull(ve.get(i)+"")%>" <%=(nul.jeNull(ve.get(i)+"").equals(nul.jeNull(vseb.getTarget_search_rocno()))?"selected":"") %>><%=nul.jeNull(ve.get(i)+"")%></option>
           <%
           }
			
			%>
            		 
            		 
            		 </select>
            		 </td>
            		 
              <td class="opiscell" width="20%"> Grafika css (ce ni zbrano je default plava): <br> Body class:</td><td class="valuecell" >
            		 
            		     <%
           
            		     if (nul.jeNull(vseb.getHead_tip()).equals("LI") || nul.jeNull(vseb.getHead_tip()).equals("UI") || nul.jeNull(vseb.getHead_tip()).equals("SE")
            	        		   || nul.jeNull(vseb.getHead_tip()).equals("HE")  || nul.jeNull(vseb.getHead_tip()).equals("FU")  || nul.jeNull(vseb.getHead_tip()).equals("PR")) {

           %>
           
           <select name="grafika_css"  style="font-family: Verdana; font-size: 8pt">
           <option></option>
           		<%
			
			 stej = 0;
            path = control.css_datoteke;
            ve = new Vector();
               try {

                 //  System.out.println("Dzs dir:"+direktorij + " "+extension);
                 File dir = new File(path);
                 String[] fileti = dir.list();
                 for (int h = 0; h < fileti.length; h++) {
                //   System.out.println(fileti[h] + " len> " + fileti.length);
                   if (fileti[h].toString().indexOf(".")!=-1 && (fileti[h].toString().indexOf("css")!=-1)) { //////// najdem vse datoteke
                     ve.add(fileti[h]);

                   }
                 }
               }
               catch (Exception ex) {
                 System.out.println("Napaka pri branju filov: "+ex.toString());
               }

           
           
           
			for (int i=0;i<ve.size();i++) {
			
			stej++;
			 %>
           
           <option value="<%=nul.jeNull(ve.get(i)+"")%>" <%=(nul.jeNull(ve.get(i)+"").equals(nul.jeNull(vseb.getGrafika_css()))?"selected":"") %>><%=nul.jeNull(ve.get(i)+"")%></option>
           <%
           }
			} 
			%>
            		 
            		 
            		 </select>
            		 <Br>
            		
            		 
            		 
            		 
            		       		 
            	 	 <select name="head_class_name_nosql2" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
          //   ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
             path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");
             
             Enumeration itn = clase.keys();
             
           /*  if (vseb.getDdivclasscustd()==null && vseb.getId()==null) {
             
              vseb.setDdivfirsttable((vsedd!=null && vsedd.getId()!=null)?vsedd.getDtdelement():"tnic");
           //  vseb.setDdivclasscustd("tnic");
             }*/
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getHead_class_name_nosql2()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
            		 
            		 
            		 
            		 </td>
            		 </tr> 
            		 
            		 <% /// grafika za hint stolpce
            		 if (nul.jeNull(vseb.getHead_tip()).equals("LI")) {
            		 
            		 %>
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 	  <tr>
            		  
            		 <td class="opiscell" width="20%">
            		 
            		Druga grafika za hint vrstico (vsi odd):
			</td>
						<td class="valuecell"  >
            		 
   	 <select name="custom_css_hint_1" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
   String patho =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(patho+"/custom.css");
             if (true) {
          //   ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
        
             
             Enumeration itn = clase.keys();
           
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getCustom_css_hint_1()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
					
            		 </td>
            		 
              <td class="opiscell" width="20%">Druga grafika za hint vrstico (vsi even): </td><td class="valuecell" >
            		 
         
           
         	 <select name="custom_css_hint_2" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
   //String patho =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
          //   Hashtable clase = control.getCSS_names(patho+"/custom.css");
             if (true) {
          //   ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
        
             
           Enumeration  itn = clase.keys();
           
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getCustom_css_hint_2()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
            		
            		 Cellspacing:
            		 <input type="text" name="cellspacing" id="cellspacing" size=2 maxlength=2 value="<%=nul.jeN(vseb.getCellspacing()) %>" style="font-family: Verdana; font-size: 8pt">
            		 for list table and hint table
            		 </td>
            		 </tr> 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 <%
            		 
            		 }
           }
            		 %>
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
           <%
           
           if (nul.jeNull(vseb.getHead_tip()).equals("LI")) {
        	   
           
           
           %>
                 
           	  <tr>
            		   <td class="opiscell" width="20%">Posebna funkcija pogoj<br>(pogoj za uporabo posebne funkcije npr. if (pogoj)): </td>
						<td class="valuecell" colspan=3><textarea  name="posebna_funkcija_pogoj" cols=65 rows=1 style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getPosebna_funkcija_pogoj()+"")%></textarea>
            		 
            		 
            		 </td></tr>
            		 <tr>
            		 
            		 <td class="opiscell" width="20%">Uporabi posebno funkcijo<br>(Funkcija ki se rocno doda v hibernate, mora vrnit isti objekt kot originalna, count ne sme niti izbran): </td>
						<td class="valuecell" colspan=3>
						<textarea  name="posebna_funkcija" cols=65 rows=1 style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getPosebna_funkcija()+"")%></textarea>
            		
            		 
            		 </td>
            		 </tr>
            		
           
           	  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi count:<br>Uporabi premikanje po straneh (v Max. stevilo recordov se vpise koliko recordov je na strani): </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="uporabi_count"  value="1" <%=nul.jeNull(vseb.getUporabi_count()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		  <br> <input type="checkbox" name="uporabi_count_ld"  value="1" <%=nul.jeNull(vseb.getUporabi_count_ld()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Max. stevilo recordov (ce se ne rabi count): </td>
						<td class="valuecell" >
            		 
            		 <input type="text" name="max_stevilo_recordov" maxlength='5' value="<%=nul.jeNull(vseb.getMax_stevilo_recordov()+"")%>" size="5" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 </tr>
           
 
 
 
            	  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi tree strukturo lista : </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="struktura_tree"  value="1" <%=nul.jeNull(vseb.getStruktura_tree()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		 <br>
            		 (list se odpira v stilu drevesa v istem frametu, dodat pod pogoj prikaza da v primeru idpm != null vezavo na nadrejeni id )<br> 
            		 npr: if (request.getParameter('idpm')!=null)  set|id_nad ime|(request.getParameter('idpm')), v primeru idpm==null je root<Br>
            		 gumb ki odpira pod liste mora klicati funkcijo v js z imenom odpriPodList('getId()')<br> id gumba za odprt je pmg+getId():
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Ne prikazi glavo lista pod tree strukturo lista:<br>&nbsp;
            		 		 <br>Klici drugo funkcijo ob odprtju tree (parameter je id, odpre tree druge tabele, ki mora biti narejen):
            		 		  </td>
						<td class="valuecell" >
            		 
             <input type="checkbox" name="struktura_tree_head"  value="1" <%=nul.jeNull(vseb.getStruktura_tree_head()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		 <br>
            		 
            		 <input type="text" name="js_funkcija_tree" maxlength='50' value="<%=nul.jeNull(vseb.getJs_funkcija_tree()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		
            		
            		
            		 </td>
            		 
            		 </tr>
 
            		
            		
            		
            		
            		
            		   	  <tr>
            		  
            		 <td class="opiscell" width="20%">Tree ime fielda (list one-to-many) za plus, ce vec kot 0: </td>
						<td class="valuecell" colspan=3 >
            		 
            		<select name="head_class_name_nosql3" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					if (true) {
					//// dobim ime model clase iz headerja
					
				
					
					
					List lii = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+vseb.getHead_class_name());
					
					Iterator ittii = lii.iterator();

					while (ittii.hasNext()) {
					
						String nex =(String)ittii.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getHead_class_name_nosql3()))) {
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
					%>
					
					
					</select>
            		 
            		 </td>
            		 </tr>
            		
            		
            		
            		
            		
            		
            		
            		
            		
            		
            		
            		
            		
            		
            		 
            		  
            	  <tr>
            		  
            		 <td class="opiscell" width="20%">Gumb tree struktura odpri: </td>
						<td class="valuecell" >
            		 
            		<select name="struktura_tree_gumbo" style="font-family: Verdana; font-size: 8pt" >
					<option></option>
			<option value="pmo.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbo()).equals("pmo.gif")?"selected":""%>>Plus</option>
			<option value="pmz.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbo()).equals("pmz.gif")?"selected":""%>>Minus</option>
				<option value="pmos.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbo()).equals("pmos.gif")?"selected":""%>>Plus sivo</option>
			<option value="pmzs.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbo()).equals("pmzs.gif")?"selected":""%>>Minus sivo</option>
					</select> 
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Gumb tree struktura zapri: </td>
						<td class="valuecell" >
            		 
            		<select name="struktura_tree_gumbz" style="font-family: Verdana; font-size: 8pt" >
					<option></option>
			<option value="pmo.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbz()).equals("pmo.gif")?"selected":""%>>Plus</option>
			<option value="pmz.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbz()).equals("pmz.gif")?"selected":""%>>Minus</option>
						<option value="pmos.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbz()).equals("pmos.gif")?"selected":""%>>Plus sivo</option>
			<option value="pmzs.gif" <%=nul.jeNull(vseb.getStruktura_tree_gumbz()).equals("pmzs.gif")?"selected":""%>>Minus sivo</option>
					</select> 	 
            		 
            		 
            		 </td>
            		 
            		 </tr>
            		 
            		 
            		    	  <tr>
            		  
            		 <td class="opiscell" width="20%">Definiraj polje v bazi za zaklepanje recordov (unique polje, zaklene samo pri update/insert): </td><td class="valuecell" >
            		 
            		    		           		  		 <select name="zakleni_record" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					 
					String headname="";
					
						if (true) {
					
					//// dobim ime model clase iz headerja
				
					
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+vseb.getHead_class_name());
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getZakleni_record()))) {
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
					
					
					
					
					
						if (!nul.jeNull(vseb.getVeza_gumb()+"").equals("")) {
						
						com.popultrade.model.TemplateGumbiParametri tgp = new com.popultrade.model.TemplateGumbiParametri();
						com.popultrade.dao.TemplateGumbiParametriDAO dah = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
						
						tgp.setTemplategumb_id(vseb.getVeza_gumb());
						
						List limo = dah.getTemplateGumbiParametris(tgp);
						
						Iterator imo = limo.iterator();
						
						while (imo.hasNext()) {
							com.popultrade.model.TemplateGumbiParametri slur = (com.popultrade.model.TemplateGumbiParametri)imo.next();
							String primeri = nul.jeNull(slur.getStolpec_metoda());
							if (nul.jeNull(slur.getStolpec_metoda()).indexOf("request.getParameter")==-1) {
							primeri = nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')";
							}
							if (!nul.jeNull(slur.getDugacno_ime_parametra()).equals("")) {
								primeri = "request.getParameter(\'"+slur.getDugacno_ime_parametra()+"\')";
							}
							
							
						
						%>
						
						<option value="<%=primeri%>" <%=primeri.equals(nul.jeNull(vseb.getZakleni_record()))?"selected":""%>><%=primeri%> (preko gumba)</option>
					
						
						<%
						}
					}
					
					
					
					
					
					
					
					
					}
					%>
					
					
					</select> 
            		   
            	</td>
             	 <td class="opiscell" width="20%">Zakleni celoten list: </td><td class="valuecell" width="30%">
             	 <input type="checkbox" name="zakleni_vse" value="1" <%=nul.jeNull(vseb.getZakleni_vse()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		  
            		 (zklenem vse, samo za podliste npr. list postavk  in view ). Zakleni polje je polje iz glave (ce glava ima getId tukaj request.getParameter('id')), id glave poslji preko gumba. 
            		 To polje je vedno izbrano, ce ni glavni list.
    
            	           		
            		 
            	</td>	 
            		  </tr>		
            		  
            		  
            		      	  <tr>
            		  
            		 <td class="opiscell" width="20%">Ne uporabi websocketov za refresh : </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="nologinneeded"  value="1" <%=nul.jeNull(vseb.getNologinneeded()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	(koda se vseeno generira, klicat jo moras rocno)
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%"></td>
						<td class="valuecell" >
            		 
            	 
            		 
            		 </td>
            		 
            		 </tr>
            		  
            		  
            		  
            		  
            		  
            		 
            		 
            		           		 
                 <tr>
                           				 <td class="opiscell" width="20%">
                            		
                            		Kontrola vezave, vrednost ki veze uporabnike podjetju (npr. control.getPodjetje()), omogoca prikaz update vrednosti v listu ostalim uporabnikom ne samo istemu userju: </td><td class="valuecell" width="30%">
                            		 	 <input type="text" name="prisotnost_polje_kontrola" maxlength='35' value="<%=nul.jeNull(vseb.getPrisotnost_polje_kontrola()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		
                            		 </td> <td class="opiscell" width="20%">Uporabi novi stil gumbov (css): </td><td class="valuecell" width="30%">
            		 
            	           		  <input type="checkbox" name="uporabi_nove_gumbe" value="1" <%=nul.jeNull(vseb.getUporabi_nove_gumbe()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
    
            		 
            	</td>	
                           		
                           		 
                            
                            		 
                           		  </tr>	 
            		   
            		   
            		 
            		 
                 <tr>
                           				 <td class="opiscell" colspan=2>
                            		 Kreiraj polja (Polja se samo kreirajo , dodatno obdelavo je treba narediti kasneje):
                           
                            		 
                            		 </td><td class="valuecell" colspan=2>
                            		<input type="button" value="Avtomatsko dodaj stolpce" onclick="goDown('m_templatelist_avt.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		<input type="button" value="Avtomatsko dodaj strukturo" onclick="goDown('m_templatelist_avt_all.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		
                            		 &nbsp;</td>  
                           		
                           		   
                            
                            		 
                           		  </tr>	 
                           		  
                           		  
           
             		 
<tr>
            		  
            		 <td class="valuecell" width="20%">
            		 
            		<input type="button" value="Pogoji za prikaz LIST" onclick="goDown('m_templateclass.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
            	<td class="valuecell" width="30%">
            	<input type="button" value="Okna prikaza LIST" onclick="goDown('m_templatelist.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
            	<input type="button" value="Search po LIKE" onclick="goDown('m_templatelist_search.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
            	
            	</td>
            		 
             		 <td class="valuecell">
             		 
             		 
             		<input type="button" value="Gumbi prikaza LIST" onclick="goDown('m_templategumbi.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt"> 
             		 
             		 </td><td class="valuecell">
             			<input type="button" value="Posiljanje izpisa (HTML-Mail)" onclick="goDown('m_templatemaillist.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt"> 
             	
             		 &nbsp;</td>
             		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            	<%
           }
           
            if (nul.jeNull(vseb.getHead_tip()).equals("LT") || nul.jeNull(vseb.getHead_tip()).equals("HT")) {
            %>
            
             	  <tr>
            		  
            		 <td class="opiscell" width="20%">Submitaj dod formo na url, ce ne default na isto (samo za update,<Br> v primeru logina daj na kontrola2.jsp?forw=|ime datoteke ki odpre po uspesnem loginu|&nlo=|ime datoteke po neuspesnem loginu|): </td>
						<td class="valuecell" >
            		 
            		 
            		 <textarea cols="70" name="alternativesubmit" rows="2"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getAlternativesubmit()+"")%></textarea>
            		 
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Opcijsko ime generirane datoteke (npr. datoteka, mora biti unique):<Br>
            		 		 Ime login strani, kamor te redirecta ce nisi logiran (default logout.jsp): </td>
						<td class="valuecell" >
            		 
            	  <input type="text" name="gennamefile" maxlength='35' value="<%=nul.jeNull(vseb.getGennamefile()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 <Br><font size=2>&nbsp;</font><Br>
            		 <input type="text" name="head_class_name_nosql3" maxlength='55' value="<%=nul.jeNull(vseb.getHead_class_name_nosql3()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            	
            		 
            		 </td>
            		 
            		 </tr>
            		 
            		      
            		 
            		      		      
           	  <tr>
            		  
            		 <td class="opiscell" width="20%">Page title: </td>
						<td class="valuecell" >
            		 
            	 <input type="text" name="page_title" maxlength='70' value="<%=nul.jeNull(vseb.getPage_title()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Page description: </td>
						<td class="valuecell" >
            		 
            		 <input type="text" name="page_description" maxlength='120' value="<%=nul.jeNull(vseb.getPage_description()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 </tr>
            		 
            		 
            	      	  <tr>
            		  
            		 <td class="opiscell" width="20%">Page Keywords: </td>
						<td class="valuecell" >
            		 
            	 <input type="text" name="page_keywords" maxlength='120' value="<%=nul.jeNull(vseb.getPage_keywords()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Uporabi tip izbire datuma za mobile: </td>
						<td class="valuecell" >
            		 
  <input type="checkbox" name="date_mobile"  value="1" <%=nul.jeNull(vseb.getDate_mobile()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		           		
            		 
            		 </td>
            		 
            		 </tr>	
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		   	  <tr>
            		  
            		 <td class="opiscell" width="20%">Header (veza na drugi template, ki se rabi kot header): </td>
						<td class="valuecell" >
            		 
            		 
            		 
            		 
            		 
            		  		 <select name="header" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
            		
            		<%
            		if (true) {
            		com.popultrade.dao.TemplateHeadDAO daogo = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		 com.popultrade.model.TemplateHead lokk = new com.popultrade.model.TemplateHead();
            		 lokk.setTip_head_foot("1");
            		List lisg = daogo.getTemplateHeads(lokk,1,1000);
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateHead vsebg = (com.popultrade.model.TemplateHead)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getHeader()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getHead_naziv())%> (<%=nul.jeNull(vsebg.getGennamefile()) %>)</option>
            		<%
            		
            		
            		
            		}
            		}
            		%>
            		
            		
            		</select>
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Footer (veza na drugi template, ki se rabi kot footer - ne za list): </td>
						<td class="valuecell" >
            		 
            		 		  		 <select name="footer" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
            		
            		<%
            		if (true) {
            		com.popultrade.dao.TemplateHeadDAO daogo = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		
            			 com.popultrade.model.TemplateHead lokk = new com.popultrade.model.TemplateHead();
            		 lokk.setTip_head_foot("2");
            		List lisg = daogo.getTemplateHeads(lokk,1,1000);
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateHead vsebg = (com.popultrade.model.TemplateHead)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getFooter()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getHead_naziv())%> (<%=nul.jeNull(vsebg.getGennamefile()) %>)</option>
            		<%
            		
            		
            		
            		}
            		}
            		%>
            		
            		
            		</select>
            		 
            		 </td>
            		 
            		 </tr>	 
            		 
            		 
            		 
        
        
        
        
        
        
        
        
        
                 		 
            		 
            		   	  <tr>
            		  
            		 <td class="opiscell" width="20%">Response (veza na drugi template, ki se rabi kot response pri commitu): </td>
						<td class="valuecell" >
            		 
            		 
            		 
            		 
            		 
            		  		 <select name="response" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
            		
            		<%
            		if (true) {
            		com.popultrade.dao.TemplateHeadDAO daogo = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		 com.popultrade.model.TemplateHead lokk = new com.popultrade.model.TemplateHead();
            		 lokk.setTip_head_foot("3");
            		List lisg = daogo.getTemplateHeads(lokk,1,1000);
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateHead vsebg = (com.popultrade.model.TemplateHead)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getResponse()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getHead_naziv())%> (<%=nul.jeNull(vsebg.getGennamefile()) %>)</option>
            		<%
            		
            		
            		
            		}
            		}
            		%>
            		
            		
            		</select>
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Work in progress (veza na drugi template, odgovor v primeru da se obdeluje dokument): </td>
						<td class="valuecell" >
            		 
            		 	
            		 	 
            		 
            		  		 <select name="inwork" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
            		
            		<%
            		if (true) {
            		com.popultrade.dao.TemplateHeadDAO daogo = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		 com.popultrade.model.TemplateHead lokk = new com.popultrade.model.TemplateHead();
            		 lokk.setTip_head_foot("4");
            		List lisg = daogo.getTemplateHeads(lokk,1,1000);
            		Iterator itg = lisg.iterator();

 
            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateHead vsebg = (com.popultrade.model.TemplateHead)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getInwork()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getHead_naziv())%> (<%=nul.jeNull(vsebg.getGennamefile()) %>)</option>
            		<%
            		
            		
            		
            		}
            		}
            		%>
            		
            		
            		</select>
            		 </td>
            		 
            		 </tr>	 
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            		 
            
            <%
            }
         
           
           if (nul.jeNull(vseb.getHead_tip()).equals("LT")) {
        	   
           
           
           %>
                 
         
            		 
              	
            		
           
           	  <tr>
            		  
            		 <td class="opiscell" width="20%">Uporabi count:<br>Uporabi premikanje po straneh (v Max. stevilo recordov se vpise koliko recordov je na strani): </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="uporabi_count"  value="1" <%=nul.jeNull(vseb.getUporabi_count()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		  <br> <input type="checkbox" name="uporabi_count_ld"  value="1" <%=nul.jeNull(vseb.getUporabi_count_ld()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Max. stevilo recordov (ce se ne rabi count): </td>
						<td class="valuecell" >
            		 
            		 <input type="text" name="max_stevilo_recordov" maxlength='5' value="<%=nul.jeNull(vseb.getMax_stevilo_recordov()+"")%>" size="5" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 </tr>
            		 
              	  <tr>
            		  
            		 <td class="opiscell" width="20%"> </td>
						<td class="valuecell" >
            		
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Generiraj custom list: </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="custom_gen" value="1" <%=nul.jeNull(vseb.getCustom_gen()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">&nbsp;
            		 
            		 
            		 </td>
            		 
            		 </tr>
 
           
             		 
<tr>
            		  
            		 <td class="valuecell" width="20%">
            		 
            		<input type="button" value="Pogoji za prikaz LIST" onclick="goDown('m_templateclass.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
            	<td class="valuecell" width="30%">
            	<input type="button" value="Prikaz LIST" onclick="goDown('m_templatelist_t.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
            	<input type="button" value="Prikaz LIST custom" onclick="goDown('m_templateui_t.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>&jelist=da&tipt=<%=nul.jeNull(vseb.getTip_head_foot()) %>')" style="font-family: Verdana; font-size: 8pt">
            	
            	
            	</td>
            		 
             		 <td class="valuecell">
             		 
             		 
             		<input type="button" value="Gumbi prikaza LIST" onclick="goDown('m_templategumbi_t.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt"> 
             		 
             		 </td><td class="valuecell">
             		<!-- 	<input type="button" value="Posiljanje izpisa (HTML-Mail)" onclick="goDown('m_templatemaillist.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt"> 
             	 -->
             	 	<input type="button" value="Search po LIKE" onclick="goDown('m_templatelist_search.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
            
             		 &nbsp;</td>
             		 
            		  </tr>
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            		  
            	<%
           }

           
           else  if (nul.jeNull(vseb.getHead_tip()).equals("HE")) {
        	   
               
               
               %>
               
               
               
               
                   	  <tr>
            		  
            		 <td class="opiscell" width="20%">Definiraj polje v bazi za zaklepanje recordov (unique polje, zaklene samo pri update/insert): </td><td class="valuecell" >
            		 
            		    		           		  		 <select name="zakleni_record" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					 
					String headname="";
					
						if (true) {
					
					//// dobim ime model clase iz headerja
				
					
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+vseb.getHead_class_name());
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getZakleni_record()))) {
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
					
					
					
					
					
						if (!nul.jeNull(vseb.getVeza_gumb()+"").equals("")) {
						
						com.popultrade.model.TemplateGumbiParametri tgp = new com.popultrade.model.TemplateGumbiParametri();
						com.popultrade.dao.TemplateGumbiParametriDAO dah = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
						
						tgp.setTemplategumb_id(vseb.getVeza_gumb());
						
						List limo = dah.getTemplateGumbiParametris(tgp);
						
						Iterator imo = limo.iterator();
						
						while (imo.hasNext()) {
							com.popultrade.model.TemplateGumbiParametri slur = (com.popultrade.model.TemplateGumbiParametri)imo.next();
							String primeri = nul.jeNull(slur.getStolpec_metoda());
							if (nul.jeNull(slur.getStolpec_metoda()).indexOf("request.getParameter")==-1) {
							primeri = nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')";
							}
							if (!nul.jeNull(slur.getDugacno_ime_parametra()).equals("")) {
								primeri = "request.getParameter(\'"+slur.getDugacno_ime_parametra()+"\')";
							}
							
							
						
						%>
						
						<option value="<%=primeri%>" <%=primeri.equals(nul.jeNull(vseb.getZakleni_record()))?"selected":""%>><%=primeri%> (preko gumba)</option>
					
						
						<%
						}
					}
					
					
					
					
					
					
					
					
					}
					%>
					
					
					</select> 
            		   
            	</td>
             	 <td class="opiscell" width="20%">Zakleni celoten list: </td><td class="valuecell" width="30%">
             	 <input type="checkbox" name="zakleni_vse" value="1" <%=nul.jeNull(vseb.getZakleni_vse()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		  
            		 (zklenem vse, samo za podliste npr. list postavk  in view ). Zakleni polje je polje iz glave (ce glava ima getId tukaj request.getParameter('id')), id glave poslji preko gumba. 
            		 To polje je vedno izbrano, ce ni glavni list.
    
            	           		
            		 
            	</td>	 
            		  </tr>		
               
               
               
               
               
               
               
               
               
               
               
               
               
                 	      <tr>
                           				 <td class="opiscell" colspan=2>
                            		 Kreiraj polja (Polja se samo kreirajo , dodatno obdelavo je treba narediti kasneje):
                           
                            		 
                            		 </td><td class="valuecell" colspan=2>
                            		<input type="button" value="Avtomatsko dodaj polja" onclick="goDown('m_templateview_avt.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		
                            		 &nbsp;</td>  
                           		
                           		 
                            
                            		 
                           		  </tr>	  		 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                		<input type="button" value="Pogoji za prikaz HEAD" onclick="goDown('m_templateclass.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Okna prikaza HEAD" onclick="goDown('m_templateview.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }   
           else  if (nul.jeNull(vseb.getHead_tip()).equals("UR")) {
        	   
               %>
       		 
               <tr>
                           		  
                           		 <td class="valuecell" width="20%">
                           		 
                           		 
                           		 </td>
                           		 
                           	<td class="valuecell" width="30%">
                           	</td>
                           		 
                            		 <td class="valuecell">
                            		 Za vnos v bazo datoteke:
                            <input type="button" value="Kreiraj funkcije " onclick="goDown('m_templatefunkcijaui_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
 
                            		 
                            		 </td><td class="valuecell">
                            		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                            		
                            		 &nbsp;</td>
                            		 
                           		  </tr>
                           		  
                           	<% 
        	   
        	   
           }
           
             else  if (nul.jeNull(vseb.getHead_tip()).equals("HT")) {
        	   
               
               
               %>
               
               
               
                	      	  <tr>
            		  
            		 <td class="opiscell" width="20%">Body style iz custom css: </td>
						<td class="valuecell" >
            		 
            	 	 <select name="head_class_name_nosql2" style="font-family: Verdana; font-size: 8pt" >
			<option value=""></option> 
             <%
             if (true) {
          //   ServletContext scon=pageContext.getServletContext();

			// String path = scon.getRealPath(control.lokacija_css_slik);
            String path =request.getRealPath("")+ "/"+control.lokacija_css_slik;
             
             Hashtable clase = control.getCSS_names(path+"/custom.css");
             
             Enumeration itn = clase.keys();
             
           /*  if (vseb.getDdivclasscustd()==null && vseb.getId()==null) {
             
              vseb.setDdivfirsttable((vsedd!=null && vsedd.getId()!=null)?vsedd.getDtdelement():"tnic");
           //  vseb.setDdivclasscustd("tnic");
             }*/
             
             while (itn.hasMoreElements()) {
             
             String okm = (String)itn.nextElement();
              %>
             
            		
             		 <option value="<%=okm%>" <%=nul.jeNull(vseb.getHead_class_name_nosql2()).equals(okm)?"selected":""%>><%=okm %></option>
					
				<%
				}
				}
				 %>
					
					</select>
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Tip template : </td>
						<td class="valuecell" >
            		 
            		  <select name="tip_head_foot" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value="0"  <%=(nul.jeNull(vseb.getTip_head_foot()).equals("0")?"selected":"")%>>Default</option>
					<option value="1" <%=(nul.jeNull(vseb.getTip_head_foot()).equals("1")?"selected":"")%>>Header</option>
					<option value="2" <%=(nul.jeNull(vseb.getTip_head_foot()).equals("2")?"selected":"")%>>Footer</option>
					<option value="3" <%=(nul.jeNull(vseb.getTip_head_foot()).equals("3")?"selected":"")%>>Response</option>
					<option value="4" <%=(nul.jeNull(vseb.getTip_head_foot()).equals("4")?"selected":"")%>>Work in progres</option>
					
					</select><br>
            		 ime diva za template (header/footer) - |tip template|_<%=nul.jeNull(vseb.getId()) %> 
            		 </td>
            		 
            		 </tr>	
               
               
               
               
               
               
               
                 	      <tr>
                           				 <td class="opiscell">
                            		 Ne uporabi zaklepanje dokumenta (zaklene dokument na userja, ki ga obdeluje):
                           
                            		 
                            		 </td><td class="valuecell">
                            		 <input type="checkbox" name="uporabi_count"  value="1" <%=nul.jeNull(vseb.getUporabi_count()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
                            		 &nbsp;</td>  
                           		 <td class="opiscell" width="20%">
                           		 
                           		 Ne refresh-aj frametov po potrditvi:
                           		 </td>
                           		 
                           	<td class="valuecell" width="30%">
                           	<input type="checkbox" name="uporabi_count_ld"  value="1" <%=nul.jeNull(vseb.getUporabi_count_ld()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
                           	</td>
                           		 
                            
                            		 
                           		  </tr>
                           		  
                           		    	  <tr>
            		  
            		 <td class="opiscell" width="20%">Template ne potrebuje logina (za strani kjer lahko vsi dostopajo): </td>
						<td class="valuecell" >
            		 
            		 <input type="checkbox" name="nologinneeded"  value="1" <%=nul.jeNull(vseb.getNologinneeded()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
            		 
            		 </td>
            		 
            		 		 <td class="opiscell" width="20%">Stran se prikaze kot je narejena (brez menija, iframov,...): </td>
						<td class="valuecell" >
            		 
            	 
            		 <input type="checkbox" name="pageisindependent"  value="1" <%=nul.jeNull(vseb.getPageisindependent()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
            		 
            		 </td>
            		 
            		 </tr>
                           		  	 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                		<input type="button" value="Pogoji za prikaz UPDATE/INSERT" onclick="goDown('m_templateclass.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Okna prikaza UPDATE/INSERT" onclick="goDown('m_templateui_t.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%><%=!nul.jeNull(vseb.getTip_head_foot()).equals("0")?"&jelist=":"" %>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
<input type="button" value="Kreiraj funkcije" onclick="goDown('m_templatefunkcijaui_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 
                 		 
                 		 </td><td class="valuecell">
                 		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein_t.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 		
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               } 
           
           
           else  if (nul.jeNull(vseb.getHead_tip()).equals("UI")) {
        	   
               
               
               %>
               
                 <tr>
                           				 <td class="opiscell">
                            		 Ne uporabit default pogoja id za iskanje recorda pri UI (ce oznaceno in rabis id ga je treba dati pod pogoje):
                           
                            		 
                            		 </td><td class="valuecell">
                            		 <input type="checkbox" name="overraid_update_default"  value="1" <%=nul.jeNull(vseb.getOverraid_update_default()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
                            		 &nbsp;</td>  
                           		 <td class="opiscell" width="20%">
                           		 
                           		
                           		 </td>
                           		 
                           	<td class="valuecell" width="30%">
                          
                           	</td> 
                           		  </tr>
               
               
                 	      <tr>
                           				 <td class="opiscell">
                            		 Ne uporabi zaklepanje dokumenta (zaklene dokument na userja, ki ga obdeluje):
                           
                            		 
                            		 </td><td class="valuecell">
                            		 <input type="checkbox" name="uporabi_count"  value="1" <%=nul.jeNull(vseb.getUporabi_count()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
                            		 &nbsp;</td>  
                           		 <td class="opiscell" width="20%">
                           		 
                           		 Ne refresh-aj frametov po potrditvi:
                           		 </td>
                           		 
                           	<td class="valuecell" width="30%">
                           	<input type="checkbox" name="uporabi_count_ld"  value="1" <%=nul.jeNull(vseb.getUporabi_count_ld()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
                           	</td> 
                           		  </tr>
                           		  
                           		  
                           		  
                           		  
                           		  
                           		    		    	  <tr>
            		  
            		 <td class="opiscell" width="20%">Definiraj polje v bazi za zaklepanje recordov (unique polje, zaklene samo pri update/insert): </td><td class="valuecell" >
            		 
            		    		           		  		 <select name="zakleni_record" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					 
					String headname="";
					
						if (true) {
					
					//// dobim ime model clase iz headerja
				
					
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+vseb.getHead_class_name());
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.substring(0,nex.indexOf(" ----XXX---- ")).equals(nul.jeNull(vseb.getZakleni_record()))) {
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
					
					
					
					
					
						if (!nul.jeNull(vseb.getVeza_gumb()+"").equals("")) {
						
						com.popultrade.model.TemplateGumbiParametri tgp = new com.popultrade.model.TemplateGumbiParametri();
						com.popultrade.dao.TemplateGumbiParametriDAO dah = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
						
						tgp.setTemplategumb_id(vseb.getVeza_gumb());
						
						List limo = dah.getTemplateGumbiParametris(tgp);
						
						Iterator imo = limo.iterator();
						
						while (imo.hasNext()) {
							com.popultrade.model.TemplateGumbiParametri slur = (com.popultrade.model.TemplateGumbiParametri)imo.next();
							String primeri = nul.jeNull(slur.getStolpec_metoda());
							if (nul.jeNull(slur.getStolpec_metoda()).indexOf("request.getParameter")==-1) {
							primeri = nul.jeNull(slur.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')";
							}
							if (!nul.jeNull(slur.getDugacno_ime_parametra()).equals("")) {
								primeri = "request.getParameter(\'"+slur.getDugacno_ime_parametra()+"\')";
							}
							
							
						
						%>
						
						<option value="<%=primeri%>" <%=primeri.equals(nul.jeNull(vseb.getZakleni_record()))?"selected":""%>><%=primeri%> (preko gumba)</option>
					
						
						<%
						}
					}
					
					
					
					
					
					
					
					
					}
					%>
					
					
					</select> 
            		   
            	</td>
             	 <td class="opiscell" width="20%"> Kontrola vezave, vrednost ki veze uporabnike podjetju :</td><td class="valuecell" width="30%">
             	
            	  
                            		 	 <input type="text" name="prisotnost_polje_kontrola" maxlength='35' value="<%=nul.jeNull(vseb.getPrisotnost_polje_kontrola()+"")%>" size="35" style="font-family: Verdana; font-size: 8pt">&nbsp;
            		        		(npr. control.getPodjetje()) omogoca prikaz update vrednosti v listu ostalim uporabnikom ne samo istemu userju
            		 
            	</td>	 
            		  </tr>		
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		      <tr>
                           				 <td class="opiscell" colspan=2>
                            		 Kreiraj polja (Polja se samo kreirajo , dodatno obdelavo je treba narediti kasneje):
                           
                            		 
                            		 </td><td class="valuecell" colspan=2>
                            		<input type="button" value="Avtomatsko dodaj polja" onclick="goDown('m_templateui_avt.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		
                            		 &nbsp;</td>  
                           		
                           		 
                            
                            		 
                           		  </tr>	  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  
                           		  	 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                		<input type="button" value="Pogoji za prikaz UPDATE/INSERT" onclick="goDown('m_templateclass.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Okna prikaza UPDATE/INSERT" onclick="goDown('m_templateui.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
<input type="button" value="Kreiraj funkcije" onclick="goDown('m_templatefunkcijaui_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 
                 		 
                 		 </td><td class="valuecell">
                 		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 		
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }    
           
           else  if (nul.jeNull(vseb.getHead_tip()).equals("SE")) {
        	   
               
               
               %>
                               <tr>
                           				 <td class="opiscell" colspan=2>
                            		 Kreiraj polja (Polja se samo kreirajo , dodatno obdelavo je treba narediti kasneje):
                           
                            		 
                            		 </td><td class="valuecell" colspan=2>
                            		<input type="button" value="Avtomatsko dodaj stolpce" onclick="goDown('m_templatese_avt.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                		
                            		 &nbsp;</td>  
                           		
                           		 
                            
                            		 
                           		  </tr>	    		 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                	 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Okna prikaza SEARCH" onclick="goDown('m_templatese.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }    
           else  if (nul.jeNull(vseb.getHead_tip()).equals("FU")) {
        	   
               
               
               %>
                 		 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 	<input type="button" value="Dodatni pogoji" onclick="return goDown('m_templateuidodatno_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                
                	 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Kreiraj funkcijo" onclick="goDown('m_templatefunkcija_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }  
               
               
                         else  if (nul.jeNull(vseb.getHead_tip()).equals("OB")) {
        	   
               
               
               %>
                 		 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                			<input type="button" value="Pogoji za prikaz " onclick="goDown('m_templateclass.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	
                	 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Podatki za prikaz objekta iz baze" onclick="goDown('m_templateobjektibaza_edit.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		</td>
                 		 
                		  </tr>
                		  
                	<%
               }  
               
               
           else  if (nul.jeNull(vseb.getHead_tip()).equals("UP")) {
        	   
               
               
               %>
                 		 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                	 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Upload parametri" onclick="goDown('m_templateupload.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }  
           else  if (nul.jeNull(vseb.getHead_tip()).equals("PD")) {
        	   
        		Hashtable prep = new Hashtable();
        		Hashtable previd = new Hashtable();
        		/// prevod vnosa
        		Hashtable prev = new Hashtable();
        		
        		Hashtable prep2 = new Hashtable();
        		Hashtable prev2 = new Hashtable();
        		/// dobim vse prevode
        		com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
        		com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
        		
        		List limo = daop.getPrevodis(prevo);

        		limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","M");
        		Iterator itep = limo.iterator();

        		while (itep.hasNext()) {
        			com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
        			prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
        		}

        		limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","M");
        		itep = limo.iterator();


        		while (itep.hasNext()) {
        			com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
        			prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
        			previd.put(prv.getPrevod_id()+"",prv.getId()+"");
        		}
        		
        		
        		
 
        		
        		
        		
        		
        		
               
               %>
               
                    	      		  <tr>
            		  
            		 <td class="opiscell" width="20%">Dolg pdf (ce je pdf presegle limit try-catch, v tem primeru ni mogoce posiljat custom neznank skozi cel pdf):</td><td class="valuecell" colspan=3>
            	    	
 <input type="checkbox" name="pdf_dolg"  value="1" <%=nul.jeNull(vseb.getPdf_dolg()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	        
            		 
            		 </td>
            		 </tr>	  
               
               
                 	      		  <tr>
            		  
            		 <td class="opiscell" width="20%">Prevod (sporocilo v primeru, da pdf ne najde zapisov):</td><td class="valuecell" colspan=3>
            	    	<%=nul.jeNull((String)prep.get(vseb.getId()+""))%>  <br>
<input type="text" size="70" name="prevod_<%=vseb.getId()%>_M_<%=nul.jeNull((String)previd.get(vseb.getId()+""))%>" value="<%=nul.jeNull((String)prev.get(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt">
         
            		 
            		 </td>
            		 </tr>	 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                	   <input type="button" value="Dodaj parametre za header/footer na izpisu" onCLick="return goDown('m_templatepdfparametrifooter_edit.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt"><br>
  
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Prikaz izpisa PDF" onclick="goDown('m_templatefunkcija_pdf_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }   
           
           
           else  if (nul.jeNull(vseb.getHead_tip()).equals("EX")) {
        	   
               
               
               %>
                 		 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                	 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Export XML" onclick="goDown('m_templatefunkcija_xml_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }   
           
           else  if (nul.jeNull(vseb.getHead_tip()).equals("EE")) {
        	   
               
               
               %>
                 		 
    <tr>
                		  
                		 <td class="valuecell" width="20%">
                		 
                	 
                		 </td>
                		 
                	<td class="valuecell" width="30%">
                	<input type="button" value="Export EDI" onclick="goDown('m_templatefunkcija_edi_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                	</td>
                		 
                 		 <td class="valuecell">
                 		 
                 		 
                 		 
                 		 </td><td class="valuecell">
                 		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }   
           
           else  if (nul.jeNull(vseb.getHead_tip()).equals("PR")) {
        	   
               
               
               %>
                 		 
    <tr>
                		  
                		 <td class="valuecell" colspan=2>
                		  (Uporabi se za izdelavo kontrole pred klicanjem procedure. V primeru napake se format setira na vrednost rezu=\"NIOK\", prevod se uporabi kot opis napake.)
                 		
                	 
                		 </td>
                		 
                	<td class="valuecell">
                	
                 		      
                	<input type="button" value="Kreiraj funkcijo" onclick="goDown('m_templatefunkcija_framein2.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                <input type="button" value="Dodaj rocno kodo" onclick="goDown('m_templateheaddodatno_edit.jsp??opcija=new&siframm=new&sifrant=null&idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                
                 		 
                 		 </td><td class="valuecell">
                 		<input type="button" value="Pridobi podatke iz predhodnega vnosa" onclick="goDown('m_templatepp_framein.jsp?idt=<%=nul.jeNull(vseb.getId()+"")%>')" style="font-family: Verdana; font-size: 8pt">
                 		 &nbsp;</td>
                 		 
                		  </tr>
                		  
                	<%
               }   
            	%>
            		  


<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {

    <%
    if (nul.jeNull(vseb.getHead_tip()).equals("LI")) {
    %>
	if (document.dod.struktura_tree.checked) {
		
		if (document.dod.head_class_name_nosql3.value=="") {
		alert("Error: ni izbrano polje za tree ime field!");
		return false;
		}
		
		
	}
	
	<%
    }
	%>

return true;
}



function goDown(kam) {

top.parent.frames[2].location = kam;

}

function PGAPP() {
}


function mom() {
top.parent.frames[2].location = "nic.jsp";
top.parent.frames[3].location = "nic.jsp";
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

  parent.frames[0].document.location = mon.substring(0,mon.indexOf("idback")-1)+"";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("id=")!=-1) {
     parent.frames[0].document.location = mon.substring(0,mon.indexOf("?")) + "";
     
     }
     else {
parent.frames[0].document.location = parent.frames[0].document.location + "";
     }
     }
     else {
     parent.frames[0].document.location = parent.frames[0].document.location + "";

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