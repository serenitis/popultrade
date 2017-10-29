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
com.popultrade.model.Em1Eventlog vseb =new com.popultrade.model.Em1Eventlog();
com.popultrade.dao.Em1EventlogDAO dao = (com.popultrade.dao.Em1EventlogDAO)contextUtil.getBeanDao("em1EventlogDAO",pageContext.getServletContext());
vseb.setId(new Long(request.getParameter("id")+""));
List lis =null;
lis = dao.getEm1Eventlogs(vseb,1,1,"","","");
if (lis !=null && lis.size()==1) {
vseb = (com.popultrade.model.Em1Eventlog)lis.get(0);
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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000644P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getId()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000634P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.getDatumFormatFromDate(vseb.getLog_time(),"dd-MM-yyyy HH:mm");
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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000649P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getHub_event_id()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000652P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.getDatumFormatFromDate(vseb.getEvent_dt(),"dd-MM-yyyy HH:mm");
%>
<%=rezu%>
<%
rezu="";
%>
</td>
</tr>
<tr><td class="valuecell" colspan="4"  ><%=ConPool.getPrevod("1000654P"+control.getJezik()).replaceAll("_"," ") %>&nbsp;</td></tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000632P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu="";
rezu2="";

if  (  nul.jeNull(vseb.getEvent_type()+"").equals("E")) {
rezu="<font color=red>"+vseb.getEvent_code()+"</font>"+"";

rezu2=rezu2+" "+rezu;
}

else if ( nul.jeNull(vseb.getEvent_type()+"").equals("I")) {
rezu="<font color=green>"+vseb.getEvent_code()+"</font>"+"";

rezu2=rezu2+" "+rezu;
}

else  {
rezu=""+nul.jeNull(vseb.getEvent_code()+"")+"";

rezu2=rezu2+" "+rezu;
}
rezu=rezu2;
%>
<%=rezu%>
 <%=ConPool.getPrevod("1001071P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu="";
rezu2="";
rezu="";
if (true  && !nul.jeNull(vseb.getEvent_code()+"").equals("")) {
com.popultrade.dao.Em1EventTextDAO doa =(com.popultrade.dao.Em1EventTextDAO)contextUtil.getBeanDao("em1EventTextDAO",pageContext.getServletContext());
com.popultrade.model.Em1EventText mod = new com.popultrade.model.Em1EventText();
mod.setLanguage_id(control.getJezik()+"");
mod.setEvent_code(nul.jeNull(vseb.getEvent_code()).replaceAll("_","\\_"));
List remi=doa.getEm1EventTexts(mod);
if (remi.size()>0) {
mod=(com.popultrade.model.Em1EventText)remi.get(0);
rezu=nul.jeNull(mod.getEvent_text());

rezu2=rezu2+" "+rezu;
}
}
rezu=rezu2;
%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000648P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getEvent_type()+"");

%>
<%=rezu%>
<%
rezu="";
%>
<%=ConPool.getPrevod("1001184P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu="";
rezu2="";
rezu="";
if (true  && !nul.jeNull(vseb.getEvent_type()+"").equals("")) {
com.popultrade.dao.Xm1KvItemDAO doa =(com.popultrade.dao.Xm1KvItemDAO)contextUtil.getBeanDao("xm1KvItemDAO",pageContext.getServletContext());
com.popultrade.model.Xm1KvItem mod = new com.popultrade.model.Xm1KvItem();
mod.setDomain_key("em1.event.event_type"+"");
mod.setItem_key(nul.jeNull(vseb.getEvent_type()).replaceAll("_","\\_"));
List remi=doa.getXm1KvItems(mod);
if (remi.size()>0) {
mod=(com.popultrade.model.Xm1KvItem)remi.get(0);
rezu=nul.jeNull(mod.getItem_value());

rezu2=rezu2+" "+rezu;
}
}
rezu=rezu2;
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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000636P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getSub_event_code()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1001072P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu="";
rezu2="";
rezu="";
if (true  && !nul.jeNull(vseb.getEvent_code()+"").equals("") && !nul.jeNull(vseb.getSub_event_code()+"").equals("")) {
com.popultrade.dao.Em1SubEventTextDAO doa =(com.popultrade.dao.Em1SubEventTextDAO)contextUtil.getBeanDao("em1SubEventTextDAO",pageContext.getServletContext());
com.popultrade.model.Em1SubEventText mod = new com.popultrade.model.Em1SubEventText();
mod.setEvent_code(nul.jeNull(vseb.getEvent_code()).replaceAll("_","\\_"));
mod.setLanguage_id(control.getJezik()+"");
mod.setSub_event_code(nul.jeNull(vseb.getSub_event_code()).replaceAll("_","\\_"));
List remi=doa.getEm1SubEventTexts(mod);
if (remi.size()>0) {
mod=(com.popultrade.model.Em1SubEventText)remi.get(0);
rezu=nul.jeNull(mod.getSub_event_text());

rezu2=rezu2+" "+rezu;
}
}
rezu=rezu2;
%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000638P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getSub_event_text()+"");

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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000722P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  colspan="3"><%
rezu=nul.jeNull(vseb.getOperator_text()+"");

%>
<%=rezu%>
</td></tr>
<tr><td class="valuecell" colspan="4"  ><%=ConPool.getPrevod("1000640P"+control.getJezik()).replaceAll("_"," ") %>&nbsp;</td></tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000656P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  colspan="3"><%
rezu=nul.jeNull(vseb.getHub_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1000657P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getHub_name()+"");

%>
<%=rezu%>
</td></tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000663P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getSender_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1000664P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getSender_name()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000668P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getReceiver_gln()+"");

