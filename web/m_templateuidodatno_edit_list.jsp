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


dao.saveTemplateUiDodatno(vseb);

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
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<body   style="margin: 0"  <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateuidodatno_edit.jsp" method="post" onSudbmit="return check()">

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
            		  
            		 <td class="opiscell" width="20%">Dodatno delete (izberes id ki se veze na glavo dokumenta), poleg tega je potrebno poslati parameter oz ime polja zaporedne stevilke preko gumba za brisat:&nbsp;</td><td class="valuecell" width="30%">
    
            		 	 		<select name="dodatno_delete" style="font-family: Verdana; font-size: 8pt"   >
					<option value=""></option>
					
					<%
					
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
					com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

					
					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
         			List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","")%>" <%=(nex.substring(0,nex.indexOf(" ----XXX---- ")).replaceAll("get","")).equals(vseb.getDodatno_delete())?"selected":""%>><%=nex.replaceAll(" ----XXX---- "," (").replaceAll("get","") +")"%></option>
							<%	
					}
       
            		 	
            		 	%>
            		 	
            		 	</select>
          
            		 
            		 &nbsp;</td>
            		 
            		  </tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java pri delete:&nbsp;</td><td class="valuecell" width="30%">
            		 	 	 <textarea name="dodatno_java" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 174px;"><%=nul.jeNull(vseb.getDodatno_java()+"")%></textarea>
            		 
            		 
            		 
            		 
            		 
            		 	  <br>
            		 Veljajo samo funkcije
            		 
            		
            		 
            		   		 
            		 <br> 
            		    		<select name="im111" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
				
					</select>
            		 
            		 	<input type="text" name="im222" maxlength='100' size="50" value="" style="font-family: Verdana; font-size: 8pt">
            		 	
            		 	
            		 	
            		 	      		 	 		<select name="funkcija222" style="font-family: Verdana; font-size: 8pt" onchange="setaj22()" >
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
            		 	
            		 	
            	
            		 	
            
            		 	
    
            		 	
            		 	%>
            		 	
            		 	</select>
            		 	
            		 	
            		 	
            		 <input type="button" value="V VREDNOST" onclick="dodajv22()" style="font-family: Verdana; font-size: 8pt">
            		 
            		 
        
            		 
            		           		  		 &nbsp;</td>
            		 
        		 
</tr>

<tr><td colspan="2" class="opiscell" align="center"><input type=button value="Repository" onclick="window.open('<%=ConPool.getRepository_url() %>code?pagena=<%=ConPool.extractPageNameFromURLString(request.getRequestURI()) %>', 'PgRepository','menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes')" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr>

<tr><td colspan="2" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>



function dodajv() {
document.dod.dodatno_insert.value = document.dod.dodatno_insert.value + " "+
document.dod.im1.value + (document.dod.im2.value.indexOf("request.getPara")!=-1?"(":"(")+ 
document.dod.im2.value + (document.dod.im2.value.indexOf("request.getPara")!=-1?")":")")+";\r\n";

}
function setaj1() {

document.dod.im22.value =
document.dod.funkcija22.value + "";

}
function setaj22() {

document.dod.im222.value =
document.dod.funkcija222.value + "";

}
function setaj() {

document.dod.im2.value =
document.dod.funkcija2.value + "";

}


function dodajv2() {
document.dod.dodatno_update.value = document.dod.dodatno_update.value + " "+
document.dod.im11.value + (document.dod.im22.value.indexOf("request.getPara")!=-1?"(":"(")+ 
document.dod.im22.value + (document.dod.im22.value.indexOf("request.getPara")!=-1?")":")")+";\r\n";

}

function dodajv22() {
document.dod.dodatno_java.value = document.dod.dodatno_java.value + " "+
document.dod.im111.value + (document.dod.im222.value.indexOf("request.getPara")!=-1?"(":"(")+ 
document.dod.im222.value + (document.dod.im222.value.indexOf("request.getPara")!=-1?")":")")+";\r\n";

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
var mon = parent.frames[2].document.location+"";

<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {

  parent.frames[2].document.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";


}
  else {
     if (mon.indexOf("?")!=-1) {
          if (mon.indexOf("idt=")!=-1) {
     parent.frames[2].document.location = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     
     }
     else {
parent.frames[2].document.location = parent.frames[2].document.location + "&idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";
     }
     }
     else {
     parent.frames[2].document.location = parent.frames[2].document.location + "?idback=<%=request.getParameter("id")%>&idt=<%=request.getParameter("idt")%>";

     }
}
<%
}
else {
%>
    if (mon.indexOf("idt=")!=-1) {
    
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