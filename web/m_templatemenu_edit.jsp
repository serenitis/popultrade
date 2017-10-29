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
com.popultrade.model.TemplateMenu vseb =new com.popultrade.model.TemplateMenu();
com.popultrade.dao.TemplateMenuDAO dao = (com.popultrade.dao.TemplateMenuDAO)contextUtil.getBeanDao("templateMenuDAO",pageContext.getServletContext());


if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateMenu(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {
	vseb = (com.popultrade.model.TemplateMenu)contextUtil.getPopulatedObject(vseb,request);
	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateMenu(new Long(request.getParameter("id")));
	
	}
	else {
		vseb = (com.popultrade.model.TemplateMenu)contextUtil.getPopulatedObject(vseb,request);
		if (!nul.jeNull(request.getParameter("idd")).equals("")) {	
vseb.setTemplatemenu_id(new Long(request.getParameter("idd")+""));
		}
	
	}
	if (!nul.jeNull(request.getParameter("templatehead_id")).equals("")) {	
		vseb.setTemplatehead_id(new Long(request.getParameter("templatehead_id")+""));
				}
	if (!nul.jeNull(request.getParameter("zaporedje")).equals("")) {	
		vseb.setZaporedje(Integer.parseInt(request.getParameter("zaporedje")+""));
				}
	if (!nul.jeNull(request.getParameter("dodatni_pogoji")).equals("")) {	
		vseb.setDodatni_pogoji(request.getParameter("dodatni_pogoji")+"");
				}
	
	if (!nul.jeNull(request.getParameter("menu_naziv")).equals("")) {	
		vseb.setMenu_naziv(request.getParameter("menu_naziv")+"");
				}
	if (!nul.jeNull(request.getParameter("rocen_url")).equals("")) {	
		vseb.setRocen_url(request.getParameter("rocen_url")+"");
				}
				
	//if (!nul.jeNull(request.getParameter("pogoj_prikaza")).equals("")) {	
		vseb.setPogoj_prikaza(request.getParameter("pogoj_prikaza")+"");
			//	}
	vseb.setMenu(new Long(session.getAttribute("menut")+""));		
		
		vseb.setShow_wo_login(nul.jeNull(request.getParameter("show_wo_login")).equals("1")?"1":"0");
		vseb.setSplit_frame_v(nul.jeNull(request.getParameter("split_frame_v")).equals("1")?"1":"0");
		vseb.setSplit_frame_h(nul.jeNull(request.getParameter("split_frame_h")).equals("1")?"1":"0");
		
		
		if (!nul.jeNull(request.getParameter("okno11")).equals("")) {	
			vseb.setOkno11(request.getParameter("okno11")+"");
					}
		else {
			vseb.setOkno11(null);
		}
		
		if (!nul.jeNull(request.getParameter("okno22")).equals("")) {	
			vseb.setOkno22(request.getParameter("okno22")+"");
					}
		else {
			vseb.setOkno22(null);
		}
		
		
		
		
				
dao.saveTemplateMenu(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("ime pogoja","menu_naziv");
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

<form name=dod action="m_templatemenu_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idd" value="<%=nul.jeNull(request.getParameter("idd")+"")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>

            		  <tr>
            		  
            		 <td class="opiscell" width="20%"> <%=("1".matches(".*(1|2).*")) %>   Naziv polja v meniju: </td><td class="valuecell" width="30%">
            		 
 <input type="text" name="menu_naziv" maxlength='35' size="20" value="<%=nul.jeNull(vseb.getMenu_naziv()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Zaporedje: </td><td class="valuecell" width="30%">
            		 
            		 <input type="text" name="zaporedje" maxlength='4' size="4" value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 	  
            		 </td>
            		 
            		  </tr>
            		  
            		  
            		              		  <tr>
            		  
            		 <td class="opiscell" width="20%">Veza na template: </td><td class="valuecell" >
            		
            		
            			  		 <select name="templatehead_id" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
            		
            		<%
            		
            		com.popultrade.dao.TemplateHeadDAO daog = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
            		
            		
            		List lisg = daog.getTemplateHeads(new com.popultrade.model.TemplateHead(),1,1000);
            		Iterator itg = lisg.iterator();


            		while (itg.hasNext()){  // while start
            			
            			com.popultrade.model.TemplateHead vsebg = (com.popultrade.model.TemplateHead)(itg.next());
            		
            		
            		%>
            		<option value="<%=vsebg.getId()%>" <%=(vsebg.getId().toString().equals(nul.jeNull(vseb.getTemplatehead_id()+""))?"selected":"")%>><%=nul.jeNull(vsebg.getHead_naziv())%></option>
            		<%
            		
            		
            		
            		}
            		%>
            		
            		
            		</select>
            		 
            		 
            		 
            		 
            		 </td>
            		 <td class="opiscell" width="20%">Dodatni pogoji (dodatni pogoji ki se dodajo na koncu linka (preko get metode), za ? se doda QUE za & znak pa AND, requestParameter se doda rocno v pogoje prikaza template-ja): </td>
            <td class="valuecell" width="30%">
            		 
            		 <input type="text" name="dodatni_pogoji" maxlength='70' size="40" value="<%=nul.jeNull(vseb.getDodatni_pogoji()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 	  
            		 </td>
            		 
            		  </tr>
            		  
            	          		  <tr>
            		  
            		 <td class="opiscell" width="20%">Menu prikazi tudi brez logina (samo za touch varianto): </td><td class="valuecell" width="30%">
            		 
         		 
            		    <input type="checkbox" name="show_wo_login"  value="1" <%=nul.jeNull(vseb.getShow_wo_login()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
            
             		 
            		 
            		 </td>
            		 
            		 <td class="opiscell" width="20%">Odpri v split frame:</td><td class="valuecell" width="30%">
Vertikalno (|):<input type="checkbox" name="split_frame_v"  value="1" <%=nul.jeNull(vseb.getSplit_frame_v()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt"><br>
Horizontalno (-):<input type="checkbox" name="split_frame_h"  value="1" <%=nul.jeNull(vseb.getSplit_frame_h()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
        
            	
            		 	  
            		 </td>
            		 
            		  </tr>	
            		  
            		  
            		  
            		  
            		     		  <tr>
            		  
            		 <td class="opiscell" width="20%">Pogoj prikaza izbire menijev pod edit userja, veza na skupina polje v bazi, vrednost v polju se primerja z vrednostjo v polju skupina (rabi regular expression, npr.:  .*(1|2).*  )  : </td><td class="valuecell" >
            		 
         		 
            		 <input type="text" name="pogoj_prikaza" maxlength='400' size="40" value="<%=nul.jeNull(vseb.getPogoj_prikaza()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
         
            		  <td class="opiscell" width="20%">Splitan frame velikosti (v %):</td><td class="valuecell" width="30%">
Okno 1: <input type="text" name="okno11" maxlength='2' size="4" value="<%=nul.jeNull(vseb.getOkno11()+"")%>" style="font-family: Verdana; font-size: 8pt"><br>
Okno 2: <input type="text" name="okno22" maxlength='2' size="4" value="<%=nul.jeNull(vseb.getOkno22()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		
        
            	
            		 	  
            		 </td>
            		  </tr>	
            		  
            		  
            		    <tr>
            		  
            		 <td class="opiscell" width="20%">Rocen URL: </td><td class="valuecell" >
            		 
         		 
            		 <input type="text" name="rocen_url" maxlength='90' size="60" value="<%=nul.jeNull(vseb.getRocen_url()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
            		 </td>
            		 
         
            		  <td class="opiscell" width="20%">Dodaten pogoj prikaza menija (vrednost):</td><td class="valuecell" width="30%">
       		
       		
         <input type="text" name="dodaten_pogoj" maxlength='250' size="70" value="<%=nul.jeNull(vseb.getDodaten_pogoj()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 <br>
            		 To vrednost se primerja z zeleno vrednostjo npr: |DODATEN POGOJ|=control.get...
            	
            		 	  
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

  parent.frames[1].document.location = "m_templatemenu.jsp";


</script>

<%
}

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>