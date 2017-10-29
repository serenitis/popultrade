package com.popultrade.webapp;



	import java.util.*;
import java.util.Date;
import java.sql.*;
import java.io.*;

import java.security.cert.X509Certificate;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionBindingEvent;

	import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



import com.popultrade.dao.FrameSizeDAO;
import com.popultrade.dao.UsersDAO;

//import com.popultrade.dao.Wse_uporabniki_nastavitveDAO;

import com.popultrade.dao.Wse_prijaveDAO;


import com.popultrade.model.FrameSize;
import com.popultrade.model.Users;
import com.popultrade.model.UsersColumns;


import com.popultrade.model.Wse_prijave;
import com.popultrade.dao.UsersColumnsDAO;


import java.text.SimpleDateFormat;

	public class control implements java.io.Serializable, HttpSessionBindingListener  {//

		/// hashtable with alerts and intervals start time
		public Hashtable sessionint = new Hashtable();

		/// temp alerts ht
		public Hashtable sessionalet = new Hashtable();
		
	//// hashtable podatkov za ivoz

		  public Hashtable izv;
		/// owner id for workers and clients
		
		public Long id_owner;
		public Users users=new Users();
	//	public Wse_uporabniki_nastavitve nastavitve = new Wse_uporabniki_nastavitve();
		
		/**
		 * 
		 */
		private static final long serialVersionUID = 1658809000908596565L;
		private String userName="";
		public String lokacija_default_slik="";
		public String lokacija_splosno_slik="";
		public String lokacija_css_slik="";
		//private ServletContext servletContext;
		  private String status="0";
		  
		  public String lokacijaslika="slike/";
		  public String lokacijaupload="d:/Tomcat5.0/webapps/ROOT/slike/";
		  public String defaultmail="registration@popultrade.com";
		  public String mailserver="smtp.triera.net";
		  
		  /// ant build
		  public String ant_home="";
		  public String hibernate_classes="";
		  public String ant_build_file="";
		  public String worker_type="";
		  
		  public String css_datoteke=""; /// lokacija css_datotek
		  
		  public String prvi_page = "indexne.jsp"; /// index
		  
		  
		  public boolean izpisujePDF=false;
		  
		  private String show_contacts;
		
		private String MODUL01;
		private String MODUL02;
		private String MODUL03;
		private String MODUL04;
		private String MODUL05;
		private String MODUL06;
		
		private String priimek;
		private String ime;
		 public boolean removePageNum=false;
		  
		
		private String parameter01;
		private String parameter02;
		private String parameter03;
		private String parameter04;
		private String parameter05;
		private String parameter06;
		private String parameter07;
		private String parameter08;
		private String parameter09;
		private String parameter10;
		
		public boolean izpisujePDF_esd10;

		public String idUporabnikaLock = "";

		
		public String lokacija_gen_hibernate;
		


		public String getIdUporabnikaLock() {
			return idUporabnikaLock;
		}
		public void setIdUporabnikaLock(String idUporabnikaLock) {
			this.idUporabnikaLock = idUporabnikaLock;
		}






		private String frame1="140";
		private String frame2="410";
		
		private String frame3="600";
		


private String uporablja_pozicijsko_mapo;


private Long podjetje_id;


public String pravica_status_dispozicije;



		//private ContextUtil contextUtil; 
	
		 public String tip_detalj="";
		 public String export_format="";
		//////////////		/
		
		//		/ jezik podjetja
		 public String company_jezik="";
		
		
		
		public Long idUporabnika;
		public Long idStranke;
	  //// id prijave
	  private Long id_prijave;
	  
		
//////	 referenca na ConPool, ko crkne session, da osvobodi narocilo na katerem dela

		
		
private String telefon;





	private conPool co= null;

	private String email;
	private String jezik="SL";
	
	private boolean test = false;
	
	
	String user="anonymous";

//	/ privilegije uporabnika m=master, n=navaden
	public String privilegijeUporabnika="";

//////	 encoding teksta
	public String encoding="utf-8";
//////	 encoding oynaka na pdf
	public String encoding_oznaka="utf-8";
////	/ opis logiranega
	public String opis = "";

	  //// sifra userja
	public String user_sifra= "";
private String user_naziv = "";

////	/ search stavek


/// sifra podjetja za katerega dela user
private String podjetje;



private String kupec;



	public String searchStavek="";


	public String upload315="N";
	
	
	
////	/ lokacija in ime fontov
	 public String lokacija_fontov = "";
	 public String ime_fontov="";
////	/ lokacija direktorija kjer se generirajo pdfi
	 public String pdf_dir = "";
	 private String klan_username_nazaj;
	 public String klan_user_koda_nazaj;

	 //// navodila imena file
	public String  glavna_navodila="";
	
	public String navodila_h="";
	public String navodila_m="";
	public String navodila_k="";


	public int st_vrstic=30;
	
	/// lokacija openssl exeja
	private String location_openssl;
	/// lokacija generiranega certifikata
	private String location_certificate;
	/// lokacija CA certifikata
	private String location_cer_CA;
	
	
	

	private String user2="";
	 private String lokacija_fo_congif="";
	 private String lokacija_pdf_file="";
	  private String lokacija_fo_file="";
	  public String getlokacija_pdf_file() {
	     return lokacija_pdf_file;
	  }
	  public String lokacija_fo_congif() {
	     return lokacija_fo_congif;
	  }


	  public String lokacija_fo_file() {
	    return lokacija_fo_file;
	  }
	 ////////////// momentalni request
	//public HttpServletRequest rq = null;


	  //// vrnem null funkcija
	  
	  public String returnNull() {
		  return null;
	  }
	  
	  
	  

	 public control() {
		 /*	if (spl[1].equals("anketa")) {
			vseb.setVrsta_okna(10);
			}
			else if (spl[1].equals("profil")) {
			vseb.setVrsta_okna(1);
			}
			else if (spl[1].equals("slika_profila")) {
			vseb.setVrsta_okna(2);
			}
			else if (spl[1].equals("slike")) {
			vseb.setVrsta_okna(3);
			}
			else if (spl[1].equals("video")) {
			vseb.setVrsta_okna(4);
			}
			else if (spl[1].equals("povezave")) {
			vseb.setVrsta_okna(5);
			}
			else if (spl[1].equals("tekst")) {
			vseb.setVrsta_okna(6);
			}
			else if (spl[1].equals("prijatelji")) {
			vseb.setVrsta_okna(7);
			}
			else if (spl[1].equals("dogodki")) {
			vseb.setVrsta_okna(8);
			}
			else if (spl[1].equals("blog")) {
			vseb.setVrsta_okna(9);
			}
			else if (spl[1].equals("statistika")) {
			vseb.setVrsta_okna(11);
			}
			else if (spl[1].equals("knjigagostov")) {
			vseb.setVrsta_okna(12);
			}
		*/
	
	   this.doit();

	 }


	
	 
	 public String getUser() {
		 return this.user;
	 }
	 
	 public String getJezik() {
		 return this.jezik;
	 }
	 
	 public String getUser2() {
		 return this.user2;
	 }


	 

	 

////////////////	 pogoji prikaza


Hashtable frames = new Hashtable();



	private boolean pravica=false; 
	



	public void setUser(ContextUtil contextUtil,ServletContext servletContext) {
	//System.out.println("LOGOUT3");
	  if (!this.user.equals("anonymous")) {
	  //  co.st_users_minus(this.usersifra_prijava);
		  removePageNum=false;
	    this.user = "anonymous";
	    this.pravica=false;
	    this.company_jezik="";
	    idUporabnika = null;
	    System.out.println("LOGOUT"); 

	    this.privilegijeUporabnika="0";
	    //izpisujePDF_esd10=false;
	    this.opis="";
	    this.jezik="SL";
	    this.MODUL01="N";
	    this.MODUL02="N";
	    this.MODUL03="N";
	    this.MODUL04="N";
	    this.MODUL05="N";
	    this.MODUL06="N";
	    this.izpisujePDF=false;
	    this.user2=""; 
	   // this.pravica_status_dispozicije="0";
	    this.parameter01="N";
	    this.parameter02="N";
	    this.parameter03="N";
	    this.parameter04="N";
	    this.parameter05="N";
	    this.parameter06="N";
	    this.parameter07="N";
	    this.parameter08="N";
	    this.parameter09="N";
	    this.parameter10="N";
	    this.upload315="N";
	    this.setUporablja_pozicijsko_mapo("");
	    this.kupec="";
	    this.podjetje="";
	    this.worker_type="";

this.setUserName("");
	    this.setStatus("0");
	    this.telefon="";

	this.export_format="";
this.id_owner=null;
	this.user_naziv="";
	
	this.setFrame1("140");
	this.setFrame2("410");
	this.setFrame3("600");
	this.pdf_head="";
this.email="";
frames = new Hashtable();
users=new Users();
//nastavitve = new Wse_uporabniki_nastavitve();
try {
//// update datum odjave
if (this.getId_prijave()!=null) {
Wse_prijaveDAO wpd = (Wse_prijaveDAO)contextUtil.getBeanDao("wse_prijaveDAO",servletContext);
Wse_prijave wsp = wpd.getWse_prijave(this.getId_prijave());

System.out.println("ODJAVA LOGIN "+wsp.getHostname());


wsp.setDatum_odjave(new Date());
wpd.saveWse_prijave(wsp);

}

}
catch (Exception exc) {
	
}

	  }

	System.out.println("LOGOUT2");
	}

	public boolean nelogin3x = false; 
	private String pdf_head="";
	

	public boolean kontrola(String user, String password,ContextUtil contextUtil,ServletContext servletContext,HttpServletRequest req,conPool ConPool) {
	  System.out.println("LOGIN");
	  
	  
	    
	  
	  
	   
 
	  

	try {
		
		if (user.trim().equals("") || password.trim().equals("")) {
			
			return false;
			
		}
		
		//this.contextUtil=contextUtil;
	//	this.servletContext =servletContext;
		//// user iz firme
		String ip_user = req.getRemoteAddr();
		boolean jeadm = false;
		
		
		if (ip_user.indexOf(".")!=-1) {
		
		if (ConPool.ipji.containsKey(ip_user.substring(0, ip_user.lastIndexOf(".")))) {
			jeadm = true;
		}
		}
		
		
		if (user!=null) {
			user = user.toLowerCase();
		}
		
		
		/// ce je blokiran
		nelogin3x = false; 
		if (ConPool.getLogiranja().containsKey(req.getRemoteAddr())) {
			LoginAttempt loga = (LoginAttempt)ConPool.getLogiranja().get(req.getRemoteAddr());
			
			if (loga.noattempt>loga.MAXNOATTEMPT) {
			
			Date dr = new Date();
			
			if (((dr.getTime()-loga.lastatempt.getTime())/(1000*60))>30) {
				ConPool.getLogiranja().remove(req.getRemoteAddr());
			}
			else {
				System.out.println("Login ni ok vec kot 3x probal -- ne kontroliram login za "+req.getRemoteAddr()+" ::: "+((dr.getTime()-loga.lastatempt.getTime())/(1000*60)));
				
			     this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"5",null);
			     nelogin3x = true; 
				
			 	if (!jeadm) {
					return false;
					}
			}
			
			}
			
		}
		
		
		boolean nwnc = true;
		
		
	
		
		
		//////////////////////////////////
		/////////////////////////////////
		
		if (nwnc)  {
		

		
		
		
		/// control, if is logged ok
		
		UsersDAO usersDAO = (UsersDAO)contextUtil.getBeanDao("usersDAO",servletContext);
		Users uppm = new Users();
		uppm.setUsername(user);
		uppm.setGeslo(password);
	//	uppm.setStatus("1");
		//upp.setId(new Long("1"));
		List li = usersDAO.getUserssExactly(uppm);
		
		
		if (li.size()==1 ) {
		uppm = (Users)li.get(0);
		
		if (uppm.getStatus()!=null && uppm.getStatus().equals("1")) {
		
		
		  //// certifikat datum, da ni potekel
		   if (uppm.getParameter08()!=null && uppm.getParameter08().equals("1")) {
		  
			   
			   Object o = req.getAttribute("javax.servlet.request.X509Certificate");
			   if (o != null) {
			   X509Certificate certs[] = (X509Certificate[]) o;
			   X509Certificate cert = certs[0];
			   
			   
			   
			 //// certifikat je potekel 
			  if ( ((cert.getNotAfter().getTime() - ((new Date()).getTime()))/(1000*60*60*24))<0   ) {
				  
				  
				  System.out.println("Ne logiram, certifikat je potekel za userja "+uppm.getUsername());
				   org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
					
					log.error("Login error: certifikate is out of date: "+uppm.getUsername());
					
					uppm.setCdateto(null);
					uppm.setCinfo(null);
					uppm.setCserial(null);
					usersDAO.saveUsers(uppm);
					
					
					
					
					 this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"4",uppm.getId());
					 uppm = new Users();
					
					return false;
			  }
			  
			  
			//// kontrola, da serijska je ista v bazi
			  if (uppm.getCserial()!=null && !uppm.getCserial().equals("") && !uppm.getCserial().equals(cert.getSerialNumber()+"")) {
				   org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
				   System.out.println("Error certificate SN dont match with the user's for user "+uppm.getUsername());
					log.error("Error certificate SN dont match with the user's for user "+uppm.getUsername());
					
					this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"4",uppm.getId());
					uppm = new Users();
				  return false;
			  }
			  else {
			  
			  /// ce datum v bazi ni enak datumu poteka certifikata (npr. podaljsal certifikat, spremenim datum na novega)
			  
	  if ( uppm.getCdateto()!=null && cert.getNotAfter().getTime() != uppm.getCdateto().getTime()   ) {
				  
				  
				  System.out.println("Certifikat je bil podaljsan spremenim datum veljavnosti v bazi za userja "+uppm.getUsername());
				   org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
					
					log.error("Certifikat je bil podaljsan spremenim datum veljavnosti v bazi za userja  "+uppm.getUsername());
					
					uppm.setCdateto(cert.getNotAfter());
					//uppm.setCinfo(null);
					//uppm.setCserial(null);
					usersDAO.saveUsers(uppm);
					
					
					
					this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"4",uppm.getId());
					uppm = new Users();
					return false;
			  }
			  }
			   
			   }
			   else {
				   
				   org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
				   System.out.println("Error certificate not found for user "+uppm.getUsername());
					log.error("Error certificate not found for user "+uppm.getUsername());
					
					this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"4",uppm.getId());
					uppm = new Users();
					return false;
			   }
			   
			   
			   
		   }
		
		
		
		
		
		
		//String ip_user = req.getRemoteAddr();
		System.out.println("ip_user ::: "+ip_user);
		
		if (ip_user.indexOf(".")!=-1 && ip_user.indexOf("127.0.0.1")==-1 ) {
		
		if (uppm.getPrivilegij()!=null && uppm.getPrivilegij().equals("A") && !ConPool.ipji.containsKey(ip_user.substring(0, ip_user.lastIndexOf(".")))) {
			setUser(contextUtil,servletContext);
			this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"6",uppm.getId());
    		return false;
    	}
		}
		else {
			/// locahost
		}
		
		if (ConPool.getLogiranja().containsKey(req.getRemoteAddr())) {
			ConPool.getLogiranja().remove(req.getRemoteAddr());
		}
		
		/*
		
		Wse_uporabniki_nastavitveDAO wse_uporabniki_nastavitveDAO = (Wse_uporabniki_nastavitveDAO)contextUtil.getBeanDao("wse_uporabniki_nastavitveDAO",servletContext);
		Wse_uporabniki_nastavitve wun = new Wse_uporabniki_nastavitve();
		wun.setUpk_id(uppm.getId());
		List liwu = wse_uporabniki_nastavitveDAO.getWse_uporabniki_nastavitves(wun, 1, 1, "", "", "");
		
		if (liwu.size()==1) {
			
			nastavitve = (Wse_uporabniki_nastavitve)liwu.get(0);
			
		}*/
		
		
		
		this.doit();
		users=uppm;
	//	nastavitve = new Wse_uporabniki_nastavitve();
	this.setUserName(user);
		  this.pravica=true;
		  this.user=uppm.getUsername();
		  this.idUporabnika=uppm.getId();
		  
		  this.user2 = user + "0000" + Math.random();
		  
		  this.opis=uppm.getUsername();
		  if (uppm.getPrivilegij()!=null) {
		  this.privilegijeUporabnika=uppm.getPrivilegij();
		  }
		  else {
			  this.privilegijeUporabnika="U";  
		  }
		  
		  System.out.println("PRIVILE :: "+uppm.getPrivilegij());
		
		  this.idUporabnikaLock = uppm.getId() + this.getDatumDanesMinSkupaj();
		  
		  this.setStatus(uppm.getStatus());
		  
		  this.user_sifra=uppm.getId()+"";
		//uppm.
		  
		  
		  this.setShow_contacts(uppm.getKontakti()!=null?uppm.getKontakti()+"":"");
		  
		  this.setJezik(uppm.getJezik());

		  
		  this.setParameter01(uppm.getParameter01());
		  this.setParameter02(uppm.getParameter02());
		  this.setParameter03(uppm.getParameter03());
		  this.setParameter04(uppm.getParameter04());
		  this.setParameter05(uppm.getParameter05());
		  this.setParameter06(uppm.getParameter06());
		  this.setParameter07(uppm.getParameter07());
		  this.setParameter08(uppm.getParameter08());
		  this.setParameter09(uppm.getParameter09());
		  this.setParameter10(uppm.getParameter10());
		  if (uppm.getKupec()!=null) {
			  this.setKupec(uppm.getKupec()+"");
		  }
		
		  this.setEmail(uppm.getE_mail());
		  
		  this.setIme(uppm.getIme());
		  this.setPriimek(uppm.getPriimek());

		  
		  this.setKupec(uppm.getKupec()+"");
		  if (uppm.getFrame1()!=null && uppm.getFrame2()!=null && uppm.getFrame3()!=null && uppm.getFrame1()>0 && uppm.getFrame2()>0 && uppm.getFrame3()>0) {
		  this.setFrame1(uppm.getFrame1()+"");
		  this.setFrame2(uppm.getFrame2()+"");
		  this.setFrame3(uppm.getFrame3()+"");
		  }
		  
	
		  
		  String nazivp = "";

		  this.user_naziv = uppm.getIme() + " " + uppm.getPriimek() + "";
	

		//  chkNull nul = new chkNull();
		  
		/*	WsepodjetjaDAO wsepodjetjaDAO = (WsepodjetjaDAO)contextUtil.getBeanDao("wsepodjetjaDAO",servletContext);
			Wsepodjetja uwp = new Wsepodjetja();
		  
			
			uwp.setSifra(uppm.getPje_sifra());
			
			
			List lwp = wsepodjetjaDAO.getWsepodjetjas(uwp, 1, 1, "", "", "");
			
			if (lwp.size()==1) {
				
				wsepodjetja = (Wsepodjetja)lwp.get(0);
				
			}
			else {
				  System.out.println("Napaka: ne najdem pje sifre podjetja!");
		            
		            return false;
			}*/
		  
		  
		  


    

       
       
       
