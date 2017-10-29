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
try {/*
com.popultrade.model.TemplateRepository vseb =new com.popultrade.model.TemplateRepository();
com.popultrade.dao.TemplateRepositoryDAO dao = (com.popultrade.dao.TemplateRepositoryDAO)contextUtil.getBeanDao("codesDAO",pageContext.getServletContext());
*/
%>
<%
boolean bok=false;
Hashtable ht =new Hashtable();
Hashtable htn =new Hashtable();
Hashtable htnn =new Hashtable();
%>
<html><head><title>spreminjaj</title></head>
<link type='text/css' href='styles/basic.css' rel='stylesheet' media='screen' />
<link type='text/css' href='styles/basic_ie.css' rel='stylesheet' media='screen' />
<style type=text/css>
@import "barveold.css";
@import "ccss/custom.css";
@import "barveblue.css";
</style>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type="text/javascript" language="JavaScript" src="scripts/jquery.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" src="ezcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<link rel="stylesheet" type="text/css" href="ezcalendar.css" />
<script language='javascript' src='popcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type='text/javascript' src='js/jquery.simplemodal.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script type='text/javascript' src='js/basic.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript'>
function chg() {

}
function subm() {
	

	
//oknoShow();
document.dod.target=parent.frames[0].name;
document.dod.alltext.value=encodeURIComponent(document.dod.alltext.value);

}
</script>
<body   style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onload="chg()">
<div id="basic-modal-content"><img src='loadingg.gif'></div>
<%
String rezu="";
%>
<form name="dod" method="get" action="m_templaterepository.jsp" target="ifr2" onSubmit="return subm()">
<input type="hidden" name="isci" value="yes">
<table border="0" cellspacing="1"  class="fonti"   width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Text:</td><td class="valuecell" width="30%"  width="30%"  colspan=3><%

%>
<input type="text"  tabindex='15' id="alltext"  name="alltext"    size="70"      class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici();"   onblur="change(this,'white');"    value="">
</td>
</tr>



<tr>
<td width="100%" colspan="4" align="right"  class="opiscell">
<p align="center"> <input type=submit  value="Search"  class="fontisubmit" >
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
if (request.getParameter("akcijaXY")==null) {
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
