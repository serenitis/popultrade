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

int stpri = 100;


// steje stevilo vrstic
int stej = 0;

// barve vrstic
String[] colors = {"plava1","plava2","silver"};





// stevilo vrstic
int stvrstic=0;

boolean iskanje = false;


try {

// get list from daoobject
com.popultrade.dao.TemplateTablesColDAO dao = (com.popultrade.dao.TemplateTablesColDAO)contextUtil.getBeanDao("templateTablesColDAO",pageContext.getServletContext());

 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateTablesCol(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateTablesCol",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateTablesCol")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateTablesCol")+"");
	}
	}


com.popultrade.model.TemplateTablesCol sif = new com.popultrade.model.TemplateTablesCol();
sif.setId_nad(new Long(request.getParameter("id_nad")));
int strec = dao.getStTemplateTablesCol(sif,"");



List lis =null;

lis = dao.getTemplateTablesCols(sif,pagenum,stizpisov,"","field_name","asc");







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
@import "sbuttoni.css";
</style>
<script language='javascript' src='colors.js' ></script>
<script type="text/javascript" language="JavaScript" src="tooltip.js"></script>
<script type="text/javascript" language="JavaScript" src="datum2.jsp"></script>
<script language=javascript>

// potrditev brisanja
function vprasaj() {
  var a = window.confirm("Potrdi brisanje?");

  if (a==true) {
alert(a);
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

//parent.frames[1].location = "nic.jsp";
//parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


	               	   p1="Ime polja";
	               	   
	               	   p2="Type polja";
						p3="Dolzina polja v bazi";
	               	   
	               	   p4="Java type polja";
						p5="Je index";
	               	   
	               	   p6="Je primaren index";
						p7="Tip povezave z drugo tabelo";
	               	   
	               	   p8="Veza na tabelo";
						p9="Opis";
	               	   
	               	   </script>



<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">

 <td width=15% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()"  ondragover="allowDrop(event)"  ondrop="drop('TemplateTablesCol','')"  onmousemove="ddrivetip(p1)">Ime polja</td>

            	   <td width=10% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p2)">Type</td>
               
            	 <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()"    onmousemove="ddrivetip(p3)">Dol</td>

            	   <td width=10% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">JT</td>
                   <td width=3% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()"  onmousemove="ddrivetip(p5)">IN</td>

            	   <td width=3% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p6)">PI</td>
               
            	 <td width=10% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()"  onmousemove="ddrivetip(p7)">C.Type</td>

            	   <td width=10% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p8)">C.Table</td>
               
                 <td width=25% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p9)">Description</td>
               
            	   

              
                 <td  bgcolor="D2EAFF" align=center>
                 
           
                 
                 <a onClick="return godown('m_templatetablescol_edit.jsp?opcija=new&siframm=new&sifrant=null&id_nad=<%=request.getParameter("id_nad") %>')" href="Javascript: PGAPP()"><img title="Dodaj novo polje" border="0" src="vnos.gif" /></a>
                 
                 
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
	
	com.popultrade.model.TemplateTablesCol vseb = (com.popultrade.model.TemplateTablesCol)(it.next());
		stvrstic++;

if (br==2){
  br=0;
}






if (vseb.getId().toString().equals(nul.jeNull(request.getParameter("idback")))) {
%>
<tr class="<%=colors[br]%>" id=sprememba onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')" >
<%
}
else {
%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')" >
<%
}

%>
<td width="15%" align="left" draggable="true"  ondragover="allowDrop(event)"  ondrop="drop('TemplateGumbi','&_Ltemplatehead_id=<%=vseb.getId() %>')"  ondragstart="dragStart(event,'TemplateTablesCol','tem1','&id=<%=vseb.getId()%>')" >



<%=nul.jeNull(vseb.getField_name())%></td>
	<td width="10%" align="left"><%=nul.jeNull(vseb.getType())%></td>
<td width="5%" align="left"><%=nul.jeNull(vseb.getWidth())%></td>
<td width="10%" align="left"><%=nul.jeNull(vseb.getH_type_java())%></td>


<td width="3%" align="center"><%=(nul.jeNull(vseb.getIs_index()).equals("1")?"<img src='ch.gif' border=0>":"")%></td>
<td width="3%" align="center"><%=(nul.jeNull(vseb.getIs_primarykey()).equals("1")?"<img src='ch.gif' border=0>":"")%></td>

<td width="10%" align="left"><%=nul.jeNull(vseb.getH_connection_type())%></td>
<td width="10%" align="left"><%=nul.jeNull(vseb.getH_connection_table())%></td>
<td width="25%" align="left"><%=nul.jeNull(vseb.getDescription())%></td>

<td  align="center">

 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&id_nad=<%=request.getParameter("id_nad") %>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>


 <a onClick="vprasaj()?document.location='m_templatetables_col.jsp?akcija=DELETE&id_nad=<%=request.getParameter("id_nad") %>&id=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>':''" href='#'><img src="x.gif" border=0 title="Brisi"></a>
	
</td>
</tr>




<%
br++;
System.out.println("ZZZZZZZZZZZZZZZZZ 2");
}/// while end


 %>
  
</table>


<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatetablescol_edit.jsp?id="+asd;
    parent.frames[3].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[3].location = asd;
return false;
}
function godown2(asd){
top.parent.frames[3].location = asd;
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
 <a style="text-decoration:none;color:black"  href="m_templatetables_col.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateTablesCol")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateTablesCol")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatetables_col.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateTablesCol")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatetables_col.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateTablesCol")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatetables_col.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatetables_col.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templatetables_col.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateTablesCol")+"").equals("")?"1":session.getValue("pagenumberTemplateTablesCol")%> of <%=ststr+1%> </td>
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



