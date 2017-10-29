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
com.popultrade.dao.TemplateFunkcijaStartDAO dao = (com.popultrade.dao.TemplateFunkcijaStartDAO)contextUtil.getBeanDao("templateFunkcijaStartDAO",pageContext.getServletContext());


if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE") && nul.jeNull(request.getParameter("kaj")).equals("class"))  {
	
	com.popultrade.dao.TemplateClassDAO daocc = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

	daocc.removeTemplateClass(new Long(request.getParameter("id")));

	
}
else if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateFunkcijaStart(new Long(request.getParameter("id")));

	
}

int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateFunkcija",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateFunkcija")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateFunkcija")+"");
	}
	}


com.popultrade.model.TemplateFunkcijaStart sif = new com.popultrade.model.TemplateFunkcijaStart();

System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX: "+session.getAttribute("idg"));

sif.setVeza_id(new Long(session.getAttribute("idt")+""));
//sif.setTemplatehead_id(new Long(session.getAttribute("idg")+""));
System.out.println("XXXXXXXXXX333XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
int strec = dao.getStTemplateFunkcijaStart(sif);



List lis =null;

lis = dao.getTemplateFunkcijaStarts(sif,pagenum,stizpisov);







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




function GetXmlHttpObject() {

var objXMLHttp=null;

if (window.XMLHttpRequest) {
objXMLHttp=new XMLHttpRequest();
}
else if (window.ActiveXObject){
objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
}
return objXMLHttp;
} 



function odpriMenu(idgumb) {


if (document.getElementById("plus_"+idgumb).innerHTML.indexOf("+")!=-1) {
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	}
var url="m_templatefunkcija_add2.jsp";
url=url+"?idgumb="+idgumb;
url=url+"&sid="+Math.random();
xmlHttp.open("GET",url,false);
xmlHttp.send(null);


document.getElementById("gumb_"+idgumb).innerHTML=xmlHttp.responseText;
document.getElementById("plus_"+idgumb).innerHTML="-";
}
else {

document.getElementById("gumb_"+idgumb).innerHTML="";
document.getElementById("plus_"+idgumb).innerHTML="+";
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
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


                	   p1="Ime funkcije";
                	   
                
                	   
                	
                	   
                	   p15="Class funkcije";
                	   
                
</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">



            
            	   
            	   <td width=50% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p1)">Ime</td>
               
            	   
               
            	   
            	<td width=30% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p15)">Class</td>
            	
        

              
                 <td  bgcolor="D2EAFF" align=center><a onClick="return godown2('m_templatefunkcijastart_edit2.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>&sifid=<%=request.getParameter("idt")%>&glavno=1&idg=<%=request.getParameter("idg")%>')" href="Javascript: PGAPP()"><img title="Dodaj nov TemplateFunkcija" border="0" src="vnos.gif" /></a></td>
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

System.out.println("----------------------------- "+lis.size());

while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplateFunkcijaStart vseb = (com.popultrade.model.TemplateFunkcijaStart)(it.next());
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


	
	<td width="50%" align="left"><%=nul.jeNull(vseb.getIme_funkcije())%></td>
	
	
	
	<td width="30%" align="left"><%=nul.jeNull(vseb.getClass_name())%></td>
	

	

	


<td  align="center">

 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>&sifid=<%=session.getAttribute("idt")%>&glavno=1',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>
<%
//if (nul.jeNull(vseb.getPredpona_pogoja()).equals("VALUE")) {

%>
 <a href="Javascript:PGAPP()" onCLick="return godown('m_templatefunkcija_class_framein2.jsp?idp=<%=vseb.getId()%>&classo=<%=nul.jeNull(vseb.getClass_name())%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=session.getAttribute("idt")%>&idt=<%=session.getAttribute("idt")%>&glavno=1')"><img src="c.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Pridobi podatek iz druge tabele"></a>
<%
//}
%>
 <a onClick="return vprasaj()" href="m_templatefunkcija2.jsp?akcija=DELETE&id=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>



</td>
</tr>





<%


/////// dobim vrednosti

com.popultrade.model.TemplateClassClass sifo = new com.popultrade.model.TemplateClassClass();
sifo.setId_veza(vseb.getId());


com.popultrade.dao.TemplateClassClassDAO daoc = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());
List lisc =null;

lisc = daoc.getTemplateClassClasss(sifo);

if (lisc.size()>0) {
sifo = (com.popultrade.model.TemplateClassClass)lisc.get(0);
}


