<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.apache.commons.io.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />

<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />

<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%
}
%>
<%
try {
boolean bok=false;
int akcij=0;
Long nidd=new Long(0);
String napaka="";
boolean mum=true;




%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barve.css";
@import "tooltipcss.css";
</style>
<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>

<script type="text/javascript" src="ezcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<link rel="stylesheet" type="text/css" href="ezcalendar.css" />
<script language='javascript' src='popcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>


<script language="javascript">


</script>




<body   style="margin: 0"  >
<%
String rezu="";

%>
<form name=dod action="m_templatetables_gen.jsp" method="post"  >
<input type="hidden" name="idg" value="<%=request.getParameter("idg")%>">

<table border="0" cellspacing="1" style=" font-family:Verdana; font-size:8pt"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>

<tr><td class="opiscell" width="20%" align="left">Akcija na bazi po generaciji hibernate:</td><td class="valuecell"  width="30%" ><%


%>
<select id="akcijab"  name="akcijab"   tabindex='20'  class="inputIEx" >
<option value=""></option>
<option value="update" >update (update sheme baze)</option>
<option value="create" >create (dropa in naredi bazo na novo, unici vse podatke)</option>

</select> (ne rabit za produkcijo !!!)


</td>
<td class="opiscell" width="20%" align="left">Prikazuj selecte v consoli od tomcata:</td><td class="valuecell" width="30%">

  <input type="checkbox"  id="selecti"  name="selecti"   tabindex='25'  value="1" style="font-family: Verdana; font-size: 8pt">
Izberi vedno za test!

</td>

</tr>




<tr><td class="opiscell" colspan=4>Samo ce je NoSQL</td></tr>




<tr><td class="opiscell" width="20%" align="left">Host baze (npr: localhost):</td><td class="valuecell"  width="30%" >

<input type="text"  id="ns_host"  name="ns_host"   tabindex='30'  value="localhost" style="font-family: Verdana; font-size: 8pt">

</td>
<td class="opiscell" width="20%" align="left">Port baze:</td><td class="valuecell" width="30%">

<input type="text"  id="ns_port"  name="ns_port"   tabindex='35'  value="27017" style="font-family: Verdana; font-size: 8pt">


</td>

</tr>


<tr><td class="opiscell" width="20%" align="left">Database:</td><td class="valuecell"  width="30%" >

<input type="text"  id="ns_database"  name="ns_database"   tabindex='40'  value="test" style="font-family: Verdana; font-size: 8pt">

</td>
<td class="opiscell" width="20%" align="left">Ce baze ni creiraj:</td><td class="valuecell" width="30%">

 <input type="checkbox"  id="ns_auto"  name="ns_auto"   tabindex='45'  value="create" style="font-family: Verdana; font-size: 8pt">

</td>

</tr>













<tr><td colspan="4" class="opiscell" align="center"><input id="submitbutton"  type=submit value="Generiraj" style="font-family: Verdana; font-size: 8pt">&nbsp;</td></tr></table></form>


<%

}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
