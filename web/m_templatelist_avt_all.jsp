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


try {
	
	
	
	if (request.getParameter("avtomatika")!=null && request.getParameter("avtomatika").equals("yes"))  {

com.popultrade.dao.TemplateHeadDAO daohe = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());

com.popultrade.model.TemplateHead head = daohe.getTemplateHead(new Long(request.getParameter("idt")));



com.popultrade.dao.TemplateListDAO dao2 = (com.popultrade.dao.TemplateListDAO)contextUtil.getBeanDao("templateListDAO",pageContext.getServletContext());
Enumeration eno = request.getParameterNames();
com.popultrade.model.TemplateList sif = new com.popultrade.model.TemplateList();


boolean jeup=false;
boolean jehe=false;
boolean jese=false;
boolean jeli=false;

while (eno.hasMoreElements()) {
String name = (String)eno.nextElement();
if (name.startsWith("ID_")) {
///zapisem v bazo elemente
String imo = request.getParameter(name);
sif = new com.popultrade.model.TemplateList();
sif.setZaporedje(Integer.parseInt(request.getParameter("SI_"+imo)));
sif.setStolpec_metoda(imo.replace("Y_Y",".").replace("X_X","()"));
sif.setStolpec_align("left");
sif.setStolpec_primaren("1");
sif.setStolpec_width("10%");
sif.setStolpec_naziv(imo.substring(3).replace("Y_Y",".").replace("X_X","()"));
sif.setTemplatehead_id(new Long(request.getParameter("idt")));
dao2.saveTemplateList(sif);

jeli = true;
}
else if (name.indexOf("IDUP_")!=-1 && !jeup) {
	jeup = true;
}
else if (name.indexOf("IDHE_")!=-1 && !jehe) {
	jehe = true;
}
else if (name.indexOf("IDSE_")!=-1 && !jese) {
	jese = true;
}
}






System.out.println("======================================================="+jeup);
int zaporedjee=5;
/// dodam update z gumbi
if (jeup) {
	
	/// ce ni gumba dodam
	com.popultrade.model.TemplateHead heade = new com.popultrade.model.TemplateHead();

	if (!nul.jeN(request.getParameter("jeup")).equals("yes")) {
		System.out.println("XXXXXXXXXXXXXXXXCCCCCCCCCCCCCCXXXXXXXXXXXXXXXXXXssssssssssXXX "+jeup);
		com.popultrade.model.TemplateGumbi vsebg =new com.popultrade.model.TemplateGumbi();
		com.popultrade.dao.TemplateGumbiDAO daog = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());
		vsebg.setTemplatehead_id(new Long(request.getParameter("idt")));
		vsebg.setTarget_gumba(request.getParameter("target_gumba"));
		vsebg.setLokacija_gumba("V");
		vsebg.setOpis_gumba("Update/insert dokument");
		vsebg.setTekst_gumb("U");
		vsebg.setTekst_gumb_p("U");
		vsebg.setStyle_gumb("blueb");
		vsebg.setStyle_gumb_p("blueb");
		vsebg.setZaporedje(zaporedjee);
		zaporedjee++;
		daog.saveTemplateGumbi(vsebg); /// save U gumba
		
		
		/// dodam id vrednost preko gumba
		com.popultrade.model.TemplateGumbiParametri vsebv =new com.popultrade.model.TemplateGumbiParametri();
		com.popultrade.dao.TemplateGumbiParametriDAO daov = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
		vsebv.setTemplategumb_id(vsebg.getId());
		vsebv.setStolpec_metoda("getId");
		daov.saveTemplateGumbiParametri(vsebv);
		
		
		com.popultrade.model.TemplateGumbi vsebgg =new com.popultrade.model.TemplateGumbi();
		vsebgg.setTemplatehead_id(new Long(request.getParameter("idt")));
		vsebgg.setTarget_gumba(request.getParameter("target_gumba"));
		vsebgg.setLokacija_gumba("H");
		vsebgg.setOpis_gumba("Dodaj dokument");
		vsebgg.setTekst_gumb("ADD");
		vsebgg.setTekst_gumb_p("ADD");
		vsebgg.setStyle_gumb("blueb");
		vsebgg.setStyle_gumb_p("blueb");
		vsebgg.setKlici_funkcijo("Add");
		vsebgg.setZaporedje(zaporedjee);
		zaporedjee++;
		daog.saveTemplateGumbi(vsebgg); /// save ADD gumba
		
		
		//// dodam head
		//zaporedjee=5;
		com.popultrade.dao.TemplateHeadDAO daohee = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
		
		heade.setVeza_gumb(vsebg.getId());
		heade.setHead_class_name(head.getHead_class_name());
		heade.setHead_naziv("Update "+head.getHead_class_name());
		heade.setHead_tip("UI");
		heade.setZaporedje(5);
		//zaporedjee++;
		
		int trx=0;
		try {
		 trx =Integer.parseInt(request.getParameter("target_gumba"));
		 if (trx==0) {
		 }
		 else {
			 trx =trx-1;
		 }
		}
		catch (Exception em) {
			System.out.println("Napaka setiranja target funkcije "+em.toString());
		}
		
		heade.setTarget_funkcija("parent.frames["+trx+"].location");
		heade.setZakleni_record("request.getParameter('id')");

		daohee.saveTemplateHead(heade);
		
		
		/// pogoj prikaza
		com.popultrade.model.TemplateClass vsebc =new com.popultrade.model.TemplateClass();
		com.popultrade.dao.TemplateClassDAO daoc = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());
		
		
		vsebc.setTemplatehead_id(heade.getId());
		vsebc.setIme_pogoja("setId");
		vsebc.setVrednost_pogoja("request.getParameter('id')");
		daoc.saveTemplateClass(vsebc);
		
		
		
		
		//// dodam polja
	}
	else {
		
		com.popultrade.dao.TemplateHeadDAO daohee = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
		 heade = daohee.getTemplateHead(new Long(request.getParameter("jeupid")));

		
	}
		