%>
<%=rezu%>
<%
rezu="";
%>
<%=ConPool.getPrevod("1000669P"+control.getJezik()).replaceAll("_"," ") %> <%
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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000672P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getBuyer_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1000673P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getBuyer_name()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000676P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getSupplier_gln()+"");

%>
<%=rezu%>
<%
rezu="";
%>
<%=ConPool.getPrevod("1000677P"+control.getJezik()).replaceAll("_"," ") %> <%
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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000680P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  colspan="3"><%
rezu=nul.jeNull(vseb.getDelivery_party_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1000681P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getDelivery_party_name()+"");

%>
<%=rezu%>
</td></tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000685P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  colspan="3"><%
rezu=nul.jeNull(vseb.getOrdered_by_gln()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1000686P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getOrdered_by_name()+"");

%>
<%=rezu%>
</td></tr>
<tr><td class="valuecell" colspan="4"  ><%=ConPool.getPrevod("1000691P"+control.getJezik()).replaceAll("_"," ") %>&nbsp;</td></tr>
<%
rezu="";
%>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000693P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getDocument_type()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1000698P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getDocument_code()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000699P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getMessage_code()+"");

%>
<%=rezu%>
<%
rezu="";
%>
<%=ConPool.getPrevod("1000703P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.getDatumFormatFromDate(vseb.getMessage_dt(),"dd-MM-yyyy HH:mm");
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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000717P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  colspan="3"><%
rezu=nul.jeNull(vseb.getDirection()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1001057P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu="";
rezu2="";
rezu="";
if (true  && !nul.jeNull(vseb.getDirection()+"").equals("")) {
com.popultrade.dao.Xm1KvItemDAO doa =(com.popultrade.dao.Xm1KvItemDAO)contextUtil.getBeanDao("xm1KvItemDAO",pageContext.getServletContext());
com.popultrade.model.Xm1KvItem mod = new com.popultrade.model.Xm1KvItem();
mod.setItem_key(nul.jeNull(vseb.getDirection()).replaceAll("_","\\_"));
mod.setDomain_key("xm1.document.direction"+"");
List remi=doa.getXm1KvItems(mod);
if (remi.size()>0) {
mod=(com.popultrade.model.Xm1KvItem)remi.get(0);
rezu=nul.jeNull(mod.getItem_value());

rezu2=rezu2+" "+rezu;
}
}
rezu=rezu2;
%>
<%=rezu%>
</td></tr>
<%
rezu="";
%>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000704P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getDocument_status()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000707P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getApplication_status()+"");

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
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000709P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getR_document_type()+"");

%>
<%=rezu%>
 <%=ConPool.getPrevod("1000710P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.jeNull(vseb.getR_document_code()+"");

%>
<%=rezu%>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("1000713P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getR_message_code()+"");

%>
<%=rezu%>
<%
rezu="";
%>
<%=ConPool.getPrevod("1000715P"+control.getJezik()).replaceAll("_"," ") %> <%
rezu=nul.getDatumFormatFromDate(vseb.getR_message_dt(),"dd-MM-yyyy HH:mm");
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
