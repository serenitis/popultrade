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
 
int stpri = 1000;
 
 
// steje stevilo vrstic
int stej = 0;
 
// barve vrstic
String[] colors = {"plava1","plava2","silver"};
 
 

boolean iskanje = false;
 

 
 
// stevilo vrstic
int stvrstic=0;
 

try {
 
// get list from daoobject
com.popultrade.dao.TemplatePagesDAO dao = (com.popultrade.dao.TemplatePagesDAO)contextUtil.getBeanDao("templatePagesDAO",pageContext.getServletContext());
 
 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 try {
	dao.removeTemplatePages(new Long(request.getParameter("id")));
 
	
	/// remove from disk
	String relp = request.getRealPath("")+""+request.getParameter("filename");
	File fik = new File(relp);
	fik.delete();
 }
 catch (Exception emo) {
	 
 }
	
}



int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumbertemplatePages",pagenum+"");
	}
	else {
	if (session.getValue("pagenumbertemplatePages")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumbertemplatePages")+"");
	}
	}

com.popultrade.model.TemplatePages sif = new com.popultrade.model.TemplatePages();




	
if (nul.jeNull(request.getParameter("isci")).equals("yes")) {
	iskanje = true;
	//sif = (com.popultrade.model.TemplatePages)contextUtil.getPopulatedObject(sif,request);
	
	if (!nul.jeNull(request.getParameter("pagename")).equals("")) {
		sif.setPagename(nul.jeNull(request.getParameter("pagename")));
	}

	
	session.setAttribute("templatePages_search",sif);
	
}
if (nul.jeNull(request.getParameter("isk")).equals("1")) {
iskanje = true;
sif = (com.popultrade.model.TemplatePages)session.getAttribute("templatePages_search");

}

int strec = dao.getStTemplatePages(sif,"");
 
List lis =null;
 




lis = dao.getTemplatePagess(sif,1,500,"","","");
 
  
 
 
 
 
 
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
 
 
                	   p1="Page name";
                	   
                
                	   
 
</script>
 
 
<body   background="podlaga.jpg" bgproperties="fixed" style="margin: 0" onLoad="chg();menuBarInit()" >

<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
 
 
 
            	   <td width=90% align=left bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p1)">Page name</td>
               
            	   
            	
 
              
                 <td  bgcolor="ADD9FF" align=center>
                 <a onClick="return godown('m_custompages_isci.jsp')" href="Javascript: B2S()"><img border="0" src="search.gif" alt="Isci" /></a>
                 <a onClick="return godown('m_custompages_edit.jsp?opcija=new&siframm=new&sifrant=null')" href="Javascript: PGAPP()"><img title="Dodaj nov TemplatePages" border="0" src="vnos.gif" /></a></td>
        </tr>
 
 
</table>
</div>
 
 
 
 
 
 
<table cellspacing=1  style="width:100%; font-family: Verdana; font-size: 7pt">
<tr><td colspan=13>&nbsp;</td></tr>
<%
 
/// menja barvo
int br = 0;
String oe_kup_nap = "";
 
 
Iterator it = lis.iterator();
 
 
while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplatePages vseb = (com.popultrade.model.TemplatePages)(it.next());
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
 
	<td width="90%" align="left"><%=nul.jeNull(vseb.getPagename())%> </td>
	

 
<td  align="center">
 
 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&filename=<%=vseb.getPagename() %>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%><%=(nul.jeNull(request.getParameter("isk")).equals("1") || nul.jeNull(request.getParameter("isci")).equals("yes"))?"&isk=1":""%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>
 

 
 <a onClick="return vprasaj()" href="m_custompages.jsp?akcija=DELETE&filename=<%=vseb.getPagename() %>&id=<%=vseb.getId()%><%=(nul.jeNull(request.getParameter("isk")).equals("1") || nul.jeNull(request.getParameter("isci")).equals("yes"))?"&isk=1":""%>"><img src="x.gif" border=0 title="Brisi"></a>
 
 
 
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
    aaa = "m_custompages_edit.jsp?id="+asd;
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
//strec=300;
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
 <a style="text-decoration:none;color:black"  href="m_custompages.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumbertemplatePages")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumbertemplatePages")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_custompages.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumbertemplatePages")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatePages.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumbertemplatePages")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatePages.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_custompages.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_custompages.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumbertemplatePages")+"").equals("")?"1":session.getValue("pagenumbertemplatePages")%> of <%=ststr+1%> </td>
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
 
