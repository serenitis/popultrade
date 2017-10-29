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
com.popultrade.model.TemplateUiDodatno vseb =new com.popultrade.model.TemplateUiDodatno();
com.popultrade.dao.TemplateUiDodatnoDAO dao = (com.popultrade.dao.TemplateUiDodatnoDAO)contextUtil.getBeanDao("templateUiDodatnoDAO",pageContext.getServletContext());



if (request.getParameter("idt")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateUiDodatnos(nul.jeNullDefault(request.getParameter("idt")));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateUiDodatno(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplateui_id(new Long(request.getParameter("idt")));

	}

vseb = (com.popultrade.model.TemplateUiDodatno)contextUtil.getPopulatedObject(vseb,request);

//vseb.setDodatno_delete(nul.jeNull(request.getParameter("dodatno_delete")).equals("1")?"1":"0");
dao.saveTemplateUiDodatno(vseb);


//// update clob za 

dao.updateClob(request.getParameter("id"),"dodatno_java_updateinsert",nul.jeNull(request.getParameter("dodatno_java_updateinsert")));



}
}


////// gumbi parametri list;


com.popultrade.dao.TemplateHeadDAO daotr = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());



com.popultrade.model.TemplateHead sif = new com.popultrade.model.TemplateHead();


sif = daotr.getTemplateHead(new Long(request.getParameter("idt")));

List parame=new ArrayList();
if (sif!=null && sif.getVeza_gumb()!=null) {
 com.popultrade.dao.TemplateGumbiDAO daotgi = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());

 
 com.popultrade.model.TemplateGumbi tgumb = daotgi.getTemplateGumbi(sif.getVeza_gumb());
 

if (tgumb!=null) {
	
	parame = tgumb.getTemplateGumbiParametris();
	
}

}



//Hashtable ht =new Hashtable();
//ht.put("id","id");
//Hashtable htn =new Hashtable();
//htn.put("kolicina","kol_kg");
%>

<html><head><title>spreminjaj</title></head>

<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>



<!--%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %-->
<!--%=javaScript.getControlsNumericValuesHashtable("document.dod",htn) %-->

<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">


<script src="src-min/ace.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateuidodatno_edit.jsp" method="post" onsubmit="return check()">

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
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr>
	<td colspan="2" class="opiscell">&nbsp;</td></tr>


<tr>
            		  
<td class="opiscell" width="20%">Dodatno javascript funkcije:&nbsp;</td><td class="valuecell" width="30%">

<textarea id="dodatno_javascript_funkcijee" rows="25" stddyle="font-family: Verdana; font-size: 8pt; width: 1013px; height: 274px;"><%=nul.jeNull(vseb.getDodatno_javascript_funkcije()+"")%></textarea>

<input type="hidden" name="dodatno_javascript_funkcije" id="dodatno_javascript_funkcije" value="">
						