com.popultrade.dao.TemplateUiDAO dao22 = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
eno = request.getParameterNames();
com.popultrade.model.TemplateUi sifo = new com.popultrade.model.TemplateUi();
while (eno.hasMoreElements()) {
String name = (String)eno.nextElement();
if (name.indexOf("IDUP_")!=-1) {
///zapisem v bazo elemente
String imo = request.getParameter(name);
sifo = new com.popultrade.model.TemplateUi();
sifo.setZaporedje(Integer.parseInt(request.getParameter("SIUP_"+imo)));
sifo.setStolpec_metoda(imo.replace("Y_Y",".").replace("X_X","()"));
sifo.setStolpec_align("left");
sifo.setTip_polja("NP");
sifo.setStolpec_naziv(imo.substring(3).replace("Y_Y",".").replace("X_X","()"));
sifo.setTab_index(request.getParameter("SIUP_"+imo));
sifo.setVnos_kdaj("BO");
sifo.setTip_inserta("textbox");


String dolz = request.getParameter("X"+name.replace("IDUP_", "ID_"));
System.out.println("DOLZ ::: "+dolz);
if (dolz!=null && !dolz.trim().equals("")) {

	sifo.setStolpec_max_stevilo_znakov(dolz);
	
	if (Integer.parseInt(dolz)>70) {
	sifo.setStolpec_sirina("70");
	}
	else {
		sifo.setStolpec_sirina(""+(Integer.parseInt(dolz)+1));
	}
}




sifo.setTemplatehead_id(heade.getId());
dao22.saveTemplateUi(sifo);
}
}
		
}
/// dodam update z gumbi end 




/// dodam search z gumbi
if (jese) {
	
	/// ce ni gumba dodam
	com.popultrade.model.TemplateHead heade = new com.popultrade.model.TemplateHead();

	if (!nul.jeN(request.getParameter("jese")).equals("yes")) {
		System.out.println("XXXXXXXXXXXXXXXXCCCCCCCCCCCCCCXXXXXXXXXXXXXXXXXXssssssssssXXX "+jese);
		com.popultrade.model.TemplateGumbi vsebg =new com.popultrade.model.TemplateGumbi();
		com.popultrade.dao.TemplateGumbiDAO daog = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());
		vsebg.setTemplatehead_id(new Long(request.getParameter("idt")));
		vsebg.setTarget_gumba(request.getParameter("target_gumba"));
		vsebg.setLokacija_gumba("H");
		vsebg.setOpis_gumba("Isci dokument");
		vsebg.setTekst_gumb("SEARCH");
		vsebg.setTekst_gumb_p("SEARCH");
		vsebg.setStyle_gumb("silverb");
		vsebg.setStyle_gumb_p("silverb");
		vsebg.setZaporedje(zaporedjee);
		zaporedjee++;
		daog.saveTemplateGumbi(vsebg); /// save U gumba
		

		//// dodam head
		//zaporedjee=5;
		com.popultrade.dao.TemplateHeadDAO daohee = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
		
		heade.setVeza_gumb(vsebg.getId());
		heade.setHead_class_name(head.getHead_class_name());
		heade.setHead_naziv("Update "+head.getHead_class_name());
		heade.setHead_tip("SE");
		heade.setZaporedje(5);
		//zaporedjee++;
		
		int trx=0;
		try {
		 trx =Integer.parseInt(request.getParameter("target_gumba"));
		 if (trx==0) { 
		 }
		 else {
			 trx =trx-1;
		 }
		}
		catch (Exception em) {
			System.out.println("Napaka setiranja target funkcije "+em.toString());
		}
		
		heade.setTarget_isci("parent.frames["+trx+"].location");
		//heade.setZakleni_record("request.getParameter('id')");

		daohee.saveTemplateHead(heade);
		
		//// dodam polja
	}
	else {
		
		com.popultrade.dao.TemplateHeadDAO daohee = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
		 heade = daohee.getTemplateHead(new Long(request.getParameter("jeseid")));

		
	}
		