//// setam prijavo
          
          
          
          this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"1",uppm.getId());
		  
		  
		  
		  //////////// setam  dimenzije framov za user default
		  
		   FrameSizeDAO frs = (FrameSizeDAO)contextUtil.getBeanDao("frameSizeDAO",servletContext);
		    
		   List lim = frs.getFrameByUsername("default");
		   
		   Iterator itm = lim.iterator();
		   
		   while (itm.hasNext()) {
			   FrameSize fs = (FrameSize)itm.next();
			   
			   frames.put(fs.getJsp_page_name(),new FrameSizeClass(this.getUser(),fs.getFrame1(),fs.getFrame2(),fs.getFrame3()));
			   
			   
		   }
		  
		  //// za userja, ce najdem
		   lim = frs.getFrameByUsername(this.getUser());
		   
		   itm = lim.iterator();
		   
		   while (itm.hasNext()) {
			   FrameSize fs = (FrameSize)itm.next();
			   
			   frames.put(fs.getJsp_page_name(),new FrameSizeClass(this.getUser(),fs.getFrame1(),fs.getFrame2(),fs.getFrame3()));
			   
			  
		   }
		  
		  //// zapisem certifikat podatke, ce jih ni
		   if (uppm.getParameter08()!=null && uppm.getParameter08().equals("1")) {
		   if (uppm.getCserial()==null || uppm.getCserial().equals("")) {
			   
			   Object o = req.getAttribute("javax.servlet.request.X509Certificate");
			   if (o != null) {
			   X509Certificate certs[] = (X509Certificate[]) o;
			   X509Certificate cert = certs[0];
			   
			   uppm.setCserial(cert.getSerialNumber()+"");
			   if (cert.getSubjectDN()!=null && cert.getSubjectDN().getName()!=null) {
			   uppm.setCinfo(cert.getSubjectDN().getName());
			   }
			   uppm.setCdateto(cert.getNotAfter());
			   
			   usersDAO.saveUsers(uppm);
			   
			   
			   }
			   else {
				   org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
					
					log.error("Error certificate not found for user "+uppm.getUsername());
					this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"4",uppm.getId());
					return false;
			   }
			   
		   }
		   }
	
		  
		}
		   else {
		/// disabled user
			   this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"3",uppm.getId());
			 	
			   
		}
		  
		  return true;
		}
		else {
			
			/// zapisem da ni ok login
			
			Hashtable logins = ConPool.getLogiranja();
			
			///add
			if (!logins.containsKey(req.getRemoteAddr())) {
				
				logins.put(req.getRemoteAddr(), new LoginAttempt(user,new Date()));
				System.out.println("Login ni ok 1x -- return false");
			}
			else {
				
				LoginAttempt loga = (LoginAttempt)logins.get(req.getRemoteAddr());
				loga.noattempt+=1;
				loga.lastatempt=new Date();
				logins.put(req.getRemoteAddr(), loga);
				
				System.out.println("Login ni ok "+loga.noattempt+"x -- return false");
			}
			
			this.putInPrijave( user,  password, contextUtil, servletContext, req, ConPool,"2",uppm.getId());
			
			return false;
		}
		}
	
	}
	catch (Exception ex) {
		org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
		
		log.error(ex.toString());
	return false;

	}
	
