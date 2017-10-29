<%@ page contentType="text/html" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.util.Date"%>
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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}
%>
<%






//stevilo prikazov vrstic

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
com.popultrade.dao.Wse_prijaveDAO dao = (com.popultrade.dao.Wse_prijaveDAO)contextUtil.getBeanDao("wse_prijaveDAO",pageContext.getServletContext());
 
 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	dao.removeWse_prijave(new Long(request.getParameter("id")));
 
	
}
 
 
int pagenum=1;
int stizpisov=stpri;
 
if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {
 
	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberWse_prijave",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberWse_prijave")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberWse_prijave")+"");
	}
	}
 
 
com.popultrade.model.Wse_prijave sif = new com.popultrade.model.Wse_prijave();



if (nul.jeNull(request.getParameter("isci")).equals("yes")) {
	iskanje = true;
	//sif = (com.popultrade.model.Users)contextUtil.getPopulatedObject(sif,request);
	
	if (!nul.jeNull(request.getParameter("username")).equals("")) {
		sif.setUsername(nul.jeNull(request.getParameter("username")));
	}
	if (!nul.jeNull(request.getParameter("ip")).equals("")) {
		sif.setIp(nul.jeNull(request.getParameter("ip")));
	} 

	
	
	session.setAttribute("wse_prijave_search",sif);
	
}
if (nul.jeNull(request.getParameter("isk")).equals("1")) {
iskanje = true;
sif = (com.popultrade.model.Wse_prijave)session.getAttribute("wse_prijave_search");

}

if (!nul.jeNull(request.getParameter("iduser")).equals("")) {
	sif.setUsername(request.getParameter("iduser"));
}


int strec = dao.getStWse_prijave(sif);
 
 
 
List lis =null;
 
lis = dao.getWse_prijaves(sif,pagenum,stizpisov);
 
 

%>

<html><head></head>
<style>

A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:Verdana,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>
<style type=text/css>

@import "barve.css";

</style>

<%
//////////// funkcija za pobarvat vrstice v primeru checked in unchecked
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
  
  if (nul.jeNull(request.getParameter("iduser")).equals("")) {
  %>
 
parent.frames[2].location = "nic.jsp";

<%
  }
%>
parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>
<script language=javascript>
<%
/////////// nastimam imena ko grem gor s misko
%>
/// statusna vrstica z

p0 =  "Id";
p1 =  "User";
p2 =  "Datum prijave v popultrade";
p3 =  "Datum odjave iz popultrade";
p4 = "Ip naslov";
p5 = "Drzava";
p6= "Hostname";
p7 = "Status";

</script>

<body topmargin="0" leftmargin="0"  background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>

<div id="divBg" style="width:100%">

<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">


          <td width=10% align=center bgcolor="ADD9FF" onmouseout="popupoff()" onmousemove="popupon(p0,document.all||document.layers?event:null)">ID</td>
                <td width=13% align=center bgcolor="D2EAFF" onmouseout="popupoff()" onmousemove="popupon(p1,document.all||document.layers?event:null)">Uporabnik</td>
                <td width=12% align=center bgcolor="ADD9FF" onmouseout="popupoff()" onmousemove="popupon(p2,document.all||document.layers?event:null)">Datum prijave</td>
<td width=12% align=center bgcolor="D2EAFF" onmouseout="popupoff()" onmousemove="popupon(p3,document.all||document.layers?event:null)">Datum odjave</td>
<td width=20% align=center bgcolor="ADD9FF" onmouseout="popupoff()" onmousemove="popupon(p4,document.all||document.layers?event:null)">IP</td>
<td width=25% align=center bgcolor="D2EAFF" onmouseout="popupoff()" onmousemove="popupon(p7,document.all||document.layers?event:null)">Status</td>
<!-- 
<td width=20% align=center bgcolor="D2EAFF" onmouseout="popupoff()" onmousemove="popupon(p6,document.all||document.layers?event:null)">Hostname</td>

<td width=13% align=center bgcolor="ADD9FF" onmouseout="popupoff()" onmousemove="popupon(p5,document.all||document.layers?event:null)">Drzava</td>
 -->

                <td  bgcolor="ADD9FF" align=center>
                <%
               if (request.getParameter("userl")==null &&  nul.jeNull(request.getParameter("iduser")).equals("")) {
                %>
                  <a onClick="return godown('m_log_user_isci.jsp')" href="Javascript: fake()"><img alt="Isci" border="0" src="search.gif" /></a>
               <%}
              else {
              %>
              &nbsp;
              <%
              } %>
                </td>
        </tr>

</table>
</div>








  



<table cellspacing=1 width="100%" style=" font-family: Verdana; font-size: 7pt">
<tr><td colspan=9><font size="1">&nbsp;</font></td></tr>
<%

