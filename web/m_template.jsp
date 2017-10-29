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
com.popultrade.dao.TemplateHeadDAO dao = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateHead(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateHead",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateHead")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateHead")+"");
	}
	}


com.popultrade.model.TemplateHead sif = new com.popultrade.model.TemplateHead();
int strec = dao.getStTemplateHead(sif);



List lis =null;

lis = dao.getTemplateHeads(sif,pagenum,stizpisov);







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
<script type="text/javascript" language="JavaScript" src="datum2.js"></script>

<script language=javascript>

// potrditev brisanja
function vprasaj() {
  var a = window.confirm("Potrdis brisanje?");

  if (a==true) {
alert(a);
    return true;
  }
  else {
    return false;
  }
}





function odpriMenu(idgumb) {


if (document.getElementById("plus_"+idgumb)!=null && document.getElementById("plus_"+idgumb).innerHTML.indexOf("+")!=-1) {
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	}
var url="m_template_add.jsp";
url=url+"?idgumb="+idgumb;
url=url+"&sid="+Math.random();
xmlHttp.open("GET",url,false);
xmlHttp.send(null);


document.getElementById("gumb_"+idgumb).innerHTML=xmlHttp.responseText;
document.getElementById("plus_"+idgumb).innerHTML="-";
}
else {
if (document.getElementById("plus_"+idgumb)!=null) {
document.getElementById("gumb_"+idgumb).innerHTML="";
document.getElementById("plus_"+idgumb).innerHTML="+";
}
}


return false;
}









function odpriMenuGl(idgumb) {


if (document.getElementById("plusgl_"+idgumb)!=null && document.getElementById("plusgl_"+idgumb).innerHTML.indexOf("+")!=-1) {
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	}
var url="m_template_add_gl.jsp";
url=url+"?idgumb="+idgumb;
url=url+"&sid="+Math.random();
xmlHttp.open("GET",url,false);
xmlHttp.send(null);


document.getElementById("GL_"+idgumb).innerHTML=xmlHttp.responseText;
document.getElementById("plusgl_"+idgumb).innerHTML="-";
}
else {
if (document.getElementById("plusgl_"+idgumb)!=null) {
document.getElementById("GL_"+idgumb).innerHTML="";
document.getElementById("plusgl_"+idgumb).innerHTML="+";
}
}


return false;
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
top.parent.frames[2].location = "nic.jsp";
top.parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


                	   p1="Head class name";
                	   
                	   p3="Id";
                	   
                	   p5="Head naziv";
                	   
                	   p7="Zaporedje";
                	   
                	   p9="Opis";
                	   
                	   p11="Head tip";
                	   
                	   p13="Class id";
                	   

</script>

<%
//// odpri na refreshu
String dodo="";
if (session.getAttribute("odpriprej")!=null && !session.getAttribute("odpriprej").toString().equals("")) {
	
	dodo = ";odpriMenuGl('"+session.getAttribute("odpriprej")+"')";
	
}

%>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()<%=dodo%>" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">

 <td width=40% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()"  ondragover="allowDrop(event)"  ondrop="drop('TemplateHead','')"  onmousemove="ddrivetip(p5)">Naziv</td>

            	   <td width=25% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p1)">Class name</td>
               
            	   
            	
               
            	   
            	  
               
            	   
            	   <td width=10% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p7)">Z</td>
               
   
               
            	   

              
                 <td  bgcolor="D2EAFF" align=center>
                 
                 <a onClick="return godown2('m_templatefunkcija_framein.jsp')" href="Javascript: PGAPP()"><img title="Funkcije" border="0" src="fun.gif" /></a>
                 
                 <a onClick="return godown('m_templatehead_edit.jsp?opcija=new&siframm=new&sifrant=null')" href="Javascript: PGAPP()"><img title="Dodaj nov template" border="0" src="vnos.gif" /></a>
                 
                 
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
	
	com.popultrade.model.TemplateHead vseb = (com.popultrade.model.TemplateHead)(it.next());
		stvrstic++;

if (br==2){
  br=0;
}



