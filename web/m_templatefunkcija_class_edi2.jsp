<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />



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

	
	String sifid=session.getAttribute("idt")+"";
	

	if (!nul.jeNull(request.getParameter("sifid")).equals("")) {
		sifid = request.getParameter("sifid");
	}


	if (request.getParameter("kaj")!=null && request.getParameter("kaj").equals("pogoji"))  {
		
		com.popultrade.dao.TemplateClassDAO dao = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

		dao.removeTemplateClass(new Long(request.getParameter("idd")));

		
	}
	else if (request.getParameter("kaj")!=null && request.getParameter("kaj").equals("vrednosti"))  {
		
		com.popultrade.dao.TemplateClassClass_vrednostiDAO dao = (com.popultrade.dao.TemplateClassClass_vrednostiDAO)contextUtil.getBeanDao("templateClassClass_vrednostiDAO",pageContext.getServletContext());

		dao.removeTemplateClassClass_vrednosti(new Long(request.getParameter("idd")));
		
	}
	else {
	
	}
	
	
	
	
	
	
	
// get list from daoobject
com.popultrade.dao.TemplateClassClassDAO dao = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());


if (request.getParameter("kaj")!=null && request.getParameter("kaj").equals("insert"))  {
	com.popultrade.model.TemplateClassClass siff = new com.popultrade.model.TemplateClassClass();

	siff.setId_veza(new Long(session.getAttribute("idp")+""));
	
	siff.setClass_name(request.getParameter("class"));
	siff.setTip_funkcije(request.getParameter("tip_funkcije"));
	
	if (!nul.jeNull(request.getParameter("idm")).equals("")) {
		siff.setId(new Long(request.getParameter("idm")));
			
	}
	
	dao.saveTemplateClassClass(siff);

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateClassClass",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateClassClass")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateClassClass")+"");
	}
	}


com.popultrade.model.TemplateClassClass sif = new com.popultrade.model.TemplateClassClass();


sif.setId_veza(new Long(session.getAttribute("idp")+""));

int strec = 0;

List lis =null;

lis = dao.getTemplateClassClasss(sif);

if (lis.size()>0) {
sif = (com.popultrade.model.TemplateClassClass)lis.get(0);
}



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


function shrani() {

document.location = "m_templatefunkcija_class_edi2.jsp?kaj=insert&idm=<%=sif.getId()%>&sifid=<%=sifid%>&tip_funkcije="+document.getElementById("tip_funkcije").value+"&class="+document.getElementById("class_name").value;

}


function chg() {


    




parent.frames[1].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


      
                	   
                	   
                	   

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();" >





<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
<tr class="<%=colors[1]%>" ><td >Class</td><td >Pogoji</td><td >Vrednosti</td></tr>
<%






%>
<tr   class="<%=colors[0]%>" >



	
	<td width="30%" align="left">


            		           		  		 <select name="class_name" id="class_name" style="font-family: Verdana; font-size: 8pt" onChange="return shrani()" >
            		 
            		 
					<option value=""></option>
					
					
					<%
					
					
					//// dobim ime model clase iz headerja
					
			
					List li = templateUtil.getClasseNamesInPackage(contextUtil,this.getServletContext(),"","");
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if ((nex!=null && nex.equals(nul.jeNull(sif.getClass_name())))) {
					%>
					
					
					<option value="<%=nex%>" selected><%=nex%></option>
					
					
					<%
					
						}
						else {
							if (nul.jeNull(session.getAttribute("classo")+"").equals("")  || nul.jeNull(session.getAttribute("classo")+"").equals(nex)) {
							%>
							
							
							<option value="<%=nex%>" ><%=nex%></option>
							
							
							<%	
							}
							
						}
					}
					%>
					
					
					</select><br>
					Tip funkcije:<br>
  		 <select name="tip_funkcije" id="tip_funkcije" style="font-family: Verdana; font-size: 8pt" onChange="return shrani()" >
            		 
            		 
					<option value=""></option>
					
					<option value="IN" <%=nul.jeNull(sif.getTip_funkcije()).equals("IN")?"selected":""%>>Insert</option>
					<option value="UP" <%=nul.jeNull(sif.getTip_funkcije()).equals("UP")?"selected":""%>>Update</option>
					<option value="LI" <%=nul.jeNull(sif.getTip_funkcije()).equals("LI")?"selected":""%>>List</option>
					<option value="ER" <%=nul.jeNull(sif.getTip_funkcije()).equals("ER")?"selected":""%>>En rezultat</option>
			
					
					</select>


