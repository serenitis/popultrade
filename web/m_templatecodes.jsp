<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.net.URLDecoder"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
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

if (request.getParameter("jezikp")!=null && !request.getParameter("jezikp").equals("")) {
session.setAttribute("jezikp",request.getParameter("jezikp"));
session.setAttribute("jezikv",request.getParameter("jezikv"));
}
// stevilo prikazov vrstic
int stpri = control.st_vrstic;
prisotnost.addUserNarocilo(control.idUporabnikaLock,"",new Date(),3,"m_templatecodes");
int stej = 0;
String[] colors = {"plava1","plava2","silver"};
int stvrstic=0;
boolean iskanje=false;
boolean lahkobrise=true;
try {
com.popultrade.dao.CodesDAO dao = (com.popultrade.dao.CodesDAO)contextUtil.getBeanDao("codesDAO",pageContext.getServletContext());
if (request.getParameter("akcijaXY")!=null && request.getParameter("akcijaXY").equals("DELETE"))  {
if (lahkobrise){
try {
dao.removeCodes(new Long(request.getParameter("id")));
prisotnost.addUserNarocilo(control.idUporabnikaLock,request.getParameter("id")+"",new Date(),6,"Codes",control.getUserName(),"","m_templatecodes");
}catch (Exception ec){
}
}
}
int pagenum=1;
int stizpisov=stpri;
if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {
pagenum = Integer.parseInt(request.getParameter("pagenumber"));
session.setAttribute("pagenumberCodes153",pagenum+"");
}
else {
session.setAttribute("pagenumberCodes153",1+"");
}
if (control.removePageNum) {
pagenum=1;
control.removePageNum=false;
}
String stolpci =nul.jeNull(control.getColumnsUser(contextUtil,pageContext.getServletContext(),"Codes153"));
String orderby = "";
if (!nul.jeNull(request.getParameter("orderup")).equals("")) {
orderby = request.getParameter("orderup");
}
String orderbysmer = "";
if (!nul.jeNull(request.getParameter("orderupsmer")).equals("")) {
orderbysmer =request.getParameter("orderupsmer");
}
String dodpog = "";
com.popultrade.model.Codes sif = new com.popultrade.model.Codes();
String dodaten_sql_pogoj = dodpog;
String sedodatno = "";
String metodo = "";
if (nul.jeNull(request.getParameter("isci")).equals("yes")) {
iskanje = true;
if (!sedodatno.equals("")) {
if (sedodatno.endsWith("and ")) {
sedodatno= sedodatno.substring(0,sedodatno.lastIndexOf("and "));
}
}
dodaten_sql_pogoj += (!dodaten_sql_pogoj.equals("")?(sedodatno.equals("")?"":" and "):"")+ sedodatno;
if (!nul.jeNull(request.getParameter("code")).equals("")) {
sif.setCode(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("code")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("code_group")).equals("")) {
sif.setCode_group(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("code_group")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("id")).equals("")) {
sif.setId(new Long(control.trimLeftRight(nul.jeNull(request.getParameter("id")))));
}
if (!nul.jeNull(request.getParameter("lang_text")).equals("")) {
sif.setLang_text(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("lang_text")))+"", "UTF-8"));
}
if (!nul.jeNull(request.getParameter("language")).equals("")) {
sif.setLanguage(URLDecoder.decode(control.trimLeftRight(nul.jeNull(request.getParameter("language")))+"", "UTF-8"));
}
session.setAttribute("codes_search",sif);
}
else if (nul.jeNull(request.getParameter("isk")).equals("1")) {
iskanje = true;
sif = (com.popultrade.model.Codes)session.getAttribute("codes_search");
}
else {
session.removeAttribute("codes_search");
}


System.out.println("------------------- "+request.getParameter("code_group"));

List lis =null;
lis = dao.getCodess(sif,1,200,dodaten_sql_pogoj,"","");
int strec = lis.size();
lis = dao.getCodess(sif,pagenum,stizpisov,dodaten_sql_pogoj,orderby,orderbysmer);


System.out.println("-------fff------------ "+request.getParameter("code_group"));