com.popultrade.dao.TemplateUiDAO dao22 = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
eno = request.getParameterNames();
com.popultrade.model.TemplateUi sifo = new com.popultrade.model.TemplateUi();
while (eno.hasMoreElements()) {
String name = (String)eno.nextElement();
if (name.indexOf("IDSE_")!=-1) {
///zapisem v bazo elemente
String imo = request.getParameter(name);
sifo = new com.popultrade.model.TemplateUi();
sifo.setZaporedje(Integer.parseInt(request.getParameter("SISE_"+imo)));
sifo.setStolpec_metoda(imo.replace("Y_Y",".").replace("X_X","()"));
sifo.setStolpec_align("left");
sifo.setTip_polja("NP");
sifo.setStolpec_naziv(imo.substring(3).replace("Y_Y",".").replace("X_X","()"));
sifo.setTab_index(request.getParameter("SISE_"+imo));
sifo.setVnos_kdaj("BO");
sifo.setTip_inserta("textbox");


String dolz = request.getParameter("X"+name.replace("IDSE_", "ID_"));
System.out.println("DOLZ ::: "+dolz);
if (dolz!=null && !dolz.trim().equals("")) {

	sifo.setStolpec_max_stevilo_znakov(dolz);
	
	if (Integer.parseInt(dolz)>70) {
	sifo.setStolpec_sirina("70");
	}
	else {
		sifo.setStolpec_sirina(""+(Integer.parseInt(dolz)+1));
	}
}




sifo.setTemplatehead_id(heade.getId());

dao22.saveTemplateUi(sifo);
}
}
		
}
/// dodam search z gumbi end 




