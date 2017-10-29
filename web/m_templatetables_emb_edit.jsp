<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.apache.commons.io.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A"))) {
%><jsp:forward page="logout.jsp"/><%
}
%>
<%
try { 
boolean bok=false;
int akcij=0;
Long nidd=new Long(0);
String napaka="";
boolean mum=false;


com.popultrade.model.TemplateTables vseb =new com.popultrade.model.TemplateTables();
com.popultrade.dao.TemplateTablesDAO dao = (com.popultrade.dao.TemplateTablesDAO)contextUtil.getBeanDao("templateTablesDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcijaXY")==null) {
vseb = dao.getTemplateTables(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
else if (request.getParameter("akcijaXY")!=null)  {
if (!bok) {
String rabiinsert="";
if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
akcij=4;
String rezu="";
vseb = dao.getTemplateTables(new Long(nul.jeNullDefault(request.getParameter("id"))));
nidd=vseb.getId();
vseb = (com.popultrade.model.TemplateTables)contextUtil.getPopulatedObject(vseb,request);
}
else {
akcij=5;
String rezu="";
vseb = (com.popultrade.model.TemplateTables)contextUtil.getPopulatedObject(vseb,request);

vseb.setSort_column_rabi(nul.jeNull(request.getParameter("sort_column_rabi")).equals("1")?"1":"0");


}
vseb.setId_nad(new Long(request.getParameter("id_nad")));
if (rabiinsert.equals("") && !bok) {
dao.saveTemplateTables(vseb);
nidd=vseb.getId();
}
}
}
Hashtable ht =new Hashtable();
Hashtable htn =new Hashtable();
Hashtable htnn =new Hashtable();
Hashtable htd =new Hashtable();




%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barve.css";
@import "tooltipcss.css";
</style>
<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type="text/javascript" src="ezcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<link rel="stylesheet" type="text/css" href="ezcalendar.css" />
<script language='javascript' src='popcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<body   style="margin: 0"  onload="mom()">
<%
String rezu="";
if (request.getParameter("akcijaXY")==null) {
%>
<form name=dod action="m_templatetables_emb_edit.jsp" method="post"    onSubmit="return custom()">
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
<input type=hidden name="idg" value="<%=request.getParameter("idg")%>">
<input type=hidden name="id_nad" value="<%=request.getParameter("id_nad")%>">
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Ime embeded tabele:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getTable_name_hibernate()+"");

%>
<input type="text"    tabindex='15' id="table_name_hibernate"  name="table_name_hibernate"     value="<%=rezu%>"    class="inputIEx"   >
</td>
<td class="opiscell" width="20%" align="left">Vezna tabela je:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getTable_type()+"");

%>


<select  id="table_type"  name="table_type"   tabindex='24'  style="font-family: Verdana; font-size: 8pt">
<option></option>
<option value="1" <%=(rezu.equals("") || rezu.equals("1"))?"selected":"" %>>Embeddable</option>
<option value="2" <%=rezu.equals("2")?"selected":"" %>>OneToMany</option>

</select>
<Br>
Embeddable: vsebina znotraj tabele
<br>
OneToMany: idji do vezna tabele znotraj tabele

</td>
</tr> 

<!-- 
<tr><td class="opiscell" width="20%" align="left">Sort column rabi (se rabi za order embedded tabele):</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getSort_column_rabi()+"");

%>
  <input type="checkbox"  id="sort_column_rabi"  name="sort_column_rabi"   tabindex='17'  value="1" <%=nul.jeNull(rezu+"").equals("1")?"checked":""%> style="font-family: Verdana; font-size: 8pt">

</td>
<td class="opiscell" width="20%" align="left">Sort column:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getSort_column()+"");
%>
<input type="text"    tabindex='15' id="sort_column"  name="sort_column"     value="<%=rezu%>"    class="inputIEx"   >
</td>
</tr> 

-->

<tr><td class="opiscell" width="20%" align="left">Opis:</td><td class="valuecell"  colspan=3><%
rezu=nul.jeNull(vseb.getDescription()+"");

%>
<textarea  tabindex='18' rows=4 cols=50 id="description" name="description"   ><%=rezu %></textarea>

</td>





</tr>


<tr><td colspan="4" class="opiscell" align="center"><input id="submitbutton"  type=submit value="Potrdi" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>



function custom() {


	
	if (trim(document.dod.table_name_hibernate.value)=="") {
		
		
		
		
		
		
		
		alert("Napaka: ime embeded tabele ni vneseno!");
		return false;
	}
	
	
	
	//// kontrola, da ime ne obstaja
	document.dod.table_name_hibernate.value = document.dod.table_name_hibernate.value.substring(0,1).toUpperCase()+document.dod.table_name_hibernate.value.substring(1);
	
	
	    	if (document.dod.table_name_hibernate.value.indexOf("Template")==-1 && document.dod.table_name_hibernate.value.indexOf("Users")==-1 
        			&& document.dod.table_name_hibernate.value.indexOf("Uploads")==-1
        			&& document.dod.table_name_hibernate.value.indexOf("Prevodi")==-1
        			&& document.dod.table_name_hibernate.value.indexOf("Jeziki")==-1
        			&& document.dod.table_name_hibernate.value.indexOf("FrameSize")==-1
        			&& document.dod.table_name_hibernate.value.indexOf("Base")==-1
        			&& document.dod.table_name_hibernate.value.indexOf("Wse_prijave")==-1
        			&& document.dod.table_name_hibernate.value.indexOf("OpenSessionInViewFilter")==-1
        			&& document.dod.table_name_hibernate.value.indexOf("DAO")==-1) {
	    		
	    		
	    	}
	    	else {
	    		
	    		alert("Napaka: ime tabele/classe v hibernatu ne sme vsebovati besed: Template,Users,Uploads,Prevodi,Jeziki,FrameSize,Base,Wse_prijave,DAO ");
	    		return false;
	    	}
	
	
	
	
	
	
	
//document.dod.submitbutton.disabled=true;
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



parent.frames[3].location = "nic.jsp";


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
//prisotnost.addUserNarocilo(control.idUporabnikaLock,nidd+"",new Date(),akcij,"TemplateTables",control.getUserName(),"","");
%>
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">Update/insert ok!</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
<script language=javascript>
function mom() {
<%if (bok) {%>
alert('<%=napaka%>');
<%}%>
}
var mon = parent.frames[0].location+"";


parent.frames[0].location = parent.frames[0].location;


</script>
<%
}

}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