return false;
	}

	
	
	
	private boolean putInPrijave(String user, String password,ContextUtil contextUtil,ServletContext servletContext,HttpServletRequest req,conPool ConPool,String status,Long iduser) {
		
		try {
			
		    //////////// drzava
	          String drzava = req.getLocale().getLanguage();
	/*
	          Locale ll = null;
	          try {
	            ll = InetAddressLocator.getLocale(InetAddress.getByName(req.
	                getRemoteAddr()).getHostName());

	            drzava = ll.getCountry();
	            if (drzava == null || drzava.equals("")) {

	              ll = InetAddressLocator.getLocale(InetAddress.getByName(req.
	                  getRemoteAddr()));
	              drzava = ll.getCountry();

	            }
	            System.out.println("DRRRRRRRRRRRRRRRRRRRRRRZZZZZZZZZZZZZZ  " +
	                               drzava);
	          }
	          catch (UnknownHostException ex1) {
	            System.out.println(ex1.toString());
	          }
	          catch (InetAddressLocatorException ex1) {
	            System.out.println(ex1.toString());
	          }*/
			
		      String drz = "Unknown";
	          Drzave drzav = new Drzave();


	          try {
	            if (drzava != null) {
	             // drz = drzava;
	              if (drzav.drzave.containsKey(drzava)) {
	              //  drz = drzava + "-" + (String) drzav.drzave.get(drzava);
	              }
	            }

	          }
	          catch (Exception ex1) {
	            System.out.println(ex1.toString());
	          }

	          String hostname="";
	          try {
	         // hostname =  InetAddress.getByName(req.getRemoteAddr()).getHostName();
	        }
	       catch (Exception ex1) {
	         System.out.println(ex1.toString());
	       }
			
			
			
			
			
			
		       Wse_prijaveDAO wpd = (Wse_prijaveDAO)contextUtil.getBeanDao("wse_prijaveDAO",servletContext);
		       Wse_prijave wsp = new Wse_prijave();
		       
		       
		       wsp.setDatum_prijave(new Date());
		       wsp.setDrzava(drz);
		       wsp.setStatus(status);
		       wsp.setHostname(hostname);
		       wsp.setIp(req.getRemoteAddr());
		       wsp.setUsername(user);
		       
		       if (iduser!=null) {
		    	   wsp.setId_user(iduser);
		       }
		       
		       
		       wpd.saveWse_prijave(wsp);
		       
		       
		       
		       
		   System.out.println("SAVEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
		   if (status.equals("1")) {
				  this.setId_prijave(wsp.getId());
		   }
			
		}
		catch (Exception exx) {
			System.out.println(exx.toString());
		return false;
		}
		return true;
		
	}
	
	
	
	
	
	
	
	
	
	
	public String getUser_naziv() {
		return user_naziv;
	}
	public void setUser_naziv(String user_naziv) {
		this.user_naziv = user_naziv;
	}
	public boolean getPravica() {
		 return this.pravica;
	 }

	 public void setPravica() {
		 this.pravica=true;
	 }

	 
		public StringBuffer sb=new StringBuffer();
		
		public void a(String vred) {
			
			sb.append(vred);
			
		}
	 
		
		public void clearStringBuffer() {
			
			try {
			sb.delete(0, sb.length());
			}
			catch (Exception e) {
				
			}
		}

//////	/ kontroliram, ce je vrednost null, ce je vrnem 0

	public String chkCheck(String vred) {

	  if (vred!=null) {

	  return vred;
	  }
	  return "0";
	}


//////	 ce je vrednost 1 vrnem checked, ce ne nic

	public String chkKljukca(String klju) {

	if (klju.equals("1")) {
	    return "checked";
	}
	return "";

	}

	
	private void doit() {
	   try{
	     Properties p = new Properties();

	     p.load(new FileInputStream("popultrade.ini"));

	     this.lokacija_fontov = p.getProperty("lokacija_fontov");
	     this.ime_fontov = p.getProperty("ime_fontov");
	     this.pdf_dir = p.getProperty("pdf_dir");
	
	     this.lokacijaslika=p.getProperty("lokacijaslika");
	     System.out.println("LOKACIJA ULOAD popultrade: "+this.lokacijaslika);
		 this.lokacijaupload=p.getProperty("lokacijaupload");
	    	// this.defaultmail=p.getProperty("defaultmail");
	    	 //this.mailserver=p.getProperty("mailserver");

		 //// lokacija fo xsl conf file
		      this.lokacija_fo_congif = p.getProperty("lokacija_fo_congif");
		      this.lokacija_pdf_file = p.getProperty("lokacija_pdf_file");
		     this.lokacija_fo_file = p.getProperty("lokacija_fo_file");
		     
		     lokacija_default_slik = p.getProperty("lokacija_default_slik");
		     lokacija_splosno_slik = p.getProperty("lokacija_splosno_slik");
		     lokacija_css_slik = p.getProperty("lokacija_css_slik");
		     lokacija_gen_hibernate=p.getProperty("lokacija_gen_hibernate");
		     this.css_datoteke =  p.getProperty("css_datoteke_lok");
		     this.hibernate_classes =  p.getProperty("hibernate_classes");
		     this.ant_home = p.getProperty("ant_home");
		     this.ant_build_file = p.getProperty("ant_build_file");
		     
		     this.setLocation_openssl(p.getProperty("location_openssl"));
		     this.setLocation_certificate(p.getProperty("location_certificate"));
		     this.setLocation_cer_CA(p.getProperty("location_cer_CA"));
	     }
	   catch (Exception e) {
	     System.out.println(e);
	     }
	     test = true;
	   }

	   public void setJezik(String jezik, String encoding) {
	     this.jezik=jezik;
	     this.encoding=encoding;
	   }




	   public void valueBound(HttpSessionBindingEvent event) {
	   System.out.println("Listener: session zacel! " + event.getName());
	   }
	   ///// ko konca session, sprostim narocilo iz obdelave
	   public void valueUnbound(HttpSessionBindingEvent event) {
		   
		   

try {
////update datum odjave
	//System.out.println("ODJAVA PRI NE LOGIN 123 "+this.getId_prijave());
if (this.getId_prijave()!=null) {
	
	
	/*
Wse_prijaveDAO wpd = (Wse_prijaveDAO)contextUtil.getBeanDao("wse_prijaveDAO",event.getSession().getServletContext());


Wse_prijave wsp = wpd.getWse_prijave(this.getId_prijave());

System.out.println("ODJAVA PRI NE LOGIN  "+wsp.getUsername());


wsp.setDatum_odjave(new Date());
wpd.saveWse_prijave(wsp);

*/
InputStream inus = event.getSession().getServletContext().getResourceAsStream("/WEB-INF/applicationContext-resources.xml");

BufferedReader reader = new BufferedReader(new InputStreamReader(inus));
StringBuilder out = new StringBuilder();
String line;

String driverr = "";
String userr = "";
String gesloo = "";
String constring = "";

while ((line = reader.readLine()) != null) {
   // out.append(line);
	
	if (line.indexOf("driverClassName")!=-1) {
		String dd = line.substring(line.indexOf("value"));
		dd = dd.substring(dd.indexOf("\"")+1,dd.lastIndexOf("\""));
		driverr = dd;
	}
	else if (line.indexOf("url")!=-1) {
		String dd = line.substring(line.indexOf("value"));
		dd = dd.substring(dd.indexOf("\"")+1,dd.lastIndexOf("\""));
		constring = dd;
	}
	else if (line.indexOf("username")!=-1) {
		String dd = line.substring(line.indexOf("value"));
		dd = dd.substring(dd.indexOf("\"")+1,dd.lastIndexOf("\""));
		userr = dd;
	}
	else if (line.indexOf("password")!=-1) {
		String dd = line.substring(line.indexOf("value"));
		dd = dd.substring(dd.indexOf("\"")+1,dd.lastIndexOf("\""));
		gesloo = dd;
	}
	//System.out.println(line);   //Prints the string content read from input stream
}

reader.close();




String user=userr;
String geslo=gesloo;
String driver=driverr;
String connectionString=constring;

Class.forName(driver);
//System.out.println(driver + " " + connectionurl + " " + user + " "+geslo);

// String url = "jdbc:msql://www.myserver.com:1114/contact_mgr";
Connection  con= DriverManager.getConnection(connectionString,user,geslo);

java.util.Date utilDate = new java.util.Date();
java.sql.Timestamp sq = new java.sql.Timestamp(utilDate.getTime());
PreparedStatement sta2 =con.prepareStatement("update wse_prijave set datum_odjave=?  WHERE id="+this.getId_prijave()+" ");
sta2.setTimestamp(1, sq);
sta2.execute();
//System.out.println("SELECT datoteka_vsebina FROM pt_najava_ladje_pot  WHERE id="+idi+" ");

sta2.close();
con.close();





}

}
catch (Exception exc) {
	System.out.println("NAPAKA UNBOUND CONTROL.class :  "+exc.toString());
}
		   
		   
	
	   }


//////	 setam referenco na conpool


		  public String getDatumDanesMinSkupaj() {
			  SimpleDateFormat formatter = new SimpleDateFormat ("ddMMyyyyHHmmss");

			  Date dat = new Date();

			  return formatter.format(dat);
			}



	  public String getDatumDanesMin() {
	  SimpleDateFormat formatter = new SimpleDateFormat ("dd-MM-yyyy HH:mm:ss");

	  Date dat = new Date();

	  return formatter.format(dat);
	}
	/**
	 * @return the privilegijeUporabnika
	 */
	public String getPrivilegijeUporabnika() {
		return privilegijeUporabnika;
	}
	/**
	 * @param privilegijeUporabnika the privilegijeUporabnika to set
	 */
	public void setPrivilegijeUporabnika(String privilegijeUporabnika) {
		this.privilegijeUporabnika = privilegijeUporabnika;
	}


	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	

	
	

	
	
//////////////  ////////////////////
	//////////////////////////////
	//////////////////////////////
	



		public String getMODUL01() {
		return MODUL01;
	}
	public void setMODUL01(String MODUL01) {
		this.MODUL01 = MODUL01;
	}
	public String getMODUL02() {
		return MODUL02;
	}
	public void setMODUL02(String MODUL02) {
		this.MODUL02 = MODUL02;
	}
	public String getMODUL03() {
		return MODUL03;
	}
	public void setMODUL03(String MODUL03) {
		this.MODUL03 = MODUL03;
	}
	public String getMODUL04() {
		return MODUL04;
	}
	public void setMODUL04(String MODUL04) {
		this.MODUL04 = MODUL04;
	}
	public String getMODUL05() {
		return MODUL05;
	}
	public void setMODUL05(String MODUL05) {
		this.MODUL05 = MODUL05;
	}
	
	
	 
	 public String getMODUL06() {
			return MODUL06;
		}
		public void setMODUL06(String modul06) {
			MODUL06 = modul06;
		}
	public void setJezik(String jezik) {
		this.jezik = jezik;
	}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		
		public String getPodjetje() {
			return podjetje;
		}
		public void setPodjetje(String podjetje) {
			this.podjetje = podjetje;
		}

		
		 public String getFrame1() {
				return frame1;
			}
			public void setFrame1(String frame1) {
				this.frame1 = frame1;
			}
			public String getFrame2() {
				return frame2;
			}
			public void setFrame2(String frame2) {
				this.frame2 = frame2;
			}
			public String getFrame3() {
				return frame3;
			}
			public void setFrame3(String frame3) {
				this.frame3 = frame3;
			}

			
			
			public Long getPodjetje_id() {
				return podjetje_id;
			}
			public void setPodjetje_id(Long podjetje_id) {
				this.podjetje_id = podjetje_id;
			}
			
			
			public Long getId_prijave() {
				return id_prijave;
			}
			public void setId_prijave(Long id_prijave) {
				this.id_prijave = id_prijave;
			}

			
			
			
			
			public String getParameter01() {
				return parameter01;
			}
			public void setParameter01(String parameter01) {
				this.parameter01 = parameter01;
			}
			public String getParameter02() {
				return parameter02;
			}
			public void setParameter02(String parameter02) {
				this.parameter02 = parameter02;
			}
			public String getParameter03() {
				return parameter03;
			}
			public void setParameter03(String parameter03) {
				this.parameter03 = parameter03;
			}
			public String getParameter04() {
				return parameter04;
			}
			public void setParameter04(String parameter04) {
				this.parameter04 = parameter04;
			}
			public String getParameter05() {
				return parameter05;
			}
			public void setParameter05(String parameter05) {
				this.parameter05 = parameter05;
			}
			public String getParameter06() {
				return parameter06;
			}
			public void setParameter06(String parameter06) {
				this.parameter06 = parameter06;
			}
			public String getParameter07() {
				return parameter07;
			}
			public void setParameter07(String parameter07) {
				this.parameter07 = parameter07;
			}
			public String getParameter08() {
				return parameter08;
			}
			public void setParameter08(String parameter08) {
				this.parameter08 = parameter08;
			}
			public String getParameter09() {
				return parameter09;
			}
			public void setParameter09(String parameter09) {
				this.parameter09 = parameter09;
			}
			public String getParameter10() {
				return parameter10;
			}
			public void setParameter10(String parameter10) {
				this.parameter10 = parameter10;
			}
			public Hashtable getFrames() {
				return frames;
			}
			public void setFrames(Hashtable frames) {
				this.frames = frames;
			}
		
		
			public String getUpload315() {
				return upload315;
			}
			public void setUpload315(String upload315) {
				this.upload315 = upload315;
			}
			public String getUserName() {
				return userName;
			}
			public void setUserName(String userName) {
				this.userName = userName;
			}
			public String getPdf_head() {
				return pdf_head;
			}
			public void setPdf_head(String pdf_head) {
				this.pdf_head = pdf_head;
			}
			public String getTelefon() {
				return telefon;
			}
			public void setTelefon(String telefon) {
				this.telefon = telefon;
			}
			public String getPriimek() {
				return priimek;
			}
			public void setPriimek(String priimek) {
				this.priimek = priimek;
			}
			public String getIme() {
				return ime;
			}
			public void setIme(String ime) {
				this.ime = ime;
			}
			public String getUporablja_pozicijsko_mapo() {
				return uporablja_pozicijsko_mapo;
			}
			public void setUporablja_pozicijsko_mapo(String uporablja_pozicijsko_mapo) {
				this.uporablja_pozicijsko_mapo = uporablja_pozicijsko_mapo;
			}
			public String getPravica_status_dispozicije() {
				return pravica_status_dispozicije;
			}
			public void setPravica_status_dispozicije(String pravica_status_dispozicije) {
				this.pravica_status_dispozicije = pravica_status_dispozicije;
			}
			public String getKupec() {
				return kupec;
			}
			public void setKupec(String kupec) {
				this.kupec = kupec;
			}
			public String getShow_contacts() {
				return show_contacts;
			}
			public void setShow_contacts(String showContacts) {
				show_contacts = showContacts;
			}


			public String getLocation_openssl() {
				return location_openssl;
			}
			public void setLocation_openssl(String location_openssl) {
				this.location_openssl = location_openssl;
			}
			
			
		////////// dobim zaporedje in sirine stolpcev
			
		
			public String getLocation_certificate() {
				return location_certificate;
			}
			public void setLocation_certificate(String location_certificate) {
				this.location_certificate = location_certificate;
			}
			
			
			public String getLocation_cer_CA() {
				return location_cer_CA;
			}
			public void setLocation_cer_CA(String location_cer_CA) {
				this.location_cer_CA = location_cer_CA;
			}
			
			
			
			
			
			
			public String getColumnsUser(ContextUtil contextUtil,ServletContext servletContext,String page) {
				
				
				try {
					
					UsersColumnsDAO usersDAO = (UsersColumnsDAO)contextUtil.getBeanDao("usersColumnsDAO",servletContext);
					UsersColumns uppm = new UsersColumns();
					uppm.setUser_id(this.idUporabnika);
					uppm.setPage_list(page);
					
					//upp.setId(new Long("1"));
					List li = usersDAO.getUsersColumnss(uppm, "", "");
					
					if (li.size()>0) {
						return ((UsersColumns)li.get(0)).getStolpci();
					}
					return "";
					
				}
				catch (Exception exxx) {
					System.out.println("Error: ne dobim konfiguracije stolpcev : "+exxx.toString());
				}
				return "";
				
			}
			
			//////// zapisem zaporedje in sirine
			
			public boolean setColumnsUser(ContextUtil contextUtil,ServletContext servletContext,String page,String columns) {
				
				
				try {
					
					UsersColumnsDAO usersDAO = (UsersColumnsDAO)contextUtil.getBeanDao("usersColumnsDAO",servletContext);
					UsersColumns uppm = new UsersColumns();
					uppm.setUser_id(this.idUporabnika);
					uppm.setPage_list(page);
					
					//upp.setId(new Long("1"));
					List li = usersDAO.getUsersColumnss(uppm, "", "");
					
					if (li.size()>0) {
						uppm= ((UsersColumns)li.get(0));
					}
						uppm.setStolpci(columns);
						
						usersDAO.saveUsersColumns(uppm);
						
					
					
					return true;
					
				}
				catch (Exception exxx) {
					System.out.println("Error: ne moram setirat stolpcev : "+exxx.toString());
				}
				return false;
				
			}
			
			public boolean removeColumnsUser(ContextUtil contextUtil,ServletContext servletContext,String page,String columns) {
				
				
				try {
					
					UsersColumnsDAO usersDAO = (UsersColumnsDAO)contextUtil.getBeanDao("usersColumnsDAO",servletContext);
					UsersColumns uppm = new UsersColumns();
					uppm.setUser_id(this.idUporabnika);
					uppm.setPage_list(page);
					
					//upp.setId(new Long("1"));
					List li = usersDAO.getUsersColumnss(uppm, "", "");
					
					if (li.size()>0) {
						uppm= ((UsersColumns)li.get(0));
					}
						uppm.setStolpci(null);
						
						usersDAO.saveUsersColumns(uppm);
						
					
					
					return true;
					
				}
				catch (Exception exxx) {
					System.out.println("Error: ne moram setirat stolpcev : "+exxx.toString());
				}
				return false;
				
			}
			
			
			
			
			
			  public  String trimLeftRight(String s) {
				  
				  return trimRight(trimLeft(s));
				  }
				  
				  public  String trimLeft(String s) {

				 return s.replaceAll("^\\s+", "");

					}

					

					public  String trimRight(String s) {

					 return s.replaceAll("\\s+$", "");

					} 
					
					
					
					
					
					/// get custom css names
					 
			 	    public Hashtable getCSS_names(String css_datoteka)
				    {
				        Hashtable sb = new Hashtable();
				        try
				        {
				            FileInputStream fstream = new FileInputStream(css_datoteka);
				            DataInputStream in = new DataInputStream(fstream);
				            BufferedReader br = new BufferedReader(new InputStreamReader(in));
				            String strLine;
				            while((strLine = br.readLine()) != null)  {
				            	
				            	if (strLine.startsWith(".t") && strLine.indexOf("{")!=-1) {
				            	
				            		String name = strLine.substring(1,strLine.indexOf(" "));
				            		
				            		sb.put(name, name);
				            		
				            		
				                //sb.append((new StringBuilder()).append(strLine).append("\r\n").toString());
				        }
				            }
				            in.close();
				        }
				        catch(Exception ecm)
				        {
				            System.out.println((new StringBuilder()).append("Napaka pri branju css custom datoteke: ").append(ecm.toString()).toString());
				        }
				        return sb;
				    }
					
					
					
					
					
					
					
					
					
					
					
			
			

	} //


