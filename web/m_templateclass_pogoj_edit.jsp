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
String class_name="";
session.setAttribute("glavno",request.getParameter("glavno"));


com.popultrade.model.TemplateClass vseb =new com.popultrade.model.TemplateClass();
com.popultrade.dao.TemplateClassDAO dao = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getTemplateClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
}

else if (request.getParameter("akcija")!=null)  {

if (!bok) {

	if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
		vseb = dao.getTemplateClass(new Long(nul.jeNullDefault(request.getParameter("id"))));
	
	}
	else {
vseb.setTemplatehead_id(new Long(request.getParameter("idg")));
	}
vseb = (com.popultrade.model.TemplateClass)contextUtil.getPopulatedObject(vseb,request);
vseb.setNosql(nul.jeNull(request.getParameter("nosql")).equals("1")?"1":"0");
dao.saveTemplateClass(vseb);

}
}

Hashtable ht =new Hashtable();
ht.put("predpona_pogoja","predpona_pogoja");
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
<script src="src-min/ace.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery.cleditor.css" />
    <script type="text/javascript" src="js/jquery-1.5.min.js"></script>
    <script type="text/javascript" src="js/jquery.cleditor.min.js"></script>
    <script type="text/javascript">
 
      //  $(document).ready(function () { $("#input").cleditor(); });
  
            		 
            		  </script>