boolean sogumbitouch = false;
/// kontrola za touch gumbe, da pokazem plus
if (!nul.jeNull(vseb.getHead_tip()).equals("") && (vseb.getHead_tip().equals("HT") || vseb.getHead_tip().equals("LT"))) {

	com.popultrade.dao.TemplateUiDAO daoui = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
com.popultrade.model.TemplateUi tru = new com.popultrade.model.TemplateUi();
tru.setTemplatehead_id(vseb.getId());

List ki = daoui.getTemplateUis(tru);

Iterator im = ki.iterator();

while (im.hasNext()) {

System.out.println("ZZZZZZZZZZZZZZZZZ 1");
com.popultrade.model.TemplateUi trui = (com.popultrade.model.TemplateUi)im.next();


if (nul.jeN(trui.getTip_inserta()).equals("buttoni") || nul.jeN(trui.getTip_inserta()).equals("tbutton")) {


sogumbitouch=true;
break;
}






}




}





if (vseb.getId().toString().equals(nul.jeNull(request.getParameter("idback")))) {
%>
<tr class="<%=colors[br]%>" id=sprememba onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')" onclick="return odpriMenuGl('<%=vseb.getId()%>')">
<%
}
else {
%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')" onclick="return odpriMenuGl('<%=vseb.getId()%>')">
<%
}

%>
<td width="40%" align="left" draggable="true"  ondragover="allowDrop(event)"  ondrop="drop('TemplateGumbi','&_ttTemplateGumbi_Ltemplatehead_id=<%=vseb.getId() %>')"  ondragstart="dragStart(event,'TemplateHead','tem1','&id=<%=vseb.getId()%>')" >

<%
if ((vseb.getSogumbi()!=null && vseb.getSogumbi()>0) || sogumbitouch) {
%>
<span bgcolor="silver" id="plusgl_<%=vseb.getId()%>">+</span>&nbsp;
<%
}else {
	%>
	<span bgcolor="silver" id="plsusglhg_<%=vseb.getId()%>">&nbsp;&nbsp;</span>&nbsp;
	<%
	
}
%>

<%=nul.jeNull(vseb.getHead_naziv())%></td>
	<td width="25%" align="left"><%=nul.jeNull(vseb.getHead_class_name())%></td>
	

	
	
	
	<td width="10%" align="center"><%=nul.jeNull(vseb.getZaporedje()+"")%></td>
	

	


<td  align="center">

 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke (ID: <%=vseb.getId()%>)"></a>

<%
if (vseb!=null && vseb.getTemplateGumbis().size()==0) {
%>
 <a onClick="vprasaj()?document.location='m_template.jsp?akcija=DELETE&id=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>':''" href='#'><img src="x.gif" border=0 title="Brisi"></a>
	 <%
}
	 if (vseb.getHead_tip().equals("PD") || vseb.getHead_tip().equals("UP") || vseb.getHead_tip().equals("UR")  || vseb.getHead_tip().equals("SE")  || vseb.getHead_tip().equals("HE")) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_pdf.jsp?id=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Generiraj jsp-je"></a>
	
	<%
	 }
	 	 else if (vseb.getHead_tip().equals("EX") || vseb.getHead_tip().equals("EE")) {
		 %>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_exp.jsp?id=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Generiraj exp jsp-je"></a>
		
		<%
		 }

 else if (vseb.getHead_tip().equals("PR") || vseb.getHead_tip().equals("FU") || vseb.getHead_tip().equals("OB") ) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_pr.jsp?id=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Generiraj jsp-je"></a>
	
	<% 
 }
  else if (vseb.getHead_tip().equals("LT") || vseb.getHead_tip().equals("HT") ) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_to.jsp?id=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Generiraj jsp-je"></a>
	
	<% 
 }
	 
  else if (vseb.getHead_tip().equals("LI") ) {
		 %>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_li.jsp?id=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Generiraj jsp-je"></a>
		
		<% 
	 }
	 
	 else {
		 %>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp.jsp?id=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Generiraj jsp-je"></a>
		
		<% 
	 }
	%>

</td>
</tr>

<%
if ((vseb.getSogumbi()!=null && vseb.getSogumbi()>0) || sogumbitouch) {
%>
<tr><td colspan=4><span id="GL_<%=vseb.getId()%>"></span></td></tr>


<%
}

%>




<%
br++;
System.out.println("ZZZZZZZZZZZZZZZZZ 2");
}/// while end


 %>
  
</table>


<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatehead_edit.jsp?id="+asd;
    parent.frames[1].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[1].location = asd;
return false;
}
function godown2(asd){
top.parent.frames[2].location = asd;
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
 <a style="text-decoration:none;color:black"  href="m_templatehead.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateHead")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateHead")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatehead.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateHead")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatehead.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateHead")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatehead.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatehead.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templatehead.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateHead")+"").equals("")?"1":session.getValue("pagenumberTemplateHead")%> of <%=ststr+1%> </td>
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



