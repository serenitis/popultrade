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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="logout.jsp"/><%
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
com.popultrade.dao.StrankeDAO dao = (com.popultrade.dao.StrankeDAO)contextUtil.getBeanDao("strankeDAO",pageContext.getServletContext());
 
 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	dao.removeStranke(new Long(request.getParameter("id")));
 
	
}
 
 
int pagenum=1;
int stizpisov=stpri;
 
if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {
 
	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberStranke",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberStranke")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberStranke")+"");
	}
	}
 
 
com.popultrade.model.Stranke sif = new com.popultrade.model.Stranke();

sif.setOznnar(control.getPodjetje());



if (nul.jeNull(request.getParameter("isci")).equals("yes")) {
	iskanje = true;
	//sif = (com.popultrade.model.Users)contextUtil.getPopulatedObject(sif,request);
	
	if (!nul.jeNull(request.getParameter("naziv")).equals("")) {
		sif.setNaziv(nul.jeNull(request.getParameter("naziv")));
	}
	if (!nul.jeNull(request.getParameter("naslov")).equals("")) {
		sif.setNaslov(nul.jeNull(request.getParameter("naslov")));
	}
	if (!nul.jeNull(request.getParameter("kraj")).equals("")) {
		sif.setKraj(nul.jeNull(request.getParameter("kraj")));
	}
	if (!nul.jeNull(request.getParameter("posta")).equals("")) {
		sif.setPosta(nul.jeNull(request.getParameter("posta")));
	}
	if (!nul.jeNull(request.getParameter("drzava")).equals("")) {
		sif.setDrzava(nul.jeNull(request.getParameter("drzava")));
	}
	if (!nul.jeNull(request.getParameter("idddv")).equals("")) {
		sif.setIdddv(nul.jeNull(request.getParameter("idddv")));
	}

	session.setAttribute("stranke_search",sif);
	
}
else if (nul.jeNull(request.getParameter("isk")).equals("1")) {
iskanje = true;
sif = (com.popultrade.model.Stranke)session.getAttribute("stranke_search");

}
else {
	
	session.removeAttribute("stranke_search");
}

int strec = dao.getStStranke(sif);


 
 
 
List lis =null;
 
lis = dao.getStrankes(sif,pagenum,stizpisov);
 
 
 
 
 
 
 
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
 
parent.frames[1].location = "nic.jsp";
parent.frames[2].location = "nic.jsp";


//// set dimenzij framov

<%

if (control.getFrames().containsKey("stranke.jsp")) {
	
	com.popultrade.webapp.FrameSizeClass fss = (com.popultrade.webapp.FrameSizeClass)control.getFrames().get("stranke.jsp");
	
	%>
	
	top.setSize(<%=fss.getFrame1()%>,<%=fss.getFrame2()%>,<%=fss.getFrame3()%>);
	
	<%
}

%>

}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>
 
<script language=javascript> 
 
 
                	   p0="Id";
                	   
                	   p2="Oznnar";
                	   
                	   p4="Naziv";
                	   
                	   p6="Naslov";
                	   
                	   p8="Kraj";
                	   
                	   p10="Posta";
                	   
                	   p12="Drzava";
                	   
                	   p14="Idddv";
                	   
                	   p16="Komentar";
                	   
                	   p18="Status";
                	   
                	   p20="Usere";
                	   
                	   p22="Edatetime";
                	   
                	   p24="Userlu";
                	   
                	   p26="Ludatetime";
                	   
 
</script>
 
 
<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
 
 
 
            	  
            	   <td width=20% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">Naziv</td>
               
            	   
            	   <td width=23% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p6)">Naslov</td>
               
            	   
            	   <td width=15% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p8)">Kraj</td>
               
            	   
            	   <td width=10% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p10)">Posta</td>
               
            	   
            	   <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p12)">Drzava</td>
               
            	   
            	   <td width=15% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p14)">Id ddv</td>
             
               
            	   
 
              
                 <td  bgcolor="ADD9FF" align=center>
                 <a onClick="return godown('stranke_isci.jsp')" href="Javascript: B2S()"><img border="0" src="search.gif" alt="Isci" /></a>
                 <a onClick="return godown('stranke_edit.jsp?opcija=new&siframm=new&sifrant=null')" href="Javascript: PGAPP()"><img title="Dodaj nov Stranke" border="0" src="vnos.gif" /></a></td>
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
	
	com.popultrade.model.Stranke vseb = (com.popultrade.model.Stranke)(it.next());
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
 
	
	<td width="20%" align="left"><%=nul.jeNull(vseb.getNaziv())%></td>
	
	<td width="23%" align="left"><%=nul.jeNull(vseb.getNaslov())%></td>
	
	<td width="15%" align="left"><%=nul.jeNull(vseb.getKraj())%></td>
	
	<td width="10%" align="left"><%=nul.jeNull(vseb.getPosta())%></td>
	
	<td width="5%" align="center"><%=nul.jeNull(vseb.getDrzava())%></td>
	
	<td width="15%" align="left"><%=nul.jeNull(vseb.getIdddv())%></td>
	
	
 
 
<td  align="center">
 
 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>
 
 
 <a onClick="return vprasaj()" href="stranke.jsp?akcija=DELETE&id=<%=vseb.getId()%>"><img src="x.gif" border=0 title="Brisi"></a>
 
 
 
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
    aaa = "stranke_edit.jsp?id="+asd;
    parent.frames[1].location = aaa;
  }
 
return false;
}
function godown(asd){
parent.frames[1].location = asd;
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
 <a style="text-decoration:none;color:black"  href="stranke.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>
 
 
<%
int vse=0;
int ststr=0;
 
int prvii=nul.jeNull(session.getValue("pagenumberStranke")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberStranke")+"");
 
if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="stranke.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>
 
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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberStranke")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="stranke.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%
 
}
}
%>
 
<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberStranke")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="stranke.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}
 
 
 
if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="stranke.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>
 
<td>|</td>
<%
}
%>
 
 
 
<td><a style="text-decoration:none;color:black"  href="stranke.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberStranke")+"").equals("")?"1":session.getValue("pagenumberStranke")%> of <%=ststr+1%> </td>
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
 
 
 

