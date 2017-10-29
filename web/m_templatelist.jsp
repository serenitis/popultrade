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
com.popultrade.dao.TemplateListDAO dao = (com.popultrade.dao.TemplateListDAO)contextUtil.getBeanDao("templateListDAO",pageContext.getServletContext());

if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("prevod"))  {
	
	
	Enumeration enn = request.getParameterNames();
	
	while (enn.hasMoreElements()) {
		
		String str = (String)enn.nextElement();
		
		if (str!=null && str.startsWith("prevod_")) {
			
			String[] stru = str.split("_");
			com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
			com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
			
			
			prevo.setPrevod_id(new Long(stru[1]));
			prevo.setSifra_jez(session.getAttribute("jezikv")+"");
			prevo.setVrsta(stru[2]);
			if (stru.length==4 && !stru[3].equals("")) {
			//	prevo.setId(new Long(stru[3]));
				
			}
			prevo = daop.getPrevodiCopy(prevo);
			
			if (prevo==null) {
				prevo = new com.popultrade.model.Prevodi();
				prevo.setPrevod(nul.jeNull(request.getParameter(str)));
				prevo.setPrevod_id(new Long(stru[1]));
				prevo.setSifra_jez(session.getAttribute("jezikv")+"");
				prevo.setVrsta(stru[2]);
				
			}
			prevo.setPrevod(nul.jeNull(request.getParameter(str)));
			
			daop.savePrevodi(prevo);
			ConPool.setPrevod_admin(stru[1],stru[2],session.getAttribute("jezikv")+"",nul.jeNull(request.getParameter(str)),prevo.getId()+"");
			
			
		}
		
		
		
	}
	
	
	
}

if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateList(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateList",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateList")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateList")+"");
	}
	}


com.popultrade.model.TemplateList sif = new com.popultrade.model.TemplateList();
sif.setTemplatehead_id(new Long(request.getParameter("idt")));
int strec = 10;








List lis =null;

lis = dao.getTemplateLists(sif);







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
 <link rel="stylesheet" href="js/jquery-ui.css">
<script type="text/javascript" language="JavaScript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" language="JavaScript" src="js/jquery-ui.js"></script>
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



var dialog;
 $(function() {


    dialog = $( "#opiss" ).dialog({

      autoOpen: false,

      height: 300,

      width: 650,

      modal: true

    });


  });






function odpriDialog(idd) {
//dialog.dialog( "close" );
document.getElementById("inframe").src="m_navodila_set_li.jsp?idnav="+idd;


dialog.dialog( "open" );
}

function zapriDialog() {
dialog.dialog( "close" );

}

