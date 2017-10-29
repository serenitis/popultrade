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
if (request.getParameter("classname")!=null && !request.getParameter("classname").equals("")) {
	session.setAttribute("idnn",request.getParameter("idnn"));
	session.setAttribute("classname",request.getParameter("classname"));
	}

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

/*

/// prevod pregleda
Hashtable prep = new Hashtable();
Hashtable preph = new Hashtable();
/// prevod vnosa
Hashtable prev = new Hashtable();
Hashtable prevh = new Hashtable();

/// prevod opozorila

Hashtable prerv = new Hashtable();
Hashtable prerh = new Hashtable();


/// id prevoda_ce obstaja
Hashtable previd = new Hashtable();




/// dobim vse prevode
com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
com.popultrade.model.Prevodi prevo = new com.popultrade.model.Prevodi();
prevo.setSifra_jez(session.getAttribute("jezikp")+"");
List limo = daop.getPrevodis(prevo);

Iterator itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prep.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodis(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prev.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
	previd.put(prv.getPrevod_id()+"",prv.getId()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikv")+"");
limo = daop.getPrevodisHint(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prevh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

prevo.setSifra_jez(session.getAttribute("jezikp")+"");
limo = daop.getPrevodisHint(prevo);
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	preph.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}




limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","R");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prerv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","R");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prerh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}



*/



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
//kliknivSivo(document.getElementById("sprememba"),document.getElementById("sprememba").className);
//window.scroll(1,document.getElementById("sprememba").offsetTop-15);

  <%
}
  %>


//parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>

   

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg()" >




<form name="dod" action="m_templatelist_pdf.jsp?idt=<%=request.getParameter("idt")%>&akcija=prevod" method="post">
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
	<b>
	<%=nul.jeNull(vseb.getStolpec_naziv())%></b>
	</td></tr>
		<tr><td class="valuecell" >
<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%><br>
Prevod:<input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
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
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_pogoj_pdf_framein.jsp?idg=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>&sifid=<%=request.getParameter("idt")%>&idnn=<%=request.getParameter("idnn")%>')">
	<img src="pp.gif" alt="Pogoji prikaza" border="0">
	
	
	</a>
	<br>
	

	
	</td></tr>
	
	<tr><td class="valuecell" >
	
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	 <br><a onClick="return vprasaj()" href="m_templatelist_pdf.jsp?akcija=DELETE&id=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>
	
	</td></tr>
	</table>
	</td>
	



<%
br++;

}/// while end


 %>
  <td align=center bgcolor="silver" height="55">
  

  
  <a onClick="return godown('m_templatelist_edit_pdf.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>')" href="Javascript: PGAPP()"><img title="Dodaj novi stolpec" border="0" src="vnos.gif" /></a>
  <br>
  <input type="submit" value="Shrani prevode"  style="font-family: Verdana; font-size: 8pt">
<br>
  <input type="button" value="Dodaj parametre za format izpisa" onCLick="return godown('m_templatepdfparametrilist_edit.jsp?idt=<%=request.getParameter("idt")%>')" style="font-family: Verdana; font-size: 8pt"><br>
  
  </td></tr>
</table>
</form>

<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatelist_edit_pdf.jsp?id="+asd;
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
 <a style="text-decoration:none;color:black"  href="m_templatelist_pdf.jsp?pagenumber=1<%=iskk%>">first</a></td><td>|</td>


<%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumberTemplateList")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumberTemplateList")+"");

if (prvii>1) {
int prej = prvii-1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatelist_pdf.jsp?pagenumber=<%=prej%><%=iskk%>">previous</a></td>

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
<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateList")+"").equals(ststr+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatelist_pdf.jsp?pagenumber=<%=ststr %><%=iskk%>"><%=ststr %></a> </td><td>|</td>
<%

}
}
%>

<%
}
if (vse!=0) {
	%>
	<td align=center bgcolor="<%=nul.jeNull(session.getValue("pagenumberTemplateList")+"").equals(ststr+1+"")?"white":"ededed" %>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_templatelist_pdf.jsp?pagenumber=<%=ststr+1 %><%=iskk%>"><%=ststr+1 %></a> </td><td>|</td>
	<%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%>
<td>
 <a style="text-decoration:none;color:black"  href="m_templatelist_pdf.jsp?pagenumber=<%=prej%><%=iskk%>">next</a></td>

<td>|</td>
<%
}
%>



<td><a style="text-decoration:none;color:black"  href="m_templatelist_pdf.jsp?pagenumber=<%=ststr+1%><%=iskk%>">last</a></td>
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



