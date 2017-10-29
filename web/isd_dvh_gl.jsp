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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U")) {
%><jsp:forward page="logout.jsp"/><%
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
 
String iskanje="";
 
try {
 
// get list from daoobject
com.popultrade.dao.Isd_dvh_glDAO dao = (com.popultrade.dao.Isd_dvh_glDAO)contextUtil.getBeanDao("isd_dvh_glDAO",pageContext.getServletContext());
 

//// kopiram v en vsd
if (nul.jeNull(request.getParameter("opcija")).equals("copy1") || nul.jeNull(request.getParameter("opcija")).equals("copy2")) {
	//// ladja
	com.popultrade.dao.LadjaDAO daola = (com.popultrade.dao.LadjaDAO)contextUtil.getBeanDao("ladjaDAO",pageContext.getServletContext());
	com.popultrade.dao.PlanprihodovDAO daopl = (com.popultrade.dao.PlanprihodovDAO)contextUtil.getBeanDao("planprihodovDAO",pageContext.getServletContext());
	
	
	/// drzave
	Hashtable drzave= new Hashtable();
					com.popultrade.dao.DrzavaDAO daosd = (com.popultrade.dao.DrzavaDAO)contextUtil.getBeanDao("drzavaDAO",pageContext.getServletContext());
					List lild = daosd.getDrzavas(new com.popultrade.model.Drzava());

					Iterator ittd = lild.iterator();

					while (ittd.hasNext()) {
						com.popultrade.model.Drzava sifr = (com.popultrade.model.Drzava)ittd.next();
						drzave.put(sifr.getNAZIV().toLowerCase(),sifr.getOZNDRZ());
					
					
					}
	
	
	
	//// dvh ji
	com.popultrade.dao.Isd_dvh_vrsDAO vrsd = (com.popultrade.dao.Isd_dvh_vrsDAO)contextUtil.getBeanDao("isd_dvh_vrsDAO",pageContext.getServletContext());
	com.popultrade.dao.Isd_dvh_posDAO posd = (com.popultrade.dao.Isd_dvh_posDAO)contextUtil.getBeanDao("isd_dvh_posDAO",pageContext.getServletContext());
	
	
	//// popultrade ji
	com.popultrade.dao.Esd10DAO esd10d = (com.popultrade.dao.Esd10DAO)contextUtil.getBeanDao("esd10DAO",pageContext.getServletContext());
	com.popultrade.dao.Esd20DAO esd20d = (com.popultrade.dao.Esd20DAO)contextUtil.getBeanDao("esd20DAO",pageContext.getServletContext());
	com.popultrade.dao.Esd30DAO esd30d = (com.popultrade.dao.Esd30DAO)contextUtil.getBeanDao("esd30DAO",pageContext.getServletContext());
	
	
	/// lrn
	com.popultrade.dao.StevciDAO sdao = (com.popultrade.dao.StevciDAO)contextUtil.getBeanDao("stevciDAO",pageContext.getServletContext());
	com.popultrade.model.Stevci stev = new com.popultrade.model.Stevci();
	
	
	com.popultrade.model.Isd_dvh_gl sif = new com.popultrade.model.Isd_dvh_gl();
	//int strec = dao.getStIsd_dvh_gl(sif);
	 
	 sif.setPotovanje(request.getParameter("siftic"));
	 sif.setOznnar(control.getPodjetje());

	List lis = dao.getIsd_dvh_gls(sif);
	
	System.out.println("--------------------------------------- NAJDEM: "+request.getParameter("siftic"));
	
	Iterator it = lis.iterator();
	boolean jeenaglava = false;
	Long idd=null;
	int zap_pos=1;
	int st_pos = 0;
	double bruto=0;
	int posiljke=0;
	
	com.popultrade.model.Esd10 esd10 = new com.popultrade.model.Esd10();
	while (it.hasNext()) {
		
		com.popultrade.model.Isd_dvh_gl glava = (com.popultrade.model.Isd_dvh_gl)it.next();
		//System.out.println(" :::::::::::::::::::::::::::: 111");
		if (glava.getSumbrutokg()!=null) {
		bruto = bruto + glava.getSumbrutokg();
		}
		//System.out.println(" :::::::::::::::::::::::::::: 1112");
		if (glava.getSumkolpakt()!=null) {
		posiljke=posiljke+glava.getSumkolpakt();
		}
		//System.out.println(" :::::::::::::::::::::::::::: 1113");
		if (nul.jeNull(request.getParameter("opcija")).equals("copy1")  && !jeenaglava) {
		String lrn_gen;
		jeenaglava=true;
		//System.out.println(" :::::::::::::::::::::::::::: 10");
		/// dobim lrn
		String letoo = nul.getDatumFormat("yyyy");
		int let = Integer.parseInt(letoo.substring(2,letoo.length()));
		stev.setHub(control.getPodjetje());
		stev.setLeto(let);
		List lim = sdao.getStevcis(stev);
		//System.out.println(" :::::::::::::::::::::::::::: 1");
		if (lim.size()>0) {
		//	System.out.println(" :::::::::::::::::::::::::::: 11");
			Iterator ito = lim.iterator();
			stev = (com.popultrade.model.Stevci)ito.next();
			lrn_gen=control.getPodjetje()+"-"+((stev.getLeto()+"").length()==1?"0"+(stev.getLeto()+""):(stev.getLeto()+""))+"-"+nul.addNule((stev.getStevec().intValue()+1)+"",5);
			stev.setStevec(new Long((stev.getStevec().intValue()+1)+""));
			sdao.saveStevci(stev);
			//System.out.println(" :::::::::::::::::::::::::::: 2");
			
		}
		else {
			//System.out.println(" :::::::::::::::::::::::::::: 3");
			stev.setStevec(new Long("1"));
			sdao.saveStevci(stev);
			lrn_gen=control.getPodjetje()+"-"+((stev.getLeto()+"").length()==1?"0"+(stev.getLeto()+""):(stev.getLeto()+""))+"-"+"00001";
			//System.out.println(" :::::::::::::::::::::::::::: 4");
		}
			
		
		/// naredim glavo v esd10
		/////// vnesi opis luke in ladjarja , ter kdo naredi in updata
		
		//System.out.println(lrn_gen +" :::::::::::::::::::::::::::: ");
		
		esd10.setUsp_id(glava.getOznnar());
		esd10.setLdj_ladja(glava.getLadja());
		String ladop=null;
		String ladjarop=null;
		String oznlad = null;
		String imo_lad=null;
		try {
		com.popultrade.model.Ladja ladj = daola.getLadja(glava.getLadja());
		
		if (ladj!=null) {
			ladop = nul.jeNull(ladj.getIMELAD());
			imo_lad=nul.jeNull(ladj.getIMO());
			if (ladj.getLadjar()!=null && ladj.getLadjar().getOZNLADJAR()!=null) {
				ladjarop = nul.jeNull(ladj.getLadjar().getNAZIV());
				oznlad = ladj.getLadjar().getOZNLADJAR();
			}
			
		}
		
		}
		catch (Exception ex) {
			
		}
		esd10.setOpisladjar(ladjarop);
		esd10.setOpisladja(ladop);
		esd10.setImo(imo_lad);
		esd10.setRef_st_prevoza(glava.getPotovanje());
		esd10.setLka_dzv_ozndrz_luka_iz_drzava(glava.getDrziz());
		esd10.setLka_luka_iz_luka(glava.getLukaiz());
		esd10.setLuka_iz_ime(glava.getImeiz());
		esd10.setLka_dzv_ozndrz_luka_v_drzava(glava.getDrzza());
		esd10.setLka_luka_v_luka(glava.getLukaza());
		esd10.setLuka_v_ime(glava.getImeza());
		esd10.setSt_brutokg(glava.getSumbrutokg());
		esd10.setSt_tovorkov(glava.getSumkolpakt());
		esd10.setOpisblaga(glava.getBlago());
		esd10.setLrn(lrn_gen);
		esd10.setPopravek("0");
		esd10.setLdr_oznladjar(oznlad); ////manjka
		esd10.setEsd20(null);
		esd10.setLadja(null);
		esd10.setEsd16s(null);
		esd10.setEsd12s(null);
		esd10.setKraj(nul.jeNullDefault(control.getKraj_vlozitve()));
		esd10.setCarurad("SI006044");
		esd10.setVrstatransporta("1");
		esd10.setPrevoznik(control.getPrevoznik());
		
		//// eta iz planprihodov ladij na podlagi siftic
		com.popultrade.model.Planprihodov plan = daopl.getPlanprihodovSiftic(request.getParameter("siftic"));
		
		
		 if (plan!=null && plan.getDatpriv()!=null) {
			 esd10.setEta(plan.getDatpriv());
		 }
		
		esd10.setUsere(control.getUser());
		esd10.setUserlu(control.getUser());
		esd10.setEdatetime(new Date());
		esd10.setLudatetime(new Date());

		//// shranim esd10 in dobim id
		
		esd10d.saveEsd10(esd10);
		idd = esd10.getIde10();
		System.out.println("------++--------------------------- :: "+esd10.getIde10());
		}
		
		
		//// dobim posiljke iz dvh
		
		List posi = glava.getIsd_dvh_pos();
		
		Iterator po = posi.iterator();
		
		while (po.hasNext()) {
			com.popultrade.model.Isd_dvh_pos posiljka = (com.popultrade.model.Isd_dvh_pos)po.next();
			
			
			
			
			if (nul.jeNull(request.getParameter("opcija")).equals("copy2")) {
				String lrn_gen;
				
				/// dobim lrn
				String letoo = nul.getDatumFormat("yyyy");
				int let = Integer.parseInt(letoo.substring(2,letoo.length()));
				stev.setHub(control.getPodjetje());
				stev.setLeto(let);
				List lim = sdao.getStevcis(stev);
				if (lim.size()>0) {
					Iterator ito = lim.iterator();
					stev = (com.popultrade.model.Stevci)ito.next();
					lrn_gen=control.getPodjetje()+"-"+((stev.getLeto()+"").length()==1?"0"+(stev.getLeto()+""):(stev.getLeto()+""))+"-"+nul.addNule((stev.getStevec().intValue()+1)+"",5);
					stev.setStevec(new Long((stev.getStevec().intValue()+1)+""));
					sdao.saveStevci(stev);
					
				}
				else {
					stev.setStevec(new Long("1"));
					sdao.saveStevci(stev);
					lrn_gen=control.getPodjetje()+"-"+((stev.getLeto()+"").length()==1?"0"+(stev.getLeto()+""):(stev.getLeto()+""))+"-"+"00001";
				}
					
				
				/// naredim glavo v esd10
				com.popultrade.model.Esd10 esd101 = new com.popultrade.model.Esd10();
				
				
				
				esd101.setUsp_id(glava.getOznnar());
				esd101.setLdj_ladja(glava.getLadja());
				String ladop=null;
				String ladjarop=null;
				String oznlad = null;
				String imo_lad=null;
				try {
				com.popultrade.model.Ladja ladj = daola.getLadja(glava.getLadja());
				
				if (ladj!=null) {
					ladop = nul.jeNull(ladj.getIMELAD());
					imo_lad=nul.jeNull(ladj.getIMO());
					if (ladj.getLadjar()!=null && ladj.getLadjar().getOZNLADJAR()!=null) {
						ladjarop = nul.jeNull(ladj.getLadjar().getNAZIV());
						oznlad = ladj.getLadjar().getOZNLADJAR();
					}
					
				}
				
				}
				catch (Exception ex) {
					
				}
				esd101.setOpisladjar(ladjarop);
				esd101.setOpisladja(ladop);
				esd101.setImo(imo_lad);
				
				esd101.setRef_st_prevoza(glava.getPotovanje());
				esd101.setLka_dzv_ozndrz_luka_iz_drzava(glava.getDrziz());
				esd101.setLka_luka_iz_luka(glava.getLukaiz());
				esd101.setLuka_iz_ime(glava.getImeiz());
				esd101.setLka_dzv_ozndrz_luka_v_drzava(glava.getDrzza());
				esd101.setLka_luka_v_luka(glava.getLukaza());
				esd101.setLuka_v_ime(glava.getImeza());
				esd101.setSt_brutokg(posiljka.getSbrutokg());
				esd101.setSt_tovorkov(posiljka.getSkolpaktra());
				esd101.setOpisblaga(nul.jeNullDefault(glava.getBlago()));
				esd101.setLrn(lrn_gen);
				esd101.setPopravek("0");
				esd101.setLdr_oznladjar(oznlad); ////manjka
				esd101.setSt_postavk(1);
				esd101.setEsd12s(null);
				esd101.setEsd16s(null);
				esd101.setEsd20(null);
				esd101.setLadja(null);
				esd101.setKraj(nul.jeNullDefault(control.getKraj_vlozitve()));
				esd101.setCarurad("SI006044");
				esd101.setVrstatransporta("1");
				esd101.setPrevoznik(control.getPrevoznik());
				
				
				//// eta iz planprihodov ladij na podlagi siftic
				com.popultrade.model.Planprihodov plan = daopl.getPlanprihodovSiftic(request.getParameter("siftic"));
				
				
				 if (plan!=null && plan.getDatpriv()!=null) {
					 esd101.setEta(plan.getDatpriv());
				 }
				
				//// shranim esd10 in dobim id
						esd101.setUsere(control.getUser());
		esd101.setUserlu(control.getUser());
		esd101.setEdatetime(new Date());
		esd101.setLudatetime(new Date());
				esd10d.saveEsd10(esd101);
				idd = esd101.getIde10();
				}
			
			
			
			
			
			
			
			
			
			/// naredim  esd20
			
			com.popultrade.model.Esd20 esd20 = new com.popultrade.model.Esd20();
			
			if (nul.jeNull(request.getParameter("opcija")).equals("copy2")) {
			esd20.setZapst(1);
			}
			else {
				esd20.setZapst(zap_pos);
			}
			esd20.setLka_dzv_ozndrz_luka_iz_drzava(posiljka.getDrzu());
			esd20.setLka_luka_iz_luka(posiljka.getLukau());
			esd20.setLuka_iz_ime(posiljka.getImeu());
			esd20.setLka_dzv_ozndrz_luka_v_drzava(posiljka.getDrzk());
			esd20.setLka_luka_v_luka(posiljka.getLukak());
			esd20.setLuka_v_ime(posiljka.getImelukak());
			if (posiljka.getNrteret()!=null) {
			esd20.setBl(posiljka.getNrteret());
			}
			else {
				esd20.setBl(" ");
			}
			
			esd20.setTippakiranja(posiljka.getPaktra());
			esd20.setSttovorkov(posiljka.getSkolpaktra());
			esd20.setBrutoblaga(posiljka.getSbrutokg());
			esd20.setImo_imco(posiljka.getImdgun());
			esd20.setSt_vrstic(posiljka.getStvbl());
			esd20.setTip(posiljka.getTip());
			
			
			esd20.setPos_naziv(nul.jeNullDefault(posiljka.getPos_naziv()));
			esd20.setPos_naslov(nul.jeNullDefault(posiljka.getPos_naslov()));
			esd20.setPos_kraj(nul.jeNullDefault(posiljka.getPos_kraj()));
			esd20.setPos_posta(nul.jeNullDefault(posiljka.getPos_posta()));
			esd20.setDzv_ozndrz_pos_drzava(nul.jeNull((String)drzave.get(nul.jeNull(posiljka.getPos_drzava()).toLowerCase())));
			esd20.setPos_idddv(nul.jeNull(posiljka.getPos_idddv()));
			
			esd20.setPre_naziv(nul.jeNullDefault(posiljka.getPre_naziv()));
			esd20.setPre_naslov(nul.jeNull(posiljka.getPre_naslov()));
			esd20.setPre_kraj(nul.jeNull(posiljka.getPre_kraj()));
			esd20.setPre_posta(nul.jeNull(posiljka.getPre_posta()));
			esd20.setDzv_ozndrz_pre_drzava(nul.jeNull((String)drzave.get(nul.jeNull(posiljka.getPre_drzava()).toLowerCase())));
			esd20.setPre_idddv(nul.jeNull(posiljka.getPre_idddv()));
			
			esd20.setNot_naziv(nul.jeNull(posiljka.getNot_naziv()));
			esd20.setNot_naslov(nul.jeNull(posiljka.getNot_naslov()));
			esd20.setNot_kraj(nul.jeNull(posiljka.getNot_kraj()));
			esd20.setNot_posta(nul.jeNull(posiljka.getNot_posta()));
			esd20.setDzv_ozndrz_not_drzava(nul.jeNull((String)drzave.get(nul.jeNull(posiljka.getNot_drzava()).toLowerCase())));
			esd20.setNot_idddv(nul.jeNull(posiljka.getNot_idddv()));
			
			esd20.setEsd30(null);
			
	
			
			
			
			String blag = nul.jeNull(posiljka.getBlago_dolgo());
			if (blag==null || blag.equals("")) {
				blag = nul.jeNullDefault(posiljka.getNazivbl());
			}
			
			esd20.setBlago(blag);
			
			//System.out.println("--------------------------------- :: "+esd10.getIde10());
			esd20.setE10_ide10(idd);
			
			/// shranim
			
			esd20d.saveEsd20(esd20);
			
			
		/// dodam listino ce je v pre_naziv napis to order
			
			if (nul.jeNull(posiljka.getPre_naziv()).equals("TO ORDER")) {
				com.popultrade.dao.Esd21DAO esd21d = (com.popultrade.dao.Esd21DAO)contextUtil.getBeanDao("esd21DAO",pageContext.getServletContext());
				
				com.popultrade.model.Esd21 esd21 = new com.popultrade.model.Esd21();
				
				esd21.setVrsta_listine("10600");
				esd21.setE20_ide20(esd20.getIde20());
				esd21.setUsere(control.getUser());
				esd21.setUserlu(control.getUser());
				esd21.setEdatetime(new Date());
				esd21.setLudatetime(new Date());
				
				esd21d.saveEsd21(esd21);
				
				
			}
			
			//// dobim vrstice
			
			List vrss = posiljka.getIsd_dvh_vrs();
			
			/// dodam vrstice
			Iterator lom = vrss.iterator();
			
			while (lom.hasNext()) {
				
				com.popultrade.model.Isd_dvh_vrs vrstica = (com.popultrade.model.Isd_dvh_vrs)lom.next();
				
				
				/// naredim  esd30
				
				com.popultrade.model.Esd30 esd30 = new com.popultrade.model.Esd30();
				
				esd30.setZapst(vrstica.getNrpostav());
				esd30.setStevilotovorkov(vrstica.getKolpaktra());
				esd30.setStevilokosov(vrstica.getKolpaktrg());
				esd30.setBrutomasa(vrstica.getBrutokg());
				esd30.setBlago(vrstica.getOpisblag());
				esd30.setKontejner(vrstica.getKontejner());
				esd30.setE20_ide20(esd20.getIde20());
				
				esd30.setTippakiranja(posiljka.getPaktra());
				esd30.setPepf("F");
				esd30.setPlomba(vrstica.getNrseal());
				
				esd30d.saveEsd30(esd30);
				
				
				
				
				
				
			}
			
			
			zap_pos++;
			st_pos++;
			
			
			
		}
		
		
		
		
		
		
	}
	if (nul.jeNull(request.getParameter("opcija")).equals("copy1") ) {
	esd10.setSt_brutokg(bruto);
	esd10.setSt_tovorkov(posiljke);
	esd10.setSt_postavk(st_pos);
	
	
	esd10d.saveEsd10(esd10);
	
	}
	
	
}



if (nul.jeNull(request.getParameter("opcija")).equals("copy1") || nul.jeNull(request.getParameter("opcija")).equals("copy2")) {
	
	
	 %><jsp:forward page="nic_preskok.jsp?lokacijaa=esd10.jsp"/><%
	 
	
	
	
}









 
if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	
 
	dao.removeIsd_dvh_gl(new Long(request.getParameter("id")));
 
	
}
 
 
int pagenum=1;
int stizpisov=stpri;
 
