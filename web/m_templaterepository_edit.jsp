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
//prisotnost.addUserNarocilo(control.idUporabnikaLock,"",new Date(),3,"TemplateRepository_edit160");
//prisotnost.addUserNarocilo(control.idUporabnikaLock,request.getParameter("id"),new Date(),1,"TemplateRepository_edit160");
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
com.popultrade.model.TemplateRepository sif =new com.popultrade.model.TemplateRepository();
com.popultrade.model.TemplateRepository vseb =new com.popultrade.model.TemplateRepository();
com.popultrade.dao.TemplateRepositoryDAO dao = (com.popultrade.dao.TemplateRepositoryDAO)contextUtil.getBeanDao("templateRepositoryDAO",pageContext.getServletContext());
if (request.getParameter("id")!=null && request.getParameter("akcijaXY")==null) {
sif.setId(new Long(request.getParameter("id")+""));
sif.setId(new Long(request.getParameter("id")));
List lis = dao.getTemplateRepositorys(sif,1,1,dodpog,"","");
if (lis.size()>0) {
vseb = (com.popultrade.model.TemplateRepository)lis.get(0);
}
}
else if (request.getParameter("akcijaXY")!=null)  {
if (!bok) {
String rabiinsert="";
if (request.getParameter("id")!=null && !request.getParameter("id").equals("")) {
akcij=4;
String rezu="";
vseb = dao.getTemplateRepository(new Long(nul.jeNullDefault(request.getParameter("id"))));
vseb = (com.popultrade.model.TemplateRepository)contextUtil.getPopulatedObject(vseb,request);
nidd=vseb.getId()+"";
vseb = (com.popultrade.model.TemplateRepository)contextUtil.getPopulatedObject(vseb,request);
}
else {
akcij=5;
String rezu="";
vseb = (com.popultrade.model.TemplateRepository)contextUtil.getPopulatedObject(vseb,request);

control.removePageNum=true;
}
if (rabiinsert.equals("") && !bok) {
if (vseb.getId()!=null) {}
else {
}
dao.saveTemplateRepository(vseb);

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
<form name=dod action="m_templaterepository_edit.jsp" method="post"    onSubmit="">
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
<tr><td class="opiscell" width="20%" align="left">Title:</td><td class="valuecell"  width="30%" ><%
rezu=nul.jeNull(vseb.getTitle()+"");

%>
<input type="text"    tabindex='10' id="title" required  name="title"  maxlength=80 size=90   value="<%=rezu%>"    class="inputIEx"   onfocus="ajax_options_hide();change(this,'yellow');setKlici(this,1);"  onblur="change(this,'white');"  >
</td>
<td class="opiscell" width="20%" align="left">Type:</td><td class="valuecell" width="30%">
<%
rezu=nul.jeNull(vseb.getRtype()+"");

%>
<select class="inputIEx" require id="rtype" name="rtype">
<option value="java" <%=nul.jeN(vseb.getRtype()).equals("java")?"selected":"" %>>Java</option>
<option value="javascript" <%=nul.jeN(vseb.getRtype()).equals("javascript")?"selected":"" %>>Javascript</option>
<option value="html" <%=nul.jeN(vseb.getRtype()).equals("html")?"selected":"" %>>Html</option>
<option value="other" <%=nul.jeN(vseb.getRtype()).equals("other")?"selected":"" %>>Combined</option>
</select>


</td>
</tr>
<tr><td class="opiscell" width="20%" align="left">Description:</td><td class="valuecell"  width="30%" colspan=3 style="height:35px" >
<%
rezu=nul.jeNull(vseb.getDescription()+"");

%>
<textarea cols=120 rows=3 tabindex='25' name="description" id="description" class="inputIExTA"  ><%=rezu%></textarea>

</td>
</tr>
<tr>

<td class="opiscell" width="20%" align="left">Content:</td><td class="valuecell" width="30%" colspan=3>
<%
rezu=nul.jeNull(vseb.getContent()+"");

%><textarea cols=120 required  tabindex='25' name="content" id="content" class="inputIExTA" style="height:180px !important" ><%=rezu%></textarea>
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
//parent.frames[3].location='nic.jsp';
}
</script>
<%
}
else {
//prisotnost.addUserNarocilo(control.idUporabnikaLock,nidd+"",new Date(),akcij,"TemplateRepository",control.getUserName(),"","TemplateRepository_edit160");
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

var mon = parent.frames[0].location+"";





<%
if (request.getParameter("akcijaXY")!=null && !request.getParameter("akcijaXY").equals("NEW")) {
%>
if (mon.indexOf("idback")!=-1) {
if (mon.indexOf("?")==-1) {
parent.frames[0].location = mon.substring(0,mon.indexOf("idback")-1)+"?idback=<%=request.getParameter("id")%>";
}
else {
parent.frames[0].location = mon.substring(0,mon.indexOf("idback"))+"idback=<%=request.getParameter("id")%>";
}
}
else {
if (mon.indexOf("?")!=-1) {
if (mon.indexOf("id=")!=-1) {
parent.frames[0].location = mon.substring(0,mon.indexOf("?")+1) + "?idback=<%=request.getParameter("id")%>";
}
else {
parent.frames[0].location = parent.frames[0].location + "&idback=<%=request.getParameter("id")%>";
}
}
else {
parent.frames[0].location =parent.frames[0].location + "?idback=<%=request.getParameter("id")%>";
}
}
<%
}
else {
%>
if (mon.indexOf("DELETE")!=-1) {
parent.frames[0].location = mon.replace("akcijaXY=DELETE","");
}
else {
parent.frames[0].location = parent.frames[0].location;
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