<body   style="margin: 0"   <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
if (request.getParameter("akcija")==null) {
%>

<form name=dod action="m_templateclass_pogoj_edit.jsp" method="post" onSubmit="return check()">

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
<input type=hidden name="idg" value="<%=nul.jeNull(request.getParameter("idg"))%>">
<input type=hidden name="sifid" value="<%=nul.jeNull(request.getParameter("sifid"))%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%" onload="mom()" ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>



            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Predpona pogoja: </td><td class="valuecell" width="30%" >
            		 
            	
            		 
            		  		 <select name="predpona_pogoja" style="font-family: Verdana; font-size: 8pt" >
            		 
            		 
					<option value=""></option>
					
			<option value="IF" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("IF")?"selected":""%>>IF</option>
				<option value="ELSE IF" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("ELSE IF")?"selected":""%>>ELSE IF</option>	
					<option value="ELSE" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("ELSE")?"selected":""%>>ELSE</option>	
					<option value="VALUE" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("VALUE")?"selected":""%>>VALUE IZ DRUGE CLASS-E</option>	
					<option value="FORMAT" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("FORMAT")?"selected":""%>>SAMO FORMAT</option>
					<option value="LIST" <%=nul.jeNull(vseb.getPredpona_pogoja()).equals("LIST")?"selected":""%>>LIST</option>
					</select>
            		 
            		 
            		 
            		 
            		 </td>
            		 
            		 
            		 <td class="opiscell" width="20%">Zaporedje: </td><td class="valuecell" width="30%" >
            		 <input type="text" name="zaporedje" maxlength='3' size=4 value="<%=nul.jeNull(vseb.getZaporedje()+"")%>" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
            		 </tr><tr>
            		 <td class="opiscell" width="20%">Vrednost pogoja (v primeru tagov oklepaje loci z //// znaki npr ////>) (<i>v primeru, da je predpona pogoja VALUE se vrednost prepise pred vrednostjo ki se dobi iz classe</i>)<Br> <b>enojne navednice se ne zamenjajo avtomaticno z dvojnimi</b>: </td><td class="valuecell" width="30%" colspan=3>
            		 
            		 
            		 <textarea name="vrednost_pogoja" cols=120 rows=3 style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getVrednost_pogoja()+"")%></textarea>
            		 
            		 
            		 
            		 
            		 
            		 
            		 <br>
            		 	  		 <select name="vrednost_pogojas" style="font-family: Verdana; font-size: 8pt" onChange="preseli()" >
            		 
            		 
					
					
				
					<%
					
					
					//// ze izbrano
					
					try {
						
						if (request.getParameter("idg")!=null ){
					com.popultrade.model.TemplateUi theadui =new com.popultrade.model.TemplateUi();
						com.popultrade.dao.TemplateUiDAO daothui = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
					
					theadui = daothui.getTemplateUi(new Long(request.getParameter("idg")));
					
					String smm="";
					if (theadui!=null) {
					smm = nul.jeNull(theadui.getStolpec_metoda());
					}
					
					%>
					
					<option value="<%=smm%>" <%=(smm.equals(nul.jeNull(vseb.getVrednost_pogoja()))?"selected":"") %>><%=smm %></option>
					
					<%
						}
					}
					catch (Exception ijo) {
					}
					
			
					
		if (nul.jeNull(session.getAttribute("glavno")+"").equals("1")) {

						
						com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
						com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

						
						//// dobim ime model clase iz headerja
						thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("sifid"))));
						class_name=thead.getHead_class_name();
						
					}
					else {
						com.popultrade.model.TemplateClassClass thead =new com.popultrade.model.TemplateClassClass();
						com.popultrade.dao.TemplateClassClassDAO daoth = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());
						thead = daoth.getTemplateClassClass(new Long(nul.jeNull(request.getParameter("sifid"))));
						class_name=thead.getClass_name();
					}
					
					
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
					%>
				
					<%
					
					
	
					
					 li = templateUtil.getKonstantePriLogu();
					
					 itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (nex!=null && nex.equals(nul.jeNull(vseb.getVrednost_pogoja()))) {
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
					
					
					
					
					
					
					/// pogoji iz predpage, ce je
										com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(session.getAttribute("idt")+""));
					
					if (thead.getTemplatePPs()!=null && thead.getTemplatePPs().size()>0) {
						Iterator itf = thead.getTemplatePPs().iterator();
						
						while (itf.hasNext()) {
							com.popultrade.model.TemplatePP tpp = (com.popultrade.model.TemplatePP)itf.next();
							
							%>
							
								<option value="<%=(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?"request.getParameter('"+tpp.getRazlicno_ime_inputa()+"')":nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')")%>" <%=(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?"request.getParameter('"+tpp.getRazlicno_ime_inputa()+"')":nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')").equals(nul.jeNull(vseb.getVrednost_pogoja()).toLowerCase())?"selected":""%>><%=(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?"request.getParameter('"+tpp.getRazlicno_ime_inputa()+"')":nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')")%> (vrednost preko predhode strani)</option>
						
							
							<%
							
						}
						
						
						
						
					}
					
					
					
					
					
					
					
					
					%>
					
					
					</select>
            		 <input type="button" value="V VREDNOST" onclick="preseli()" style="font-family: Verdana; font-size: 8pt">
            		 
            		 <input type="button" value="FORMAT VREDNOST" onclick="dodajvformat()" style="font-family: Verdana; font-size: 8pt">
            		 
            		 </td>
            		 
            		  </tr>
            		  
            		  
            		  <tr id="formatme" >
            		  <td colspan=4><textarea id="input" name="input" cols="55">VALUE</textarea><br><input type="button" value="  UPORABI  " onclick="preseliFormat()" style="font-family: Verdana; font-size: 8pt"></td>
            		  
            		  
            		  </tr>
            		  
            		  
            		  
            		  <tr>
            		    		 <td class="opiscell" width="20%">Vsebina iz repository: </td>
            		 
            		 <td class="valuecell" colspan=3>
            	
            		           	
            		           	    <script type="text/javascript">
 //  alert(3);
            		  var dobitnik = "vrednost_pogoja";
            		
            		  function transcont() {
            			//  alert(document.getElementById("repository1"));
            			  var icooox = document.getElementById("repository1");
            			//  alert(icooox.value);
            			  if (icooox.value=="") {
            				  return false;
            			  }
            				 xmlHttp=GetXmlHttpObject();
            				 var url="m_getrepository.jsp";
            				 url=url+"?idrepo="+icooox.value;
            				 url=url+"&sid="+Math.random();
            				 xmlHttp.open("GET",url,false);
            				 xmlHttp.send(null);
            				 eval("document.dod."+dobitnik).value=xmlHttp.responseText;

            				 return false;
            			}
            		 
            		  </script>
            		           	
            		           	
            		           		 
            		  		 <select name="repository1" id="repository1" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					com.popultrade.model.TemplateRepository thead2 =new com.popultrade.model.TemplateRepository();
