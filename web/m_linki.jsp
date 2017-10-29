<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}
%>
<%
 
// stevilo prikazov vrstic
 
int stpri = control.st_vrstic;
 
 
// steje stevilo vrstic
int stej = 0;
 
// barve vrstic
String[] colors = {"plava1","plava2","silver"};
 
 
String a = "0";
String b = ""+stpri;
if (request.getParameter("a")!=null) {
a = request.getParameter("a");
}
if (request.getParameter("b")!=null) {
b = request.getParameter("b");
}
 
 
 
// stevilo vrstic
int stvrstic=0;
 
String iskanje="";
 
try {
 
// get list from daoobject
com.popultrade.dao.LinkiDAO dao = (com.popultrade.dao.LinkiDAO)contextUtil.getBeanDao("linkiDAO",pageContext.getServletContext());
 
 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	dao.removeLinki(new Long(request.getParameter("id")));
 
	
}
com.popultrade.model.Linki sif = new com.popultrade.model.Linki();
 
List lis =null;
 
lis = dao.getLinkis(sif);
 
 
 
 
 
 
 
%>
<html><head><title></title></head>
<style> 
 
A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>
<style type=text/css> 
 
@import "barve.css";
 
</style>
<script language='javascript' src='colors.js' ></script>
<script language="JavaScript1.2"> 
 
 
 
ie=document.all?1:0
n=document.layers?1:0
 
var moveOnScroll=true
 
var hideAll=true
 
function makeMenuBar(obj,nest,vis){
    nest=(!nest) ? '':'document.'+nest+'.'
    this.css=(n) ? eval(nest+'document.'+obj):eval(obj+'.style')
        this.hideIt=b_hideIt;	this.showIt=b_showIt; this.vis=b_vis
        if(ie && vis) this.css.visibility='hidden'
        this.state=1
        this.go=0
        this.height=n?this.css.document.height:eval(obj+'.offsetHeight')
        this.top=b_gettop
    this.obj = obj + "Object"; 	eval(this.obj + "=this")
}
function b_gettop(){
        var gleft=(n) ? eval(this.css.top):eval(this.css.pixelTop);
        return gleft;
}
function b_showIt(){
        this.css.visibility="visible"
}
function b_hideIt(){
        this.css.visibility="hidden"
}
function b_vis(){
        if(this.css.visibility=="hidden" || this.css.visibility=="hide") return true;
}
 
function checkScrolled(){
        if(!oMenu.go)oMenu.css.top=(!oMenu.state)?eval(scrolled):eval(scrolled)
        if(n) setTimeout('checkScrolled()',30)
}
 
function menuBarInit(){
        oSub=new Array()
 
 
 
        oMenu=new makeMenuBar('divBg')
        scrolled=n?"window.pageYOffset":"document.body.scrollTop"
        oMenu.css.top=eval(scrolled)
        oMenu.css.visibility='visible'
        if(moveOnScroll)window.onscroll=checkScrolled;
}
 
function extract(num){
        if(hideAll){
                for(i=0;i<oSub.length;i++){
                        if(num!=i) oSub[i].hideIt()
                }
        }
        !oSub[num].vis()?oSub[num].hideIt():oSub[num].showIt();
 
}
 
onload=menuBarInit;
 
 
 
</script>
<script language=javascript> 
 
