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
%><jsp:forward page="logout.jsp"/><%
}
%>
<%
try {
boolean bok=false;
com.popultrade.model.Em1DocumentLog vseb =new com.popultrade.model.Em1DocumentLog();
com.popultrade.dao.Em1DocumentLogDAO dao = (com.popultrade.dao.Em1DocumentLogDAO)contextUtil.getBeanDao("em1DocumentLogDAO",pageContext.getServletContext());
vseb.setId(new Long(request.getParameter("id")+""));
List lis =null;
lis = dao.getEm1DocumentLogs(vseb,1,1,"","","");
if (lis !=null && lis.size()==1) {
vseb = (com.popultrade.model.Em1DocumentLog)lis.get(0);
}
String rezu="";
String rezu2="";
%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barve.css";
@import "tooltipcss.css";
@import "js/jquery.contextmenu.css";
</style>
<script language='javascript' src='colors.js' ></script>
<script type="text/javascript" language="JavaScript" src="tooltip.js"></script>
<script language='javascript' src='colors.js' ></script>
<script language='javascript' >
function mom() {
parent.frames[2].location = "nic.jsp";
}
</script>
<body   style="margin: 0"  onload="mom()">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001947P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getId()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001949P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.getDatumFormatFromDate(vseb.getMessage_dt(),"dd-MM-yyyy HH:mm");
%>
<%=rezu%>
<%
rezu="";
%>
</td>
</tr>
<tr><td class="valuecell" colspan="4"  ><%=ConPool.getPrevod("1001951P"+control.getJezik()).replaceAll("_"," ") %>&nbsp;</td></tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001953P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getSender_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1001954P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getSender_name()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001959P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getReceiver_gln()+"");

%>
<%=rezu%>
<%
rezu="";
%>
<%=ConPool.getPrevod("1001960P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getReceiver_name()+"");

%>
<%=rezu%>
<%
rezu="";
%>
</td>
</tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001963P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getBuyer_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1001964P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getBuyer_name()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001967P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getSupplier_gln()+"");

%>
<%=rezu%>
<%
rezu="";
%>
<%=ConPool.getPrevod("1001968P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getSupplier_name()+"");

%>
<%=rezu%>
<%
rezu="";
%>
</td>
</tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001971P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  colspan="3"><%
rezu=nul.jeNull(vseb.getDelivery_party_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1001972P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getDelivery_party_name()+"");

%>
<%=rezu%>
</td></tr>
<tr><td class="valuecell" colspan="4"  ><%=ConPool.getPrevod("1001976P"+control.getJezik()).replaceAll("_"," ") %>&nbsp;</td></tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001978P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getDocument_type()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1001979P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getDocument_code()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1001985P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getMessage_code()+"");

%>
<%=rezu%>
<%
rezu="";
%>
</td>
</tr>
<tr><td colspan="4" class="opiscell" align="center">&nbsp;</td></tr></table></form>
<%
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