String dodo="";
String dodo1="style='background-image:url(\"orderbydot.gif\"); background-position:right;background-repeat:no-repeat;width:XXX'";
String dodo2="style='background-image:url(\"orderbydos.gif\"); background-position:right;background-repeat:no-repeat;width:XXX'";
String dodo3="style='background-image:url(\"orderbyupt.gif\"); background-position:right;background-repeat:no-repeat;width:XXX'";
String dodo4="style='background-image:url(\"orderbyups.gif\"); background-position:right;background-repeat:no-repeat;width:XXX'";
String dodo5="style='background-image:url(\"orderbyt.gif\"); background-position:right;background-repeat:no-repeat;width:XXX'";
String dodo6="style='background-image:url(\"orderbys.gif\"); background-position:right;background-repeat:no-repeat;width:XXX'";
%>
<%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<html><head><title></title></head>
<style>
body {
overflow-x:hidden;
}
A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>
<link type='text/css' href='styles/basic.css' rel='stylesheet' media='screen' />
<link type='text/css' href='styles/basic_ie.css' rel='stylesheet' media='screen' />
<style type=text/css>
@import "barveold.css";
@import "tooltipcss.css";
@import "ccss/custom.css";
@import "js/jquery.contextmenu.css";
@import "sbuttoni.css";
@import "barveblue.css";
</style>
<script language='javascript' src='colors.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type="text/javascript" language="JavaScript" src="tooltip.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="scripts/jquery.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" src="scripts/jquery-migrate.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="js/jquery.contextmenu.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="js/jquery.blockUI.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script type='text/javascript' src='js/jquery.simplemodal.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script type='text/javascript' src='js/basic.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>'></script>
<script language='javascript' src='js/ajax-dynamic-list-n.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>
<script language=javascript>
function vprasaj2(alerto,resett,iddd,sem) {
  var a = window.confirm(alerto);
 if (a==true) {
 if (resett=='1') {
   document.getElementById("res"+iddd).innerHTML='';
 if (sem!='' && sem!=null && sem!=undefined) {
 document.location = sem;	
   return false;
 }
  }
   return true;
  }
 else {
   return false;
}
}
function vprasaj(alerto,resett,iddd) {
  var a = window.confirm(alerto);
 if (a==true) {
 if (resett=='1') {
   document.getElementById("res"+iddd).innerHTML='';
  }
   return true;
  }
 else {
   return false;
}
}



function chg() {
 <%
if (request.getParameter("idback")!=null && !request.getParameter("idback").equals("null") && !request.getParameter("idback").equals("")) {
%>
kliknivSivo(document.getElementById("spr<%=request.getParameter("idback")%>"),document.getElementById("spr<%=request.getParameter("idback")%>").className);
window.scroll(1,document.getElementById("spr<%=request.getParameter("idback")%>").offsetTop-15);
<%
}
%>
 <%
if (request.getParameter("idomko")!=null && !request.getParameter("idomko").equals("null") && !request.getParameter("idomko").equals("")) {
if (session.getAttribute("idomko")==null || !session.getAttribute("idomko").toString().equals(request.getParameter("idomko"))) {
session.setAttribute("idomko",request.getParameter("idomko"));
%>
parent.frames[2].document.location='m_templatecodes_edit.jsp?id=<%=request.getParameter("idomko")%>';
<%
}
}
String requri = nul.jeNull(request.getRequestURI());
if (requri.indexOf("/")!=-1) {
requri = requri.substring(requri.lastIndexOf("/")+1,requri.length());
}
if (control.getFrames().containsKey(requri)) {
com.popultrade.webapp.FrameSizeClass fss = (com.popultrade.webapp.FrameSizeClass)control.getFrames().get(requri);
%>
top.setSize(<%=fss.getFrame1()%>,<%=fss.getFrame2()%>,<%=fss.getFrame3()%>);
<%
}
%>
parent.frames[2].location='nic.jsp';
parent.frames[3].location='nic.jsp';
}
</script>
<%}%>
<%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="scripts/colResizable-1.3.min.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<script type="text/javascript" language="JavaScript" src="scripts/menulist.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>"></script>
<%}%>
<%
Hashtable sifhint=new Hashtable();
Hashtable sifhintp=new Hashtable();
%>
<%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<script language=javascript>
$(function(){
$("#table1").colResizable();
});
$(function(){
$("#table2").colResizable({headerOnly:true});
});
$(document).ready(function(){ 
var el=$('#stable1'); 
var originalelpos=el.offset().top;
$(window).scroll(function(){ 
var el = $('#stable1');  
var elpos = el.offset().top;  
var windowpos = $(window).scrollTop(); 
var finaldestination = windowpos+originalelpos; 
el.stop().animate({'top':finaldestination},1); 
}); 
}); 
function resHead() {
var myTable = document.getElementById("table1"); 
var ths = myTable.getElementsByTagName("th");  
var myTable2 = document.getElementById("table2");   
var ths2 = myTable2.getElementsByTagName("th"); 
for (var i=0;i<ths.length;i++) {
//alert(ths[i].style.width + "   " + ths2[i].style.width );
ths[i].style.width=ths2[i].style.width;
}
}
$(window).resize(function() {
resHead();
}); 
p155="Code group";
p154="Code";
p174="View Language";
p156="To translate language";
<%

