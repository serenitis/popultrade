<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.apache.commons.io.*"%>
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
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%
}
%>
<%
try {
boolean bok=false;
int akcij=0;
Long nidd=new Long(0);
String napaka="";
boolean mum=true;

if (mum) {
com.popultrade.model.TemplateTablesCol vseb =new com.popultrade.model.TemplateTablesCol();
com.popultrade.dao.TemplateTablesColDAO dao = (com.popultrade.dao.TemplateTablesColDAO)contextUtil.getBeanDao("templateTablesColDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcijaXY")==null) {
vseb = dao.getTemplateTablesCol(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
else if (request.getParameter("akcijaXY")!=null)  {
if (!bok) {
String rabiinsert="";
if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
akcij=4;
String rezu="";
vseb = dao.getTemplateTablesCol(new Long(nul.jeNullDefault(request.getParameter("id"))));
nidd=vseb.getId();
vseb = (com.popultrade.model.TemplateTablesCol)contextUtil.getPopulatedObject(vseb,request);
}
else {
akcij=5;
String rezu="";
vseb = (com.popultrade.model.TemplateTablesCol)contextUtil.getPopulatedObject(vseb,request);



}

vseb.setIs_primarykey(nul.jeNull(request.getParameter("is_primarykey")).equals("1")?"1":"0");
vseb.setH_null(nul.jeNull(request.getParameter("h_null")).equals("1")?"1":"0");
vseb.setIs_index(nul.jeNull(request.getParameter("is_index")).equals("1")?"1":"0");

vseb.setId_nad(new Long(request.getParameter("idt")));
if (request.getParameter("h_connection_table")!=null && request.getParameter("h_connection_table").indexOf("-----")!=-1) {
	
	vseb.setH_connection_table(request.getParameter("h_connection_table").substring(request.getParameter("h_connection_table").indexOf("-----")+5));
	
}



if (rabiinsert.equals("") && !bok) {
dao.saveTemplateTablesCol(vseb);
nidd=vseb.getId();
}
}
}
Hashtable ht =new Hashtable();
Hashtable htn =new Hashtable();
Hashtable htnn =new Hashtable();
Hashtable htd =new Hashtable();
ht.put("Napaka: ime polja v hibernate ni vneseno!","field_name");
//ht.put("Napaka: tip polja v bazi ni izbrano!","type");
//ht.put("Napaka: tip polja v javi ni izbrano!","h_type_java");
ht.put("Napaka: tip polja v hibernate ni izbrano!","h_type");




%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barve.css";
@import "tooltipcss.css";
</style>
<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<script type="text/javascript" src="ezcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<link rel="stylesheet" type="text/css" href="ezcalendar.css" />
<script language='javascript' src='popcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>


<script language="javascript">

function setSelect(zarepl) {
	
	xmlHttp=GetXmlHttpObject2();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	} 
	var url="m_templatetablescolajx.jsp";
	url=url+"?id_nad="+zarepl+"&trenutni="+document.dod.h_connection_column.value;
	url=url+"&sid="+Math.random();
	xmlHttp.open("GET",url,false);
	xmlHttp.send(null);
	if (xmlHttp.responseText.indexOf("h_connection_column")!=-1) {
	document.getElementById("poljevezno").innerHTML=xmlHttp.responseText;
	}
	else {
	return false;
	}
	return true;

	
	
	
}

function callSet() {
	
	if (document.getElementById('h_connection_table') && document.dod.h_connection_table!=null && document.dod.h_connection_table.value!="") {
		
		var cre = document.dod.h_connection_table.value.substring(0,document.dod.h_connection_table.value.indexOf("-----"));
	//	alert(cre);
		setSelect(cre);
		
	}
	
	
}

</script>




<body   style="margin: 0"  onload="mom();callSet()">
<%
String rezu="";
if (request.getParameter("akcijaXY")==null) {
%>
<form name=dod action="m_templatetablescol_emb_edit.jsp" method="post"    onSubmit="return check()">
<%
if (vseb.getId()!=null && !vseb.getId().equals("")) {
%>
<input type=hidden name="akcijaXY" value="UPDATE">
<%
}
else {
%>
<input type=hidden name="akcijaXY" value="NEW">
<%
}
%>
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">
<input type=hidden name="idg" value="<%=nul.jeNull(request.getParameter("idg"))%>">

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Ime polja hibernate (vedno z malo zacetnico):<br>Ime polja v bazi(ce razlicno od ime polja):</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getField_name()+"");

%>
<input type="text"    tabindex='10' id="field_name"  name="field_name"     value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  ><br>
<input type="text"    tabindex='12' id="field_name_db"  name="field_name_db"     value="<%=nul.jeNull(vseb.getField_name_db()+"")%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  >

</td>
<td class="opiscell" width="20%" align="left">Opis:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getDescription()+"");