if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {
 
	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumberIsd_dvh_gl",pagenum+"");
	}
	else {
	if (session.getValue("pagenumberIsd_dvh_gl")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumberIsd_dvh_gl")+"");
	}
	}
 
 
com.popultrade.model.Isd_dvh_gl sif = new com.popultrade.model.Isd_dvh_gl();
//int strec = dao.getStIsd_dvh_gl(sif);
 
 sif.setPotovanje(request.getParameter("siftic"));
 sif.setOznnar(control.getPodjetje());
 
List lis =null;
 

lis = dao.getIsd_dvh_gls(sif);
 
 if (lis.size()==0) {
	 
	 %><jsp:forward page="esd10_copy.jsp?napaka=Napaka: ne najdem dispozicij z vneseno stevilko ticanja!"/><%
	 
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
parent.frames[2].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>
 
<script language=javascript> 
 
 
                	   p0="Id";
                	   
                	   p2="Posiljatelj";
                	   
                	   p4="Narnrdis";
                	   
                	   p6="Nrdis";
                	   
                	   p8="Popravek";
                	   
                	   p10="Tipdis";
                	   
                	   p12="Izvajal";
                	   
                	   p14="Oznnar";
                	   
                	   p16="Agentkt";
                	   
                	   p18="Ladja";
                	   
                	   p20="Potovanje";
                	   
                	   p22="Drziz";
                	   
                	   p24="Lukaiz";
                	   
                	   p26="Imeiz";
                	   
                	   p28="Drzza";
                	   
                	   p30="Lukaza";
                	   
                	   p32="Imeza";
                	   
                	   p34="Sumtarakt";
                	   
                	   p36="Sumbrutokg";
                	   
                	   p38="Sumvolm3";
                	   
                	   p40="Sumkolpakt";
                	   
                	   p42="Stpbl";
                	   
                	   p44="Stpkft";
                	   
                	   p46="Stpkte";
                	   
                	   p48="Blago";
                	   
                	   p50="Vpis";
                	   
 
</script>
 
 
<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
 
 

               
            	   
            	   <td width=8% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">Narnrdis</td>
               
            	   
            	   <td width=8% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p6)">Nrdis</td>
               
            	   
            	   <td width=3% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p8)">Pop.</td>
               
            	   
            	   <td width=5% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p10)">Tipdis</td>
               
            	   
            	   <td width=5% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p12)">Izvajal</td>
            	   
               
               <td width=25% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p18)">Ladja</td>
               
                <td width=10% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p20)">Potovanje</td>
               
            	   
            	    <td width=25% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p48)">Blago</td>
               
            	   
              
                 <td  bgcolor="ADD9FF" align=center>
                 
                 <a href="nic_preskok.jsp?lokacijaa=isd_dvh_gl.jspQUEopcija=copy1ANDsiftic=<%=request.getParameter("siftic")%>" href="Javascript: PGAPP()"><img title="Kopiraj dispozivijo v en vsd" border="0" src="copy1.gif" /></a>
                 <br>
                 <a href="nic_preskok.jsp?lokacijaa=isd_dvh_gl.jspQUEopcija=copy2ANDsiftic=<%=request.getParameter("siftic")%>" href="Javascript: PGAPP()"><img title="Kopiraj dispozivijo v vec vsdjev" border="0" src="copy2.gif" /></a>
                 
                 
                 </td>
        </tr>
 
 
