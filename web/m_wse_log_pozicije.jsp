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
com.popultrade.dao.Wse_log_pozicijeDAO dao = (com.popultrade.dao.Wse_log_pozicijeDAO)contextUtil.getBeanDao("wse_log_pozicijeDAO",pageContext.getServletContext());
 
 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	dao.removeWse_log_pozicije(new Long(request.getParameter("id")));
 
	
}
 
 
int pagenum=1;
int stizpisov=stpri;
 
if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {
 
	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberWse_log_pozicije",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberWse_log_pozicije")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberWse_log_pozicije")+"");
	}
	}
 
 
com.popultrade.model.Wse_log_pozicije sif = new com.popultrade.model.Wse_log_pozicije();

sif.setLog_id(new Long(request.getParameter("id")));


int strec = dao.getStWse_log_pozicije(sif);
 
 
 
List lis =null;
 
lis = dao.getWse_log_pozicijes(sif,pagenum,stizpisov);
 
 
 
 
 
 
 
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
 
//parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>
 
<script language=javascript> 
 
 
                	
                	   p2="Dogodek";
                	   
                	   p4="Datum ura";
                	   
                	   p6="Tekst";
                	   
 
</script>
 
 
<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
 
 
 
            	 
            	   <td width=5% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p2)">Dogodek</td>
               
            	   
            	   <td width=12% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">Datum ura</td>
               
            	   
            	   <td width=77% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p6)">Tekst</td>
               
            	   
 
              
                 <td  bgcolor="ADD9FF" align=center>&nbsp;<a onClick="return godown('m_wse_log_pozicije_edit.jsp?opcija=new&siframm=new&sifrant=null')" href="Javascript: PGAPP()"><imgs title="Dodaj nov Wse_log_pozicije" border="0" src="vnos.gif" /></a></td>
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
	
	com.popultrade.model.Wse_log_pozicije vseb = (com.popultrade.model.Wse_log_pozicije)(it.next());
		stvrstic++;
 
if (br==2){
  br=0;
}
 

%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%

 
%>
 
	
	<td width="5%" align="center"><%=nul.jeNull(vseb.getDogodek()+"")%></td>
	
	<td width="12%" align="left"><%=nul.getDatumFormatFromDate(vseb.getDatum_ura(),"dd-MM-yyyy HH:mm:ss")%></td>
	
	<td width="77%" align="left"><%=nul.jeNull(vseb.getTekst())%></td>
	
 
 
<td  align="center">
 

 
&nbsp;
 
 
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
    aaa = "m_wse_log_pozicije_edit.jsp?id="+asd;
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
 <a style="text-decoration:none;color:black"  href="m_wse_log_pozicije.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>
 
 
<%
int vse=0;
int ststr=0;
 
int prvii=nul.jeNull(session.getValue("pagenumberWse_log_pozicije")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberWse_log_pozicije")+"");
 
if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_wse_log_pozicije.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>
 
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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberWse_log_pozicije")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_wse_log_pozicije.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%
 
}
}
%>
 
<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberWse_log_pozicije")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_wse_log_pozicije.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}
 
 
 
if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_wse_log_pozicije.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>
 
<td>|</td>
<%
}
%>
 
 
 
<td><a style="text-decoration:none;color:black"  href="m_wse_log_pozicije.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberWse_log_pozicije")+"").equals("")?"1":session.getValue("pagenumberWse_log_pozicije")%> of <%=ststr+1%> </td>
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
 
 
 