if (!ConPool.cache.containsKey("jsp153"+control.getJezik())) {ConPool.cache.put("jsp153"+control.getJezik(),sifhint);

}

else {
sifhint=(Hashtable)ConPool.cache.get("jsp153"+control.getJezik());}

%>
</script>
<%}%>
<%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<body   style="margin: 0"  background="podlaga.jpg" bgproperties="fixed"     onLoad="chg();resHead()" >
<div id="basic-modal-content"><img src='loadingg.gif'></div>
<div id="stable1" style="position:absolute;width:100%">
<%}%>
<%
String stolpci_m = "";
%>
<%
boolean napr=false;
%><%
boolean naprjs=false;
%><%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<table id="table1"   width=100% cellspacing=1   class="fontilist" >
<%}%>
<%

if (stolpci.equals("")) {
stolpci="155:::15%---154:::15%---174:::30%---156:::35%---";
}
%>
<%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<%
if (true){
%>
<tr bgcolor="white">
<%
String[] colss = stolpci.split("---");
for (int xc=0;xc<colss.length;xc++) {
if (colss[xc]!=null && !colss[xc].equals("")) {
String[] spp = colss[xc].split(":::");
%>
<%
if (spp[0].equals("155")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 opiscell" id="th155" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p155)">Code group</th>
<%
}
else if (stolpci.indexOf("155:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("155P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'155XXX15'); } ,icon:''},";
}
%>
<%
if (spp[0].equals("154")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 valuecell" id="th154" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p154)">Code</th>
<%
}
else if (stolpci.indexOf("154:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("154P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'154XXX15'); } ,icon:''},";
}
%>
<%
if (spp[0].equals("174")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 opiscell" id="th174" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p174)">View Language</th>
<%
}
else if (stolpci.indexOf("174:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("174P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'174XXX30'); } ,icon:''},";
}
%>
<%
if (spp[0].equals("156")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 valuecell" id="th156" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p156)">To translate language</th>
<%
}
else if (stolpci.indexOf("156:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("156P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'156XXX35'); } ,icon:''},";
}
%>
<%
}
}
%>
<th  class="opiscell" valign=middle align=center class="" ><span id='res009'>
<a href="#" class='btnblueb'  onClick="parent.frames[2].location='m_templatecodes_edit.jsp?opcija=new&siframm=new&sifrant=<%=request.getParameter("sifrant")%>';return false;" href="Javascript: PGAPP()" title="<%=ConPool.getPrevod("159P"+control.getJezik()).replaceAll("_"," ") %>">ADD</a>
<a href="#" onClick="parent.frames[2].location='m_templatecodes_isci.jsp?opcija=new&siframm=new&sifrant=<%=request.getParameter("sifrant")%>';return false;" href="Javascript: PGAPP()"   class='btnsilverb' title="<%=ConPool.getPrevod("166P"+control.getJezik()).replaceAll("_"," ") %>">SEARCH</a>
&nbsp;</span></th>
</tr>
<%
}
%>
<script type="text/javascript">