/// dodam head z gumbi
if (jehe) {
	
	/// ce ni gumba dodam
	com.popultrade.model.TemplateHead heade = new com.popultrade.model.TemplateHead();

	if (!nul.jeN(request.getParameter("jehe")).equals("yes")) {
		System.out.println("XXXXXXXXXXXXXXXXCCCCCCCCCCCCCCXXXXXXXXXXXXXXXXXXssssssssssXXX "+jehe);
		com.popultrade.model.TemplateGumbi vsebg =new com.popultrade.model.TemplateGumbi();
		com.popultrade.dao.TemplateGumbiDAO daog = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());
		vsebg.setTemplatehead_id(new Long(request.getParameter("idt")));
		vsebg.setTarget_gumba(request.getParameter("target_gumba"));
		vsebg.setLokacija_gumba("V");
		vsebg.setOpis_gumba("Pregled dokumenta");
		vsebg.setTekst_gumb("H");
		vsebg.setTekst_gumb_p("H");
		vsebg.setStyle_gumb("silverb");
		vsebg.setStyle_gumb_p("silverb");
		vsebg.setZaporedje(zaporedjee);
		zaporedjee++;
		daog.saveTemplateGumbi(vsebg); /// save U gumba
		
		com.popultrade.model.TemplateGumbiParametri vsebv =new com.popultrade.model.TemplateGumbiParametri();
		com.popultrade.dao.TemplateGumbiParametriDAO daov = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
		vsebv.setTemplategumb_id(vsebg.getId());
		vsebv.setStolpec_metoda("getId");
		daov.saveTemplateGumbiParametri(vsebv);
		//// dodam head
		//zaporedjee=5;
		com.popultrade.dao.TemplateHeadDAO daohee = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
		
		heade.setVeza_gumb(vsebg.getId());
		heade.setHead_class_name(head.getHead_class_name());
		heade.setHead_naziv("Pregled "+head.getHead_class_name());
		heade.setHead_tip("HE");
		heade.setZaporedje(5);


		daohee.saveTemplateHead(heade);
		
		
		/// pogoj prikaza
		com.popultrade.model.TemplateClass vsebc =new com.popultrade.model.TemplateClass();
		com.popultrade.dao.TemplateClassDAO daoc = (com.popultrade.dao.TemplateClassDAO)contextUtil.getBeanDao("templateClassDAO",pageContext.getServletContext());
		
		
		vsebc.setTemplatehead_id(heade.getId());
		vsebc.setIme_pogoja("setId");
		vsebc.setVrednost_pogoja("request.getParameter('id')");
		daoc.saveTemplateClass(vsebc);
		
		//// dodam polja
	}
	else {
		
		com.popultrade.dao.TemplateHeadDAO daohee = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());
		 heade = daohee.getTemplateHead(new Long(request.getParameter("jeheid")));

		
	}
		
	com.popultrade.dao.TemplateViewDAO dao22 = (com.popultrade.dao.TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO",pageContext.getServletContext());

	eno = request.getParameterNames();

	com.popultrade.model.TemplateView sif2 = new com.popultrade.model.TemplateView();
	while (eno.hasMoreElements()) {

	String name = (String)eno.nextElement();
	if (name.indexOf("IDHE_")!=-1) {
	///zapisem v bazo elemente
	String imo = request.getParameter(name);
	sif2 = new com.popultrade.model.TemplateView();
	sif2.setZaporedje(Integer.parseInt(request.getParameter("SIHE_"+imo)));
	sif2.setStolpec_metoda(imo.replace("Y_Y",".").replace("X_X","()"));
	sif2.setStolpec_align("left");
	
	sif2.setTip_polja("NP");
	sif2.setStolpec_naziv(imo.substring(3).replace("Y_Y",".").replace("X_X","()"));
	sif2.setTemplatehead_id(heade.getId());
	dao22.saveTemplateView(sif2);
	}

}
		
}



/// dodam gumb za brisanje
if (jeli) {
	
	
	com.popultrade.dao.TemplateGumbiDAO daog = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());
	
		com.popultrade.model.TemplateGumbi vsebgg =new com.popultrade.model.TemplateGumbi();
		vsebgg.setTemplatehead_id(new Long(request.getParameter("idt")));
		
		
		int trx=0;
		try {
		 trx =Integer.parseInt(request.getParameter("target_gumba"));
		 if (trx==0) {
		 }
		 else {
			 trx =trx-1;
		 }
		}
		catch (Exception em) {
			System.out.println("Napaka setiranja target funkcije "+em.toString());
		}
		
		vsebgg.setTarget_gumba(""+trx+"");
		vsebgg.setLokacija_gumba("V");
		vsebgg.setOpis_gumba("Brisi dokument");
		vsebgg.setTekst_gumb("X");
		vsebgg.setTekst_gumb_p("X");
		vsebgg.setStyle_gumb("redb");
		vsebgg.setStyle_gumb_p("redb");
		vsebgg.setKlici_funkcijo("Brisi");
		vsebgg.setZaporedje(zaporedjee+50);
		vsebgg.setUporabi_alert("1");
		zaporedjee++;
		daog.saveTemplateGumbi(vsebgg); /// save ADD gumba
		
		
		
		com.popultrade.model.TemplateGumbiParametri vsebv =new com.popultrade.model.TemplateGumbiParametri();
		com.popultrade.dao.TemplateGumbiParametriDAO daov = (com.popultrade.dao.TemplateGumbiParametriDAO)contextUtil.getBeanDao("templateGumbiParametriDAO",pageContext.getServletContext());
		vsebv.setTemplategumb_id(vsebgg.getId());
		vsebv.setStolpec_metoda("getId");
		daov.saveTemplateGumbiParametri(vsebv);
		
		
		
}




/// dodam head z gumbi end 
%>

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">PODATKI VNESENI/SPREMENJENI</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>

<script language=javascript>


  document.location = "m_templatelist.jsp?idt=<%=request.getParameter("idt")%>";


</script>

