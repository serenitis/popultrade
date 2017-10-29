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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="m_loginu.html"/><%
}
%>  
<%
try {
boolean bok=false;
com.popultrade.model.Novice vseb =new com.popultrade.model.Novice();
com.popultrade.dao.NoviceDAO dao = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcija")==null) {
vseb = dao.getNovice(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
else if (request.getParameter("akcija")!=null)  {
if (!bok) {
if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
String rezu="";
vseb = dao.getNovice(new Long(nul.jeNullDefault(request.getParameter("id"))));
vseb = (com.popultrade.model.Novice)contextUtil.getPopulatedObject(vseb,request);
vseb.setDatum_novice(nul.parseDatumUra( nul.jeNull(request.getParameter("datum_novice"))+" "+nul.jeNull(request.getParameter("datum_novice_U"))));
}
else {
String rezu="";
vseb = (com.popultrade.model.Novice)contextUtil.getPopulatedObject(vseb,request);
vseb.setDatum_novice(nul.parseDatumUra( nul.jeNull(request.getParameter("datum_novice"))+" "+nul.jeNull(request.getParameter("datum_novice_U"))));
}
dao.saveNovice(vseb);
}
}
Hashtable ht =new Hashtable();
Hashtable htn =new Hashtable();
Hashtable htd =new Hashtable();
htd.put(""+ConPool.getPrevod("360J"+control.getJezik()).replaceAll("_"," "),"datum_novice");
ht.put(""+ConPool.getPrevod("360J"+control.getJezik()).replaceAll("_"," "),"datum_novice");
%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
<%=javaScript.getControlsEmptyValuesHashtable("document.dod",ht) %>
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<script language='javascript' src='js/ajax.js' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js' ></script>
<body   style="margin: 0"   <%=request.getParameter("akcija")==null?"onload=\"mom()\"":""%>>
<%
String rezu="";
if (request.getParameter("akcija")==null) {
%>
<form name=dod action="novice_edit.jsp" method="post" onSubmit="return check()">
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
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("363P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell"  width="30%" ><%
if (true) {
rezu="";
com.popultrade.dao.BaseObjectDAO doa =(com.popultrade.dao.BaseObjectDAO)contextUtil.getBeanDao("baseObjectDAO",pageContext.getServletContext());
com.popultrade.model.BaseObject mod = new com.popultrade.model.BaseObject();
List remi=doa.getBaseObjects(mod);
if (remi.size()>0) {
mod=(com.popultrade.model.BaseObject)remi.get(0);
}
}
%>
<input type="text" tabindex='4' id="status"  name="status"     value="<%=rezu%>" style="font-family: Verdana; font-size: 8pt"   autocomplete="off"  onkeyup="ajax_showOptionsID(this,'getCountriesByLetters',event,'sifrantopis366.jsp?status='+document.dod.status.value +'','1','status')" ></td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("361P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getNaslov_novice()+"");

%>
<input type="text" tabindex='2' id="naslov_novice"  name="naslov_novice"   maxlength='70' size='50' value="<%=rezu%>" style="font-family: Verdana; font-size: 8pt" ></td>
</tr>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("362P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getOpis_novice()+"");

%>
<textarea tabindex='3' id="opis_novice" name="opis_novice" cols='55' rows='7' style="font-family: Verdana; font-size: 8pt"><%=rezu%></textarea></td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("360P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.getDatumFormatFromDate(vseb.getDatum_novice(),"dd-MM-yyyy HH:mm");
%>
<%
String A360="";
String B360="";
if (rezu!=null && rezu.indexOf(" ")!=-1) {
A360=rezu.substring(0,rezu.indexOf(" "));
B360=rezu.substring(rezu.indexOf(" ")+1,rezu.length());
} 
%>
<input type="text" tabindex='1' id="datum_novice"  name="datum_novice"   maxlength='10' size='12' value="<%=A360%>" style="font-family: Verdana; font-size: 8pt" ><input type="text" tabindex='1' id="datum_novice_U"  name="datum_novice_U"   maxlength='5' size='6' value="<%=B360%>" style="font-family: Verdana; font-size: 8pt" ></td>
</tr>
<tr><td colspan="4" class="opiscell" align="center"><input type=submit value="<%=ConPool.getPrevod("358R"+control.getJezik()).replaceAll("_"," ") %>" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>
<script language='javascript'>
function custom() {
return true;
}
function mom() {
dp_ca1 = new Epoch('epoch_popup','popup',document.dod.datum_novice);

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
<p align="center"><%=ConPool.getPrevod("358X"+control.getJezik()).replaceAll("_"," ") %></td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
<script language=javascript>
var mon = null+"";
<%
if (request.getParameter("akcija")!=null && !request.getParameter("akcija").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
if (mon.indexOf("?")==-1) {
null = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
}
else {
null = mon.substring(0,mon.indexOf("idback")-1)+"&idback=<%=request.getParameter("id")%>";
}
}
else {
if (mon.indexOf("?")!=-1) {
if (mon.indexOf("id=")!=-1) {
null = mon.substring(0,mon.indexOf("?")) + "?idback=<%=request.getParameter("id")%>";
}
else {
null = null + "&idback=<%=request.getParameter("id")%>";
}
}
else {
null =null + "?idback=<%=request.getParameter("id")%>";
}
}
<%
}
else {
%>
if (mon.indexOf("id=")!=-1) {
null = mon.substring(0,mon.indexOf("?"));
}
else {
null = null;
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
