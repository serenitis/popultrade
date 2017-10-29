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
com.popultrade.model.Users vseb =new com.popultrade.model.Users();
com.popultrade.dao.UsersDAO dao = (com.popultrade.dao.UsersDAO)contextUtil.getBeanDao("usersDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getUsers(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
 
else if (request.getParameter("akcija")!=null)  {
 
if (!bok) {
 
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getUsers(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	
	
 
vseb = (com.popultrade.model.Users)contextUtil.getPopulatedObject(vseb,request);

vseb.setStatus(nul.jeNull(request.getParameter("status")).equals("1")?"1":"0");

if (nul.jeNull(request.getParameter("cserial")).equals("")) {
	
	vseb.setCserial(null);
	vseb.setCdateto(null);
	vseb.setCinfo(null);
	
}

//vseb.setParameter01(nul.jeNull(request.getParameter("parameter01")).equals("1")?"1":"0");
vseb.setParameter09(nul.jeNull(request.getParameter("parameter09")).equals("1")?"1":"0");
vseb.setParameter08(nul.jeNull(request.getParameter("parameter08")).equals("1")?"1":"0");
vseb.setParameter07(nul.jeNull(request.getParameter("parameter07")).equals("1")?"1":"0"); /// rabi JS DB

dao.saveUsers(vseb);




//// insert privilegij


com.popultrade.dao.UsersPrivilegijeDAO daoup = (com.popultrade.dao.UsersPrivilegijeDAO)contextUtil.getBeanDao("usersPrivilegijeDAO",pageContext.getServletContext());


///  brisem


daoup.deleteByUser_id(vseb.getId()+"");


/// dodam
com.popultrade.dao.UsersPrivilegijeDAO daoup2 = (com.popultrade.dao.UsersPrivilegijeDAO)contextUtil.getBeanDao("usersPrivilegijeDAO",pageContext.getServletContext());

Enumeration enu = request.getParameterNames();

while (enu.hasMoreElements()) {
	
	String zum = (String)enu.nextElement();
	
	
	if (zum.startsWith("cb_")) {
		
		com.popultrade.model.UsersPrivilegije upr = new com.popultrade.model.UsersPrivilegije();
		
		upr.setId_menija(new Long(request.getParameter(zum)));
		upr.setMeni_viden("1"); 
		upr.setUser_id(vseb.getId());
		
		
		daoup2.saveUsersPrivilegije(upr);
		
		
	}
	
	
	
	
}




 
}
}
 
Hashtable ht =new Hashtable();


ht.put("uporabnisko ime","username");
ht.put("vrsta uporabnika","privilegij");
ht.put("geslo","passwordn");

ht.put("podjetje","USP_OZNNAR");

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
 
<form name=dod action="m_users_edit.jsp" method="post" onSubmit="return check()">
 
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


if (nul.jeNull(request.getParameter("isk")).equals("1")) {
	%>
	<input type=hidden name="isk" value="1">
	<%
}
%>
 
 
 
 
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
 <input type=hidden name="idback" value="<%=nul.jeNull(vseb.getId()+"")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
 
 
 
 <tr>
            		  
            		 <td class="opiscell" width="20%">Ime: </td><td class="valuecell" width="30%">
            		 
            		  <input type="text" name="ime" value="<%=nul.jeNull(vseb.getIme())%>" size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell" width="20%">Priimek: </td><td class="valuecell" width="30%">
            		 
            		   <input type="text" name="priimek" value="<%=nul.jeNull(vseb.getPriimek())%>" size="35" maxlength="35" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr>
 
 
 
 <tr>
            		  
            		 <td class="opiscell">Skupina (rabi se za definicijo privilegij U userjev in kot primerjava pogoja za prikaz izbire menijev): </td><td class="valuecell">
            		 <input type="text" name="skupina" value="<%=nul.jeNull(vseb.getSkupina())%>" size="3" maxlength="3" style="font-family: Verdana; font-size: 8pt">
        	ce ni vrednosti pokaze izbiro vseh menijev
        	</td>
            		 
            		 <td class="opiscell">Jezik: </td><td class="valuecell">
            		 
            			<select name="jezik" style="font-family: Verdana; font-size: 8pt" >
            			<option value=""></option>
            			<%
            				com.popultrade.dao.JezikiDAO daosi = (com.popultrade.dao.JezikiDAO)contextUtil.getBeanDao("jezikiDAO",pageContext.getServletContext());
					List lil = daosi.getJezikis(new com.popultrade.model.Jeziki());

					Iterator itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Jeziki sifr = (com.popultrade.model.Jeziki)itti.next();
						if (nul.jeNull(vseb.getJezik()).equals(nul.jeNull(sifr.getSIFRA_JEZ()))) {
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
					
					
					</select></td>
            		 
            		  </tr>
 
 
 
 <tr>
            		  
            		 <td class="opiscell">Vrsta uporabnika: </td><td class="valuecell">
            		 
					<select name="privilegij" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<option value="A" <%=nul.jeNull(vseb.getPrivilegij()).equals("A")?"selected":""%>>Administrator</option>
					
					<option value="U" <%=nul.jeNull(vseb.getPrivilegij()).equals("U")?"selected":""%>>Uporabnik</option>
					</select></td>
            		 
            		 <td class="opiscell">Uporabnik aktiven: </td><td class="valuecell">
            		 
        		  <input type="checkbox" name="status" value="1" <%=nul.jeNull(vseb.getStatus()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr>
 
 
 
 <tr>
            		  
            		 <td class="opiscell">Uporabnisko ime: </td><td class="valuecell">
            		 
            		 <input type="text" name="username" maxlength='12' value="<%=nul.jeNull(vseb.getUsername()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell">Geslo: </td><td class="valuecell">
            		 
            		 <input type="text" name="geslo" maxlength='12' value="<%=nul.jeNull(vseb.getGeslo()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		  </tr>
 
 

 

 
		  
  <tr>
            		  
            		 <td class="opiscell">Email: </td><td class="valuecell">
            		 
            		 <input type="text" name="e_mail" maxlength='70' size='65' value="<%=nul.jeNull(vseb.getE_mail()+"")%>" style="font-family: Verdana; font-size: 8pt"></td>
            		 
            		 <td class="opiscell">Pregled kontaktov: </td><td class="valuecell">
            		 
            		  <input type="checkbox" name="kontakti" value="1" <%=nul.jeNull(vseb.getKontakti()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"></td>
            	
            		  </tr>
 
 
    <tr>
            		  
            		 <td class="opiscell">Leader user (user, ki lahko dela jobe (parameter02)): </td><td class="valuecell">
            		 
            	 <input type="checkbox" name="parameter02" value="1" <%=nul.jeNull(vseb.getParameter02()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		 	 </td>
            		 
            		 <td class="opiscell">Super user (user, ki lahko dela vse in gleda vse (parameter03)):
            		</td><td class="valuecell">
            		 <input type="checkbox" name="parameter03" value="1" <%=nul.jeNull(vseb.getParameter03()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
            		  </td>
            	
            		  </tr>
 
 
 
   <tr>
            		  
            		 <td class="opiscell">Uporabi nalaganje sifranta po kliku na gumb potrdi: </td><td class="valuecell">
            		 
            	 <input type="checkbox" name="parameter09" value="1" <%=nul.jeNull(vseb.getParameter09()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		 	 </td>
            		 
            		 <td class="opiscell">Uporabi Javascript Database za dropdown (tabele morajo biti izbrane za JS DB, ob vsaki spremembi
            		 baze je potrebno ponovno generirat JS DB): </td><td class="valuecell">
            		  <input type="checkbox" name="parameter07" value="1" <%=nul.jeNull(vseb.getParameter07()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            	
            		  </td>
            	
            		  </tr>
 
    	  <tr>
            		  
            		 <td class="valuecell" colspan="4" height="30"><strong>Certifikat</strong> 
            		 
            		 <%
            		 if (!nul.jeNull(vseb.getCcert()).equals("")) {
            		 %>
            		 
            		 <a href="certifikati/<%=vseb.getCcert()+"" %>" ><%=vseb.getCcert()+"" %></a> | 
            		 Geslo: <%=vseb.getCgeslo() %> | 
            		 CA certifikat: <a href="certifikati/ca.crt" >ca.crt</a>
            		 <%
            		 }
            		 %>
            		 
            		 </td></tr>
            		 
            		   	  <tr>
            		   	  
         <tr>
            		  
            		 <td class="opiscell">Zahtevaj certifikat za logiranje: </td><td class="valuecell">
            		 
            	 <input type="checkbox" name="parameter08" value="1" <%=nul.jeNull(vseb.getParameter08()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            		 	 </td>
            		 
            		 <td class="opiscell"> Odstrani certifikat (reset certifikata , tako da se lahko logira z novim):</td><td class="valuecell">
            		 <%
            		 if (vseb.getId()!=null) {
            		 %>
            		 
            		 <input type="button" style="font-family: Verdana; font-size: 8pt" value="Reset Certificate" onclick="resetCer('<%=vseb.getId() %>')" >
            		 
            		 <%
            		 }
            		 %>
            		 
            		  </td>
            	
            		  </tr>
            		   	  
            		   	  
            		   	  
    <tr>
            		  
            		 <td class="opiscell">Serijska stevilka certifikata: </td><td class="valuecell">
            		 <%=nul.jeNull(vseb.getCserial()) %>
            		 
  <input type="hidden" name="cserial"  value="<%=nul.jeNull(vseb.getCserial()+"")%>" >
            		           		 
            	 	 </td>
            		 
            		 <td class="opiscell">Datum trajanja do: </td><td class="valuecell">
            		 
            		 <%
            		 if (vseb.getCdateto()!=null) {
            		 %>
            		 <%=nul.getDatumFormatFromDate(vseb.getCdateto(),"dd-MM-yyyy") %>
            		 
            		 Do poteka dni: <%=(vseb.getCdateto().getTime()- ((new Date()).getTime()))/(1000*60*60*24) %>
            		 <%
            		 }
            		 %>
            		  </td>
            	
            		  </tr>
 
     <tr>
            		  
            		 <td class="opiscell">Info: </td><td class="valuecell" colspan=3>
            		 <%=nul.jeNull(vseb.getCinfo()) %>
            	 	 </td>
            		 
            		
            		  </tr>
 
 
 
   	  <tr>
            		  
            		 <td class="valuecell" colspan="4" height="30"><strong>Privilegije za menije</strong></td></tr>
            		 
            		   	  <tr>
            		  
            		 <td class="valuecell" colspan="4" height="30">
            		 
 <table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" ><tr>
 <%
 
 
 if (vseb.getId()!=null) {
 
 //// privilegije
 
 
 //List lico = vseb.getUsersprivilegijes();
 com.popultrade.dao.UsersPrivilegijeDAO daoup = (com.popultrade.dao.UsersPrivilegijeDAO)contextUtil.getBeanDao("usersPrivilegijeDAO",pageContext.getServletContext());

 List lico = daoup.getUsersPrivilegijeByUserid(request.getParameter("id"));
 
 Iterator ito = lico.iterator();
 
 Hashtable priv = new Hashtable();
 
 int sttmenu = 0;
 while (ito.hasNext()) {
	 
	 com.popultrade.model.UsersPrivilegije uprr = (com.popultrade.model.UsersPrivilegije)ito.next();
	 
	 
	 priv.put(uprr.getId_menija()+"","1");
	 
	 sttmenu++;
	 
 }
 
 System.out.println("::::::::::::::::::::::::::::::::::::::::::::::");
 
 System.out.println("::::::::::::::::::::::::::::::::::::::::::::::"+sttmenu);
 
 System.out.println("::::::::::::::::::::::::::::::::::::::::::::::");
 
 
 	/////// dodatno iz template
	
	com.popultrade.dao.TemplateMenuDAO daotm = (com.popultrade.dao.TemplateMenuDAO)contextUtil.getBeanDao("templateMenuDAO",pageContext.getServletContext());

	
	
	
	
	com.popultrade.model.TemplateMenu sif = new com.popultrade.model.TemplateMenu();



	int strec = daotm.getStTemplateMenu(sif);


	 
	List lisi =null;

	lisi = daotm.getTemplateMenus(sif,1,1000);
	String[] barve = new String[2];
	
	barve[0] = "add9ff";
	barve[1] = "8fcaff";
	int bum  =0;
	Iterator itf = lisi.iterator();
	while (itf.hasNext()) {
		com.popultrade.model.TemplateMenu tmenu = (com.popultrade.model.TemplateMenu)itf.next();
		
		
		
		
		
		bum++;
		if (bum==2) {
			bum=0;
		}
		
		if (nul.jeN(tmenu.getPogoj_prikaza()).equals("") || nul.jeN(vseb.getSkupina()).matches(tmenu.getPogoj_prikaza()) || nul.jeN(vseb.getSkupina()).equals("")) {
		
		
		%>
<td valign="top" bgcolor="<%=barve[bum]%>">

 <table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" >
 <tr><td bgcolor="70bafc"><input type="checkbox" name="cb_0_<%=tmenu.getId()%>" <%=priv.containsKey(tmenu.getId()+"")?"checked":""%> value="<%=tmenu.getId()%>" onclick="oznaci_vse('<%=tmenu.getId()%>')">
<%=ConPool.getPrevod(tmenu.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>
</td></tr>

		
		

		<%
		Iterator ihn = tmenu.getTemplatemenus().iterator();
		
		while (ihn.hasNext()) {
			com.popultrade.model.TemplateMenu tmenu2 = (com.popultrade.model.TemplateMenu)ihn.next();
			
			String kolo = "";
			
			if (tmenu2.getTemplatehead_id()!=null) {
				try {
				com.popultrade.dao.TemplateHeadDAO daoh = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

				com.popultrade.model.TemplateHead thed = daoh.getTemplateHead(tmenu2.getTemplatehead_id());
				
				if (nul.jeNull(thed.getHead_tip()).equals("UI")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_edit.jsp";
				}
				else if (nul.jeNull(thed.getHead_tip()).equals("HE")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_view.jsp";
				}
			//	else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
			//		kolo = thed.getHead_class_name().toLowerCase()+ ".jsp";
			//	}
				else if (nul.jeNull(thed.getHead_tip()).equals("SE")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_isci.jsp";
				}
				else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
					kolo = thed.getHead_class_name().toLowerCase()+ "_list"+thed.getId()+".jsp";
				}
				
				
			}
			catch (Exception eeex) {
				
			}
				
			}
			
			%>

		


<%

if (tmenu2.getTemplatemenus().size()>0) {

			Iterator ihni = tmenu2.getTemplatemenus().iterator();
			
			
			
			
%>	<tr><td>
	&nbsp; <input type="checkbox"  <%=priv.containsKey(tmenu2.getId()+"")?"checked":""%>  name="cb_<%=tmenu.getId()%>_<%=tmenu2.getId()%>" value="<%=tmenu2.getId()%>"> <%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>
	</td></tr>
<tr><td>

 <table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" >

<%

			while (ihni.hasNext()) {
				com.popultrade.model.TemplateMenu tmenu3 = (com.popultrade.model.TemplateMenu)ihni.next();
				
				String koloi = "";
				
				if (tmenu3.getTemplatehead_id()!=null) {
					try {
					com.popultrade.dao.TemplateHeadDAO daoh = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

					com.popultrade.model.TemplateHead thed = daoh.getTemplateHead(tmenu3.getTemplatehead_id());
					
					if (nul.jeNull(thed.getHead_tip()).equals("UI")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_edit.jsp";
					}
					else if (nul.jeNull(thed.getHead_tip()).equals("HE")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_view.jsp";
					}
					//else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
					//	koloi = thed.getHead_class_name().toLowerCase()+ ".jsp";
				//	}
					else if (nul.jeNull(thed.getHead_tip()).equals("SE")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_isci.jsp";
					}
					else if (nul.jeNull(thed.getHead_tip()).equals("LI")) {
						koloi = thed.getHead_class_name().toLowerCase()+ "_list"+thed.getId()+".jsp";
					}
					
				}
				catch (Exception eeex) {
					
				}
					
				}
				if (nul.jeN(tmenu3.getPogoj_prikaza()).equals("") || nul.jeN(vseb.getSkupina()).matches(tmenu3.getPogoj_prikaza()) || nul.jeN(vseb.getSkupina()).equals("")) {
					
				%>

<tr><td>
				&nbsp; &nbsp; &nbsp; <input type="checkbox"  <%=priv.containsKey(tmenu3.getId()+"")?"checked":""%>  name="cb_<%=tmenu.getId()%>_<%=tmenu3.getId()%>" value="<%=tmenu3.getId()%>"> <%=ConPool.getPrevod(tmenu3.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>
		</td></tr>	 
				<%
				}
			}

%>
</table>
</td></tr>

<%

}
else {
	if (nul.jeN(tmenu2.getPogoj_prikaza()).equals("") || nul.jeN(vseb.getSkupina()).matches(tmenu2.getPogoj_prikaza()) || nul.jeN(vseb.getSkupina()).equals("")) {
		
	%>
	<tr><td>
	&nbsp; <input type="checkbox"  <%=priv.containsKey(tmenu2.getId()+"")?"checked":""%>  name="cb_<%=tmenu.getId()%>_<%=tmenu2.getId()%>" value="<%=tmenu2.getId()%>"> <%=ConPool.getPrevod(tmenu2.getId()+"P"+control.getJezik()).replaceAll("'","").replaceAll("\"","")%>
	</td></tr>
	<%
	}
}


			 
	
			
		}
		
		%>

</table>
</td>
		

		<%
	}
		 
	}
	
 }
	

%>
</tr>
</table>

</td></tr>
 
 
 
 
 
 
 
 
 
 
 
 
 
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'> 


function oznaci_vse(idgl) {

all = eval("document.dod.cb_0_"+idgl);
for (i=0; i<document.dod.elements.length; i++) {


if (document.dod.elements[i].name.indexOf("cb_"+idgl)!=-1) {
if (all.checked==true) {
document.dod.elements[i].checked=true;
}
else if (all.checked==false) {
document.dod.elements[i].checked=false;
}

}


//document.write("The field name is: " + document.FormName.elements[i].name + " and its value is: " + document.FormName.elements[i].value + ".<br />");


}

}



function resetCer(idcer) {
	
	
	var cot = confirm("Zelis resetirat certifikat?");
	
	if (cot) {
		
		document.dod.cserial.value="";
		document.dod.submit();
	}
	
}



function custom() {
 
 
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
<p align="center">PODATKI VNESENI/SPREMENJENI</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
 
<script language=javascript> 
function mom() {
}


parent.frames[1].document.location = parent.frames[1].document.location;

</script>
 
<%
}
 
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>