</td>
            		 
        		 
</tr>


	              		  <tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno javascript uporabi se ko zgornje polje "dodatno javascript funkcije" ni zadosti dolgo : </td>
						<td class="valuecell" style="width: 80%">
						
						<textarea id="dodatno_javascript2e" stddyle="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_javascript2()+"")%></textarea>
						
						<input type="hidden" name="dodatno_javascript2" id="dodatno_javascript2" value="">
						
						</td>
            		 
            		  </tr>
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno javascript, klice se po kliku na gumb potrdi: </td>
						<td class="valuecell" style="width: 80%">
						
						<textarea id="dodatno_javascripte" stddyle="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_javascript()+"")%></textarea>
						<input type="hidden" name="dodatno_javascript" id="dodatno_javascript" value="">
						
						
						</td>
            		 
            		  </tr>
            	
            		  
            		  
            		  	  <tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno javascript pri load okna (pri body onload funkciji): </td>
						<td class="valuecell" style="width: 80%">
						
						<textarea id="dodatno_javascript_onloade" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_javascript_onload()+"")%></textarea>
						<input type="hidden" name="dodatno_javascript_onload" id="dodatno_javascript_onload" value="">
						
						
						</td>
            		 
            		  </tr>
            		  
            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno insert:&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 
            		 	 <textarea id="dodatno_inserte" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_insert()+"")%></textarea>
            		 	 
            		 	 <input type="hidden" name="dodatno_insert" id="dodatno_insert" value="">
						
            		 	 
            		 	 
            		 <br>
            		 Pri dodatnih opcijah je potrebno definirat type vrednosti ki se vnese v class (tabelo) preko metode, ce je metoda tipa string mora biti vnesena vrednost tudi tipa string, primeri za razlicne type:<br>
            		 Long: <i>setImemetode</i>(new Long(<i>vrednost metode tipa string</i>)) npr: setKljuc(new Long(request.getParameter("idg")+""))<br>
            		 String: <i>setImemetode</i>(<i>vrednost metode tipa string</i>) <br>
            		 Integer: <i>setImemetode</i>(Integer.parseInt(<i>vrednost metode tipa string</i>)) <br>
            		 Double: <i>setImemetode</i>(Double.parseDouble(<i>vrednost metode tipa string</i>)) <br>
            		 
            		 
            		 <br>
            		 
            		    		<select id="im1" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
					com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

					
					//// dobim ime model clase iz headerja
					thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("idt"))));
					String class_name=thead.getHead_class_name();
					//// dobim ime model clase iz headerja
					//thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("sifid"))));
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","set") +")"%></option>
							<%	
					}
					%>
					</select>
            		 
            		 	<input type="text" id="im2" maxlength='100' size="50" value="" style="font-family: Verdana; font-size: 8pt">
            		 	 		<select id="funkcija2" style="font-family: Verdana; font-size: 8pt" onchange="setaj()"  >
					<option value=""></option>
            		 	<%
            		 	/// rezultat je lahko funkcija
            		 		com.popultrade.model.TemplateFunkcijaStart tfun =new com.popultrade.model.TemplateFunkcijaStart();
					com.popultrade.dao.TemplateFunkcijaStartDAO daof = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",pageContext.getServletContext());

					 li = daof.getTemplateFunkcijaStarts(tfun,1,1000);
					 System.out.println("FUNKK ::: "+li.size());
					 itti = li.iterator();
					while (itti.hasNext()) {
						com.popultrade.model.TemplateFunkcijaStart tfu = (com.popultrade.model.TemplateFunkcijaStart)itti.next();
            		 	%>
            		 	<option value="[F<%=tfu.getId()%>] <%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%>)"><%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%>)</option>
            		 	
            		 	<%
					}
            		 	%>
            		 	
            		 	
            		 	
            		 			 	<%
            		 	
            		 	Iterator peko = parame.iterator();
            		 	
            		 	while (peko.hasNext()) {
            		 		com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)peko.next();
            		 		
            		 		if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
            		 			%>
                		 		
                		 		<option value="<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()):nul.jeNull(tgpp.getDugacno_ime_parametra()))%>"><%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()):nul.jeNull(tgpp.getDugacno_ime_parametra()))%></option>
                		 		
                		 		<%
            		 		}
            		 		
            		 		else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
            		 		%>
            		 		
            		 		<option value="request.getParameter('<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))%>')">request.getParameter("<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))%>")</option>
            		 		
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
            		 	
            		 	
            		 <input type="button" value="V VREDNOST" onclick="dodajv()" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 &nbsp;</td>
            		 
            		  </tr><tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno update:&nbsp;</td><td class="valuecell" width="30%">
            		 	 
            		 	 
            		 	 	 <textarea id="dodatno_updatee" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_update()+"")%></textarea>
            		 	 	 
            		 	 	 <input type="hidden" name="dodatno_update" id="dodatno_update" value="">
						
            		 	 	 
            		 	 	 
            		  <br>
            		 	 Pri dodatnih opcijah je potrebno definirat type vrednosti ki se vnese v class (tabelo) preko metode, ce je metoda tipa string mora biti vnesena vrednost tudi tipa string, primeri za razlicne type:<br>
            		 Long: <i>setImemetode</i>(new Long(<i>vrednost metode tipa string</i>)) npr: setKljuc(new Long(request.getParameter("idg")+""))<br>
            		 String: <i>setImemetode</i>(<i>vrednost metode tipa string</i>) <br>
            		 Integer: <i>setImemetode</i>(Integer.parseInt(<i>vrednost metode tipa string</i>)) <br>
            		 Double: <i>setImemetode</i>(Double.parseDouble(<i>vrednost metode tipa string</i>)) <br>
            		 
            		 
            		
            		 
            		   		 
            		 <br> 
            		    		<select id="im11" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					
				
					
				
					//// dobim ime model clase iz headerja
					//thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("sifid"))));
					li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","set") +")"%></option>
							<%	
					}
					%>
					</select>
            		 
            		 	<input type="text" id="im22" maxlength='100' size="50" value="" style="font-family: Verdana; font-size: 8pt">
            		 	
            		 	
            		 	
            		 	      		 	 		<select id="funkcija22" style="font-family: Verdana; font-size: 8pt" onchange="setaj1()" >
					<option value=""></option>
            		 	<%
            		 	/// rezultat je lahko funkcija
            	
					 li = daof.getTemplateFunkcijaStarts(tfun,1,1000);
					 itti = li.iterator();
					while (itti.hasNext()) {
						com.popultrade.model.TemplateFunkcijaStart tfu = (com.popultrade.model.TemplateFunkcijaStart)itti.next();
            		 	%>
            		 	<option value="[F<%=tfu.getId()%>] <%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%>)"><%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%>)</option>
            		 	
            		 	<%
					}
            		 	%>
            		 	
            		 	
            		 	
            		 	
            		 	<%
            		 	
            		 	 peko = parame.iterator();
            		 	
            		 	while (peko.hasNext()) {
            		 		com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)peko.next();
            		 		if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
            		 			%>
                		 		
                		 		<option value="<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()):nul.jeNull(tgpp.getDugacno_ime_parametra()))%>"><%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()):nul.jeNull(tgpp.getDugacno_ime_parametra()))%></option>
                		 		
                		 		<%
            		 		}
            		 		
            		 		else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
            		 		%>
            		 		
            		 		<option value="request.getParameter('<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))%>')">request.getParameter("<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))%>")</option>
            		 		
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
            		 	
            		 	
            		 	
            		 <input type="button" value="V VREDNOST" onclick="dodajv2()" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		           		  		 &nbsp;</td>
            		 
        		 
</tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno setiranje default vrednosti pri add gumbu:&nbsp;</td><td class="valuecell" width="30%">
            		 	 	 <textarea id="dodatno_java_defaulte" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_java_default()+"")%></textarea>
            		 
            		 
            		  <input type="hidden" name="dodatno_java_default" id="dodatno_java_default" value="">
						
            		 
            		 
            		 	  <br>Setiramo default vrednosti ko kliknemo na gumb add (npr v datum dodamo sysdate itd).<br>
            		 	 Pri dodatnem setiranju default vrednosti pri add gumbu je potrebno definirat type vrednosti ki se vnese v class (tabelo) preko metode, ce je metoda tipa string mora biti vnesena vrednost tudi tipa string, primeri za razlicne type:<br>
            		 Long: <i>setImemetode</i>(new Long(<i>vrednost metode tipa string</i>)) npr: setKljuc(new Long(request.getParameter("idg")+""))<br>
            		 String: <i>setImemetode</i>(<i>vrednost metode tipa string</i>) <br>
            		 Integer: <i>setImemetode</i>(Integer.parseInt(<i>vrednost metode tipa string</i>)) <br>
            		 Double: <i>setImemetode</i>(Double.parseDouble(<i>vrednost metode tipa string</i>)) <br>
            		 
            		 
            		
            		 
            		   		 
            		 <br> 
            		    		<select id="im111" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					
				
					
				
					//// dobim ime model clase iz headerja
					//thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("sifid"))));
					li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","set")%>"><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","set") +")"%></option>
							<%	
					}
					%>
					</select>
            		 
            		 	<input type="text" id="im222" maxlength='100' size="50" value="" style="font-family: Verdana; font-size: 8pt">
            		 	
            		 	
            		 	
            		 	      		 	 		<select id="funkcija222" style="font-family: Verdana; font-size: 8pt" onchange="setaj22()" >
					<option value=""></option>
            		 	<%
            		 	/// rezultat je lahko funkcija
            	
					 li = daof.getTemplateFunkcijaStarts(tfun,1,1000);
					 itti = li.iterator();
					while (itti.hasNext()) {
						com.popultrade.model.TemplateFunkcijaStart tfu = (com.popultrade.model.TemplateFunkcijaStart)itti.next();
            		 	%>
            		 	<option value="[F<%=tfu.getId()%>] <%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%>)"><%=nul.jeNull(tfu.getIme_funkcije())%> (<%=nul.jeNull(tfu.getClass_name())%>)</option>
            		 	
            		 	<%
					}
            		 	%>
            		 	
            		 	
            		 	
            		 	
            		 	<%
            		 	
            		 	 peko = parame.iterator();
            		 	
            		 	while (peko.hasNext()) {
            		 		com.popultrade.model.TemplateGumbiParametri tgpp = (com.popultrade.model.TemplateGumbiParametri)peko.next();
            		 		if (nul.jeNull(tgpp.getStolpec_metoda()).indexOf("request.getParameter")!=-1) {
            		 			%>
                		 		
                		 		<option value="<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()):nul.jeNull(tgpp.getDugacno_ime_parametra()))%>"><%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()):nul.jeNull(tgpp.getDugacno_ime_parametra()))%></option>
                		 		
                		 		<%
            		 		}
            		 		
            		 		else if (!nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase().equals("id")) {
            		 		%>
            		 		
            		 		<option value="request.getParameter('<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))%>')">request.getParameter("<%=(nul.jeNull(tgpp.getDugacno_ime_parametra()).equals("")?nul.jeNull(tgpp.getStolpec_metoda()).replaceAll("get","").toLowerCase():nul.jeNull(tgpp.getDugacno_ime_parametra()))%>")</option>
            		 		
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
            		 	
            		 	
            		 	
            		 <input type="button" value="V VREDNOST" onclick="dodajv22()" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		 
            		           		  		 &nbsp;</td>
            		 
        		 
</tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java:&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_javae" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_java()+"")%></textarea>
            		  <input type="hidden" name="dodatno_java" id="dodatno_java" value="">
					
            		 
            		 </td>
            		 
        		 
</tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java (uporabi se za pridobivanje class iz drugih tabel, ki se potem uporabi za setiranje vrednosti, doda se v jsp v isti obliki kot je tu napisano)<br>V primeru, da gre za custom clase varianto je treba dati custom clase v list z imenom lis (ze deklariran):&nbsp;</td><td class="valuecell" width="30%">
            		 <textarea id="dodatno_java_rocnoe" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_java_rocno()+"")%></textarea>
            		  <input type="hidden" name="dodatno_java_rocno" id="dodatno_java_rocno" value="">
					
            		 </td>
            		 
        		 
