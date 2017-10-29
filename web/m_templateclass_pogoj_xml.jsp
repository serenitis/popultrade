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
com.popultrade.dao.TemplateClassDAO dao = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());


if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateClass(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateClass",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateClass")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateClass")+"");
	}
	}


com.popultrade.model.TemplateClass sif = new com.popultrade.model.TemplateClass();

System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX: "+session.getAttribute("idg"));
sif.setTemplatehead_id(new Long(session.getAttribute("idg")+""));
System.out.println("XXXXXXXXXX333XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
int strec = dao.getStTemplateClass(sif);



List lis =null;

lis = dao.getTemplateClasss(sif,pagenum,stizpisov);







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
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


                	   p1="Predpona pogoja";
                	   
                
                	   
                	
                	   
                	   p7="Predpona pogoja";
                	   
                	   p9="Vrednost pogoja";
                	   
                	   p11="Opis pogoja";
                	   
                	   p13="Vrednost ob izpolnitvi pogoja";
                	   
                	   p15="Zaporedje";
                	   
                	   
                	   

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">



            
            	   
            	   <td width=10% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p7)">PP</td>
               
            	   
               
            	   
            	<td width=40% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p15)">Pogoj</td>
            	
            	<td width=30% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p13)">Vred.</td>
               
            	    <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p9)">Zap</td>

              
                 <td  bgcolor="D2EAFF" align=center><a onClick="return godown('m_templateclass_pogoj_xml_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=session.getAttribute("idt")%>&sifid=<%=session.getAttribute("idt")%>&glavno=1&idg=<%=session.getAttribute("idg")%>')" href="Javascript: PGAPP()"><img title="Dodaj nov TemplateClass" border="0" src="vnos.gif" /></a></td>
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
	
	com.popultrade.model.TemplateClass vseb = (com.popultrade.model.TemplateClass)(it.next());
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


	
	<td width="10%" align="left"><%=nul.jeNull(vseb.getPredpona_pogoja())%></td>
	
	<td width="40%" align="left"><%=nul.jeNull(vseb.getDodaten_hql_pogoj())%></td>
	
	<td width="30%" align="left"><%=nul.jeNull(vseb.getVrednost_pogoja())%></td>
	
	<td width="5%" align="center"><%=nul.jeNull(vseb.getZaporedje()+"")%></td>
	

	


<td  align="center">

 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>&sifid=<%=session.getAttribute("idt")%>&glavno=1',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>
<%
//if (nul.jeNull(vseb.getPredpona_pogoja()).equals("VALUE")) {

%>
 <a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_class_framein.jsp?idp=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=session.getAttribute("idt")%>&idt=<%=session.getAttribute("idt")%>&glavno=1&predpona=<%=nul.jeNull(vseb.getPredpona_pogoja())%>')"><img src="c.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Pridobi podatek iz druge tabele"></a>
<%
//}
%>
 <a onClick="return vprasaj()" href="m_templateclass_pogoj_xml.jsp?akcija=DELETE&id=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>



</td>
</tr>


<%


/////// dobim vrednosti

com.popultrade.model.TemplateClassClass sifo = new com.popultrade.model.TemplateClassClass();
sifo.setId_veza(vseb.getId());



List lisc =null;
com.popultrade.dao.TemplateClassClassDAO daoc = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());

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
	<td>
	
	</td>
	<td colspan=4>
	
	<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	
	<tr>
	
	<td  class="<%=colors[br]%>" width="70%" ><%=nul.jeNull(tcv.getVrednost())%>
	</td>
		<td  class="<%=colors[br]%>" >
		
		
	<a onClick="return godown('m_templateclass_pogoj_xml_edit2.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=session.getAttribute("idt")%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=tcv.getId()%>&vrednost=<%=tcv.getVrednost()%>')" href="Javascript: PGAPP()"><img title="Dodaj nov Pogoj" border="0" src="vnos.gif" /></a>	
		
		
		
	</td>

	
	</tr>
	<tr>
	<td colspan=2><table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	<%
	
	com.popultrade.model.TemplateClass sifi = new com.popultrade.model.TemplateClass();


	sifi.setTemplatehead_id(tcv.getId());



	List lisi =null;

	lisi = dao.getTemplateClasss(sifi,1,100);
	
	
	Iterator limo = lisi.iterator();
	
	
	
	while (limo.hasNext()) {
		
		com.popultrade.model.TemplateClass si =(com.popultrade.model.TemplateClass)limo.next();
		
		%>
		

		<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">



			
			<td width="10%" align="left"><%=nul.jeNull(si.getPredpona_pogoja())%></td>
			
			<td width="40%" align="left"><%=nul.jeNull(si.getDodaten_hql_pogoj())%></td>
			
			<td width="30%" align="left"><%=nul.jeNull(si.getVrednost_pogoja())%></td>
			
			<td width="5%" align="center"><%=nul.jeNull(si.getZaporedje()+"")%></td>
			

			


		<td  align="center">

		 <a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_pogoj_xml_edit2.jsp?id=<%=si.getId()%>&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>&sifid=<%=session.getAttribute("idt")%>&glavno=2&vrednost=<%=tcv.getVrednost()%>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Spremeni podatke"></a>
		<%
		//if (nul.jeNull(vseb.getPredpona_pogoja()).equals("VALUE")) {

		%>
		 <ad href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_class_framein.jsp?id=<%=si.getId()%>&opcija=spremeni&siframm=new&idback=<%=si.getId()%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=session.getAttribute("idt")%>&idt=<%=session.getAttribute("idt")%>&glavno=2&vrednost=<%=tcv.getVrednost()%>&predpona=<%=nul.jeNull(vseb.getPredpona_pogoja())%>')"><imgd src="c.gif" border=0 onClick="kliknivSivo(this,'<%=colors[br]%>');" title="Pridobi podatek iz druge tabele"></ad>
		<%
		//}
		%>
		 <a onClick="return vprasaj()" href="m_templateclass_pogoj_xml.jsp?akcija=DELETE&id=<%=si.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>



		</td>
		</tr>
		
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
    aaa = "m_templateclass_pogoj_xml_edit.jsp?id="+asd;
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
 <a style="text-decoration:none;color:black"  href="m_templateclass_pogoj_xml.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateClass")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateClass")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templateclass_pogoj_xml.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateClass")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templateclass_pogoj_xml.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateClass")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templateclass_pogoj_xml.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templateclass_pogoj_xml.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templateclass_pogoj_xml.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateClass")+"").equals("")?"1":session.getValue("pagenumberTemplateClass")%> of <%=ststr+1%> </td>
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



