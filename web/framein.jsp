<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
<%

 String userAgent = request.getHeader( "User-Agent" );
boolean isFirefox = ( userAgent != null && userAgent.indexOf( "Firefox/" ) != -1 );
String size="0";
String scrol = "yes";
if (isFirefox) {
size="1";
scrol="auto";
}
%>
<html>
<link href='js/css/sm-core-css.css' rel='stylesheet' type='text/css' />
<link href='js/css/sm-simple/sm-simple.css' rel='stylesheet' type='text/css' />

<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script src="scripts/jquery.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script><script src="js/typeahead.bundle.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script src="scripts/jquery-migrate-3.0.0.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script><script src="js/typeahead.bundle.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript'  src="js/uijs2/jquery-ui.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>

<script type="text/javascript" src="js/jqxcore.js"></script>
<script type="text/javascript" src="js/jqxsplitter.js"></script>

<link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />


<script src="js/jquery.smartmenus.js" type="text/javascript"></script>
<style type="text/css">
#main-menu {
position:relative;
z-index:9999;
width:auto;
}
#main-menu ul {
width:12em; 
}
</style>
<style type="text/css">
html, body
{
margin: 0;
padding: 0;
overflow: hidden;
}
</style>
<body  style="margin: 0" >
<table cellspacing=0 cellpadding=0 width=100% height=100% >

<tr><td>
<div id="mainSplitter">
<div id='topp' style="background-image:url('podlaga.jpg');"   >
<iframe  noresize="noresize"  id="ifr2" name="PgnClientsReceiveFromprvain" target="PgnClientsReceiveFromdrugain"  scrolling="yes" frameborder="0"   src="nicdrag.jsp"   style="width:100%;height:100%"  >b</iframe>
</div>
<div  style="background-image:url('podlaga.jpg');">
<iframe noresize="noresize" id="ifr3" name="PgnClientsReceiveFromdrugain" target="PgnClientsReceiveFromprvain" src="nicdrag.jsp" scrolling="yes" frameborder="0" style="width:100%;height:100%"  onlodad="collapseL(this.contentWindow.location)"  >b</iframe>
</div>


</div>
</td></tr>
</table>
</body>
<script language="javascript">
$(document).ready(function () {
var theme = 'classic';
$('#mainSplitter').jqxSplitter({ theme: theme, width: '100%', height: '100%', orientation: 'vertical', panels: [{ size: '50%',collapsible:false }, { size: '50%',collapsible:true}] });
});
var prej = "";
function collapseL(kajj) {
}
function resetPageBlockAll() {
if (document.getElementById("ifr2").contentWindow!=null && typeof document.getElementById("ifr2").contentWindow.resetPageBlock === "function") { 
document.getElementById("ifr2").contentWindow.resetPageBlock();
}
if (document.getElementById("ifr3").contentWindow!=null && typeof document.getElementById("ifr3").contentWindow.resetPageBlock === "function") { 
document.getElementById("ifr3").contentWindow.resetPageBlock();
}
}

resetLoadingOverlay();
</script>
