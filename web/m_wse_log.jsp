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
 
 
 
 
 
// stevilo vrstic
int stvrstic=0;
 
boolean iskanje=false;
 
try {
 
// get list from daoobject
com.popultrade.dao.Wse_logDAO dao = (com.popultrade.dao.Wse_logDAO)contextUtil.getBeanDao("wse_logDAO",pageContext.getServletContext());
 
 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	dao.removeWse_log(new Long(request.getParameter("id")));
 
	
}
 
 
int pagenum=1;
int stizpisov=stpri;
 
if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {
 
	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberWse_log",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberWse_log")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberWse_log")+"");
	}
	}
 




 
com.popultrade.model.Wse_log sif = new com.popultrade.model.Wse_log();


com.popultrade.model.Wse_log_pozicije sifw = new com.popultrade.model.Wse_log_pozicije();


if (nul.jeNull(request.getParameter("isci")).equals("yes")) {
	iskanje = true;
	//sif = (com.popultrade.model.Users)contextUtil.getPopulatedObject(sif,request);
	
	if (!nul.jeNull(request.getParameter("datum_ura1")).equals("")) {
		sifw.setDatum_ura1(nul.parseDatumUra(nul.jeNull(request.getParameter("datum_ura1"))));
	}
	if (!nul.jeNull(request.getParameter("datum_ura2")).equals("")) {
		sifw.setDatum_ura2(nul.parseDatumUra(nul.jeNull(request.getParameter("datum_ura2"))));
	}
	if (!nul.jeNull(request.getParameter("opis")).equals("")) {
		sif.setOpis(nul.jeNull(request.getParameter("opis")));
	}
	if (!nul.jeNull(request.getParameter("tekst")).equals("")) {
		sifw.setTekst(nul.jeNull(request.getParameter("tekst")));
	}

	
	session.setAttribute("wse_log_pozicije_search",sifw);
	session.setAttribute("wse_log_search",sif);
	
}
if (nul.jeNull(request.getParameter("isk")).equals("1")) {
iskanje = true;
sifw = (com.popultrade.model.Wse_log_pozicije)session.getAttribute("wse_log_pozicije_search");
sif = (com.popultrade.model.Wse_log)session.getAttribute("wse_log_search");

}



List lis =null;
int strec=0;

if (!iskanje) {
strec = dao.getStWse_log(sif);

lis = dao.getWse_logs(sif,pagenum,stizpisov);
}
else {
	//strec = dao.getStWse_log(sif);

	lis = dao.getWse_log_search(sif,sifw,1,49);
	
	strec = lis.size();
	
}
 
 
 
 
 
 
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
@import "tooltipcss.css";
</style>
<script language='javascript' src='colors.js' ></script>
<script type="text/javascript" language="JavaScript" src="tooltip.js"></script>
 
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
 
 
    
 
 
  <%
if (request.getParameter("idback")!=null && !request.getParameter("idback").equals("null") && !request.getParameter("idback").equals("")) {
  %>
kliknivSivo(document.getElementById("sprememba"),document.getElementById("sprememba").className);
window.scroll(1,document.getElementById("sprememba").offsetTop-15);
 
  <%
}
  %>
 
parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>
 
<script language=javascript> 
 
 
                	   p0="Id";
                	   
                	   p2="Opis";
                	   
                	   p4="Uporabnik";
                	   
 
</script>
 
 
<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
 
 
 
            	   <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p0)">Id</td>
               
            	   
            	   <td width=70% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p2)">Opis</td>
               
            	   
            	   <td width=15% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">Uporabnik</td>
               
            	   
 
              
                 <td  bgcolor="D2EAFF" align=center>
                 
                    <a onClick="return godown('m_wse_log_isci.jsp')" href="Javascript: B2S()"><img border="0" src="search.gif" alt="Isci" /></a>
              
                 
                 </td>
        </tr>
 
 
</table>
</div>
 
 
 
 
 
 
<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
<tr><td colspan=3>&nbsp</td></tr>
<%
 
/// menja barvo
int br = 0;
String oe_kup_nap = "";
 
 
Iterator it = lis.iterator();
 
 
while (it.hasNext()){  // while start
	
	com.popultrade.model.Wse_log vseb = (com.popultrade.model.Wse_log)(it.next());
		stvrstic++;
 
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
 
	<td width="5%" align="center"><%=nul.jeNull(vseb.getId()+"")%></td>
	
	<td width="70%" align="left"><%=nul.jeNull(vseb.getOpis())%></td>
	
	<td width="15%" align="left"><%=nul.jeNull(vseb.getUporabnik())%></td>
	
 
 
<td  align="center">
 
 <a href="Javascript:PGAPP()" onCLick="return godown('m_wse_log_pozicije.jsp?id=<%=vseb.getId()%>')"><img src="p1.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Pregled pozicij"></a>
 
 
 <a onClick="return vprasaj()" href="m_wse_log.jsp?akcija=DELETE&id=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>"><ismg src="x.gif" border=0 title="Brisi"></a>
 
 
 
</td>
</tr>
 
<%
br++;
 
}/// while end
 
 
 %>
  
</table>
 
 
<script language=javascript> 
function go(asd,vv){
  if (vv == 1){
    aaa = "m_wse_log_edit.jsp?id="+asd;
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
// st izpisov
if (strec>stizpisov) {
	String iskk="";
	if (iskanje) {
		iskk="&isk=1";
		}
%><p align=center>
<table  border="0" cellpadding="7" cellspacing="1" style="border-collapse: collapse; font-family:Verdana; font-size:8pt;">
<tr bgcolor="ededed">
<td align=center >
Browse page: </td><td>
 <a style="text-decoration:none;color:black"  href="m_wse_log.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>
 
 
<%
int vse=0;
int ststr=0;
 
int prvii=nul.jeNull(session.getValue("pagenumberWse_log")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberWse_log")+"");
 
if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_wse_log.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>
 
<td>|</td>
<%
}
%>
<%
 
for (int y=0;y<strec;y++) {
vse++;
if (vse==stizpisov) {
vse=0;
 
ststr++;
if ((prvii-5)<ststr && ststr<(prvii+5)) {
%>
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberWse_log")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_wse_log.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%
 
}
}
%>
 
<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberWse_log")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_wse_log.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}
 
 
 
if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_wse_log.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>
 
<td>|</td>
<%
}
%>
 
 
 
<td><a style="text-decoration:none;color:black"  href="m_wse_log.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberWse_log")+"").equals("")?"1":session.getValue("pagenumberWse_log")%> of <%=ststr+1%> </td>
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
 
 
 