</tr>
<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java 2 (uporabi se za pridobivanje class iz drugih tabel, ki se potem uporabi za setiranje vrednosti, doda se v jsp v isti obliki kot je tu napisano) -- ce je zgornji prekratek:&nbsp;</td><td class="valuecell" width="30%">
            		 <textarea id="dodatno_java_rocno2e" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_java_rocno2()+"")%></textarea>
            		 <input type="hidden" name="dodatno_java_rocno2" id="dodatno_java_rocno2" value="">
            		 
            		 </td>
            		 
        		 
</tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java test (uporabi se pred klicanjem inserta ali update, bok se setira v true , ce gre za napako, "napaka" je neznanka v katero se vpise opis napake, ki se prikaze v JS oknu, v primeru napake se ne izvede update ali insert):&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_java_teste" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 274px;"><%=nul.jeNull(vseb.getDodatno_java_test()+"")%></textarea>
            		 <input type="hidden" name="dodatno_java_test" id="dodatno_java_test" value="">
            		 
            		 </td>
            		 
        		 
</tr>


<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java po update,insert ali funkcija (uporabi se po klicanju inserta,funkcije ali update, prepise se tocno kot pise v textarea):&nbsp;</td><td class="valuecell" width="30%">
            		 <textarea id="dodatno_java_updateinserte" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 674px;"><%=nul.jeNull(vseb.getDodatno_java_updateinsert()+"")%></textarea>
            		 
            		 <input type="hidden" name="dodatno_java_updateinsert" id="dodatno_java_updateinsert" value="">
            		 
            		 
            		 <br>
            		 Ne uporabi avtomaticni insert (se ne generira insert del strani, ce pogoj ustreza format if (###POGOJ###)): 
            		   <input type="text" size="70" maxlength="75" id="dodatno_delete" value="<%=nul.jeNull(vseb.getDodatno_delete()+"")%>"  style="font-family: Verdana; font-size: 8pt">
    
            		 </td>
            		 
            		 
            		 
            		  
            		 
        		 
</tr>
<tr>
            		  
            	   		 <td class="opiscell" width="20%">Dodatno html (doda se pred potrdi gumb - pred tr) / vrednost se da po ! v java kodi za funkcije:&nbsp;</td><td class="valuecell" width="30%">
            	   		 <textarea id="dodatno_htmle" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_html()+"")%></textarea>
            	   		 
            	   		  <input type="hidden" name="dodatno_html" id="dodatno_html" value="">
            		
            	   		 </td>
           
        		 
</tr>
<tr>
            		  
            	   		 <td class="opiscell" width="20%">Dodatno html2 (doda se pred potrdi gumb - pred tr) pod dodatno html:&nbsp;</td><td class="valuecell" width="30%">
            	   		 <textarea id="dodatno_html2e" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_html2()+"")%></textarea>
            	   		 
            	   		 <input type="hidden" name="dodatno_html2" id="dodatno_html2" value="">
            	   		 
            	   		 </td>
           
        		 
