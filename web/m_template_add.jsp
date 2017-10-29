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

boolean iskanje = false;


try {

	//System.out.println("--------"+request.getParameter("idgumb"));
	%>
	
	<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	<%
	
	com.popultrade.dao.TemplateHeadDAO dao = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


	com.popultrade.model.TemplateHead vseb = dao.getTemplateHead(new Long(request.getParameter("idgumb")));
	
	
if (vseb.getTemplateGumbis().size()>0) {

List li = vseb.getTemplateGumbis();

Iterator itg = li.iterator();

while (itg.hasNext()) {

com.popultrade.model.TemplateGumbi tg = (com.popultrade.model.TemplateGumbi)itg.next();

List tmpl = dao.getTemplateHeadImaGumb(tg.getId()+"");
boolean jeze = false;
boolean sogumbi = false;

com.popultrade.model.TemplateHead thh = new com.popultrade.model.TemplateHead();

if (tmpl.size()>0) {
	///dam edit
	 thh = (com.popultrade.model.TemplateHead)tmpl.get(0);

	
	jeze = true;	

if (thh.getTemplateGumbis().size()>0) {
	sogumbi=true;
}
}
%>


<tr><td colspan=4>
<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">



<tr><td width=10% bgcolor=d6d6d6>&nbsp;


<%
if (sogumbi) {
	%>
	
	<a href="#" onclick="return odpriMenu('<%=thh.getId()%>')" style="text-decoration:none"><span id="plus_<%=thh.getId()%>">+</span></a>
	
	<%
}
else {
	
	
}

%>


</td>

<td width=50% bgcolor=d6d6d6  draggable="true"  ondragover="allowDrop(event)"  ondrop="drop('TemplateGumbii','&_Ltemplatehead_id=<%=thh.getId()%>')"  ondragstart="dragStart(event,'TemplateGumbi','tem2','&id=<%=tg.getId()%>')"  >
<%=nul.jeNull(tg.getOpis_gumba())%>
</td>
<td width=20% bgcolor=d6d6d6 draggable="true"  ondragover="allowDrop(event)"  ondrop="drop('TemplateGumbii','&_Ltemplatehead_id=<%=thh.getId()%>')"  ondragstart="dragStart(event,'TemplateGumbi','tem2','&id=<%=tg.getId()%>&mmove=yes')" >
<%
if (!nul.jeNull(tg.getUrl_gumba()).equals("")) {
%>
<img src='<%=nul.jeNull(tg.getUrl_gumba())%>'>
<%
}
else if (!nul.jeN(tg.getTekst_gumb()).equals("")) {
%>
<a class="btn<%=tg.getStyle_gumb()%>"><%=tg.getTekst_gumb() %></a>
<%
}
%>
   
  
</td>
<td bgcolor=d6d6d6>
<%
/// kontrola, ce obstaja ze link do templatehead
if (nul.jeNull(tg.getKlici_funkcijo()).equals("")) {
if (jeze) {

	%>
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=thh.getId()%>&opcija=spremeni&siframm=new&idtg=<%=tg.getId()%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	
	
		 <%
	 if (thh.getHead_tip().equals("PD") || thh.getHead_tip().equals("UP") || thh.getHead_tip().equals("UR") || thh.getHead_tip().equals("SE") || thh.getHead_tip().equals("HE")) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_pdf.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
 
	<%
	 }
 	 else if (thh.getHead_tip().equals("EX") || thh.getHead_tip().equals("EE")) {
		 %>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_exp.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj exp jsp-je"></a>
		
		<%
		 }
 	 else if (thh.getHead_tip().equals("PR") || thh.getHead_tip().equals("FU") ||  thh.getHead_tip().equals("OB") ) {
 		 %>
 		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_pr.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
 		
 		<% 
 	 }
 	   else if (thh.getHead_tip().equals("LT") || thh.getHead_tip().equals("HT") ) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_to.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
	
	<% 
 }	 else if (thh.getHead_tip().equals("LI")  ) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_li.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>

	<% 
 }
		 
	 else {
		 %>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
	
		<% 
	 }
	%>
	

	<%
	
}
else {
%>
<a onClick="return godown('m_templatehead_edit.jsp?opcija=new&siframm=new&sifrant=null&idtg=<%=tg.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj nov template" border="0" src="vnos.gif" /></a>
<%	
}
}
%>

</td>



</tr>
</table>


</td></tr>
<tr><td colspan=4>

