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
com.popultrade.model.Codes vseb =new com.popultrade.model.Codes();
com.popultrade.dao.CodesDAO dao = (com.popultrade.dao.CodesDAO)contextUtil.getBeanDao("codesDAO",pageContext.getServletContext());
if (session.getAttribute("codes_search")!=null) {
vseb = (com.popultrade.model.Codes)session.getAttribute("codes_search");
}
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
	
	if (trim(document.dod.lang_text.value)!="" && trim(document.dod.language.value)=="") {
		
		alert("Please select a language!");
		return false;
	}
	
	
	
//oknoShow();
document.dod.target=parent.frames[1].name;
document.dod.code_group.value=encodeURIComponent(document.dod.code_group.value);
document.dod.code.value=encodeURIComponent(document.dod.code.value);
document.dod.lang_text.value=encodeURIComponent(document.dod.lang_text.value);
document.dod.language.value=encodeURIComponent(document.dod.language.value);
}
</script>
<body   style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onload="chg()">
<div id="basic-modal-content"><img src='loadingg.gif'></div>
<%
String rezu="";
%>
<form name="dod" method="get" action="m_templatecodes.jsp" target="ifr2" onSubmit="return subm()">
<input type="hidden" name="isci" value="yes">
<table border="0" cellspacing="1"  class="fonti"   width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Group code:</td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getCode_group()+"");

%>
<input type="text"  tabindex='15' id="code_group"  name="code_group"          class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici();"   onblur="change(this,'white');"    value="<%=nul.jeNull(vseb.getCode_group()+"")%>">
</td>
<td class="opiscell" width="20%" align="left">Code:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getCode()+"");

%>
<input type="text"  tabindex='10' id="code"  name="code"          class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici();"   onblur="change(this,'white');"    value="<%=nul.jeNull(vseb.getCode()+"")%>">
</td></tr>

<tr><td class="opiscell" width="20%" align="left">Translation:</td><td class="valuecell" width="30%"  width="30%" ><%
rezu=nul.jeNull(vseb.getLang_text()+"");

%>
<input type="text"  tabindex='20' id="lang_text"  name="lang_text"          class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici();"   onblur="change(this,'white');"    value="<%=nul.jeNull(vseb.getLang_text()+"")%>">
</td>
<td class="opiscell" width="20%" align="left">Language:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getLanguage()+"");

%>


			<select name="language" id="language"  class="inputIEx"  >
            			<option value=""></option>
            			<%
            				com.popultrade.dao.JezikiDAO daosi = (com.popultrade.dao.JezikiDAO)contextUtil.getBeanDao("jezikiDAO",pageContext.getServletContext());
					List lil = daosi.getJezikis(new com.popultrade.model.Jeziki());

					Iterator itti = lil.iterator();

					while (itti.hasNext()) {
						com.popultrade.model.Jeziki sifr = (com.popultrade.model.Jeziki)itti.next();
			
							%>
							<option  value="<%=nul.jeNull(sifr.getSIFRA_JEZ())%>" <%=nul.jeNull(sifr.getSIFRA_JEZ()).equals(rezu)?"selected":""%>><%=nul.jeNull(sifr.getOPIS_JEZ())%></option>
							<%
						
					}
					%>
					
					
					</select>




</td></tr>



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
