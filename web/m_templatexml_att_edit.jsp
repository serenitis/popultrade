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


com.popultrade.model.TemplateAttribute vseb =new com.popultrade.model.TemplateAttribute();
com.popultrade.dao.TemplateAttributeDAO dao = (com.popultrade.dao.TemplateAttributeDAO)contextUtil.getBeanDao("templateAttributeDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcijaXY")==null) {
vseb = dao.getTemplateAttribute(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
else if (request.getParameter("akcijaXY")!=null)  {
if (!bok) {
String rabiinsert="";
if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
akcij=4;
String rezu="";
vseb = dao.getTemplateAttribute(new Long(nul.jeNullDefault(request.getParameter("id"))));
nidd=vseb.getId();
vseb = (com.popultrade.model.TemplateAttribute)contextUtil.getPopulatedObject(vseb,request);
}
else {
akcij=5;
String rezu="";
vseb = (com.popultrade.model.TemplateAttribute)contextUtil.getPopulatedObject(vseb,request);
vseb.setId_nad(new Long(request.getParameter("id_nad")));

}
if (rabiinsert.equals("") && !bok) {
dao.saveTemplateAttribute(vseb);
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
<form name=dod action="m_templatexml_att_edit.jsp" method="post"    onSubmit="return custom()">
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
<input type=hidden name="ida" value="<%=nul.jeNull(request.getParameter("ida")+"")%>">
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<input type=hidden name="id_nad" value="<%=nul.jeNull(request.getParameter("id_nad")+"")%>">
<input type=hidden name="idg" value="<%=nul.jeNull(request.getParameter("idg")+"")%>">


<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Tag name:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getTag_name()+"");

%>
<input type="text"    tabindex='10' id="tag_name"  name="tag_name"     value="<%=rezu%>"    class="inputIEx"   >
</td>
<td class="opiscell" width="20%" align="left">Sequence:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getZaporedje()+"");

%>


<input type="text"    tabindex='12' id="zaporedje"  name="zaporedje"     value="<%=rezu%>"    class="inputIEx"   >



</td>




</tr> 


<tr><td class="opiscell" width="20%" align="left">Description:</td><td class="valuecell"   ><%
rezu=nul.jeNull(vseb.getDescription()+"");

%>
<textarea  tabindex='18' rows=4 cols=70 id="description" name="description"  class="inputIEx" ><%=rezu %></textarea>

</td>
<td class="opiscell" width="20%" align="left"></td><td class="valuecell"  width="30%" >
</td>
</tr>






<tr><td colspan="4" class="opiscell" align="center"><input id="submitbutton"  type=submit value="Commit" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>



function custom() {


	
	if (trim(document.dod.tag_name.value)=="") {
		
		alert("Error: tag_name is not entered!");
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
prisotnost.addUserNarocilo(control.idUporabnikaLock,nidd+"",new Date(),akcij,"TemplateAttribute",control.getUserName(),"");
%>
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">Update/insert ok</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
<script language=javascript>
function mom() {

}

top.parent.frames[2][0].odpriUL('<%=request.getParameter("ida")%>');
parent.frames[0].location='m_templatexml_att_list.jsp?id_nad=<%=request.getParameter("id_nad") %>&idg=<%=request.getParameter("idg") %>&ida=<%=request.getParameter("ida") %>';
</script>
<%
}

}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