</script>
</table>
</div>
<%}
%>
<table id="table2"   width=100% cellspacing=1 class="fontilist" >
<%if (!nul.jeNull(request.getParameter("jehead")).equals("1")) {%>
<%
if (true){
%>
<tr bgcolor="white">
<%
String[] colss = stolpci.split("---");
for (int xc=0;xc<colss.length;xc++) {
if (colss[xc]!=null && !colss[xc].equals("")) {
String[] spp = colss[xc].split(":::");
%>
<%
if (spp[0].equals("155")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 opiscell" id="th155" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p155)"><%=ConPool.getPrevod("155P"+control.getJezik()).replaceAll("_"," ") %></th>
<%
}
else if (stolpci.indexOf("155:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("155P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'155XXX15'); } ,icon:''},";
}
%>
<%
if (spp[0].equals("154")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 valuecell" id="th154" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p154)"><%=ConPool.getPrevod("154P"+control.getJezik()).replaceAll("_"," ") %></th>
<%
}
else if (stolpci.indexOf("154:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("154P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'154XXX15'); } ,icon:''},";
}
%>
<%
if (spp[0].equals("174")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 opiscell" id="th174" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p174)"><%=ConPool.getPrevod("174P"+control.getJezik()).replaceAll("_"," ") %></th>
<%
}
else if (stolpci.indexOf("174:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("174P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'174XXX30'); } ,icon:''},";
}
%>
<%
if (spp[0].equals("156")) {
%>
<%
 dodo="style='width:XXX'";
%>
<th class="cmenu3 valuecell" id="th156" align="left"  <%=dodo.replaceAll("XXX",spp[1])%> onmouseout="hideddrivetip()" onmousemove="ddrivetip(p156)"><%=ConPool.getPrevod("156P"+control.getJezik()).replaceAll("_"," ") %></th>
<%
}
else if (stolpci.indexOf("156:::")==-1){
stolpci_m = stolpci_m + "'"+ConPool.getPrevod("156P"+control.getJezik()).replaceAll("_"," ") +"':{onclick:function(menuItem,menu) {  stolpec(this.id+'___'+'156XXX35'); } ,icon:''},";
}
%>
<%
}
}
%>
<th  class="opiscell" valign=middle align=center class="" ><span id='res009'>
<a href="#" class='btnblueb'  onClick="parent.frames[2].location='m_templatecodes_edit.jsp?opcija=new&siframm=new&sifrant=<%=request.getParameter("sifrant")%>';return false;" href="Javascript: PGAPP()" title="Add code">ADD</a>
<a href="#" onClick="parent.frames[2].location='m_templatecodes_isci.jsp?opcija=new&siframm=new&sifrant=<%=request.getParameter("sifrant")%>';return false;" href="Javascript: PGAPP()"   class='btnsilverb' title="Search codes">SEARCH</a>
&nbsp;</span></th>
</tr>
<%
}
%>
<%}%>
<%
//---ZACETEKZAAJAX---
int br = 0;
String oe_kup_nap = "";
String rezu="";

String[] colss = stolpci.split("---");
//---ZACETEKZAAJAX1---
Iterator it = lis.iterator();

