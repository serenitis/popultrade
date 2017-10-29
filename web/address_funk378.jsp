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
%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
<link rel="stylesheet" type="text/css" href="scripts/epoch_styles.css">
<script type="text/javascript" src="scripts/epoch_classes.js"></script>
<script language='javascript' src='popcalendar.js'></script>
<script language='javascript' src='datum2.js' ></script>
<script language='javascript' src='js/ajax.js' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js' ></script>
<body   style="margin: 0"   onload="mom()">
<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">
<%
String odg_funkcija="";
if (true) {
com.popultrade.dao.NoviceDAO doa380Novice =(com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
com.popultrade.model.Novice mod380Novice = new com.popultrade.model.Novice();
mod380Novice.setId(new Long(request.getParameter("id")));
List remi380Novice=doa380Novice.getNovices(mod380Novice);
if (remi380Novice.size()>0) {
	System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC ::: "+request.getParameter("id"));
mod380Novice=(com.popultrade.model.Novice)remi380Novice.get(0);
}

if  (  !nul.jeNull(mod380Novice.getId()+"").equals("")) {
if (true) {
com.popultrade.dao.NoviceDAO doa393Novice =(com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
com.popultrade.model.Novice mod393Novice = new com.popultrade.model.Novice();
mod393Novice.setStatus(mod380Novice.getStatus());
mod393Novice.setNaslov_novice(mod380Novice.getNaslov_novice());
mod393Novice.setSifra_novice(mod380Novice.getSifra_novice());
mod393Novice.setDatum_novice(mod380Novice.getDatum_novice());
mod393Novice.setDatum_vnosa(mod380Novice.getDatum_vnosa());
mod393Novice.setOpis_novice(mod380Novice.getOpis_novice());
doa393Novice.saveNovice(mod393Novice);


odg_funkcija=nul.jeNull(ConPool.getPrevod("401P"+control.getJezik()));
System.out.println(odg_funkcija);
}
}
}
%>
<%=odg_funkcija%></td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
<script language=javascript>

function mom() {
//parent.frames[1].location='test.jsp';
}
</script>
</body>
<%
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
