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
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%
}
%>
<%
try {
boolean bok=false;
int akcij=0;
String nidd="";
String napaka="";
String dodpog="";
boolean mum=false;
if (!nul.jeNull(request.getParameter("id")).equals("")) {
if (!prisotnost.users.containsKey(nul.jeNull(request.getParameter("id")))) {
//prisotnost.addUserNarocilo(control.idUporabnikaLock,"",new Date(),3,"Codes_edit160");
//prisotnost.addUserNarocilo(control.idUporabnikaLock,request.getParameter("id"),new Date(),1,"Codes_edit160");
mum=true;
}
else if (prisotnost.istiUserKontrola(control.idUporabnikaLock,request.getParameter("id"))) {
mum=true;
}
}
else {
mum=true;
}
if (mum) {
com.popultrade.model.Codes sif =new com.popultrade.model.Codes();
com.popultrade.model.Codes vseb =new com.popultrade.model.Codes();
com.popultrade.dao.CodesDAO dao = (com.popultrade.dao.CodesDAO)contextUtil.getBeanDao("codesDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcijaXY")==null) {
sif.setId(new Long(request.getParameter("id")+""));
sif.setId(new Long(request.getParameter("id")));
List lis = dao.getCodess(sif,1,1,dodpog,"","");
if (lis.size()>0) {
vseb = (com.popultrade.model.Codes)lis.get(0);
}
}
else if (request.getParameter("akcijaXY")!=null)  {
if (!bok) {
String rabiinsert="";
if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
akcij=4;
String rezu="";
vseb = dao.getCodes(new Long(nul.jeNullDefault(request.getParameter("id"))));
vseb = (com.popultrade.model.Codes)contextUtil.getPopulatedObject(vseb,request);
nidd=vseb.getId()+"";
vseb = (com.popultrade.model.Codes)contextUtil.getPopulatedObject(vseb,request);
}
else {
akcij=5;
String rezu="";
vseb = (com.popultrade.model.Codes)contextUtil.getPopulatedObject(vseb,request);

control.removePageNum=true;
}
if (rabiinsert.equals("") && !bok) {
if (vseb.getId()!=null) {}
else {
}
dao.saveCodes(vseb);

nidd=vseb.getId()+"";






//if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("prevod"))  {
	
	
	Enumeration enn = request.getParameterNames();
	
	while (enn.hasMoreElements()) {
		
		String str = (String)enn.nextElement();
		
		if (str!=null && str.startsWith("prevod_")) {
			
			String[] stru = str.split("_");
			com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
			com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
			
			System.out.println("---------------------------- "+nidd);
			prevo.setPrevod_id(new Long(nidd));
			prevo.setSifra_jez(session.getAttribute("jezikv")+"");
			prevo.setVrsta(stru[2]);
			if (stru.length==4 && !stru[3].equals("")) {
			//	prevo.setId(new Long(stru[3]));
				
			}
			prevo = daop.getPrevodiCopy(prevo);
			
			if (prevo==null) {
				prevo = new com.popultrade.model.Prevodi();
				prevo.setPrevod(nul.jeNull(request.getParameter(str)));
				prevo.setPrevod_id(new Long(nidd));
				prevo.setSifra_jez(session.getAttribute("jezikv")+"");
				prevo.setVrsta(stru[2]);
				
			}
			prevo.setPrevod(nul.jeNull(request.getParameter(str)));
			
			daop.savePrevodi(prevo);
			
		//// setam prevod v memorji
			ConPool.setPrevod_admin(nidd,stru[2],session.getAttribute("jezikv")+"",nul.jeNull(request.getParameter(str)),prevo.getId()+"");
			
		}
		
		
		
	}
	
	
	
//}














}
}
}
Hashtable ht =new Hashtable();
Hashtable htn =new Hashtable();
Hashtable htnn =new Hashtable();
Hashtable htd =new Hashtable();




