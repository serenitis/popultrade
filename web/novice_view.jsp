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
com.popultrade.model.Novice vseb =new com.popultrade.model.Novice();
com.popultrade.dao.NoviceDAO dao = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null ) {
vseb = dao.getNovice(new Long(nul.jeNullDefault(request.getParameter("id"))));
}
String rezu="";
%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barve.css";
</style>
<script language='javascript' src='colors.js' ></script>
<script language='javascript' >
function mom() {
}
</script>
<body   style="margin: 0"  onload="mom()">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("281P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%" ><%
rezu=nul.getDatumFormatFromDate(vseb.getDatum_novice(),"dd-MM-yyyy HH:mm");
%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("282P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getNaslov_novice()+"");

%>
<%=rezu%>
</td>
</tr>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("283P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%" colspan="3"><%
rezu=nul.jeNull(vseb.getOpis_novice()+"");

%>
<%=rezu%>
</td></tr>
<tr><td colspan="4" class="opiscell" align="center">&nbsp;</td></tr></table></form>
<%
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
