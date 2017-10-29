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

%>

<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barveold.css";
@import "tooltipcss.css";
@import "ccss/custom.css";
@import "css_dat/new_list.css";

@import "js/rtf/demo.css";
@import "js/rtf/jquery-teokno-1.4.0.css";

</style>
<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>

<link rel="stylesheet" href="js/uijs/jquery-ui.css">
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script src="scripts/jquery.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script><script src="js/typeahead.bundle.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript'  src="js/uijs/jquery-ui.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" src="js/rtf/jquery-te-1.4.0.min.js" charset="utf-8"></script>
<body   style="margin: 0" onload="setvall()" >

<table border="0" cellspacing="1" class="fonti"  width="100%" height="100%"  ><tr><td colspan="4"  style="height:15px" class="opiscell">&nbsp;</td></tr>


<tr><td class="valuecell"  colspan="3">
<div style="width:100%;height:100%">
<textarea    tabindex='50' id="description112" name="description112" cols='120' rows='5' style="width:480px !important;height:600px !important" onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);" onblur="change(this,'white');" clawss="inputIEta" ></textarea>
</div>
</td></tr>


</td></tr><tr><td colspan="4" class="opiscell" align="center"  style="height:15px" ><input id="submitbutton"  onclick="prenesi()" type=button value="<%=ConPool.getPrevod("198R"+control.getJezik()).replaceAll("_"," ") %>"  class="fontisubmit"> &nbsp;</td></tr></table>


<script type="text/javascript">
$( document ).ready(function() {
	//document.getElementById('description112').value=top.rteditor.value;
$('#description112').jqte();
$("#description112").jqteVal(top.rteditor.value);
//alert(top.rteditor.value);

});

function setvall() {
	
	
}
function prenesi() {
	
//	top.rteditor.value=document.getElementById('description112').value;
	//top.rteditor.jqteVal(top.rteditor.value);
	top.sloko.jqteVal(document.getElementById('description112').value);
	top.closeove4();
}
</script>


