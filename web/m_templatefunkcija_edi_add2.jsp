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


com.popultrade.dao.TemplateClassDAO daotc = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());

com.popultrade.dao.TemplateClassClassDAO daoc = (com.popultrade.dao.TemplateClassClassDAO)contextUtil.getBeanDao("templateClassClassDAO",pageContext.getServletContext());

com.popultrade.model.TemplateClassClass sifo = new com.popultrade.model.TemplateClassClass();


/////// dobim vrednosti


sifo.setId_veza(new Long(request.getParameter("idgumb")));



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
	
	
	<tr bgcolor="silver" >

	<td colspan=3>
	
	<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	
	<tr>
	
	<td   width="70%" ><%=nul.jeNull(tcv.getVrednost())%>
	</td>
		<td   >
		
				<%
		if (nul.jeNull(tcv.getRabi_kot()).equals("VR")) {
		%>
	<a onClick="return godown('m_templatefunkcija_pogoj_edit_edi22.jsp?idv=<%=request.getParameter("idgumb")%>&opcija=new&siframm=new&sifrant=null&idt=<%=session.getAttribute("idt")%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=tcv.getId()%>&vrednost=<%=tcv.getVrednost()%>')" href="Javascript: PGAPP()"><img title="Dodaj nov Pogoj" border="0" src="vnos.gif" /></a>	
		
		<%
		}
		%>
		
	</td>

	
	</tr>
	<tr>
	<td colspan=2><table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
	<%
	
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

		 <a href="Javascript:PGAPP()" onCLick="return godown('m_templatefunkcija_pogoj_edit_edi22.jsp?idv=<%=request.getParameter("idgumb")%>&id=<%=si.getId()%>&opcija=spremeni&siframm=new&idback=<%=request.getParameter("idgumb")%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>&sifid=<%=session.getAttribute("idt")%>&glavno=2&vrednost=<%=tcv.getVrednost()%>',1)"><img src="u.gif" border=0 title="Spremeni podatke"></a>
		
		<%
	if (si.getTemplateClassClass()!=null && si.getTemplateClassClass().getId()!=null ) {
			%>
			
			 <a href="Javascript:PGAPP()" onCLick="return godown22('m_templatelist_edi.jspQUEidt=<%=si.getTemplateClassClass().getId()%>ANDidnn=<%=request.getParameter("idgumb")%>ANDclassname=<%=si.getTemplateClassClass().getClass_name()%>')"><img src="p1.gif" border=0 title="Spremeni nacin prikaza"></a>
			
			<%
			
		}
	
		%>
		<%
		//if (nul.jeNull(vseb.getPredpona_pogoja()).equals("VALUE")) {

		%>
		 <a href="Javascript:PGAPP()" onCLick="return godown('m_templatefunkcija_class_framein_edi2.jsp?idv=<%=request.getParameter("idgumb")%>&idp=<%=si.getId()%>&opcija=spremeni&siframm=new&idback=<%=si.getId()%>&idg=<%=session.getAttribute("idg")%>&sifid=<%=session.getAttribute("idt")%>&idt=<%=session.getAttribute("idt")%>&glavno=2&vrednost=<%=tcv.getVrednost()%>')"><img src="c.gif" border=0  title="Pridobi podatek iz druge tabele"></a>
		<%
		//}
		%>
		 <a onClick="return vprasaj()" href="m_templatefunkcija_edi2.jsp?akcija=DELETE&kaj=class&id=<%=si.getId()%>&idg=<%=session.getAttribute("idg")%>&idt=<%=session.getAttribute("idt")%>"><img src="x.gif" border=0 title="Brisi"></a>



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



}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>