%>
<input type="text"    tabindex='15' id="description"  name="description"   size=70   value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  >
</td>
</tr>
<tr><td class="opiscell" width="20%" align="left">Tip polja v bazi (v primeru da gre za povezavo z drugo tabelo se polje ne rabi):</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getType()+"");

%>
<select id="type"  name="type"   tabindex='20'  class="inputIEx" >
<option value=""></option>
<option value="varchar" <%=(rezu.equals("varchar")?"selected":"") %>>varchar</option>
<option value="number" <%=(rezu.equals("number")?"selected":"") %>>number</option>
<option value="timestamp" <%=(rezu.equals("timestamp")?"selected":"") %>>timestamp</option>
<option value="blob" <%=(rezu.equals("blob")?"selected":"") %>>blob</option>
<option value="text" <%=(rezu.equals("text")?"selected":"") %>>text (ne oracle)</option>
</select>
Sirina:
<%
rezu=nul.jeNull(vseb.getWidth()+"");

%>
<input type="text"    tabindex='22' id="width"  name="width"   size=3  value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  >

</td>
<td class="opiscell" width="20%" align="left">Tip polja v javi (v primeru da gre za povezavo z drugo tabelo se polje ne rabi):</td><td class="valuecell" width="30%">
	<%
rezu=nul.jeNull(vseb.getH_type_java()+"");

%>

<select id="h_type_java"  name="h_type_java"   tabindex='23'  class="inputIEx" onchange="(document.dod.h_type_java.value!='Date'?(document.dod.h_datefromto.disabled=true):(document.dod.h_datefromto.disabled=false))">
<option value=""></option>
<option value="Long" <%=(rezu.equals("Long")?"selected":"") %>>Long (vedno za id-je in vezave)</option>
<option value="String" <%=(rezu.equals("String")?"selected":"") %>>String</option>
<option value="Double" <%=(rezu.equals("Double")?"selected":"") %>>Double</option>
<option value="Date" <%=(rezu.equals("Date")?"selected":"") %>>Date</option>
<option value="Integer" <%=(rezu.equals("Integer")?"selected":"") %>>Integer</option>
<option value="byte[]" <%=(rezu.equals("byte[]")?"selected":"") %>>byte[] (za tip blob v bazi)</option>


</select> <br>
<%
rezu = nul.jeNull(vseb.getH_datefromto()+"");
%>
Naredi iskanje od-do za datum:
  <input type="checkbox"  id="h_datefromto"  name="h_datefromto"   tabindex='24'  value="1" <%=nul.jeNull(rezu+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">


</td>
</tr>
<tr><td class="opiscell" width="20%" align="left">Ne sme biti null:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getH_null()+"");

%>
  <input type="checkbox"  id="h_null"  name="h_null"   tabindex='25'  value="1" <%=nul.jeNull(rezu+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">


</td>
<td class="opiscell" width="20%" align="left">Access type (tip dostopa do polja):</td><td class="valuecell" width="30%">


	<%
rezu=nul.jeNull(vseb.getAccess_field_type()+"");

%>

<select id="access_field_type"  name="access_field_type"   tabindex='23'  class="inputIEx" >
<option value=""></option>
<option value="@Transient" <%=(rezu.equals("@Transient")?"selected":"") %>>Transient (polje se ne zafila iz baze)</option>
<option value="@Fetch(FetchMode.SELECT)" <%=(rezu.equals("@Fetch(FetchMode.SELECT)")?"selected":"") %>>@Fetch(FetchMode.SELECT) (vrednost se zafila le ko jo zahtevas)</option>
 

</select>


</td>
</tr>

<tr><td class="opiscell" width="20%" align="left" colspan=4>&nbsp;</td></tr>

<tr><td class="opiscell" width="20%" align="left">Tip povezave do druge tabele:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getH_connection_type()+"");

