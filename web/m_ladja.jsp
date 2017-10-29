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
com.popultrade.dao.LadjaDAO dao = (com.popultrade.dao.LadjaDAO)contextUtil.getBeanDao("ladjaDAO",pageContext.getServletContext());
 
 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	dao.removeLadja(request.getParameter("id"));
 
	
}
int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberladja",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberladja")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberladja")+"");
	}
	}

com.popultrade.model.Ladja sif = new com.popultrade.model.Ladja();






if (nul.jeNull(request.getParameter("isci")).equals("yes")) {
	iskanje = true;
	//sif = (com.popultrade.model.Users)contextUtil.getPopulatedObject(sif,request);
	
	if (!nul.jeNull(request.getParameter("LADJA")).equals("")) {
		sif.setLADJA(nul.jeNull(request.getParameter("LADJA")));
	}
	if (!nul.jeNull(request.getParameter("IMELAD")).equals("")) {
		sif.setIMELAD(nul.jeNull(request.getParameter("IMELAD")));
	}
	if (!nul.jeNull(request.getParameter("DZV_OZNDRZ")).equals("")) {
		sif.setDZV_OZNDRZ(nul.jeNull(request.getParameter("DZV_OZNDRZ")));
	}
	if (!nul.jeNull(request.getParameter("LDR_OZNLADJAR")).equals("")) {
		sif.setLDR_OZNLADJAR(nul.jeNull(request.getParameter("LDR_OZNLADJAR")));
	}

	
	
	session.setAttribute("ladja_search",sif);
	
}
else if (nul.jeNull(request.getParameter("isk")).equals("1")) {
iskanje = true;
sif = (com.popultrade.model.Ladja)session.getAttribute("ladja_search");

}
else {
	
	session.removeAttribute("ladja_search");
}







int strec = dao.getStLadja(sif);


 
List lis =null;
 
lis = dao.getLadjas(sif,pagenum,stizpisov);
 
 
 
 
 
 
 
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
if (!nul.jeNull(request.getParameter("idback")).equals("") && !nul.jeNull(request.getParameter("idback")).equals("null")) {
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
 
 
                	   p0="LADJA";
                	   
                	   p2="IMELAD";
                	   
                	   p4="LDR OZNLADJAR";
                	   
                	   p6="DOLZINA";
                	   
                	   p8="BT";
                	   
                	   p10="UGREZ";
                	   
                	   p12="TIP";
                	   
                	   p14="OPISTIPA";
                	   
                	   p16="DZV OZNDRZ";
                	   
                	   p18="NOSILNOST";
                	   
                	   p20="OPISDVIG";
                	   
                	   p22="STRGROT";
                	   
                	   p24="LETOIZD";
                	   
                	   p26="IMO";
                	   
                	   p28="DATUMAZUR";
                	   
                	   p30="USERIDAZUR";
                	   
 
</script>
 
 
<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
 
 
 
            	   <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p0)">LAD</td>
               
            	   
            	   <td width=35% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p2)">IME LADJE</td>
               
            	   
            	   <td width=25% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">LADJAR</td>
               
            	   
            	   <td width=5% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p6)">DOLZINA</td>
               
            	   
            	 
            	   
            	   <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p12)">TIP</td>
               
            	   
            	  
            	   
            	   <td width=10% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p16)">DZV</td>
               
            	  
            	   
            	   <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p26)">IMO</td>
               
            	   
            	  
            	   
 
              
                 <td  bgcolor="D2EAFF" align=center>
                  <a onClick="return godown('m_ladja_isci.jsp')" href="Javascript: B2S()"><img border="0" src="search.gif" alt="Isci" /></a>
                 <a onClick="return godown('m_ladja_edit.jsp?opcija=new&siframm=new&sifrant=null')" href="Javascript: PGAPP()"><img title="Dodaj nov Ladja" border="0" src="vnos.gif" /></a></td>
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
	
	com.popultrade.model.Ladja vseb = (com.popultrade.model.Ladja)(it.next());
		stvrstic++;

if (br==2){
  br=0;
}
 
if (vseb.getLADJA().toString().equals(nul.jeNull(request.getParameter("idback")))) {
%>
<tr class="<%=colors[br]%>" id=sprememba onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}
else {
%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">
<%
}

String ladjar = "";
if (vseb.getLadjar()!=null && vseb.getLadjar().getOZNLADJAR()!=null) {
	ladjar = nul.jeNull(vseb.getLadjar().getNAZIV());
}
 
%>
 
	<td width="5%" align="left"><%=nul.jeNull(vseb.getLADJA())%></td>
	
	<td width="35%" align="left"><%=nul.jeNull(vseb.getIMELAD())%></td>
	
	<td width="25%" align="left"><%=ladjar%></td>
	
	<td width="5%" align="left"><%=nul.jeNull(vseb.getDOLZINA()+"")%></td>

	
	<td width="5%" align="left"><%=nul.jeNull(vseb.getTIP())%></td>
	
	
	
	<td width="10%" align="left"><%=nul.jeNull(vseb.getDZV_OZNDRZ())%></td>
	

	
	<td width="5%" align="left"><%=nul.jeNull(vseb.getIMO())%></td>
	

 
<td  align="center">
 
 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getLADJA()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getLADJA()%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>
 
 
 <a onClick="return vprasaj()" href="m_ladja.jsp?akcija=DELETE&id=<%=vseb.getLADJA()%>"><img src="x.gif" border=0 title="Brisi"></a>
 
 
 
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
    aaa = "m_ladja_edit.jsp?id="+asd;
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
/////////// st izpisov
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
 <a style="text-decoration:none;color:black"  href="m_ladja.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberladja")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberladja")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_ladja.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

<td>|</td>
<%
}
%>
<%
//System.out.println("aaaaaaaaaaaaaaa ::: "+prvii);
for (int y=0;y<strec;y++) {
vse++;
if (vse==stizpisov) {
vse=0;

ststr++;
if ((prvii-5)<ststr && ststr<(prvii+5)) {
%>
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberladja")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_ladja.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberladja")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_ladja.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_ladja.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_ladja.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberladja")+"").equals("")?"1":session.getValue("pagenumberladja")%> of <%=ststr+1%> </td>
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
 