<span id="gumb_<%=thh.getId()%>"></span>
</tr>
<%
}
}

///////// opcija gumbi touch


if (!nul.jeNull(vseb.getHead_tip()).equals("") && (vseb.getHead_tip().equals("HT") || vseb.getHead_tip().equals("LT"))) {


//// dobim iz update gumbe (buttoni,tbutton)

	com.popultrade.dao.TemplateUiDAO daoui = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
com.popultrade.model.TemplateUi tru = new com.popultrade.model.TemplateUi();
tru.setTemplatehead_id(vseb.getId());

List ki = daoui.getTemplateUis(tru);

Iterator im = ki.iterator();

while (im.hasNext()) {


com.popultrade.model.TemplateUi trui = (com.popultrade.model.TemplateUi)im.next();


if (nul.jeN(trui.getTip_inserta()).equals("buttoni") || nul.jeN(trui.getTip_inserta()).equals("tbutton")) {



List tmpl = dao.getTemplateHeadImaGumb(trui.getId()+"");
boolean jeze = false;
boolean sogumbi = false;

com.popultrade.model.TemplateHead thh = new com.popultrade.model.TemplateHead();

if (tmpl.size()>0) {
	///dam edit
	 thh = (com.popultrade.model.TemplateHead)tmpl.get(0);

	
	jeze = true;	

if (thh.getTemplateGumbis().size()>0) {
	sogumbi=true;
}
}


%>





<tr><td colspan=4>
<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">



<tr><td width=10% bgcolor=d6d6d6>&nbsp;


<%
if (sogumbi) {
	%>
	
	<a href="#" onclick="return odpriMenu('<%=thh.getId()%>')" style="text-decoration:none"><span id="plus_<%=thh.getId()%>">+</span></a>
	
	<%
}
else {
	
	
}

%>


</td>

<td width=50% bgcolor=d6d6d6>
<%=nul.jeNull(trui.getStolpec_naziv())%>
</td>
<td width=20% bgcolor=d6d6d6>
<%
//if (!nul.jeNull(tg.getUrl_gumba()).equals("")) {
%>
<img src='toto.gif'>
<%
//}
%>


</td>
<td bgcolor=d6d6d6>
<%

if (jeze) {

	%>
	 <a href="Javascript:PGAPP()" onCLick="return go('<%=thh.getId()%>&opcija=spremeni&siframm=new&idtg=<%=trui.getId()%>',1)"><img src="u.gif" border=0  title="Spremeni podatke"></a>
	
	
		 <%
	 if (thh.getHead_tip().equals("PD") || thh.getHead_tip().equals("UP") || thh.getHead_tip().equals("UR") || thh.getHead_tip().equals("SE") || thh.getHead_tip().equals("HE")) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_pdf.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
 
	<%
	 }
 	 else if (thh.getHead_tip().equals("EX") || thh.getHead_tip().equals("EE")) {
		 %>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_exp.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj exp jsp-je"></a>
		
		<%
		 }
 	 else if (thh.getHead_tip().equals("PR") || thh.getHead_tip().equals("FU") || thh.getHead_tip().equals("OB") ) {
 		 %>
 		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_pr.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
 		
 		<% 
 	 }
 	   else if (thh.getHead_tip().equals("LT") || thh.getHead_tip().equals("HT") ) {
	 %>
	 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_to.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0 title="Generiraj jsp-je"></a>
	
	<% 
 }
 	  else if (thh.getHead_tip().equals("LI")  ) {
 			 %>
 			 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp_li.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
 		
 			<% 
 		 }	 
	 else {
		 %>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_generiraj_jsp.jsp?id=<%=thh.getId()%>&opcija=spremeni&siframm=new&idback=<%=thh.getId()%>&sifrant=<%=request.getParameter("sifrant")%>',1)"><img src="gen.gif" border=0  title="Generiraj jsp-je"></a>
	
		<% 
	 }
	%>
	

	<%
	
}
else {
%>
<a onClick="return godown('m_templatehead_edit.jsp?opcija=new&siframm=new&sifrant=null&idtg=<%=trui.getId()%>')" href="Javascript: PGAPP()"><img title="Dodaj nov template" border="0" src="vnos.gif" /></a>
<%	
}

%>

</td>



</tr>
</table>


</td></tr>
<tr><td colspan=4>

<span id="gumb_<%=thh.getId()%>"></span>
</tr>













<%


}






}







}




%>
</table>
<%


}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>