com.popultrade.dao.TemplateRepositoryDAO daoth2 = (com.popultrade.dao.TemplateRepositoryDAO)contextUtil.getBeanDao("templateRepositoryDAO",pageContext.getServletContext());
					List li2 = daoth2.getTemplateRepositorys(thead2,1,10000, "", "title", "");
					Iterator itti2 = li2.iterator();
					while (itti2.hasNext()) {
						thead2 = (com.popultrade.model.TemplateRepository)itti2.next();
							%>
							<option value="<%=thead2.getId()%>"><%=nul.jeNull(thead2.getTitle()) %> (<%=thead2.getRtype() %>)</option>
							<%	
					}
					%></select><br><input type="button"  style="font-family: Verdana; font-size: 8pt" value="Transfer content to field" onclick="transcont()">
					
					</td></tr>
					
					
            		  
            		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">Pogoj: </td><td class="valuecell" width="30%" colspan="3">
            		 
            		 
            		 <textarea cols="100" rows=4 id="dodaten_hql_pogoje"  style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(vseb.getDodaten_hql_pogoj()+"")%></textarea>
            		
            		
            		
            		 <input type="hidden" name="dodaten_hql_pogoj" id="dodaten_hql_pogoj" value="">
            		  
            		  <br>
            		  
            		  
            		<select id="hql1" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="(">(</option>
            		  </select>
            		  
            		  <select id="hql2" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value="AND">AND</option>
            		  <option value="OR">OR</option>
            		  </select>
            		  
            		<select id="hql3" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
					<%
					//// dobim ime model clase iz headerja
					//thead = daoth.getTemplateHead(new Long(nul.jeNull(request.getParameter("sifid"))));
					 li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+class_name);
					 itti = li.iterator();
					while (itti.hasNext()) {
						String nex =(String)itti.next();
							%>
							<option value="<%=nex.substring(0,nex.indexOf(" ----XXX---- "))%>()"><%=nex.replaceAll(" ----XXX---- "," (") +")"%></option>
							<%	
					}
					
					if (thead.getTemplatePPs()!=null && thead.getTemplatePPs().size()>0) {
						Iterator itf = thead.getTemplatePPs().iterator();
						
						while (itf.hasNext()) {
							com.popultrade.model.TemplatePP tpp = (com.popultrade.model.TemplatePP)itf.next();
							
				
							%>
							
							<option value="<%=(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?"request.getParameter('"+tpp.getRazlicno_ime_inputa()+"')":nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')")%>" <%=(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?"request.getParameter('"+tpp.getRazlicno_ime_inputa()+"')":nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')").equals(nul.jeNull(vseb.getVrednost_pogoja()).toLowerCase())?"selected":""%>><%=(!nul.jeNull(tpp.getRazlicno_ime_inputa()).equals("")?"request.getParameter('"+tpp.getRazlicno_ime_inputa()+"')":nul.jeNull(tpp.getStolpec_metoda()).toLowerCase().replaceAll("get","request.getParameter(\'")+"\')")%> (vrednost preko predhode strani)</option>
							
							
							<%
							
						}
						
						
						
						
					}
					%>
					</select>
					  	<select id="hql35" style="font-family: Verdana; font-size: 8pt" >
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
					
					<input type="text" size=20 id="hql5"  style="font-family: Verdana; font-size: 8pt">
						
            		  	<select id="hql7" style="font-family: Verdana; font-size: 8pt" >
					<option value=""></option>
            		  <option value=")">)</option>
            		  </select>
            		  
            		  <input type="button" value="DODAJ" onclick="dodaj()" style="font-family: Verdana; font-size: 8pt"> 
            		  
            		  
            		  <input type="button" value="RESET" onclick="dodajreset()" style="font-family: Verdana; font-size: 8pt"> 
            		  </td>
            		 
</tr>














		  
            		  <tr>
            		  
            		 <td class="opiscell" width="20%">NoSQL tabela: </td><td class="valuecell" width="30%" colspan="3">