<%


}
	
	else {
	
	/// dolocim, ce je gumb ze bil narejen avtomaticno
		boolean jeupg=false;
		boolean jeheg=false;
		boolean jeseg=false;
		String targett = ""; /// target vseh gumbov
		
		String jeupgid="";
		String jehegid="";
		String jesegid="";
		
		
// get list from daoobject
com.popultrade.dao.TemplateListDAO dao = (com.popultrade.dao.TemplateListDAO)contextUtil.getBeanDao("templateListDAO",pageContext.getServletContext());
com.popultrade.model.TemplateList sif = new com.popultrade.model.TemplateList();
sif.setTemplatehead_id(new Long(request.getParameter("idt")));


List lis =null;

lis = dao.getTemplateLists(sif);


Iterator it = lis.iterator();
Hashtable obstaja= new Hashtable();
boolean prvi = false;
int zaporedje = 5;
int zaporedjex = 5;
int zaporedjese = 5;
int zaporedjehe = 5;

while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplateList vseb = (com.popultrade.model.TemplateList)(it.next());
	
	if (vseb.getStolpec_metoda()!=null && vseb.getZaporedje()!=null ){
	obstaja.put(vseb.getStolpec_metoda().replace(".","Y_Y").replace("()","X_X"),vseb.getZaporedje()+"");
	
	if (vseb.getZaporedje()>zaporedje) {
	zaporedje = vseb.getZaporedje();
	}
	}
	}


//////// dobim veze na gumbe

com.popultrade.dao.TemplateGumbiDAO daogu = (com.popultrade.dao.TemplateGumbiDAO)contextUtil.getBeanDao("templateGumbiDAO",pageContext.getServletContext());
com.popultrade.dao.TemplateHeadDAO daohe = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


com.popultrade.model.TemplateGumbi sifgu = new com.popultrade.model.TemplateGumbi();

sifgu.setTemplatehead_id(new Long(request.getParameter("idt")));


List ligu = daogu.getTemplateGumbis(sifgu,1, 50, "", "zaporedje", "");


Hashtable obstajaup= new Hashtable(); /// update
Hashtable obstajase= new Hashtable(); /// search
Hashtable obstajahe= new Hashtable(); /// head


Iterator ite = ligu.iterator();

