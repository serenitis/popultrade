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
com.popultrade.dao.TemplatePPDAO dao = (com.popultrade.dao.TemplatePPDAO)contextUtil.getBeanDao("templatePPDAO",pageContext.getServletContext());

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
	

	dao.removeTemplatePP(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberTemplatePP",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberTemplatePP")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberTemplatePP")+"");
	}
	}


com.popultrade.model.TemplatePP sif = new com.popultrade.model.TemplatePP();
sif.setTemplatehead_id(new Long(session.getAttribute("idt")+""));
int strec = 10;

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



*/

List lis =null;

lis = dao.getTemplatePPs(sif);







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

  <%
}
  %>

parent.frames[1].location = "nic.jsp";
top.parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>

   

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg()" >




<form name="dod" action="m_templatepp.jsp?idt=<%=session.getAttribute("idt")+""%>&akcija=prevod" method="post">
<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 9pt">

<tr>


	<td   class="opiscell" colspan=2>&nbsp;
	</td></tr>
<%

/// menja barvo
int br = 0;
String oe_kup_nap = "";


Iterator it = lis.iterator();

boolean prvi = false;
while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplatePP vseb = (com.popultrade.model.TemplatePP)(it.next());

		stvrstic++;

if (br==2){
  br=0;
}

%><tr>


	<td   class="opiscell" width="20%">
	
	
	<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=vseb.getId()%>_P_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","P",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
	
	<%
	if (nul.jeNull(vseb.getKontrola_javascript()).equals("DA")) {
		%><br><font color=red>Kontrola JS:</font><br>
			<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","J",session.getAttribute("jezikp")+""))%><br>
<input type="text" name="prevod_<%=vseb.getId()%>_J_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(vseb.getId()+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(vseb.getId()+"","J",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">
		
		<%
	}
	
	
	

	
	
	
	
	%>
	
	
	</td>
	<td class="valuecell" width="30%" valign=top>
	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >


	<tr><td class="opiscell" >
	<b>
	<%=nul.jeNull(vseb.getStolpec_metoda())%></b>
	</td><td class="valuecell" >
	TI:  <%=nul.jeNull(vseb.getTab_index())%>
	</td><td class="valuecell" >
	Z: <%=nul.jeNull(vseb.getZaporedje()+"")%>
	</td><td class="opiscell" >
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_pogoj_framein.jsp?idg=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&sifid=<%=session.getAttribute("idt")+""%>&idt=<%=session.getAttribute("idt")+""%>')">
	
	<img src="pp.gif" alt="Pogoji prikaza vrednosti" border=0>
	
	</a>
	</td><td class="valuecell" >
	<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_dd_framein.jsp?idg=<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&sifid=<%=session.getAttribute("idt")+""%>&idt=<%=session.getAttribute("idt")+""%>')">
	<img src="dd.gif" alt="DropDown izbira" border=0>
	
	
	</a>
	</td>
	
	

	
	
		<td class="opiscell" >
	
	<%
	if (nul.jeNull(vseb.getTip_inserta()).equals("dropbox")) {
	%>
		<a href="Javascript:PGAPP()" onCLick="return godown('m_templateclass_class_framein_hint.jsp?idp=<%=vseb.getId()%>&predpona=LIST&opcija=spremeni&siframm=new&idback=66&idg=52&sifid=49&idt=49&glavno=1')">
	<img src="db.gif" alt="DropDown izbira SELECTBOX" border=0>
	</a>
	<%
	}
	%>
	
	</td>
	
	<td class="opiscell" >
	
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=vseb.getId()%>&opcija=spremeni&siframm=new&idtf=<%=vseb.getId()%>&idt=<%=session.getAttribute("idt")+""%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	<a onClick="return vprasaj()" href="m_templatepp.jsp?akcija=DELETE&id=<%=vseb.getId()%>&idt=<%=session.getAttribute("idt")+""%>"><img src="x.gif" border=0 title="Brisi"></a>
	
	</td></tr>


	</table>
	</td>
 </tr>
<%






%>


<%
br++;

}/// while end


 %>


 
 <%

	
	%><tr>
	<td class="opiscell" colspan=2>
	<a onClick="return godown('m_templatepp_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=session.getAttribute("idt")+""%>')" href="Javascript: PGAPP()"><img title="Dodaj novo polje" border="0" src="vnos.gif" /></a> &nbsp;
</td>
</tr>
	
	<%

 
//// osnovni prevodi
if (lis.size()>0) {
	%>
	 <tr><td colspan=2 align=center bgcolor=silver >
	 
	 
	 	<table  cellspacing="1" cellpadding="2" style=" font-family:Verdana; font-size:8pt"  width="100%"  >
	<tr><td>
 
</td><td>
	 	<%=nul.jeNull(ConPool.getPrevod_admin(session.getAttribute("idt")+"","R",session.getAttribute("jezikp")+""))%>
<input type="text" name="prevod_<%=session.getAttribute("idt")+""%>_R_<%=nul.jeNull((String)ConPool.getPrevod_admin_id(session.getAttribute("idt")+""+""))%>" value="<%=nul.jeNull(ConPool.getPrevod_admin(session.getAttribute("idt")+"","R",session.getAttribute("jezikv")+""))%>" style="font-family: Verdana; font-size: 8pt">(potrdi)

</td></tr>	 
	 </table>
	 </td></tr>
	<%
	
}


 %>
 <tr><td colspan=2 align=center bgcolor=silver height=32>
 
  (dodatni pogoji samo za pdf,funkcije in procedure)
  <input type="button" value="Dodatni pogoji"  style="font-family: Verdana; font-size: 8pt" onClick="return godown('m_templateuidodatno_edit.jsp?opcija=new&siframm=new&sifrant=null&idt=<%=session.getAttribute("idt")+""%>')">
  <input type="submit" value="Shrani prevode"  style="font-family: Verdana; font-size: 8pt">
  </td></tr>
</table>
</form>

<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_templatepp_edit.jsp?id="+asd;
    top.parent.frames[3].location = aaa;
  }

return false;
}
function godown(asd){
top.parent.frames[3].location = asd;
return false;
}
function PGAPP(){
}

</script>


</body></html>
 <%

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>