// potrditev brisanja
function vprasaj() {
  var a = window.confirm("Potrdis brisanje?");
  if (a==true) {
 
    return true;
  }
  else {
    return false;
  }
}
 
 
function chg() {
 
  
 
parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>
 
<script language=javascript> 
 
 
                	   p0="Id";
                	   
                	p5="Zaporedje prikaza";
                	   
                	   p4="Link";
                	   
 
</script>
 
 
<body topmargin="0" leftmargin="0"  background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style="border-collapse:
collapse; font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
 
 
 
            	   <td width=10% align=center bgcolor="ADD9FF" onmouseout="popupoff()" onmousemove="popupon(p0,document.all||document.layers?event:null,'')">Id</td>
               
            	  
            	   
            	   <td width=70% align=center bgcolor="D2EAFF" onmouseout="popupoff()" onmousemove="popupon(p4,document.all||document.layers?event:null,'')">Link</td>
               
            	   <td width=10% align=center bgcolor="ADD9FF" onmouseout="popupoff()" onmousemove="popupon(p5,document.all||document.layers?event:null,'')">Zap</td>
               
 
              
                 <td  bgcolor="D2EAFF" align=center><a onClick="return godown('m_linki_edit.jsp?opcija=new&siframm=new&sifrant=null')" href="Javascript: PGAPP()"><img alt="Dodaj nov Linki" border="0" src="vnos.gif" /></a></td>
        </tr>
 
 
</table>
</div>
 
 
 
 
 
 
<table width=100% cellspacing=1  style="border-collapse: collapse; font-family: Verdana; font-size: 7pt">
<tr><td colspan=8>&nbsp</td></tr>
<%
 
/// menja barvo
int br = 0;
String oe_kup_nap = "";
 
int spodaj = Integer.parseInt(a);
int zgoraj = Integer.parseInt(b);
 
Iterator it = lis.iterator();
 
 
while (it.hasNext()){  // while start
	
	com.popultrade.model.Linki vseb = (com.popultrade.model.Linki)(it.next());
		stvrstic++;
	if (stvrstic>200) {
		break;
	}
	
stej++;
System.out.println(stej);
if ((stej > spodaj) && (stej <= zgoraj)) {
 
if (br==2){
  br=0;
}
 
if (vseb.getId().toString().equals(nul.jeNull(request.getParameter("idback")))) {
%>
<tr class="<%=colors[br]%>" id=sprememba onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}
else {
%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}
 
%>
 
	<td width="10%" align="center"><%=nul.jeNull(vseb.getId()+"")%></td>
	
	<td width="70%" align="left"><%=nul.jeNull(vseb.getLink())%></td>
	
 <td width="10%" align="center"><%=nul.jeNull(vseb.getZaporedje()+"")%></td>
 
<td  align="center">
 
 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" alt="Spremeni podatke"></a>
 
 
 <a onClick="return godown('m_kat1_slike.jsp?prikazi=1&sifra=<%=vseb.getId()%>&sifraor=null&stsl=22&back=')" href="Javascript: vod()"  ><img src="i.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" alt="Spremeni slike"></a>
 
 
 <a onClick="return vprasaj()" href="m_linki.jsp?akcija=DELETE&id=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>"><img src="x.gif" border=0 alt="Brisi"></a>
 
 
 
</td>
</tr>
 
<%
br++;
}
}/// while end
 
 
 
 
}
catch (Exception ex){
System.out.println("Sss"+ex.toString());
}
 
%>
 
<script language=javascript> 
function go(asd,vv){
  if (vv == 1){
    aaa = "m_linki_edit.jsp?id="+asd;
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
 
</script>
<%
if (stej > stpri) {
    if (stej>200) {
 
  stvrstic=200;
    }
  
%>
 <table  style="font-family: Verdana; font-size: 7pt; border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="1" height="38">
<tr><td colspan=30><font size=1>Najdeno: 
<%=stvrstic%></font></td></tr><tr>
<%
long ost =stvrstic%stpri;
long max =stvrstic - ost;
max = max /stpri;
int i =1;
int f=0;
 
String iskk = "";
int pom = 0;
if (!iskanje.equals("")) {
iskk="&isk=1";
}
for (int e=0; e < max; e++) {
pom++;
if (pom==25) {
pom=1;
%>
</tr><tr>
<%
}
 
 
%>
 
<td bgcolor=silver align=center><a href="m_linki.jsp?a=<%=f%>&b=<%=f+stpri+1%><%=iskk%>"> <%=i%> </a></td>
 
<%
i++;
f = f+stpri;
}
 
if (ost != 0) {
%>
 
<td bgcolor=silver align=center><a href="m_linki.jsp?a=<%=f%>&b=<%=ost+f+1%><%=iskk%>"> <%=i%> </a></td>
 
<%
 
 
}
 
 
 
%>
</td></tr></table>
 
<%
}
%>
 
</table></body></html>
 
 
 
 

