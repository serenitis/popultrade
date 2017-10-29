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

dao.updateClob(request.getParameter("id"),"dodatno_java_rocno",nul.jeNull(request.getParameter("dodatno_java_rocno")));



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

<form name=dod action="m_templateuidodatno_edit.jsp" method="post" onSubmit="return check()">

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
            		  
            		 <td class="opiscell" width="20%">Dodatno java (uporabi se za pridobivanje class iz drugih tabel, ki se potem uporabi za setiranje vrednosti, doda se v jsp v isti obliki kot je tu napisano):&nbsp;</td><td class="valuecell" width="30%">
            		 <textarea id="dodatno_java_rocnoe" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_java_rocno()+"")%></textarea>
            		 <input type="hidden" name="dodatno_java_rocno" id="dodatno_java_rocno" value="">
					
            		 
            		 </td>
            		 
        		 
</tr>
<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java 2 (uporabi se za pridobivanje class iz drugih tabel, ki se potem uporabi za setiranje vrednosti, doda se v jsp v isti obliki kot je tu napisano doda se kot drugi dela dodatno java):&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_java_rocno2e" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_java_rocno2()+"")%></textarea>
            		 <input type="hidden" name="dodatno_java_rocno2" id="dodatno_java_rocno2" value="">
					
            		 
            		 
            		 </td>
            		 
        		 
</tr>
<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno javascript po onload:&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_javascripte" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_javascript()+"")%></textarea>
            		 
            		 <input type="hidden" name="dodatno_javascript" id="dodatno_javascript" value="">
					
            		 
            		 </td>
            		 
        		 
</tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Javascript funkcije:&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_javascript2e" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_javascript2()+"")%></textarea>
            		 <input type="hidden" name="dodatno_javascript2" id="dodatno_javascript2" value="">
					
            		 
            		 </td>
            		 
        		 
</tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno java funkcije znotraj ! za jsp :&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_java_updateinserte" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_java_updateinsert()+"")%></textarea>
            		 
            		 <input type="hidden" name="dodatno_java_updateinsert" id="dodatno_java_updateinsert" value="">
					
            		 </td>
            		 
        		 
</tr>
<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno HTML se inserta pod listom pred izbiro strani :&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 <textarea id="dodatno_inserte" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_insert()+"")%></textarea>
            		 
            		 <input type="hidden" name="dodatno_insert" id="dodatno_insert" value="">
					
            		 
            		 </td>
            		 
        		 
</tr>

<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno Java pred klicanjem lista :&nbsp;</td><td class="valuecell" width="30%">
            		 
            		 
            		 <textarea id="dodatno_updatee" style="font-family: Verdana; font-size: 8pt; width: 1013px; height: 374px;"><%=nul.jeNull(vseb.getDodatno_update()+"")%></textarea>
            		 
            		  <input type="hidden" name="dodatno_update" id="dodatno_update" value="">
					
            		 </td>
            		 
        		 
</tr>
<tr>
            		  
            		 <td class="opiscell" width="20%">Dodatno css (doda se na zacetek strani - <b>Samo za novi del aplikacije (ter list in update)</b>):&nbsp;</td><td class="valuecell" width="30%">
            		 
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
	
	//document.getElementById("dodatno_javascript_funkcije").value = editor3.getValue();
	
	
	//document.getElementById("dodatno_javascript_onload").value = editor4.getValue();
	document.getElementById("dodatno_insert").value = editor5.getValue();
	
	document.getElementById("dodatno_update").value = editor6.getValue();
//document.getElementById("dodatno_java_default").value = editor7.getValue();

//document.getElementById("dodatno_java").value = editor8.getValue();
		document.getElementById("dodatno_java_rocno").value = editor9.getValue();
				document.getElementById("dodatno_java_rocno2").value = editor10.getValue();
				
				
			//	document.getElementById("dodatno_java_test").value = editor11.getValue();
						document.getElementById("dodatno_java_updateinsert").value = editor12.getValue();
							
							
				//		document.getElementById("dodatno_html").value = editor13.getValue();
							//	document.getElementById("dodatno_html2").value = editor14.getValue();
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