%>

<select id="h_connection_type"  name="h_connection_type"   tabindex='55'  class="inputIEx" >
<option value=""></option>
<option value="OneToOne" <%=(rezu.equals("OneToOne")?"selected":"") %>>OneToOne</option>
<option value="OneToMany" <%=(rezu.equals("OneToMany")?"selected":"") %>>OneToMany</option>
<option value="ManyToOne" <%=(rezu.equals("ManyToOne")?"selected":"") %>>ManyToOne</option>


</select> Za NoSQL je mogoc samo onetomany


</td>
<td class="opiscell" width="20%" align="left">Povezana tabela:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getH_connection_table()+"");
System.out.println(rezu + " --------------------------------------------- cc");
%>
            		 <select id="h_connection_table"  name="h_connection_table"    class="inputIEx"   tabindex='60' onchange="callSet()" >
					<option value=""></option>
					<%
					com.popultrade.dao.TemplateTablesDAO daott = (com.popultrade.dao.TemplateTablesDAO)contextUtil.getBeanDao("templateTablesDAO",pageContext.getServletContext());

					List li  = daott.getTemplateTabless(new com.popultrade.model.TemplateTables(),1,150,"","table_name_hibernate","asc");
					Iterator itti = li.iterator();
					while (itti.hasNext()) {
						com.popultrade.model.TemplateTables nex =(com.popultrade.model.TemplateTables)itti.next();
						if (nex!=null && nex.getTable_name_hibernate().equals(nul.jeNull(rezu))) {
					%>
					<option value="<%=nex.getId()+"-----"+nex.getTable_name_hibernate()%>" selected><%=nex.getTable_name_hibernate()%></option>
					<%
						}
						else {
							%>
							<option value="<%=nex.getId()+"-----"+nex.getTable_name_hibernate()%>" ><%=nex.getTable_name_hibernate()%></option>
							<%	
						}
					}
					%>
					</select>


</td>
</tr>
<tr><td class="opiscell" width="20%" align="left">Polje v povezani tabeli,ki se veze na to:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getH_connection_column()+"");

%><input type='text' id="h_connection_column" name='h_connection_column'  class="inputIEx"   value="<%=rezu%>"><span id="poljevezno"></span>
</td>
<td class="opiscell" width="20%" align="left">Referencno polje na povezano tabelo (pri ManyToOne je to "Polje v povezani tabeli" in obratno):</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getH_connection_property_ref()+"");

%>

 		 <select  id="h_connection_property_ref"  name="h_connection_property_ref"   class="inputIEx"  >
					<option value=""></option>
					<%
					com.popultrade.dao.TemplateTablesColDAO daotc = (com.popultrade.dao.TemplateTablesColDAO)contextUtil.getBeanDao("templateTablesColDAO",pageContext.getServletContext());
					 com.popultrade.model.TemplateTablesCol remo = new com.popultrade.model.TemplateTablesCol();
					 remo.setId_nad(new Long(request.getParameter("id_nad")));
					 li  = daotc.getTemplateTablesCols(remo,1,150,"","field_name","asc");
					 itti = li.iterator();
					while (itti.hasNext()) {
						com.popultrade.model.TemplateTablesCol nex =(com.popultrade.model.TemplateTablesCol)itti.next();
						if (nex!=null && nex.getField_name().equals(nul.jeNull(rezu))) {
					%>
					<option value="<%=nex.getField_name()%>" selected><%=nex.getField_name()%></option>
					<%
						}
						else {
							%>
							<option value="<%=nex.getField_name()%>" ><%=nex.getField_name()%></option>
							<%	
						}
					}
					%>
					</select>





</td>
</tr>
<tr><td class="opiscell" width="20%" align="left">Cascade tip za vezo na tabelo:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getH_connection_cascade()+"");

%>
<input type="text"    tabindex='75' id="h_connection_cascade"  name="h_connection_cascade"  readonly='readonly'   value="REMOVE"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  >
</td>
<td class="opiscell" width="20%" align="left">Mapped-by (samo onetoone, ime onetoone annotationa v vezani tabeli):</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getH_mapped_by()+"");

%>
 <input type="text"    tabindex='80' id="h_mapped_by"  name="h_mapped_by"     value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  >
</td>
</tr>

<tr><td class="opiscell" width="20%" align="left" colspan=4>&nbsp;</td></tr>