while (ite.hasNext()) {
	
	
com.popultrade.model.TemplateGumbi sim = (com.popultrade.model.TemplateGumbi)ite.next();
	/// dobim glavo
	if (sim.getId()!=null) {
		
		//// 
		
		
		
		com.popultrade.model.TemplateHead head =new com.popultrade.model.TemplateHead();
		
		head.setVeza_gumb(sim.getId());
		
		List lish = daohe.getTemplateHeads(head, 1, 1, "", "","");
		
		if (lish.size()>0) {
		
			head = (com.popultrade.model.TemplateHead)lish.get(0);
			
		System.out.println("NASEL XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "+head.getHead_tip());
		
		/// ce je head update 
		if (nul.jeN(head.getHead_tip()).equals("UI") && obstajaup.size()==0) {
		System.out.println("NASEL UIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
		
		if (!nul.jeN(sim.getTarget_gumba()).equals("") && targett.equals("")) {
			targett = sim.getTarget_gumba();
			
		}
		
		
		jeupg=true;
		
		jeupgid = head.getId()+"";
		
		com.popultrade.dao.TemplateUiDAO daox = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
		com.popultrade.model.TemplateUi sifx = new com.popultrade.model.TemplateUi();
		sifx.setTemplatehead_id(head.getId());


		List lisx =null;
		lisx = daox.getTemplateUis(sifx);
		Iterator itx = lisx.iterator();
		boolean prvix = false;
		
		while (itx.hasNext()){  // while start
			
			com.popultrade.model.TemplateUi vsebx = (com.popultrade.model.TemplateUi)(itx.next());
			if (vsebx.getStolpec_metoda()!=null && vsebx.getZaporedje()!=null ){
			obstajaup.put(vsebx.getStolpec_metoda(),vsebx.getZaporedje()+"");
			if (vsebx.getZaporedje()>zaporedjex) {
			zaporedjex = vsebx.getZaporedje();
			}
			}
			
		}
		
		}
		/// end ce je head update 
		
		
		
		
		
			/// ce je head head 
		if (nul.jeN(head.getHead_tip()).equals("HE") && obstajahe.size()==0) {
	//	System.out.println("NASEL UIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
		jeheg=true;
		
		jehegid = head.getId()+"";
		if (!nul.jeN(sim.getTarget_gumba()).equals("") && targett.equals("")) {
			targett = sim.getTarget_gumba();
			
		}
		com.popultrade.dao.TemplateViewDAO daox = (com.popultrade.dao.TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO",pageContext.getServletContext());
		com.popultrade.model.TemplateView sifx = new com.popultrade.model.TemplateView();
		sifx.setTemplatehead_id(head.getId());

		List lisx =null;
		lisx = daox.getTemplateViews(sifx);

		Iterator itx = lisx.iterator();
		while (itx.hasNext()){  // while start
			
			com.popultrade.model.TemplateView vseb = (com.popultrade.model.TemplateView)(itx.next());
			if (vseb.getStolpec_metoda()!=null && vseb.getZaporedje()!=null ){
			obstajahe.put(vseb.getStolpec_metoda(),vseb.getZaporedje()+"");
			if (vseb.getZaporedje()>zaporedjehe) {
			zaporedjehe = vseb.getZaporedje();
			}
			}
			}
		
		}
		/// end ce je head head 
		
		
		
					/// ce je head search 
		if (nul.jeN(head.getHead_tip()).equals("SE") && obstajase.size()==0) {
	//	System.out.println("NASEL UIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
		jeseg=true;
		jesegid = head.getId()+"";
		if (!nul.jeN(sim.getTarget_gumba()).equals("") && targett.equals("")) {
			targett = sim.getTarget_gumba();
			
		}
			com.popultrade.dao.TemplateUiDAO daox = (com.popultrade.dao.TemplateUiDAO)contextUtil.getBeanDao("templateUiDAO",pageContext.getServletContext());
			com.popultrade.model.TemplateUi sifx = new com.popultrade.model.TemplateUi();
			sifx.setTemplatehead_id(head.getId());
			List lisx =null;
			lisx = daox.getTemplateUis(sifx);
			Iterator itx = lisx.iterator();

			while (itx.hasNext()){  // while start
				com.popultrade.model.TemplateUi vseb = (com.popultrade.model.TemplateUi)(itx.next());
				if (vseb.getStolpec_metoda()!=null && vseb.getZaporedje()!=null ){
				obstajase.put(vseb.getStolpec_metoda(),vseb.getZaporedje()+"");
				if (vseb.getZaporedje()>zaporedje) {
				zaporedjese = vseb.getZaporedje();
				}
				}
			}
		}
		/// end ce je head search 
		
		
		
	}
		
		
	}


	
}







%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>

<style> 
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  text-shadow: 1px 1px 3px #666666;
  font-family: Arial;
  color: #ffffff;
  font-size: 12px;
  padding: 0px 4px 0px 4px;
  border: solid #377499 2px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
</style>
<script language="javascript">

function gum() {

parent.frames[3].location="nic.jsp";
}


zapt = <%=zaporedje%>;
zaptx = <%=zaporedjex%>;
zaptse = <%=zaporedjese%>;
zapthe = <%=zaporedjehe%>;
function dodajZaporedjeup(kam,trenutnozap) {

	var tree = document.getElementById(kam);
	var tree2 = document.getElementById(trenutnozap);
if (tree.value==(zaptx+'') && !tree2.checked) {
tree.value="";
zaptx = zaptx-5;
}
else if (tree2.checked) {
zaptx = zaptx+5;

tree.value=zaptx;
}
else {tree.value="";}
}


function dodajZaporedjese(kam,trenutnozap) {

	var tree = document.getElementById(kam);
	var tree2 = document.getElementById(trenutnozap);
	if (tree.value==(zaptse+'') && !tree2.checked) {
	tree.value="";
	zaptse = zaptse-5;
	}
	else if (tree2.checked) {
	zaptse = zaptse+5;

	tree.value=zaptse;
	}
	else {tree.value="";}
	}


function dodajZaporedjehe(kam,trenutnozap) {

	var tree = document.getElementById(kam);
	var tree2 = document.getElementById(trenutnozap);
	if (tree.value==(zapthe+'') && !tree2.checked) {
	tree.value="";
	zapthe = zapthe-5;
	}
	else if (tree2.checked) {
	zapthe = zapthe+5;

	tree.value=zapthe;
	}
	else {tree.value="";}
	}







function dodajZaporedje(kam,trenutnozap) {
	var tree = document.getElementById(kam);
	var tree2 = document.getElementById(trenutnozap);
	if (tree.value==(zapt+'') && !tree2.checked) {
	tree.value="";
	zapt = zapt-5;
	}
	else if (tree2.checked) {
	zapt = zapt+5;

	tree.value=zapt;
	}
	else {tree.value="";}
	}





/// kontrola, ce vsi chekirani imajo zaporedje
function chek() {

  var elements = document.forms['dod'].elements;
  for (i=0; i<elements.length; i++){
    
    
    if (elements[i].type=="checkbox" && elements[i].checked && elements[i].name.indexOf("ID_")!=-1) {
    
    smot = elements[i].value;
  //  alert(smot);
    evv = eval("document.dod.SI_"+smot);
    if (evv.value!="") {
    
    }
    else {
    alert("Napaka: element "+smot +" nima vnesenega zaporedja!");
    return false;
    }
    
    
    }
    
  }
  
  
  if (document.dod.target_gumba.value=="") {
	  
	  alert("Napaka: Target ni izbran! ");
	  return false;
  }
  


}


</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">


<form name=dod action="m_templatelist_avt_all.jsp" method="post" onsubmit="return chek()" >
<input type=hidden name="avtomatika" value="yes">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">

<%
if (jeheg) {
%>
<input type=hidden name="jehe" value="yes">
<input type=hidden name="jeheid" value="<%=jehegid%>">
<%
}
%>
<%
if (jeseg) {
%>
<input type=hidden name="jese" value="yes">
<input type=hidden name="jeseid" value="<%=jesegid%>">
<%
}
%>
<%
if (jeupg) {
%>
<input type=hidden name="jeup" value="yes">
<input type=hidden name="jeupid" value="<%=jeupgid%>">
<%
}
%>
<table border="0" width="100%" cellspacing=9 id="table1" height="100%"  bgcolor=#C3E1FC	>


<tr>
<td width="100%"  class="opiscell" bgcolor="#E3F1FE"  colspan=5>Izberi polja za katera zelis avtomatsko generacijo. Ob izbiri se doda avtomaticno zaporedje, zaporedje je mogoce tudi rocno popraviti. Polja , ki se ne da izbrati so ze generirana.</td>
</tr>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="0" width="100%" id="table2" height="100%" cellspacing=3 cellpadding=5  >
			<tr>
			
			
							
					<%
					 
					String headname="";
					int stej = 0;
						if (true) {
					
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					headname=nul.jeNull(thead.getHead_class_name());
					 
					
					
	//// dobim iz templatetables , ce je
					
					
					com.popultrade.model.TemplateTables ttt =new com.popultrade.model.TemplateTables();
					com.popultrade.dao.TemplateTablesDAO dattt = (com.popultrade.dao.TemplateTablesDAO)contextUtil.getBeanDao("templateTablesDAO",pageContext.getServletContext());

					
					ttt.setTable_name_hibernate(headname);
					Hashtable cols = new Hashtable();
					
					List rex = dattt.getTemplateTabless(ttt, 1, 1, "", "", "");
					
					if (rex.size()==1) {
						
						com.popultrade.model.TemplateTables  ttx = (com.popultrade.model.TemplateTables)rex.get(0);
						
						List rp = ttx.getTemplateTablesCol();
						
						if (rp!=null) {
							
							Iterator itx = rp.iterator();
							while (itx.hasNext()) {
								
								com.popultrade.model.TemplateTablesCol ttc = (com.popultrade.model.TemplateTablesCol)itx.next();
								
								
								cols.put(nul.jeNull(ttc.getField_name()).toLowerCase(), ttc.getDescription()+"-----"+nul.jeNull(ttc.getWidth()));
								
								
							}
							
						}
						
						
					}
					
					
				//// konec dobim iz templatetables , ce je
					
					
					
					
					
					
					
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (stej==5) {
			stej=0;
			%>
			</tr><tr>
			<%
			}
			stej++;
							
							%><td bgcolor="#E3F1FE"  valign="middle">
							<table border="0" width="100%" cellspacing=1 cellpadding=1  height="100%" >
									<table border="0" width="100%"  >
							
								<%
							String ino = nex.substring(0,nex.indexOf(" ----XXX---- "));
							
							ino = ino.toLowerCase().replace("get", "");
							
							System.out.println("::::::::::::::::: "+ino + " ::::: ");
							String vredd = "";
							String dolz = "";
							if (cols.containsKey(ino)) {
								String bo = cols.get(ino).toString();
								
								vredd = bo.substring(0,bo.indexOf("-----"));
								dolz = bo.substring(bo.indexOf("-----")+5);
								
						%>
							
								<tr><td colspan=3 bgcolor='#f7fbff'>
						
							<%=nul.jeN(vredd) %>&nbsp;
							</td></tr>
							
							<%		
							}
							%>
							<tr>
							<td align="center" width=5><input type="text"  <%=obstaja.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  id="SI_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  name="SI_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" value="<%=obstaja.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?obstaja.get(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")):"" %>" style="font-family: Verdana; width:33; border:0px; font-size: 10pt;background-color:#E3F1FE; font-weight:bold;color:red" ></td>
							<td  align="center" valign="middle" width=15>
							<input type='checkbox' <%=obstaja.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  onclick="dodajZaporedje('SI_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>','ID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>')" name="ID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  id="ID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" style="font-family: Verdana; font-size: 8pt" value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>">
							</td>
							<td  align="left" valign="middle" >
							<b><%=nex.replaceAll(" ----XXX---- ","</b> (") +")"%>
							</td>
							</tr>
							
							
							<tr>
							<td align="center" width=5><input type="text"  <%=obstajaup.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  id="SIUP_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  name="SIUP_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" value="<%=obstajaup.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?obstajaup.get(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")):"" %>" style="font-family: Verdana; width:33; border:0px; font-size: 10pt;background-color:#E3F1FE; font-weight:bold;color:red" ></td>
							<td  align="center" valign="middle" width=15>
							<input type='checkbox' <%=obstajaup.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  onclick="dodajZaporedjeup('SIUP_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>','IDUP_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>')" name="IDUP_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  id="IDUP_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" style="font-family: Verdana; font-size: 8pt" value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>">
							<input type='hidden'  name="XID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  id="XID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  value="<%=dolz%>">
							
							
							</td>
							<td  align="left" valign="middle" ><i>Update</i>
							</td>
							</tr>
							
							
							<tr>
							<td align="center" width=5><input type="text"  <%=obstajahe.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  id="SIHE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  name="SIHE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" value="<%=obstajahe.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?obstajahe.get(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")):"" %>" style="font-family: Verdana; width:33; border:0px; font-size: 10pt;background-color:#E3F1FE; font-weight:bold;color:red" ></td>
							<td  align="center" valign="middle" width=15>
							<input type='checkbox' <%=obstajahe.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  onclick="dodajZaporedjehe('SIHE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>','IDHE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>')" name="IDHE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  id="IDHE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" style="font-family: Verdana; font-size: 8pt" value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>">
							</td>
							<td  align="left" valign="middle" ><i>Head</i>
							</td>
							</tr>
							
							
							
							
								<tr>
							<td align="center" width=5><input type="text"  <%=obstajase.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  id="SISE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  name="SISE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" value="<%=obstajase.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?obstajase.get(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")):"" %>" style="font-family: Verdana; width:33; border:0px; font-size: 10pt;background-color:#E3F1FE; font-weight:bold;color:red" ></td>
							<td  align="center" valign="middle" width=15>
							<input type='checkbox' <%=obstajase.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  onclick="dodajZaporedjese('SISE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>','IDSE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>')" name="IDSE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  id="IDSE_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" style="font-family: Verdana; font-size: 8pt" value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>">
							</td>
							<td  align="left" valign="middle" ><i>Search</i>
							</td>
							</tr>
							
							
							
							
							</table></td>
							<%	
							
							
						
					}
					}
					
			
			
					for (int k=stej;k<5;k++){
				%>
				<td></td>
				<%
				}
			%>
			 
	
				
			</tr>
			
				<tr><td colspan=5 align=center>Target gumbov: 
                		<select name="target_gumba" style="font-family: Verdana; font-size: 8pt" >
					<option value="0" <%=nul.jeNull(targett).equals("0")?"selected":""%>>parent.frames[0]</option>
					<option value="1" <%=nul.jeNull(targett).equals("1")?"selected":""%>>parent.frames[1]</option>
					<option value="2" <%=nul.jeNull(targett).equals("2")?"selected":""%>>parent.frames[2]</option>
					
			
					
					
					</select>	</td></tr>
			
			
			
			<tr><td colspan=5 align=center>	<input type="submit" value="Generiraj polja" style="font-family: Verdana; font-size: 8pt">
                		</td></tr>
			
		</table>
		</td>
	</tr>
</table>
</form>
</body>

</html>

 
  <%
}
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>
 