</table>
</div>
 
 
 
 
 
 
<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
<tr><td colspan=3 height="25">&nbsp</td></tr>
<%
 
/// menja barvo
int br = 0;
String oe_kup_nap = "";
 
 
Iterator it = lis.iterator();
 
 
while (it.hasNext()){  // while start
	
	com.popultrade.model.Isd_dvh_gl vseb = (com.popultrade.model.Isd_dvh_gl)(it.next());
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
 

	
	<td width="8%" align="center"><%=nul.jeNull(vseb.getNarnrdis()+"")%></td>
	
	<td width="8%" align="center"><%=nul.jeNull(vseb.getNrdis()+"")%></td>
	
	<td width="3%" align="center"><%=nul.jeNull(vseb.getPopravek()+"")%></td>
	
	<td width="5%" align="center"><%=nul.jeNull(vseb.getTipdis())%></td>
	
	<td width="5%" align="center"><%=nul.jeNull(vseb.getIzvajal())%></td>
	
	<td width="25%" align="left"><%=nul.jeNull(vseb.getLadja())%></td>
	
	<td width="10%" align="center"><%=nul.jeNull(vseb.getPotovanje())%></td>
	
	<td width="25%" align="left"><%=nul.jeNull(vseb.getBlago())%></td>
	
	
	
 
 
<td  align="center">
 

 
 <a onClick="return vprasaj()" href="nic_preskok.jsp?lokacijaa=isd_dvh_gl.jspQUEakcija=DELETEANDid=<%=vseb.getId()%>ANDsiftic=<%=request.getParameter("siftic")%>"><img src="x.gif" border=0 title="Brisi"></a>
 
 
 
</td>
</tr>
 
<%
br++;
 
}/// while end
 
 
 %>
  
</table>
 
 
<script language=javascript> 
function go(asd,vv){
  if (vv == 1){
    aaa = "isd_dvh_gl_edit.jsp?id="+asd;
    parent.frames[2].location = aaa;
  }
 
return false;
}
function godown(asd){
parent.frames[2].location = asd;
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
 
 
 