Hashtable ipji = ConPool.ipji;



/*
ipji.put("172.19.141","Marco");
ipji.put("172.19.142","Gregor");
ipji.put("172.19.143","Miro");
ipji.put("172.19.144","Bozo");
ipji.put("172.19.145","Panteongroup® Kranj");
ipji.put("172.19.146","Snezana");
ipji.put("172.19.147","Peter");
ipji.put("172.19.148","Alen");
ipji.put("172.19.149","Sandi");
ipji.put("172.19.150","Edi LJ (Panteongroup® Ljubljana)");
ipji.put("172.19.151","Andrej");
ipji.put("172.19.152","Pavel");
ipji.put("172.19.153","Thomas");
ipji.put("172.19.154","Sasa");
ipji.put("172.19.155","Sasa T2");
ipji.put("172.19.156","Panteongroup® Zagreb");
ipji.put("172.19.157","Edi doma");
ipji.put("172.19.159","Panteongroup® Beograd");

ipji.put("172.19.158","Vesna");
ipji.put("192.168.2","ATNET Koper");

*/


/// menja barvo
int br = 0;
String oe_kup_nap = "";


Iterator it = lis.iterator();


while (it.hasNext()){  // while start
	
	com.popultrade.model.Wse_prijave vseb = (com.popultrade.model.Wse_prijave)(it.next());



stej++;

if (br==2){
  br=0;
}

//System.out.println("11111111111");

String ipm = nul.jeNull(vseb.getIp());

if (ipm.indexOf(".")!=-1) {
ipm=ipm.substring(0,ipm.lastIndexOf("."));
}

if (vseb.getId().equals(nul.jeNull(request.getParameter("idback")))) {

%>

<tr class="<%=colors[br]%>" id=sprememba onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}
else if (ipji.containsKey(ipm)) {
	%>
	<tr bgcolor="e5e5e5" >
	<%
}
else {
%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}

%>


  <td width="10%" align="center"><%=nul.jeNull(vseb.getId()+"")%></td>
  <td width="13%"  ><%=nul.jeNull(vseb.getUsername())%></td>
<td  width="12%" align="center"><%=nul.getDatumFormatFromDate(vseb.getDatum_prijave(),"dd-MM-yyyy HH:mm:ss")%></td>
<td  width="12%" align="center"><%=nul.getDatumFormatFromDate(vseb.getDatum_odjave(),"dd-MM-yyyy HH:mm:ss")%></td>


<td  width="20%" align="left"><%=nul.jeNull(vseb.getIp())%>

<%
if (ipji.containsKey(ipm)) {
	%>
(<b><%=ipji.get(ipm) %></b>)	
	<%
}
%>


</td>
<td  width="25%" align="center"><%=nul.jeNull(vseb.getStatus())%>
</td>
<!-- 
<td  width="20%" align="left"><%=nul.jeNull(vseb.getHostname())%></td>
<td  width="13%" align="center">

  <%
if (vseb.getDrzava()!=null && vseb.getDrzava().indexOf("-")!=-1) {
String en = vseb.getDrzava().substring(0,vseb.getDrzava().indexOf("-"));
%>
<img src="flags/<%=en.toLowerCase()%>.gif" border="0" alt="<%=vseb.getDrzava()%>">
<%

}
else {
%>
 <%=nul.jeNull(vseb.getDrzava())%>
<%
}
%>


</td>-->




<td align=center>
&nbsp;
  <a href="Javascript:fake()" onCLick="return go('<%=vseb.getId()%>',1)"><!--<img src="i.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" alt="Detalj">--></a>
</td>

</tr>

<%
br++;





}/////////////// while end






%>
</table>
<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_log_user_detalj.jsp?id="+asd;
    parent.frames[2].location = aaa;
//document.loca
  }



return false;

}
function godown(asd){
parent.frames[2].location = asd;
return false;
}
function B2S(){
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
 <a style="text-decoration:none;color:black"  href="m_log_user.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>
 
 
<%
int vse=0;
int ststr=0;
 
int prvii=nul.jeNull(session.getValue("pagenumberWse_prijave")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberWse_prijave")+"");
 
if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_log_user.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>
 
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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberWse_prijave")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_log_user.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%
 
}
}
%>
 
<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberWse_prijave")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_log_user.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}
 
 
 
if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_log_user.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>
 
<td>|</td>
<%
}
%>
 
 
 
<td><a style="text-decoration:none;color:black"  href="m_log_user.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberWse_prijave")+"").equals("")?"1":session.getValue("pagenumberWse_prijave")%> of <%=ststr+1%> </td>
<td>|</td>
<td>
records: <%=strec%></td>
</tr>
</table></p>
<%
}
%>


</table></body></html>




<%

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>