<tr><td class="opiscell" width="20%" align="left" colspan=4>&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Uporabi index na polju:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getIs_index()+"");

%>

  <input type="checkbox"  id="is_index"  name="is_index"   tabindex='85'  value="1" <%=nul.jeNull(rezu+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">


</td>
<td class="opiscell" width="20%" align="left">Ime indexa, ce je zbran kot index:<br>Vsebinski kljuc:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getIndex_name()+"");

%>
<input type="text"    tabindex='90' id="index_name"  name="index_name"     value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  >
<br>

<%
rezu=nul.jeNull(vseb.getContent_key()+"");

%>
<input type="text"    tabindex='92' id="content_key"  name="content_key"   size=70   value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"  >




</td>
</tr>


<tr><td class="opiscell" width="20%" align="left">Komentar:</td><td colspan=3 class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getComments()+"");

%><Br>
<textarea tabindex='105' id="comments" cols=150 rows=5 name="comments"   style="font-family: Verdana; font-size: 8pt" clsass="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"   onblur="change(this,'white');"   ><%=rezu%></textarea>


</td>

</tr>


<tr><td colspan="4" class="opiscell" align="center"><input id="submitbutton"  type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>



function custom() {

	if (document.dod.is_index.checked) {
		
		if (trim(document.dod.index_name.value)=="") {
			
			alert("Napaka: ime indexa ni vneseno!");
			return false;
		}
		
	}
	
	
	if (document.dod.h_connection_type.value!="") {
		
		
		if (document.dod.h_connection_table!=null && document.dod.h_connection_table.value=="") {
				
				alert("Napaka: ime povezovalna tabela ni izbrana!");
				return false;
			}
		
		if (document.dod.h_connection_column.value=="") {
		//	alert("Napaka: polje v povezani tabeli (ki veze tabele) ni izbrano!");
			//return false;
		}
		}
	else {
	if (trim(document.dod.h_type_java.value)=="") {
			
			alert("Napaka: tip polja hibernate ni izbrano!");
			return false;
		}
	
	if (trim(document.dod.type.value)=="") {
		
		alert("Napaka: tip polja ni izbrano!");
		return false;
	}
	
	
		
	}

	
	
	
	
return true;
}
function KeyCheck(event){
if ( typeof event == "undefined" ) event = window.event;
var KeyID = event.keyCode;
if (KeyID==9 ){
if (window.setAll){
setAll();
}
}
}
function Focusie(){
if (window.setAll){
setAll();
}
}
function KeyCheckMouse(e){
var KeyID = e.keyCode;
if (window.setAll){
setAll();
}
}
function mom() {
<%if (bok) {%>
alert('<%=napaka%>');
<%}%>

<%
if (request.getParameter("akcijaXY")==null) {
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
<p align="center">Update/Insert ok.</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
<script language=javascript>

<%
String parent = "parent.frames[2]";

//if (nul.jeN(request.getParameter("izvor")).equals("frame")) {
	 parent = "top.parent.frames[2][1]";
	
//}

%>


function mom() {
<%if (bok) {%>
alert('<%=napaka%>');
<%}%>
}
var mon = <%=parent%>.location+"";
<%
if (request.getParameter("akcijaXY")!=null && !request.getParameter("akcijaXY").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
if (mon.indexOf("?")==-1) {
	<%=parent%>.location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
}
else {
	<%=parent%>.location = mon.substring(0,mon.indexOf("idback"))+"idback=<%=request.getParameter("id")%>";
}
}
else {
if (mon.indexOf("?")!=-1) {
if (mon.indexOf("id=")!=-1) {
	<%=parent%>.location = mon.substring(0,mon.indexOf("?")+1) + "?idback=<%=request.getParameter("id")%>";
}
else {
	<%=parent%>.location = <%=parent%>.location + "&idback=<%=request.getParameter("id")%>";
}
}
else {
	<%=parent%>.location =<%=parent%>.location + "?idback=<%=request.getParameter("id")%>";
}
}
<%
}
else {
%>
if (mon.indexOf("DELETE")!=-1) {
	<%=parent%>.location = mon.replace("akcijaXY=DELETE","");
}
else {
	<%=parent%>.location = <%=parent%>.location;
}
<%
}
%>
</script>
<%
}
}

}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
