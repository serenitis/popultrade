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
com.popultrade.dao.TemplateConversionsDAO dao = (com.popultrade.dao.TemplateConversionsDAO)contextUtil.getBeanDao("templateConversionsDAO",pageContext.getServletContext());

 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateConversions(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateConversions",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateConversions")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateConversions")+"");
	}
	}


com.popultrade.model.TemplateConversions sif = new com.popultrade.model.TemplateConversions();

sif.setId_nad(new Long(request.getParameter("idg")));

int strec = dao.getStTemplateConversions(sif,"");



List lis =null;

lis = dao.getTemplateConversionss(sif,pagenum,stizpisov,"","name","asc");







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
//top.parent.frames[2].location = "nic.jsp";
//top.parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


                	   p1="Name";
                	   
                	   p3="Description";
                	   p4 = "Conversion id";
                	p5 = "XML";
                	p6 = "APP";

</script>



<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">

 <td width=20% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()"  ondragover="allowDrop(event)"  ondrop="drop('TemplateConversions','')"  onmousemove="ddrivetip(p1)">Name</td>

            	   <td width=40% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p3)">Description</td>
               
            	   
         	   <td width=20% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">LPD</td>       	
               
            	    <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p5)">XML</td>  
            	     <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p6)">APP</td>  
            
                 <td  bgcolor="ADD9FF" align=center>
                 
           
                 
                 <a onClick="return godown('m_conversions_edit.jsp?opcija=new&siframm=new&sifrant=null&idg=<%=request.getParameter("idg") %>')" href="Javascript: PGAPP()"><img title="Dodaj novo tabelo" border="0" src="vnos.gif" /></a>
                  
                 
                 
                 </td>
        </tr>
 

</table>
</div>




<form name="dod" method="post" action="m_templatetables_gen0.jsp" >

<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
<tr><td colspan=3>&nbsp</td></tr>
<%

/// menja barvo
int br = 0;
String oe_kup_nap = "";


Iterator it = lis.iterator();


while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplateConversions vseb = (com.popultrade.model.TemplateConversions)(it.next());
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
<td width="20%" align="left" draggable="true"  ondragover="allowDrop(event)"  ondrop="drop('TemplateGumbi','&_Ltemplatehead_id=<%=vseb.getId() %>')"  ondragstart="dragStart(event,'TemplateConversions','tem12x','&id=<%=vseb.getId()%>')" >



<%=nul.jeNull(vseb.getName())%></td>
	<td width="40%" align="left"><%=nul.jeNull(vseb.getDescription())%></td>

<td width="20%" align="center"><%=nul.jeNull(vseb.getConv_id()) %></td>
<td width="5%" align="center">XML</td>
<td width="5%" align="center">APP</td>

<td  align="center">

 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>&idg=<%=request.getParameter("idg") %>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke (ID: <%=vseb.getId()%>)"></a>
<a href="Javascript:PGAPP()" onCLick="return godown('m_conversions_con_framein.jsp?idg=<%=vseb.getId()%>&opcija=spremeni&siframm=new&sifrant=<%=request.getParameter("sifrant")%>',1,'<%=vseb.getId()%>')"><img src="i.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Conversion"></a>


 <a onClick="vprasaj()?document.location='m_conversions.jsp?akcija=DELETE&idg=<%=request.getParameter("idg") %>&id=<%=vseb.getId()%>&sifrant=<%=request.getParameter("sifrant")%>':''" href='#'><img src="x.gif" border=0 title="Brisi"></a>
	
</td>
</tr>




<%
br++;
System.out.println("ZZZZZZZZZZZZZZZZZ 2");
}/// while end


 %>
  
</table>
</form>

<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_conversions_edit.jsp?id="+asd;
    top.parent.frames[2].location = aaa;
  }

return false;
}
function godown(asd,as,sa){
	
	
	top.parent.frames[2].location = asd;
	
	
	top.parent.frames[3].location = "m_templatexml_app_list.jsp?idg="+sa;
	
return false;
}
function godown2(asd){
	top.parent.frames[2].location = asd;
return false;
}
function PGAPP(){
}

function submitt() {
	
	var jec = 0;
	jec=1;
	/*  var elements = document.forms["dod"].elements;
	  for (i=0; i<elements.length; i++){
	   
		  if (elements[i].name.indexOf("cb_")!=-1) {
			  
			  if (elements[i].checked) {
				jec=1;
				break;
			  }
		  }
		  
	  }*/
	  
	  if (jec==1) {
	document.dod.target = top.parent.frames[2].name;
	document.dod.submit();
	  }
	  else {
		  alert("Napaka: ni izbranih tabel za generacijo hibernate class!");
	  }
	
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
 <a style="text-decoration:none;color:black"  href="m_conversions.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateConversions")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateConversions")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_conversions.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateConversions")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_conversions.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateConversions")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_conversions.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_conversions.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_conversions.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateConversions")+"").equals("")?"1":session.getValue("pagenumberTemplateConversions")%> of <%=ststr+1%> </td>
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