</tr>
<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno css (doda se na zacetek strani - <b>Samo za novi del aplikacije</b>):&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_csse" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 274px;"><%=nul.jeNull(vseb.getDodatno_css()+"")%></textarea>
            		 
            		 <input type="hidden" name="dodatno_css" id="dodatno_css" value="">
            		 
            		 </td>
            		 
        		 
</tr>
<tr><td colspan="2" class="opiscell" align="center"><input type=button value="Repository" onclick="window.open('<%=ConPool.getRepository_url() %>code?pagena=<%=ConPool.extractPageNameFromURLString(request.getRequestURI()) %>', 'PgRepository','menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes')" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr>
<tr><td colspan="2" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>

var editor1 = ace.edit("dodatno_javascript2e");
editor1.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor1.setTheme("ace/theme/chrome");
editor1.renderer.setOption("showLineNumbers", true); 
editor1.getSession().setMode("ace/mode/javascript");


var editor2 = ace.edit("dodatno_javascripte");
editor2.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor2.setTheme("ace/theme/chrome");
editor2.renderer.setOption("showLineNumbers", true); 
editor2.getSession().setMode("ace/mode/javascript");


var editor3 = ace.edit("dodatno_javascript_funkcijee");
editor3.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor3.setTheme("ace/theme/chrome");
editor3.renderer.setOption("showLineNumbers", true); 
editor3.getSession().setMode("ace/mode/javascript");


var editor4 = ace.edit("dodatno_javascript_onloade");
editor4.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor4.setTheme("ace/theme/chrome");
editor4.renderer.setOption("showLineNumbers", true); 
editor4.getSession().setMode("ace/mode/javascript");


var editor5 = ace.edit("dodatno_inserte");
editor5.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor5.setTheme("ace/theme/chrome");
editor5.renderer.setOption("showLineNumbers", true); 
editor5.getSession().setMode("ace/mode/java");



var editor6 = ace.edit("dodatno_updatee");
editor6.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor6.setTheme("ace/theme/chrome");
editor6.renderer.setOption("showLineNumbers", true); 
editor6.getSession().setMode("ace/mode/java");



var editor7 = ace.edit("dodatno_java_defaulte");
editor7.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor7.setTheme("ace/theme/chrome");
editor7.renderer.setOption("showLineNumbers", true); 
editor7.getSession().setMode("ace/mode/java");



var editor8 = ace.edit("dodatno_javae");
editor8.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor8.setTheme("ace/theme/chrome");
editor8.renderer.setOption("showLineNumbers", true); 
editor8.getSession().setMode("ace/mode/java");

