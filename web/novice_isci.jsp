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
if (!control.getPravica()) {
%><jsp:forward page="logout.jsp"/><%
}
try {
com.popultrade.model.Novice vseb =new com.popultrade.model.Novice();
com.popultrade.dao.NoviceDAO dao = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
if (session.getAttribute("novice_search")!=null) {
vseb = (com.popultrade.model.Novice)session.getAttribute("novice_search");
}
%>
<%
boolean bok=false;
Hashtable ht =new Hashtable();
Hashtable htn =new Hashtable();
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
<script language='javascript'>
function chg() {

}
function subm() {
document.dod.target=parent.frames[1].name;
}
</script>
<body   style="margin: 0"  background="podlaga.jpg" bgproperties="fixed"  onload="chg()">
<%
String rezu="";
%>
<form name="dod" method="post" action="test.jsp" target="ifr2" onSubmit="return subm()">
<input type="hidden" name="isci" value="yes">
<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("293P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%" ><select tabindex='1' id="status" name="status" style="font-family: Verdana; font-size: 8pt" >
<option></option><%
if (true) {
com.popultrade.dao.SifrantopisDAO daoSifrantopis = (com.popultrade.dao.SifrantopisDAO)contextUtil.getBeanDao("sifrantopisDAO",pageContext.getServletContext());
com.popultrade.model.Sifrantopis modSifrantopis = new com.popultrade.model.Sifrantopis();
modSifrantopis.setSFT_SIFRANT("X08"+"");
modSifrantopis.setJZK_SIFRA_JEZIK(control.getJezik()+"");
List liSifrantopis = daoSifrantopis.getSifrantopiss(modSifrantopis);
Iterator iSifrantopis=liSifrantopis.iterator();
while (iSifrantopis.hasNext()) {
com.popultrade.model.Sifrantopis modiSifrantopis = (com.popultrade.model.Sifrantopis)iSifrantopis.next();
%>
<option value="<%=nul.jeNull(modiSifrantopis.getSFT_SIFRA())%>" <%=nul.jeNull(modiSifrantopis.getSFT_SIFRA()).equals(nul.jeNull(vseb.getStatus()))?"selected":""%>><%=nul.jeNull(modiSifrantopis.getOPIS())%></option>;
<%

}

}
%>
</select>
</td>
<td class="opiscell" width="20%" align="left"><%=ConPool.getPrevod("294P"+control.getJezik()).replaceAll("_"," ") %></td><td class="valuecell" width="30%">
<input type="text" tabindex='2' id="naslov_novice"  name="naslov_novice"   maxlength='70' size='35' value="<%=nul.jeNull(vseb.getNaslov_novice())%>" style="font-family: Verdana; font-size: 8pt" ></td></tr>
<tr>
<td width="100%" colspan="4" align="right" bgcolor="#C3E1FC">
<p align="center"><input  type=button  value="<%=ConPool.getPrevod("292S"+control.getJezik()).replaceAll("_"," ") %>" style="font-family: Verdana; font-size: 8pt"> <input type=submit value="<%=ConPool.getPrevod("292R"+control.getJezik()).replaceAll("_"," ") %>" style="font-family: Verdana; font-size: 8pt">
</td>
</tr>
</table>
</form>
<script language='javascript'>
function custom() {
return true;
}
function mom() {
//parent.frames[3].location = "nic.jsp";
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
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