if (sifo.getId()!=null) {

List vredn = sifo.getTemplateClassClass_vrednostis();

Iterator iu = vredn.iterator();

while (iu.hasNext()) {
	
	com.popultrade.model.TemplateClassClass_vrednosti tcv = (com.popultrade.model.TemplateClassClass_vrednosti)iu.next();
	
	%>
	
	
	<tr class="<%=colors[br]%>" >

	<td colspan=3>
	
	<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	
	<tr>
	
	<td  class="<%=colors[br]%>" width="70%" ><%=nul.jeNull(tcv.getVrednost())%>
	</td>
		<td  class="<%=colors[br]%>" >
		
		<%
		if (nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
		%>
	<a onClick="return godown('m_templatefunkcija_pogoj_edit22.jsp?idv=<%=vseb.getId()%>&opcija=new&siframm=new&sifrant=null&idt=<%=session.getAttribute("idt")%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=tcv.getId()%>&vrednost=<%=tcv.getVrednost()%>')" href="Javascript: PGAPP()"><img title="Dodaj nov Pogoj" border="0" src="vnos.gif" /></a>	
		<%
		}
		%>
		
		
	</td>

	
	</tr>
	<tr>
	<td colspan=2><table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	<%
	com.popultrade.dao.TemplateClassDAO daotc = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());
	com.popultrade.model.TemplateClass sifi = new com.popultrade.model.TemplateClass();


	sifi.setTemplatehead_id(tcv.getId());



	List lisi =null;

	lisi = daotc.getTemplateClasss(sifi,1,100);
	
	
	Iterator limo = lisi.iterator();
	
	
	
	while (limo.hasNext()) {
		
		com.popultrade.model.TemplateClass si =(com.popultrade.model.TemplateClass)limo.next();
		
		%>
		

		<tr bgcolor="silver" >

<td width="5%" align="center">

<%
/// kontrola, ce je vrednost

com.popultrade.model.TemplateClassClass sifo2 = new com.popultrade.model.TemplateClassClass();
sifo2.setId_veza(si.getId());



List lisct =null;

lisct = daoc.getTemplateClassClasss(sifo2);

if (lisct.size()>0) {
sifo2 = (com.popultrade.model.TemplateClassClass)lisct.get(0);
}
   

if (sifo2.getTemplateClassClass_vrednostis().size()>0) {


%>
<a href="#" onclick="return odpriMenu('<%=si.getId()%>')" style="text-decoration:none"><span id="plus_<%=si.getId()%>">+</span></a>

<%
}
%>

			</td>
			
			
			<td width="10%" align="left"><%=nul.jeNull(si.getPredpona_pogoja())%></td>
			
			<td width="40%" align="left"><%=nul.jeNull(si.getDodaten_hql_pogoj())%></td>
			
			<td width="25%" align="left"><%=nul.jeNull(si.getVrednost_pogoja())%></td>
			
			<td width="5%" align="center"><%=nul.jeNull(si.getZaporedje()+"")%></td>
			

			


		<td  align="center">

		 <a href="Javascript:PGAPP()" onCLick="return godown('m_templatefunkcija_pogoj_edit22.jsp?idv=<%=vseb.getId()%>&id=<%=si.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>&sifid=<%=session.getAttribute("idt")%>&glavno=2&vrednost=<%=tcv.getVrednost()%>',1)"><img src="u.gif" border=0 title="Spremeni podatke"></a>
		<%
		//if (nul.jeNull(vseb.getPredpona_pogoja()).equals("VALUE")) {

		%>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_templatefunkcija_class_framein2.jsp?idv=<%=vseb.getId()%>&idp=<%=si.getId()%>&opcija=spremeni&siframm=new&idback=<%=si.getId()%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=session.getAttribute("idt")%>&idt=<%=session.getAttribute("idt")%>&glavno=2&vrednost=<%=tcv.getVrednost()%>')"><img src="c.gif" border=0 title="Pridobi podatek iz druge tabele"></a>
		<%
		//}
		%>
		 <a onClick="return vprasaj()" href="m_templatefunkcija2.jsp?akcija=DELETE&kaj=class&id=<%=si.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>



		</td>
		</tr>
		<tr><td colspan=6><span id="gumb_<%=si.getId()%>"></span></td></tr>
		<%
		
		
	}
	
	
	
	
	
	%>
	</table></td></tr>
	
	
	
	</table>
	</td>
	</tr>
	
	<%
	
	
}




}





%>





<%
br++;

}/// while end


 %>
  
</table>


<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatefunkcijastart_edit2.jsp?id="+asd;
    parent.frames[1].location = aaa;
  }

return false;
}
function godown(asd){
top.parent.frames[3].location = asd;
return false;
}
function godown2(asd){
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
 <a style="text-decoration:none;color:black"  href="m_templatefunkcija2.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateFunkcija")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateFunkcija")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatefunkcija2.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateFunkcija")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatefunkcija2.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateFunkcija")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatefunkcija2.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatefunkcija2.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templatefunkcija2.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateFunkcija")+"").equals("")?"1":session.getValue("pagenumberTemplateFunkcija")%> of <%=ststr+1%> </td>
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