<input type="checkbox" name="nosql" value="1" <%=nul.jeNull(vseb.getNosql()+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">
  
            v primeru da vrednost iz druge class je v NoSQL tabeli
            		  </td>
            		 
</tr>














<tr><td colspan="4" class="opiscell" align="center"><input type=button value="Repository" onclick="window.open('<%=ConPool.getRepository_url() %>code?pagena=<%=ConPool.extractPageNameFromURLString(request.getRequestURI()) %>', 'PgRepository','menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes')" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr>





<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>


function preseliFormat() {


var val = document.dod.input.value;

if (val.indexOf("font style=\"background-color")!=-1) {



//alert(document.dod.input.value);

val1 = val.substring(0,"<font style=\"background-color");

val2 = val.substring("<font style=\"background-color",val.length);
val2 = val2.replace("<font style=\"","<div style=\"width:100%;height:100%; ");
val2 = val2.replace("</font>","</div>");

val = val1+val2;
//alert(val);

}
val = val.replace(/\"/g,'\\\"');
val = val.replace("VALUE","\"+ nul.jeNull("+document.dod.vrednost_pogojas.value+ "()+\"\") +\"");


document.dod.vrednost_pogoja.value =document.dod.vrednost_pogoja.value+ "\""+ val + "\"";


//alert(document.dod.input.value);


}


function dodajvformat() {
if( document.getElementById("formatme").style.display=='none' ){
   document.getElementById("formatme").style.display = '';

 }
 
 else{
   document.getElementById("formatme").style.display = 'none';

   
 }

//alert(document.dod.vrednost_pogojas.value);
document.dod.input.value = document.dod.vrednost_pogojas.value;

}


var editor1 = ace.edit("dodaten_hql_pogoje");
editor1.setOptions({
enableBasicAutocompletion: true, 
enableLiveAutocompletion: true, 
showPrintMargin: false,
maxLines: Infinity,
fontSize: "14pt"
});
editor1.setTheme("ace/theme/chrome");
editor1.renderer.setOption("showLineNumbers", true); 
editor1.getSession().setMode("ace/mode/java");

function custom() {

	
	document.getElementById("dodaten_hql_pogoj").value = editor1.getValue();
	
	

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
	editor1.setValue(editor1.getValue() + " "+
document.getElementById("hql1").value + " "+
document.getElementById("hql2").value + " "+(document.getElementById("hql35").value=='nequals'?'!':'')+ ((document.getElementById("hql35").value=='nequals' || document.getElementById("hql35").value=='equals')?"nul.jeNull(":'')+
document.getElementById("hql3").value+ ((document.getElementById("hql35").value=='nequals' || document.getElementById("hql35").value=='equals')?"+\"\")":"")+((document.getElementById("hql35").value=='nequals' || document.getElementById("hql35").value=='equals')?".equals('":document.getElementById("hql35").value)+
document.getElementById("hql5").value+((document.getElementById("hql35").value=='nequals' || document.getElementById("hql35").value=='equals')?"')":"")+
document.getElementById("hql7").value);

}

function dodajv() {
document.dod.vrednost_pogoja.value = document.dod.vrednost_pogoja.value + " ";
document.dod.vrednost_pogoja.value =document.dod.vrednost_pogoja.value+ document.dod.hv1.value + " nul.jeNull(";
if (document.dod.hv2.value.indexOf("request.getParameter")==-1) {
document.dod.vrednost_pogoja.value= document.dod.vrednost_pogoja.value+document.dod.hv2.value + "()+\"\") ";
}
else {
document.dod.vrednost_pogoja.value=document.dod.vrednost_pogoja.value+document.dod.hv2.value + "+\"\") ";
}

document.dod.vrednost_pogoja.value=document.dod.vrednost_pogoja.value+document.dod.hv3.value;

}

function preseli() {
document.dod.vrednost_pogoja.value =document.dod.vrednost_pogoja.value+ " nul.jeNull("+document.dod.vrednost_pogojas.value+ "()+\"\") ";

}

function preseli20() {
document.dod.funkcija_formata2.value =document.dod.funkcija_formata20.value+ "";

}


function mom() {

document.getElementById("formatme").style.display = 'none';


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