function updateNav(idnnv,zanar) {

ert = document.getElementById("NAV_"+idnnv);
if (zanar==0) {
ert.innerHTML = 'NAV';
}
else {
ert.innerHTML = "<img src='todo.gif' border=0 height=12> TODO ";

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


parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>

   

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg()" >

<div id="opiss" title="Navodila">
<iframe  style="font-family: Verdana; font-size: 8pt;width:95%;height:95%" id="inframe"></iframe>
</div>


<form name="dod" action="m_templatelist.jsp?idt=<%=request.getParameter("idt")%>&akcija=prevod" method="post">
<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 9pt">

<tr>
<%

/// menja barvo
int br = 0;
String oe_kup_nap = "";


Iterator it = lis.iterator();


while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplateList vseb = (com.popultrade.model.TemplateList)(it.next());
		stvrstic++;

if (br==2){
  br=0;
}



%>


	<td  class="<%=colors[br]%>" width="<%=nul.jeNull(vseb.getStolpec_width())%>" align="<%=nul.jeNull(vseb.getStolpec_align())%>">
	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	<tr><td class="opiscell" >
	
	
	
	  <table  width=100% height=100% cellspacing=1  style="font-family: Verdana; font-size: 8pt">
  <tr><td width=50%>
<b>
	<%=nul.jeNull(vseb.getStolpec_naziv())%></b><%=nul.jeNull(vseb.getFormat_stolpca()).equals("")?"":"<br>F: "+vseb.getFormat_stolpca()%></td>
	<%
	String navik = "NAV";
	if (nul.jeNull(vseb.getNavodila_obdelana()).equals("1")) {
	navik = "<img src='todo.gif' border=0 height=12> TODO";
	}
	 %>
	
	<td align=right><b><a href="#" onclick="odpriDialog('<%=vseb.getId()%>')" title="Vnos navodil za izdelavo polja" id="NAV_<%=vseb.getId() %>" style="text-decoration:none"><%=navik %></a></b></td>
	</tr></table>
	
	
	
	
	
	</td></tr>
		<tr><td class="valuecell" >
		 <table cellspacing=0  style="font-family: Verdana; font-size: 8pt"><tr><td colspan=2>
		
<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","H",session.getAttribute("jezikp")+""))%></td></tr><tr><td>
<i>Hint:</i></td><td><input type="text" name="prevod_<%=vseb.getId()%>_H_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","H",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
</td></tr>

<tr><td colspan=2>
<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%></td></tr><tr><td>
<i>Prevod:</i></td><td><input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
</td></tr></table>

	</td></tr>
	<tr><td class="valuecell" >
	<b>
	(<%=nul.jeNull(vseb.getStolpec_metoda())%>)</b>
	</td></tr>
	<tr><td class="valuecell" >
	W: <%=nul.jeNull(vseb.getStolpec_width())%>
	</td></tr>
	<tr><td class="valuecell" >
	A: <%=nul.jeNull(vseb.getStolpec_align())%>
	</td></tr>
	<tr><td class="valuecell" >
	Z: <%=nul.jeNull(vseb.getZaporedje()+"")%>
	</td></tr>
	
		<tr><td class="valuecell" >
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_pogoj_framein.jsp?idg=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>&sifid=<%=request.getParameter("idt")%>')" ><img src="pp.gif" alt="Pogoji prikaza" border="0"></a>
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_class_framein_hint.jsp?idp=<%=vseb.getId()%>&predpona=LIST&opcija=spremeni&siframm=new&idback=<%=vseb.getId()%>&idg=<%=vseb.getId()%>&sifid=<%=request.getParameter("idt")%>&idt=<%=request.getParameter("idt")%>&glavno=1')"><img src="hint.gif" alt="Hint iz sifranta" border="0"></a>
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	 <a onClick="return vprasaj()" href="m_templatelist.jsp?akcija=DELETE&id=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>
	
	</td></tr>

	</table>
	</td>
	



<%
br++;

}/// while end


 %>
  <td align=left bgcolor="silver" height="55">
  
  <%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","R",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=request.getParameter("idt")%>_R_<%=nul.jeNull(ConPool.getPrevod_admin_id(request.getParameter("idt")+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(request.getParameter("idt")+"","R",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">(potrdi brisanje)
  <br>&nbsp;<br>
  
<input type="button" onClick="return godown('m_templatelist_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>')"  style="font-family: Verdana; font-size: 8pt;background-color:#003461;color:white;border-style:solid;"  title="Dodaj novi stolpec"  value="Dodaj novi stolpec">
  <br>&nbsp;<br>
  <input type="submit" value="Shrani prevode"  style="font-family: Verdana; font-size: 8pt">
<br>
  <input type="button" value="Dodatni pogoji delete"  style="font-family: Verdana; font-size: 8pt" onClick="return godown('m_templateuidodatno_edit_list.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>')">
<br>
   <input type="button" value="Dodatni pogoji"  style="font-family: Verdana; font-size: 8pt" onClick="return godown('m_templateviewdodatno_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>')">
 
  </td></tr>
</table>
</form>

<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatelist_edit.jsp?id="+asd;
    parent.frames[3].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[3].location = asd;
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
 <a style="text-decoration:none;color:black"  href="m_templatelist.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateList")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateList")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatelist.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateList")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatelist.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateList")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatelist.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatelist.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templatelist.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
<td>|</td>
<td >
page: <%=nul.jeNull(session.getValue("pagenumberTemplateList")+"").equals("")?"1":session.getValue("pagenumberTemplateList")%> of <%=ststr+1%> </td>
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



