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
com.popultrade.dao.TemplateUiDAO dao = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());




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
			
		//// setam prevod v memorji
			ConPool.setPrevod_admin(stru[1],stru[2],session.getAttribute("jezikv")+"",nul.jeNull(request.getParameter(str)),prevo.getId()+"");
			
		}
		
		
		
	}
	
	
	
}

if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.removeTemplateUi(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplateUi",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplateUi")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplateUi")+"");
	}
	}


com.popultrade.model.TemplateUi sif = new com.popultrade.model.TemplateUi();

System.out.println(request.getParameter("idt") + " -----------------------");
sif.setTemplatehead_id(new Long(request.getParameter("idt")));
int strec = 10;
//com.popultrade.dao.PrevodiDAO daop = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",pageContext.getServletContext());
/*

/// prevod pregleda
Hashtable prep = new Hashtable();
Hashtable preph = new Hashtable();
/// prevod vnosa
Hashtable prev = new Hashtable();
Hashtable prevh = new Hashtable();
/// prevod javascript errorja
Hashtable prejv = new Hashtable();
Hashtable prejh = new Hashtable();


/// prevod gumba shrani in reset
Hashtable presv = new Hashtable();
Hashtable presh = new Hashtable();

Hashtable prerv = new Hashtable();
Hashtable prerh = new Hashtable();
Hashtable prerx = new Hashtable();
Hashtable prervx = new Hashtable();
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





limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","J");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}

limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","J");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prejh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}









limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","S");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	presv.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","S");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	presh.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
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


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikv")+"","X");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prervx.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}


limo = daop.getPrevodisByVrsta(session.getAttribute("jezikp")+"","X");
itep = limo.iterator();

while (itep.hasNext()) {
	com.popultrade.model.Prevodi prv = (com.popultrade.model.Prevodi)itep.next();
	prerx.put(prv.getPrevod_id()+"",prv.getPrevod()+"");
}
*/

List lis =null;

lis = dao.getTemplateUis(sif);







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
document.getElementById("inframe").src="m_navodila_set.jsp?idnav="+idd;


dialog.dialog( "open" );
}

function zapriDialog() {
dialog.dialog( "close" );

}

function updateNav(idnnv,zanar) {

ert = document.getElementById("NAV_"+idnnv);
if (zanar==0) {
ert.innerHTML = 'NAVODILA';
}
else {
ert.innerHTML = "<img src='todo.gif' border=0 height=12> TODO LIST";

}

}









function chg() {


    


  <%
if (request.getParameter("idback")!=null && !request.getParameter("idback").equals("null") && !request.getParameter("idback").equals("")) {
  %>

  <%
}
  %>


parent.frames[3].location = "nic.jsp";






}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>




<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg()" >


<div id="opiss" title="Navodila">
<iframe  style="font-family: Verdana; font-size: 8pt;width:95%;height:95%" id="inframe"></iframe>
</div>

<form name="dod" action="m_templateui.jsp?idt=<%=request.getParameter("idt")%>&akcija=prevod" method="post">
<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 9pt">


<%

/// menja barvo
int br = 0;
String oe_kup_nap = "";


Iterator it = lis.iterator();

boolean prvi = false;
while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplateUi vseb = (com.popultrade.model.TemplateUi)(it.next());

		stvrstic++;

if (br==2){
  br=0;
}
if (br==0) {
	if (!prvi) {
		prvi=true;
		%><tr><%
	}
	else {
		%></tr><tr><%
	}
	
}