%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barveold.css";
@import "tooltipcss.css";
@import "ccss/custom.css";
@import "barveblue.css";
</style>
<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type="text/javascript" src="ezcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<link rel="stylesheet" type="text/css" href="ezcalendar.css" />
<script language='javascript' src='popcalendar.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script src="scripts/jquery.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script><script src="js/typeahead.bundle.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<body   style="margin: 0"  onload="mom()">
<%
String rezu="";
if (request.getParameter("akcijaXY")==null) {
%>
<form name=dod action="m_templatecodes_edit.jsp" method="post"    onSubmit="">
<%
if (vseb.getId()!=null && !vseb.getId().equals("")) {
%>
<input type=hidden name="akcijaXY" value="UPDATE">
<%
}
else {
%>
<input type=hidden name="akcijaXY" value="NEW">
<%
}
%>
<input type=hidden name="id" value="<%=nul.jeNull(vseb.getId()+"")%>">
<table border="0" cellspacing="1" class="fonti"  width="100%"  ><tr><td colspan="4" class="opiscell">&nbsp;</td></tr>
<tr><td class="opiscell" width="20%" align="left">Group code:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getCode_group()+"");

%>
<input type="text"    tabindex='10' id="code_group"  name="code_group"     value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"  onblur="change(this,'white');"  >
</td>
<td class="opiscell" width="20%" align="left">Code:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getCode()+"");

%>
<input type="text"    tabindex='15' id="code"  name="code"     value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"  onblur="change(this,'white');"  >
</td>
</tr>
<tr><td class="opiscell" width="20%" align="left">View language:</td><td class="valuecell"  width="30%" colspan=3 style="height:35px" ><%


%><%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%>
</td>
</tr>
<tr>

<td class="opiscell" width="20%" align="left">To translate language:</td><td class="valuecell" width="30%" colspan=3>
<%
if (vseb.getId()!=null) {
rezu = nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""));
}
else {
	rezu="";
}
%><textarea cols=120 rows=2 tabindex='25' name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" id="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" class="inputIExTA"  ><%=rezu%></textarea>
</td>
</tr>
<tr><td colspan="4" class="opiscell" align="center"><input id="submitbutton"  type=submit value="Confirm"  class="fontisubmit"> &nbsp;</td></tr></table></form>
<script language='javascript'>
function setDD() {

}




function custom() {


document.dod.submitbutton.disabled=true;
return true;
}
function KeyCheck(event){
if ( typeof event == "undefined" ) event = window.event;
var KeyID = event.keyCode;
if (KeyID==9 ){
if (window.setAll){
setAll();
}
}
}
function Focusie(){
if (window.setAll){
setAll();
}
}
function KeyCheckMouse(e){
var KeyID = e.keyCode;
if (window.setAll){
setAll();
}
}
function mom() {
<%if (bok) {%>
alert('<%=napaka%>');
<%}%>

<%
if (request.getParameter("akcijaXY")==null) {
%>
<%
}
%>
parent.frames[3].location='nic.jsp';
}
</script>
<%
}
else {
//prisotnost.addUserNarocilo(control.idUporabnikaLock,nidd+"",new Date(),akcij,"Codes",control.getUserName(),"","Codes_edit160");
%>
<table border="0" cellspacing="1"  class="fonti"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">Insert/change ok.</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
<script language=javascript>
function mom() {
<%if (bok) {%>
alert('<%=napaka%>');
<%}%>
}
var mon = parent.frames[1].location+"";
<%
if (request.getParameter("akcijaXY")!=null && !request.getParameter("akcijaXY").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
if (mon.indexOf("?")==-1) {
parent.frames[1].location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
}
else {
parent.frames[1].location = mon.substring(0,mon.indexOf("idback"))+"idback=<%=request.getParameter("id")%>";
}
}
else {
if (mon.indexOf("?")!=-1) {
if (mon.indexOf("id=")!=-1) {
parent.frames[1].location = mon.substring(0,mon.indexOf("?")+1) + "?idback=<%=request.getParameter("id")%>";
}
else {
parent.frames[1].location = parent.frames[1].location + "&idback=<%=request.getParameter("id")%>";
}
}
else {
parent.frames[1].location =parent.frames[1].location + "?idback=<%=request.getParameter("id")%>";
}
}
<%
}
else {
%>
if (mon.indexOf("DELETE")!=-1) {
parent.frames[1].location = mon.replace("akcijaXY=DELETE","");
}
else {
parent.frames[1].location = parent.frames[1].location;
}
<%
}
%>
</script>
<%
}
}
else {
%>
<html><head><title>spreminjaj</title></head>
<style type=text/css>
@import "barveold.css";
@import "tooltipcss.css";
@import "ccss/custom.css";
@import "barveblue.css";
</style>
<table border="0" cellspacing="1"  class="fonti"   width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">Sprememba podatkov ni dovoljena, drugi uporabnik trenutno spreminja te iste podatke.</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>
<%
}
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