boolean norecords=true;
while (it.hasNext()){  // while start
 norecords=false;
com.popultrade.model.Codes vseb = (com.popultrade.model.Codes)(it.next());
stvrstic++;
if (br==2){
 br=0;
}
//---ZACETEKZAAJAX2---
if (!prisotnost.getUserZaklenil(nul.jeNull(vseb.getId()+"")).equals(control.getIdUporabnikaLock()) && prisotnost.users.containsKey(nul.jeNull(vseb.getId()+""))) {
%>
<tr class="green"  id="spr<%=vseb.getId()%>"  >
<%
}
else if (vseb.getId().toString().equals(nul.jeNull(request.getParameter("idback")))) {
%>
<tr class="<%=colors[br]%>" id="spr<%=vseb.getId()%>" onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}
else {
%>
<tr class="<%=colors[br]%>"  id="spr<%=vseb.getId()%>"   onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}
for (int xc=0;xc<colss.length;xc++) {
if (colss[xc]!=null && !colss[xc].equals("")) {
String[] spp = colss[xc].split(":::");
%>
<%
if (spp[0].equals("155")) {
rezu="";
%>
<%
rezu=nul.jeNull(vseb.getCode_group()+"");

%>
<td width="15%" align="left" >

<%=rezu%>
</td>
<%
}
%>
<%
if (spp[0].equals("154")) {
rezu="";
%>
<%
rezu=nul.jeNull(vseb.getCode()+"");

%>
<td width="15%" align="left" >

<%=rezu%>
</td>
<%
}
%>
<%
if (spp[0].equals("174")) {
rezu="";
%>



<td width="30%" align="left" >

<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%>
</td>
<%
}
%>
<%
if (spp[0].equals("156")) {
rezu="";
%>

<td width="35%" align="left" >

<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>
</td>
<%
}
%>
<%
}
}
%>
<% 
  napr=false;
 naprjs=false;
 %>
<td  align="center" style="padding:2px;"><span onclick='event.cancelBubble = true; if(event.stopPropagation) { event.stopPropagation(); }'  id='res<%=vseb.getId()%>' style='display:<%=(prisotnost.getUserZaklenil(nul.jeNull(vseb.getId()+"")).equals(control.getIdUporabnikaLock()) || !prisotnost.users.containsKey(nul.jeNull(vseb.getId()+"")))?"inline":"none"%>'>
<%
%>
<a href="" onClick="parent.frames[2].location='m_templatecodes_edit.jsp?opcija=spremeni&siframm=new&sifrant=<%=request.getParameter("sifrant")%>&id=<%=vseb.getId()%>';kliknivSivo(this,'<%=colors[br]%>');return false;"  class='btnblueb'   title="Update code"     >U</a>
<a onClick="return vprasaj2('<%=ConPool.getPrevod("172D"+control.getJezik())%>','0','<%=vseb.getId()%>','m_templatecodes.jsp?akcijaXY=DELETE&sifrant=<%=request.getParameter("sifrant")%>&id=<%=vseb.getId()%>')"  class='btnredb'  href="m_templatecodes.jsp?akcijaXY=DELETE&sifrant=<%=request.getParameter("sifrant")%>&id=<%=vseb.getId()%>" title="Delete code">X</a>
</span></td>
</tr>
<%
br++;
}/// while end
%>
</table>
<%
if (norecords) {%>
<font style='font-size:2px'>&nbsp;</font><br><table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  style='background:ebebeb'>&nbsp;</td>
</tr>
<tr>
<td width="100%"    style='background:f3f3f3' height='35px'>
<p align="center"><%=nul.jeNull(ConPool.getPrevod_admin("1000033","Y",control.getJezik()+""))%>&nbsp;<br></td>
</tr>
<tr>
<td width="100%"   style='background:ebebeb'>&nbsp;</td>
</tr>
</table>
<%}
%>
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<script language=javascript>
function prisotnostUID(idtr,stdok,clasn,us,pod,pagnn) {
prisotnostUID2(idtr,stdok,clasn,us,pod,pagnn,'m_templatecodes','codes153_pri.jsp','<%=ConPool.getQueryStringFromRequest(request)%>');
}
<%
Enumeration enn = sifhintp.keys();
while (enn.hasMoreElements()) {
String nexi = (String)enn.nextElement();
%>
<%=nexi%> = "<%=(String)sifhintp.get(nexi)%>";
<%
}
%>
function go(asd,vv){
if (vv == 1){
 aaa = "m_templatecodes_edit.jsp?id="+asd;
  parent.frames[2].location = aaa;
}
return false;
}
function godown(asd){
parent.frames[2].location = asd;
return false;
}
function PGAPP(){
}
function odpriVrstico(spat){
evi = document.getElementById("vrst"+spat);
evis = document.getElementById("vimg"+spat);
if(evi.style.display == "block") {
evi.style.display = "none";
evis.src = "od.gif";
}
else {
evi.style.display = "block";
evis.src = "dom.gif";
}
return false;
}
function odpriVrstico2(spat){
evi = document.getElementById("vrst"+spat);
evis = document.getElementById("vimg"+spat);
if(evi.style.display == "block") {
evi.style.display = "none";
evis.innerHTML = "+";
}
else {
evi.style.display = "block";
evis.innerHTML = "--";
}
return false;
}
</script>
<%
if (strec>stizpisov) {
String iskk="";
if (!nul.jeNull(request.getQueryString()).equals("")) {
iskk=nul.jeNull(request.getQueryString()).replaceAll("akcijaXY=DELETE","").replaceAll("pagenumber","XY")+"";
}
else {
iskk="";
}
String orme = "";
if (!nul.jeNull(request.getParameter("orderup")).equals("")) {
orme = "&orderup="+request.getParameter("orderup")+"&orderupsmer="+request.getParameter("orderupsmer");
}
if (!iskk.equals("")) {
iskk="&"+iskk+orme;
}
if (iskanje) {
iskk=iskk+"&isk=1"+orme;
}
%><p align=center>
<table  id='pagebrowse'  class="fontilist" >
<tr bgcolor="ededed">
<td align=center >
Browse page: </td><td>
<a style="text-decoration:none;color:black"  href="m_templatecodes.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>
<%
int vse=0;
int ststr=0;
int prvii=nul.jeNull(session.getValue("pagenumberCodes153")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberCodes153")+"");
if (prvii>1) {
int prej = prvii-1;
%>
<td>
<a style="text-decoration:none;color:black"  href="m_templatecodes.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>
<td>|</td>
<%
}
for (int y=0;y<strec;y++) {
vse++;
if (vse==stizpisov) {
vse=0;
ststr++;
if ((prvii-5)<ststr && ststr<(prvii+5)) {
%>
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberCodes153")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatecodes.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%
}
}
}
if (vse!=0) {
%>
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberCodes153")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatecodes.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
<%
}
if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatecodes.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>
<td>|</td>
<%
}
%>
<td><a style="text-decoration:none;color:black"  href="m_templatecodes.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberCodes153")+"").equals("")?"1":session.getValue("pagenumberCodes153")%> of <%=ststr+1%> </td>
<td>|</td>
<td>
records: <%=strec%></td>
</tr>
</table></p>
<%
}
%>
</body></html>
<%
}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