if (nul.jeNull(vseb.getTip_polja()).equals("NP")) {
	
	
%>


	<td   class="opiscell" width="20%">
	
	<a name="bottomm<%=vseb.getId()%>"></a>
	<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
	
	<%
	if (nul.jeNull(vseb.getKontrola_javascript()).equals("DA") || nul.jeNull(vseb.getKontrola_javascript_pravilnost()).equals("1") || nul.jeNull(vseb.getDodatna_js_kontrola_uporabi()).equals("1") ||  nul.jeNull(vseb.getKontrola_numericno()).equals("1")) {
		%><br><font color=red>Kontrola JS:</font><br>
			<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","J",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=vseb.getId()%>_J_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","J",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
		
		<%
	}
	
	//// hint pomoc
	if (nul.jeNull(vseb.getHint_pomoc()).equals("1")) {
		%><br><font color=red>Hint pomoc:</font><br>
		<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","Q",session.getAttribute("jezikp")+"")).replaceAll("\n","<br/>")%><br>
<textarea cols="35" rows="5" name="prevod_<%=vseb.getId()%>_Q_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" style="font-family: Verdana; font-size: 8pt"><%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","Q",session.getAttribute("jezikv")+""))%></textarea>
	
	<%	
	}
	
	
	List liu=null;
	Iterator imn = null;
	
	if (vseb.getSo_childi()>0) {
	 liu = vseb.getTemplateuis();
	 imn = liu.iterator();
	
	while (imn.hasNext()) {
		
		com.popultrade.model.TemplateUi vsebb = (com.popultrade.model.TemplateUi)(imn.next());
		
		
		%><br>-------------------------<br>
			<%=nul.jeNull(ConPool.getPrevod_admin(vsebb.getId()+"","P",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=vsebb.getId()%>_P_<%=nul.jeNull(ConPool.getPrevod_admin_id(vsebb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vsebb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
	
	<%
	if (nul.jeNull(vsebb.getKontrola_javascript()).equals("DA") || nul.jeNull(vsebb.getKontrola_javascript_pravilnost()).equals("1") || nul.jeNull(vsebb.getDodatna_js_kontrola_uporabi()).equals("1") ||  nul.jeNull(vseb.getKontrola_numericno()).equals("1")) {
		%><br><font color=red>Kontrola JS:</font><br>
			<%=nul.jeNull(ConPool.getPrevod_admin(vsebb.getId()+"","J",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=vsebb.getId()%>_J_<%=nul.jeNull(ConPool.getPrevod_admin_id(vsebb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vsebb.getId()+"","J",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
		
		<%
	}
		
	
		
	}
	
}
	
	
	%>
	
	
	</td>
	<td class="valuecell" width="30%" valign=top>
	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	<tr><td class="opiscell" colspan=8 >
		  <table  width=100% height=100% cellspacing=1  style="font-family: Verdana; font-size: 8pt">
  <tr><td width=50%>
	<b>
	<%=nul.jeNull(vseb.getStolpec_naziv())%></b></td>
	<%
	String navik = "NAVODILA";
	if (nul.jeNull(vseb.getNavodila_obdelana()).equals("1")) {
	navik = "<img src='todo.gif' border=0 height=12> TODO LIST";
	}
	 %>
	
	<td align=right><b><a href="#" title="Vnos navodil za izdelavo polja" onclick="odpriDialog('<%=vseb.getId()%>')" id="NAV_<%=vseb.getId() %>" style="text-decoration:none"><%=navik %></a></b></td>
	</tr></table>
	</td></tr>

	<tr><td class="valuecell" >
	<b>
	
	<%
	if (nul.jeNull(vseb.getParameter_drugo_ime()).equals("")) {
	%>
	(<%=nul.jeNull(vseb.getStolpec_metoda())%>)
	<%
	}
	else {
		%>
		(<%=nul.jeNull(vseb.getParameter_drugo_ime())%>)
		<%	
	}
	%>
	
	</b><%=nul.jeNull(vseb.getFormat_stolpca()).equals("")?"":"<br>F: "+vseb.getFormat_stolpca()%>
	</td><td class="opiscell" width=10% >
	TI:  <%=nul.jeNull(vseb.getTab_index())%>
	</td><td class="valuecell" width=10%  >
	JK: <%=nul.jeNull(vseb.getKontrola_javascript())%>
	</td><td class="opiscell" width=10%  >
	Z: <%=nul.jeNull(vseb.getZaporedje()+"")%>
	</td><td class="valuecell" width=7%  >
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_pogoj_framein.jsp?idg=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&sifid=<%=request.getParameter("idt")%>&idt=<%=request.getParameter("idt")%>')">
	
	<img src="pp.gif" alt="Pogoji prikaza vrednosti" border=0>
	
	</a>
	</td><td class="opiscell" width=7%  >
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_dd_framein.jsp?idg=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&sifid=<%=request.getParameter("idt")%>&idt=<%=request.getParameter("idt")%>')">
	<img src="dd.gif" alt="DropDown izbira" border=0>
	</a>
	

	
	</td>
	
	

	
	
		<td class="opiscell" width=10% >
	
	<%
	if (nul.jeNull(vseb.getTip_inserta()).equals("dropbox")) {
	%>
		<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_class_framein_hint.jsp?idp=<%=vseb.getId()%>&predpona=LIST&opcija=spremeni&siframm=new&idback=66&idg=52&sifid=49&idt=49&glavno=1')">
	<img src="db.gif" alt="DropDown izbira SELECTBOX" border=0>
	</a>
	<%
	}
	%>
		<%
	
	if (nul.jeNull(vseb.getUporabi_ajax_kontrolo()).equals("1")) {
	%>
<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_dd_framein.jsp?idg=<%=vseb.getId()%>&kontrola=A&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&sifid=<%=request.getParameter("idt")%>&idt=<%=request.getParameter("idt")%>')">
	<img src="ak.gif" alt="Ajax kontrola vkljucena v JS" border=0>
	</a>
	
	<%
	}
	%>
	</td>
	
	<td class="opiscell" width=10% >
	
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>&idn=<%=request.getParameter("idn")%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	<a onClick="return vprasaj()" href="m_templateui.jsp?akcija=DELETE&id=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>&idn=<%=request.getParameter("idn")%>"><img src="x.gif" border=0 title="Brisi"></a>
	
	</td></tr>

	
<%

if (vseb.getSo_childi()>0) {
 imn = liu.iterator();

while (imn.hasNext()) {
	
	com.popultrade.model.TemplateUi vsebb = (com.popultrade.model.TemplateUi)(imn.next());
%>

	<tr><td class="opiscell" colspan=8 >
	<b>
	<%=nul.jeNull(vsebb.getStolpec_naziv())%></b>
	</td></tr>

	<tr><td class="opiscell" >
	<b>
		<%
	if (nul.jeNull(vsebb.getParameter_drugo_ime()).equals("")) {
	%>
	(<%=nul.jeNull(vsebb.getStolpec_metoda())%>)
	<%
	}
	else {
		%>
		(<%=nul.jeNull(vsebb.getParameter_drugo_ime())%>)
		<%	
	}
	%>
	
	
	
	</b><%=nul.jeNull(vsebb.getFormat_stolpca()).equals("")?"":"<br>F: "+vsebb.getFormat_stolpca()%>
	</td><td class="valuecell" >
	TI:  <%=nul.jeNull(vsebb.getTab_index())%>
	</td><td class="opiscell" >
	JSK: <%=nul.jeNull(vsebb.getKontrola_javascript())%>
	</td><td class="valuecell" >
	Z: <%=nul.jeNull(vsebb.getZaporedje()+"")%>
	</td><td class="opiscell" >
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_pogoj_framein.jsp?idg=<%=vsebb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vsebb.getId()%>&sifid=<%=request.getParameter("idt")%>&idt=<%=request.getParameter("idt")%>')">
	
	<img src="pp.gif" alt="Pogoji prikaza vrednosti" border=0>
	
	</a>
	</td><td class="valuecell" >
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_dd_framein.jsp?idg=<%=vsebb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vsebb.getId()%>&sifid=<%=request.getParameter("idt")%>&idt=<%=request.getParameter("idt")%>')">
	<img src="dd.gif" alt="AJAX izbira" border=0>
	
	
	</a>
	</td>  
	<td class="opiscell" >
	
	<%
	if (nul.jeNull(vsebb.getTip_inserta()).equals("dropbox")) {
	%>
		<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_class_framein_hint.jsp?idp=<%=vsebb.getId()%>&predpona=LIST&opcija=spremeni&siframm=new&idback=66&idg=52&sifid=49&idt=49&glavno=1')">
	<img src="db.gif" alt="DropDown izbira SELECTBOX" border=0>
	</a>
	<%
	}
	%>
			<%
	
	if (nul.jeNull(vsebb.getUporabi_ajax_kontrolo()).equals("1")) {
	%>
<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_dd_framein.jsp?idg=<%=vsebb.getId()%>&kontrola=A&opcija=spremeni&siframm=new&idtf=<%=vsebb.getId()%>&sifid=<%=request.getParameter("idt")%>&idt=<%=request.getParameter("idt")%>')">
	<img src="ak.gif" alt="Ajax kontrola vkljucena v JS" border=0>
	</a>
	
	<%
	}
	%>
	</td>
	
	
	<td class="opiscell" >
	
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=vsebb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vsebb.getId()%>&idt=<%=request.getParameter("idt")%>&idn=<%=request.getParameter("idn")%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	<a onClick="return vprasaj()" href="m_templateui.jsp?akcija=DELETE&id=<%=vsebb.getId()%>&idt=<%=request.getParameter("idt")%>&idn=<%=request.getParameter("idn")%>"><img src="x.gif" border=0 title="Brisi"></a>
	
	</td></tr>

	

	
<%	
}
}
%>
	<tr><td colspan=7 ><a onClick="return godown('m_templateui_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>&idn=<%=vseb.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj v isto polje" border="0" src="next.gif" /></a></td></tr>
	</table>
	
	
	</td>

<% 





}
else {
	%>
		<td   class="valuecell" width="20%">
<a name="bottomm<%=vseb.getId()%>"></a>
	<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull(ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">

	</td>
	<td class="valuecell" width="30%">
	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
<tr>
	<td class="opiscell" >
	Z: <%=nul.jeNull(vseb.getZaporedje()+"")%>
	</td><td class="valuecell" >
	
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>&idn=<%=request.getParameter("idn")%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	 <br><a onClick="return vprasaj()" href="m_templateui.jsp?akcija=DELETE&id=<%=vseb.getId()%>&idt=<%=request.getParameter("idt")%>&idn=<%=request.getParameter("idn")%>"><img src="x.gif" border=0 title="Brisi"></a>
	
	</td></tr>
	</table>
	
	 
	</td>
	<%
}
%>


<%
br++;

}/// while end

if (br==0 || br==2) {
	
	if (br==2) {
 %>
 </tr><tr>
 <%
	}
	else {
		 %>
		<tr>
		 <%
		
	}
 %>
            		  
<td class="opiscell" width="20%">&nbsp;</td><td class="valuecell" width="30%">
	<a onClick="return godown('m_templateui_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>')" href="Javascript: PGAPP()"><img title="Dodaj novo polje" border="0" src="vnos.gif" /></a> &nbsp;

<td class="opiscell" width="20%">&nbsp;</td><td class="valuecell" width="30%">

&nbsp;</td>
<%
if (br==0) {
%>
</tr>
 
 <%
}
}
else if (br==1) {
	
	%>
	<td class="opiscell" width="20%">&nbsp;</td><td class="valuecell" width="30%">
	<a onClick="return godown('m_templateui_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>')" href="Javascript: PGAPP()"><img title="Dodaj novo polje" border="0" src="vnos.gif" /></a> &nbsp;

</tr>
	
	<%
}
 
//// osnovni prevodi
if (lis.size()>0) {
	%>
	 <tr><td colspan=4 align=center bgcolor=silver >
	 
	 
	 	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	<tr><td>
 
	 	<%=nul.jeNull(ConPool.getPrevod_admin(nul.jeNull((String)request.getParameter("idt")+""),"S",session.getAttribute("jezikp")+""))%>
<input type="text" name="prevod_<%=request.getParameter("idt")%>_S_<%=nul.jeNull(ConPool.getPrevod_admin_id(nul.jeNull((String)request.getParameter("idt")+"")))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(nul.jeNull((String)request.getParameter("idt")+""),"S",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">(reset)
</td><td>
	 	<%=nul.jeNull(ConPool.getPrevod_admin(nul.jeNull((String)request.getParameter("idt")+""),"R",session.getAttribute("jezikp")+""))%>
<input type="text" name="prevod_<%=request.getParameter("idt")%>_R_<%=nul.jeNull(ConPool.getPrevod_admin_id(nul.jeNull((String)request.getParameter("idt")+"")))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(nul.jeNull((String)request.getParameter("idt")+""),"R",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">(potrdi)

</td>

<td>Odgovor ob uspesnem insertu ali update:<br>
	 	<%=nul.jeNull(ConPool.getPrevod_admin(nul.jeNull((String)request.getParameter("idt")+""),"X",session.getAttribute("jezikp")+""))%>
<input type="text" name="prevod_<%=request.getParameter("idt")%>_X_<%=nul.jeNull(ConPool.getPrevod_admin_id(nul.jeNull((String)request.getParameter("idt")+"")))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(nul.jeNull((String)request.getParameter("idt")+""),"X",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">(potrdi)

</td>

</tr>	 
	 </table>
	 </td></tr>
	<%
	
}


 %>
 <tr><td colspan=4 align=center bgcolor=silver height=32>

  
  <input type="button" value="Dodatni pogoji"  style="font-family: Verdana; font-size: 8pt" onClick="return godown('m_templateuidodatno_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=request.getParameter("idt")%>')">
  <input type="submit" value="Shrani prevode"  style="font-family: Verdana; font-size: 8pt">
  </td></tr>
</table>
</form>

<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templateui_edit.jsp?id="+asd;
    parent.frames[3].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[3].location = asd + "&sid="+Math.random();
return false;
}
function PGAPP(){
}

</script>

<a name="bottomm"></a>
</body></html>
 <%
if (request.getRequestURI()!=null ) {
System.out.println(request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1,request.getRequestURI().length())+"?"+ request.getQueryString());

if (request.getQueryString().indexOf("#")==-1 && request.getQueryString().indexOf("DELETE")==-1) {
	session.setAttribute("retuu",request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1,request.getRequestURI().length())+"?"+ request.getQueryString());
}
}
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}


%>