</td>
	
	<td width="40%" align="left">
	
	
	<%
	if (!nul.jeNull(sif.getId()+"").equals("")) {
	%>
	
	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	
<%
//// pogoji

List lio = sif.getTemplateClasss();


Iterator iter = lio.iterator();





while (iter.hasNext()) {
	
	com.popultrade.model.TemplateClass temc =(com.popultrade.model.TemplateClass)iter.next();
	
	%>
	<tr><td class="opiscell" >
	<%=nul.jeNull(temc.getIme_pogoja())%></td><td> = </td><td class="opiscell"><%=nul.jeNull(temc.getVrednost_pogoja())%></td>
	<td>
	
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_templatefunkcija_edit22.jsp?idp=<%=request.getParameter("idp")%>&id=<%=temc.getId()%>&idtc=<%=sif.getId()%>&sifid=<%=sifid%>&opcija=spremeni&siframm=new&idback=<%=temc.getId()%>')"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	 <a onClick="return vprasaj()" href="m_templatefunkcija_class_edi2.jsp?idp=<%=request.getParameter("idp")%>&akcija=DELETE&idd=<%=temc.getId()%>&sifid=<%=sifid%>&kaj=pogoji"><img src="x.gif" border=0 title="Brisi"></a>
	
	
	</td>
	
	</tr>
	<%
}



%>


<tr><td></td><td></td><td></td><td>


<a onClick="return godown('m_templatefunkcija_edit22.jsp?idp=<%=request.getParameter("idp")%>&opcija=new&siframm=new&sifrant=null&sifid=<%=sifid%>&idtc=<%=sif.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj novi pogoj" border="0" src="vnos.gif" /></a>
 

</td></tr>
</table>

<%
	}
%>

</td>
	
	<td width="30%" align="left">
	
	
		<%
		
		if (!nul.jeNull(session.getAttribute("predpona")+"").equals("LIST")) {
	if (!nul.jeNull(sif.getId()+"").equals("")) {
	%>
	
	
		<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	
<%
//// pogoji

List lio = sif.getTemplateClassClass_vrednostis();


Iterator iter = lio.iterator();





while (iter.hasNext()) {
	
	com.popultrade.model.TemplateClassClass_vrednosti temc =(com.popultrade.model.TemplateClassClass_vrednosti)iter.next();
	
	%>
	<tr><td class="opiscell" >
	<%=nul.jeNull(temc.getVrednost())%> (<%=nul.jeNull(temc.getRabi_kot())%>)</td><td>
	
	
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_templatefunkcija_class_vrednosti_edi2.jsp?idp=<%=request.getParameter("idp")%>&id=<%=temc.getId()%>&idtc=<%=sif.getId()%>&sifid=<%=sifid%>&opcija=spremeni&siframm=new&idback=<%=temc.getId()%>')"><img src="u.gif" border=0 title="Spremeni podatke"></a>
	 <a onClick="return vprasaj()" href="m_templatefunkcija_class_edi2.jsp?idp=<%=request.getParameter("idp")%>&akcija=DELETE&idd=<%=temc.getId()%>&sifid=<%=sifid%>&kaj=vrednosti"><img src="x.gif" border=0 title="Brisi"></a>
	
	
	</td></tr>
	<%
}



%>

<tr><td></td><td>

<a onClick="return godown('m_templatefunkcija_class_vrednosti_edi2.jsp?idp=<%=request.getParameter("idp")%>&opcija=new&siframm=new&sifrant=null&sifid=<%=sifid%>&idtc=<%=sif.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj novo vrednost" border="0" src="vnos.gif" /></a>
        
</td></tr>

</table>
	
	<%
	}
		}
	%>
	
	
	
	</td>
	


</tr>

<%

 %>
  
</table>


<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templateclass_pogoj_edit.jsp?id="+asd;
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
 <a style="text-decoration:none;color:black"  href="m_templateclass.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateClassClass")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateClassClass")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templateclass.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateClassClass")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templateclass.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateClassClass")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templateclass.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templateclass.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templateclass.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateClassClass")+"").equals("")?"1":session.getValue("pagenumberTemplateClassClass")%> of <%=ststr+1%> </td>
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