var editor9 = ace.edit("dodatno_java_rocnoe");
editor9.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor9.setTheme("ace/theme/chrome");
editor9.renderer.setOption("showLineNumbers", true); 
editor9.getSession().setMode("ace/mode/java");


var editor10 = ace.edit("dodatno_java_rocno2e");
editor10.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor10.setTheme("ace/theme/chrome");
editor10.renderer.setOption("showLineNumbers", true); 
editor10.getSession().setMode("ace/mode/java");




var editor11 = ace.edit("dodatno_java_teste");
editor11.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor11.setTheme("ace/theme/chrome");
editor11.renderer.setOption("showLineNumbers", true); 
editor11.getSession().setMode("ace/mode/java");

var editor12 = ace.edit("dodatno_java_updateinserte");
editor12.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor12.setTheme("ace/theme/chrome");
editor12.renderer.setOption("showLineNumbers", true); 
editor12.getSession().setMode("ace/mode/java");


var editor13 = ace.edit("dodatno_htmle");
editor13.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor13.setTheme("ace/theme/chrome");
editor13.renderer.setOption("showLineNumbers", true); 
editor13.getSession().setMode("ace/mode/html");


var editor14 = ace.edit("dodatno_html2e");
editor14.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor14.setTheme("ace/theme/chrome");
editor14.renderer.setOption("showLineNumbers", true); 
editor14.getSession().setMode("ace/mode/html");




var editor15 = ace.edit("dodatno_csse");
editor15.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor15.setTheme("ace/theme/chrome");
editor15.renderer.setOption("showLineNumbers", true); 
editor15.getSession().setMode("ace/mode/css");















function check() {
	

	document.getElementById("dodatno_javascript2").value = editor1.getValue();
	//alert(12);
document.getElementById("dodatno_javascript").value = editor2.getValue();
	
	document.getElementById("dodatno_javascript_funkcije").value = editor3.getValue();
	
	
	document.getElementById("dodatno_javascript_onload").value = editor4.getValue();
	document.getElementById("dodatno_insert").value = editor5.getValue();
	
	document.getElementById("dodatno_update").value = editor6.getValue();
document.getElementById("dodatno_java_default").value = editor7.getValue();

document.getElementById("dodatno_java").value = editor8.getValue();
		document.getElementById("dodatno_java_rocno").value = editor9.getValue();
				document.getElementById("dodatno_java_rocno2").value = editor10.getValue();
				
				
				document.getElementById("dodatno_java_test").value = editor11.getValue();
						document.getElementById("dodatno_java_updateinsert").value = editor12.getValue();
							
							
						document.getElementById("dodatno_html").value = editor13.getValue();
								document.getElementById("dodatno_html2").value = editor14.getValue();
										document.getElementById("dodatno_css").value = editor15.getValue();
}







function dodajv() {
	editor5.setValue(editor5.getValue() + " "+
	document.getElementById("im1").value + (document.getElementById("im2").value.indexOf("request.getPara")!=-1?"(":"(")+ 
			document.getElementById("im2").value + (document.getElementById("im2").value.indexOf("request.getPara")!=-1?")":")")+";\r\n");

}
function setaj1() {

	document.getElementById("im22").value =
			document.getElementById("funkcija22").value + "";

}
function setaj22() {

	document.getElementById("im222").value =
			document.getElementById("funkcija222").value + "";

}
function setaj() {

	document.getElementById("im2").value =
			document.getElementById("funkcija2").value + "";






}


function dodajv2() {
	editor6.setValue(editor6.getValue()+ " "+
document.getElementById("im11").value + (document.getElementById("im22").value.indexOf("request.getPara")!=-1?"(":"(")+ 
document.getElementById("im22").value + (document.getElementById("im22").value.indexOf("request.getPara")!=-1?")":")")+";\r\n");

}

function dodajv22() {
	editor7.setValue(editor7.getValue() + " "+
document.getElementById("im111").value+ (document.getElementById("im222").value.indexOf("request.getPara")!=-1?"(":"(")+ 
document.getElementById("im222").value + (document.getElementById("im222").value.indexOf("request.getPara")!=-1?")":")")+";\r\n");

}

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