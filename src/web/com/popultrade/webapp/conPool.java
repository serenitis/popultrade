package com.popultrade.webapp;


	import java.sql.Connection;
	
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.popultrade.model.CreateLogFromClass;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Hashtable;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Vector;
import java.util.jar.JarFile;
import java.util.zip.ZipEntry;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;

	public class conPool implements java.io.Serializable  {
		
		
		
		private int num_send_dir_simultaneus;
		private int num_send_files_simultaneus;
		
		private int num_send_dir_simultaneus_op;
		private int num_send_files_simultaneus_op;
		
		private int client_check_interval;
		private int option_check_interval;
		 
		/// entity manager factory za nosql, samo ce je v nasprtonem primeru je null, rabim persistence.xml za zdaj kasneje treba narediti preko spring, pazi na ime persistece
		
		private EntityManagerFactory  entman=null; 
		private String persistenceName="com.popultrade.pers"; /// ime persistence iz popultrade.ini
private String packageName_fixno="";
private String repository_url=""; /// url repository, dobim iz txt datoteke
private String websocket_url ="";


private String remote_address=""; /// iz kjer mora priti request na sub strani



private String application_url="";











	public int getNum_send_dir_simultaneus_op() {
	return num_send_dir_simultaneus_op;
}

public void setNum_send_dir_simultaneus_op(int num_send_dir_simultaneus_op) {
	this.num_send_dir_simultaneus_op = num_send_dir_simultaneus_op;
}

public int getNum_send_files_simultaneus_op() {
	return num_send_files_simultaneus_op;
}

public void setNum_send_files_simultaneus_op(int num_send_files_simultaneus_op) {
	this.num_send_files_simultaneus_op = num_send_files_simultaneus_op;
}

public int getOption_check_interval() {
	return option_check_interval;
}

public void setOption_check_interval(int option_check_interval) {
	this.option_check_interval = option_check_interval;
}

	public String getApplication_url() {
	return application_url;
}

public void setApplication_url(String application_url) {
	this.application_url = application_url;
}

	public int getNum_send_dir_simultaneus() {
	return num_send_dir_simultaneus;
}

public void setNum_send_dir_simultaneus(int num_send_dir_simultaneus) {
	this.num_send_dir_simultaneus = num_send_dir_simultaneus;
}

public int getNum_send_files_simultaneus() {
	return num_send_files_simultaneus;
}

public void setNum_send_files_simultaneus(int num_send_files_simultaneus) {
	this.num_send_files_simultaneus = num_send_files_simultaneus;
}

	public String getRemote_address() {
	return remote_address;
}

public void setRemote_address(String remote_address) {
	this.remote_address = remote_address;
}

	public String getWebsocket_url() {
	return websocket_url;
}

public void setWebsocket_url(String websocket_url) {
	this.websocket_url = websocket_url;
}



	public String getRepository_url() {
	return repository_url;
}

public void setRepository_url(String repository_url) {
	this.repository_url = repository_url;
}

	public String getPackageName_fixno() {
	return packageName_fixno;
}

public void setPackageName_fixno(String packageName_fixno) {
	this.packageName_fixno = packageName_fixno;
}



	/**
		 * 
		 */
		private static final long serialVersionUID = 1546870898675643534L;
	private DataSource ds = null;
	private boolean jecas = false;
	
	
	private Hashtable logiranja = new Hashtable(); /// logiranja, ip in datum
	
	private String defaultmail;
	private String mailserver;
    private String log_ics_napake;
    private String log_ics_napake_ime;
    private String lokacija_jspcopy_datotek;
	
	public String tese = "TO JE TEST REFERENCE";
////////////	/ narocila v obdelavi
	  private Hashtable ht = new Hashtable();

//	/ stevilo userjev
	  private Hashtable st_users=new Hashtable();
	  
	  private String casbuildjar = ""; /// cas kdaj je bil zbuildan jar , za kreacijo copy jspjev
	  
	  
	  


		public int getClient_check_interval() {
		return client_check_interval;
	}

	public void setClient_check_interval(int client_check_interval) {
		this.client_check_interval = client_check_interval;
	}

		public EntityManagerFactory getEntman() {
			return entman;
		}

		public void setEntman(EntityManagerFactory entman) {
			this.entman = entman;
		}



	public String getPersistenceName() {
			return persistenceName;
		}

		public void setPersistenceName(String persistenceName) {
			this.persistenceName = persistenceName;
		}


		  /// hashtable sifrantov list polja loceno po jsp strani
	public Hashtable cache = new Hashtable();
	  
	  
	  
	  public Hashtable getLogiranja() {
		return logiranja;
	}

	public void setLogiranja(Hashtable logiranja) {
		this.logiranja = logiranja;
	}

	public String getLokacija_jspcopy_datotek() {
		return lokacija_jspcopy_datotek;
	}

	public void setLokacija_jspcopy_datotek(String lokacija_jspcopy_datotek) {
		this.lokacija_jspcopy_datotek = lokacija_jspcopy_datotek;
	}

	public String getCasbuildjar() {
		return casbuildjar;
	}

	public void setCasbuildjar(String casbuildjar) {
		this.casbuildjar = casbuildjar;
	}

	
	    public String getLog_ics_napake_ime()
	    {
	        return log_ics_napake_ime;
	    }

	    public void setLog_ics_napake_ime(String log_ics_napake_ime)
	    {
	        this.log_ics_napake_ime = log_ics_napake_ime;
	    }
	    
	    
	    public String getLog_ics_napake()
	    {
	        return log_ics_napake;
	    }

	    public void setLog_ics_napake(String log_ics_napake)
	    {
	        this.log_ics_napake = log_ics_napake;
	    }
	    
	    
	    public Vector getLog_datoteke(String lokacija_datotek, String ime_datotek)
	    {
	        Vector ve = new Vector();
	        try
	        {
	            int zx = 0;
	            File dir = new File(lokacija_datotek);
	            String fileti[] = dir.list();
	            for(int h = 0; h < fileti.length; h++)
	                if(fileti[h].toString().indexOf("log") != -1 && fileti[h].toString().startsWith(ime_datotek))
	                {
	                    ve.add(zx, fileti[h]);
	                    zx++;
	                }

	        }
	        catch(Exception ex)
	        {
	            System.out.println((new StringBuilder()).append("Napaka pri branju filov: ").append(ex.toString()).toString());
	        }
	        return ve;
	    }
	    public StringBuffer getLog_napake(String log_datoteka)
	    {
	        StringBuffer sb = new StringBuffer();
	        try
	        {
	            FileInputStream fstream = new FileInputStream(log_datoteka);
	            DataInputStream in = new DataInputStream(fstream);
	            BufferedReader br = new BufferedReader(new InputStreamReader(in));
	            String strLine;
	            while((strLine = br.readLine()) != null) 
	                sb.append((new StringBuilder()).append(strLine).append("\r\n").toString());
	            in.close();
	        }
	        catch(Exception ecm)
	        {
	            System.out.println((new StringBuilder()).append("Napaka pri branju log datoteke: ").append(ecm.toString()).toString());
	        }
	        return sb;
	    }
	    
	    
	    

	 
	  public conPool() {
	      try {
	    	
////	/ variabile iz txt fila
	this.doit();
this.getIPs();
	


/// transaction entity manager factory
try {
	
	
	if (this.getPersistenceName()!=null && !this.getPersistenceName().equals("")) {
entman = Persistence.createEntityManagerFactory( this.getPersistenceName() );
	}
	}
catch (Exception exo) {
	System.out.println("Entitymanagerfactory za nosql je null (ne najdem persistence.xml ali se ne uporablja nosql) "+exo.toString());
	exo.printStackTrace();
}


	    }
	    catch (Exception ex) {
	      System.out.println("exception: " + ex.toString());
	    }

	  }


public void setCas(ServletContext servletContext) {
	if (!jecas) {
	 // casovna_kontrola cas = new casovna_kontrola();
	  //cas.setCon(servletContext);
	  //cas.start();
	  jecas=true;
	}
}
	




public void zapisiLog(Log logger,String message) {
	try {
		
	logger.error(message);
	}
	catch (Exception ex) {
		System.out.println("Napaka zapisovanja loga: "+ex.toString());
	}
	
	
}







//public boolean soPrevodi_admin=false;
private Hashtable prevodi_admin = new Hashtable();
private Hashtable prevodi_admin_id = new Hashtable();


public synchronized void setPrevode_admin(ContextUtil contextUtil,ServletContext servletContext ) {
	
	try {
		
		com.popultrade.dao.PrevodiDAO daol = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",servletContext);
		List lio = daol.getPrevodis();
		
		Iterator itm = lio.iterator();
		
	//	System.out.println("prevod size: "+lio.size());
		
		while (itm.hasNext()) {
			
			com.popultrade.model.Prevodi prev = (com.popultrade.model.Prevodi)itm.next();
		//	System.out.println("PREV: "+prev.getPrevod_id()+prev.getVrsta()+prev.getSifra_jez()+" ::: "+prev.getPrevod()==null?"":prev.getPrevod() );
			prevodi_admin.put(prev.getPrevod_id()+prev.getVrsta()+prev.getSifra_jez(), prev.getPrevod()==null?"":prev.getPrevod());
			prevodi_admin_id.put(prev.getPrevod_id()+"",prev.getId()+"");
		}
		
		
		
		
		
	}
	catch (Exception ex) {
		System.out.println("Ne dobim prevodov:"+ex.toString());
	}
	
	
}
public synchronized String getPrevod_admin_id(String idd) {
	
	if (prevodi_admin_id.containsKey(idd)) {
		return (String)prevodi_admin_id.get(idd);
	}
	return "";
}

public synchronized String getPrevod_admin(String key,String vrsta,String jezik) {
	try {
	
		if (this.prevodi_admin.containsKey(key+vrsta+jezik)) {
			return (String)this.prevodi_admin.get(key+vrsta+jezik);
		}
		
	}
	catch (Exception ex) {
		System.out.println("Ne dobim single prevoda admin:" + ex.toString());
		
	}
	return "";
}





public String gP(String key)
{
    try
    {
        if(prevodi.containsKey(key))
            return replaceXMLchar(((String)prevodi.get(key)).replaceAll("_"," ")).replaceAll(" ","&#160;");
    }
    catch(Exception ex)
    {
        System.out.println((new StringBuilder()).append("Ne dobim single prevoda:").append(ex.toString()).toString());
    }
    return "";
}
public String gP2(String key)
{
    try
    {
        if(prevodi.containsKey(key))
            return replaceXMLchar(((String)prevodi.get(key)).replaceAll("_"," "));
    }
    catch(Exception ex)
    {
        System.out.println((new StringBuilder()).append("Ne dobim single prevoda:").append(ex.toString()).toString());
    }
    return "";
}



private String replaceXMLchar(String ch) {
//   return ch.replaceAll("\"","\\\"").replaceAll("\'","&apos;").replaceAll("&","&amp;").replaceAll("<","&amp;").replaceAll(">","&gt;");

ch = ch.replaceAll("\"","\\\"");
// ch = ch.replaceAll("\'","&apos;");
ch = ch.replaceAll("&","&amp;");
ch = ch.replaceAll("<","&amp;");
ch = ch.replaceAll(">","&gt;");

return ch;
}



public synchronized void setPrevod_admin(String key,String vrsta,String jezik,String prevod,String idd) {
	try {
	
		//if (!this.prevodi_admin.containsKey(key+vrsta+jezik)) {
			prevodi_admin.put(key+vrsta+jezik, prevod);
			prevodi_admin_id.put(key,idd);
	//	}
		
	}
	catch (Exception ex) {
		System.out.println("Ne moram setat single prevoda admin:" + ex.toString());
		
	}

}











public boolean soPrevodi=false;
private Hashtable prevodi = new Hashtable();






public void setPrevode(ContextUtil contextUtil,ServletContext servletContext ) {
	
	try {
		
		com.popultrade.dao.PrevodiDAO daol = (com.popultrade.dao.PrevodiDAO)contextUtil.getBeanDao("prevodiDAO",servletContext);
		List lio = daol.getPrevodis();
		
		Iterator itm = lio.iterator();
		
	//	System.out.println("prevod size: "+lio.size());
		prevodi.clear();
		while (itm.hasNext()) {
			
			com.popultrade.model.Prevodi prev = (com.popultrade.model.Prevodi)itm.next();
		//	System.out.println("PREV: "+prev.getPrevod_id()+prev.getVrsta()+prev.getSifra_jez()+" ::: "+prev.getPrevod()==null?"":prev.getPrevod() );
			prevodi.put(prev.getPrevod_id()+prev.getVrsta()+prev.getSifra_jez(), prev.getPrevod()==null?"":prev.getPrevod());
			prevodi_admin.put(prev.getPrevod_id()+prev.getVrsta()+prev.getSifra_jez(), prev.getPrevod()==null?"":prev.getPrevod());
			prevodi_admin_id.put(prev.getPrevod_id()+"",prev.getId()+"");
		}
		
		
		
		//this.setPrevode_admin(contextUtil, servletContext);
		this.setTableNames(contextUtil, servletContext);
		
	}
	catch (Exception ex) {
		System.out.println("Ne dobim prevodov:"+ex.toString());
	}
	
	
}


public Hashtable table_names = new Hashtable(); /// imena tabel v hibernate in v bazi, za avtomatsko update iz tabele gt1dbchange preko websocketov

private void setTableNames(ContextUtil contextUtil,ServletContext servletContext) {
	
	try {
		
		com.popultrade.dao.TemplateTablesDAO daol = (com.popultrade.dao.TemplateTablesDAO)contextUtil.getBeanDao("templateTablesDAO",servletContext);
		List lio = daol.getTemplateTabless(null);
		
		Iterator itm = lio.iterator();
		
	//	System.out.println("prevod size: "+lio.size());

		while (itm.hasNext()) {
			
			com.popultrade.model.TemplateTables prev = (com.popultrade.model.TemplateTables)itm.next();
		//	System.out.println("PREV: "+prev.getPrevod_id()+prev.getVrsta()+prev.getSifra_jez()+" ::: "+prev.getPrevod()==null?"":prev.getPrevod() );
			
			if (prev.getTable_name_hibernate()!=null && !prev.getTable_name_hibernate().equals("")) {
			table_names.put(prev.getTable_name().toLowerCase(), prev.getTable_name_hibernate());
			}
			else {
				table_names.put(prev.getTable_name().toLowerCase(), prev.getTable_name());	
			}
			
		}
		
		
	}
	catch (Exception ex) {
		System.out.println("Ne dobim imena tabel :"+ex.toString());
	}
}


/// dobim query string za poslat naprej
public String getQueryStringFromRequest(HttpServletRequest request) {
	
	String rett = "";
	try {
		
		Enumeration um = request.getParameterNames();
		
		while (um.hasMoreElements()) {
			
			String na = (String)um.nextElement();
			
			rett += "&"+na+"="+request.getParameter(na);
			
		}
		
		
		
	}
	catch (Exception exc) {
		
	}
	
	return rett;
	
	
}






public String getPrevod(String key) {
	try {
	
		if (this.prevodi.containsKey(key)) {
			return (String)this.prevodi.get(key);
		}
		
	}
	catch (Exception ex) {
		System.out.println("Ne dobim single prevoda:" + ex.toString());
		
	}
	return "";
}





	public synchronized void st_users_plus(String usersifra_prijava,String user) {
	  try {
	  this.st_users.put(usersifra_prijava,user);
	  }
	  catch (Exception ex) {
	    System.out.println("Ne moram pristeti userja! "+ex.toString());
	  }
	}

	public void st_users_minus(String usersifra_prijava) {
	  try {
	    if (st_users.containsKey(usersifra_prijava)) {
	      this.st_users.remove(usersifra_prijava);
	    }
	  }
	  catch (Exception ex) {
	    System.out.println("Ne moram odsteti userja! "+ex.toString());
	  }
	}

	public String get_st_users_prijavljenih() {
	return ""+  this.st_users.size();
	}

//////////////	/ imam vsa narocila, ki so v obdelavi

////	 dam v tabelo stevilko narocila in userja

	  public synchronized boolean narociloVObdelavi(String stnarocila,String user,String sifracompany) {
	    try {
	      if (!ht.containsKey(stnarocila)) {
	      //  ht.put(stnarocila,new podatkiObdelave(user,sifracompany));
	        System.out.println("dodano v tabelo narocil v obdelavi: "+stnarocila+" user: "+user);
	      }
	      else {
	        System.out.println("uporabnik ze obdeluje narocilo: "+stnarocila+" user: "+user);
	      }
	    }
	    catch (Exception ex) {
	      System.out.println("Napaka pri dodajanju v tabelo nrocil v uporabi. ConPool");
	    return false;
	    }

	  return true;
	  }

////	 brisem iz tabele narocilo na podlagi stevilke narocila

	  public synchronized boolean narociloNiVecVObdelavi(String stnarocila) {

	    try {
	Enumeration en = ht.keys();
	String ele = "";
	while (en.hasMoreElements()) {
	  ele = en.nextElement().toString();
	  if (ele.equals(stnarocila)) {
	    ht.remove(stnarocila);
	    System.out.println("Narocilo: "+stnarocila+" ni vec v obdelavi!");
	  }
	}
	}
	catch (Exception ex) {
	  System.out.println("Napaka pri brisanju narocila v obdelavi iz sistema. ConPool");
	return false;
	}
	    return true;
	  }


////	 brisem iz tabele vsa narocila, ki obdeluje user

	  public synchronized boolean userNeObdelujeVec(String user) {
	   // System.out.println("EEEEEELLLLLLLLEEEEEEE1111");

	    return true;
	  }


////////////	 dobim hashtabelo z narocili v obdelavi

	  public Hashtable getNarocilaVObdelavi() {
	    return this.ht;
	  }

//////	/ kontrola, ce ima to stevilko narocila in tega userja

	  public boolean chkObdelavo(String stnarocila,String user){

	 
	    return false;
	  }






	public synchronized boolean removeUser() {
	  try {
	  if (ds!=null) {

	 // conn.close();
	  return true;
	  }
	  else {
	    return false;
	  }
	  }
	  catch (Exception ex) {
	  System.out.println("Ne dobim povezave> "+ex.toString());
	    return false;
	}
	  }

//////////////////	/ dobim parametre iz txt fila

	  private void doit() {
		  
		  
	   try{
	     Properties p = new Properties();
//	     p.load(new FileInputStream("/var/tomcat4/bin/trgovina_mehano.ini"));
	     p.load(new FileInputStream("popultrade.ini"));
	     ///// porta
	     
	     this.setDefaultmail(p.getProperty("defaultmail"));
	     this.setMailserver(p.getProperty("mailserver"));
	   this.setLokacija_jspcopy_datotek(p.getProperty("lokacija_copyclass_jsp"));
	   
	   this.setPersistenceName(p.getProperty("persistence_name"));
	   this.setPackageName_fixno(p.getProperty("packageName_fixno"));
	   /// lokacija repository
	   this.setRepository_url(p.getProperty("repository_url"));
	 
	   this.setWebsocket_url(p.getProperty("websocket_url"));
	   
	   this.setRemote_address(p.getProperty("remote_address"));
	   
	   this.setApplication_url(p.getProperty("application_url"));
	   
	   try {
	   this.setClient_check_interval(Integer.parseInt(p.getProperty("client_check_interval").trim()));
	   }
	   catch (Exception emo) {
		   System.out.println("Error cant set: client_check_interval "+emo.toString()+". Setting to default 60s.");
		   this.setClient_check_interval(60);
		   this.setNum_send_files_simultaneus(5);
	   }
	   
	   try {
		this.setNum_send_dir_simultaneus(Integer.parseInt(p.getProperty("num_send_dir_simultaneus").trim()));
		this.setNum_send_files_simultaneus(Integer.parseInt(p.getProperty("num_send_files_simultaneus").trim()));
	   }
	   catch (Exception emo) {
		   System.out.println("Error cant set: num_send_dir_simultaneus or num_send_files_simultaneus "+emo.toString() + ". Setting to default 3 and 5.");
		   this.setNum_send_dir_simultaneus(3);
		   this.setNum_send_files_simultaneus(5);
	   }
	   
	   
	   try {
		this.setNum_send_dir_simultaneus_op(Integer.parseInt(p.getProperty("num_send_dir_simultaneus_op").trim()));
		this.setNum_send_files_simultaneus_op(Integer.parseInt(p.getProperty("num_send_files_simultaneus_op").trim()));
		
	   }
	   catch (Exception emo) {
		   System.out.println("Error cant set: num_send_dir_simultaneus_op options or num_send_files_simultaneus_op options "+emo.toString() + ". Setting to default 3 and 5.");
		   this.setNum_send_dir_simultaneus_op(3);
		   this.setNum_send_files_simultaneus_op(5);
	   }
	   try {
			this.setOption_check_interval(Integer.parseInt(p.getProperty("option_check_interval").trim()));
		
			
		   }
		   catch (Exception emo) {
			   System.out.println("Error cant set: Option_check_interval "+emo.toString() + ". Setting to default 90 sec.");
			   this.setOption_check_interval(90);
			  
		   }
	   
	     deleteOldFiles(p);
	     
	     
	     }
	   catch (Exception e) {
	     System.out.println(e);
	     }
	   

	   
	   
	   

	   }

	  
	  //// brisem datoteke ki kopirajo bean-e
	  private void deleteOldFiles(Properties ppo) {
		  
		   //// dobim cas zadnjega builda jara
		   
		   try{
			 String  lokjar = ppo.getProperty("lokacija_jar");
			     
			     if (lokjar==null || lokjar.equals("")) {
			    	 throw new Exception("Napaka: ni lokacije jar datoteke v parametrih!!!! (popultrade.ini)");
			     }
			   
			   
			   
			   File fi=new File("popultradejar.ini");
			   
			   if (!fi.exists()) {
				   fi.createNewFile();
			   }
			   
			     Properties p = new Properties();
//			     p.load(new FileInputStream("/var/tomcat4/bin/trgovina_mehano.ini"));
			     p.load(new FileInputStream("popultradejar.ini"));
			  //  String casbuildjar = "";
			     if (p.getProperty("casbuildjar")!=null && !p.getProperty("casbuildjar").equals("")) {
			    	 casbuildjar=p.getProperty("casbuildjar");
			    	 
			     }
			     
			     /// cas zadnjega builda
			     JarFile jf = new JarFile(lokjar);
			     ZipEntry manifest = jf.getEntry("META-INF/MANIFEST.MF");
			     long manifestTime = manifest.getTime();  //v millis
			     
			     
			     //// brisem vse datoteke, ce imajo star cas in setam nov
			     if (!casbuildjar.equals(manifestTime+"")) {
			    	 
			    	 
			    	 if (!casbuildjar.equals("")) {
			    		// casbuildjar = manifestTime+"";
			    		 /// lokacija posebnih datotek iz config file -- celoten path z "/" na koncu
			    		 File folder = new File(ppo.getProperty("lokacija_copyclass_jsp"));
			    		 File[] listOfFiles = folder.listFiles();

			    		 for (File file : listOfFiles) {
			    		     if (file.isFile()) {
			    		        if (file.getName().indexOf(casbuildjar)!=-1) {
			    		        	file.delete();
			    		        }
			    		     }
			    		 }
			    		 
			    		 
			    		 
			    	 }
			    	 
			    	 
			    	 
			    	 casbuildjar = manifestTime+"";
			    	 
			    	 p.remove("casbuildjar");
			    	 p.setProperty("casbuildjar", casbuildjar);
			    	 p.store(new FileOutputStream(fi), "");
			    	 
			    	 
			    	 
			     }
			     
			 
			     }
			   catch (Exception e) {
			     System.out.println(e);
			     }
		  
	  }
	  
	  
	  
	  
	  

	/**
	 * @return the defaultmail
	 */
	public String getDefaultmail() {
		return defaultmail;
	}


	/**
	 * @param defaultmail the defaultmail to set
	 */
	public void setDefaultmail(String defaultmail) {
		this.defaultmail = defaultmail;
	}


	/**
	 * @return the mailserver
	 */
	public String getMailserver() {
		return mailserver;
	}


	/**
	 * @param mailserver the mailserver to set
	 */
	public void setMailserver(String mailserver) {
		this.mailserver = mailserver;
	}



	public Hashtable ipji = new Hashtable();


//////////ipji za dostop

public void getIPs() {
try {
Properties p = new Properties();

p.load(new FileInputStream("popultrade_ipji.txt"));


Enumeration en  = p.keys();

while (en.hasMoreElements()) {
	  String next = (String)en.nextElement();
	  System.out.println("Dodam ip v listo: "+next);
	  ipji.put(next, (String)p.getProperty(next));
	  
	  
}



}
catch (Exception ex) {
	System.out.println("Ne najdem datoteke z ipji za log! "+ex.toString());
}

}








//// insert v mongodb

private CreateLogFromClass clfc = new CreateLogFromClass();

public synchronized boolean addToNoSql(Object clasn,conPool ConPool,String status,String description,control contro,String type) {
	
	try {
		//EntityManagerFactory  entityManagerFactory = ConPool.getEntman(); //Persistence.createEntityManagerFactory( "com.popultrade.pers" );
		
		
		
		
		System.out.println("A---------------------------------- 2");	
		EntityManager entityManager = entman.createEntityManager();
		System.out.println("A---------------------------------- 3");	
		entityManager.getTransaction().begin();
		
		
		com.popultrade.model.LogAll logm = new com.popultrade.model.LogAll();
		logm.setDatee(new Date());
		if (contro.getPodjetje()!=null && !contro.getPodjetje().equals("")) {
		logm.setCompany_log(contro.getPodjetje());
		}
		
		if (status!=null && !status.equals("")) {
			logm.setStatus(status);
			}
		if (contro.getUserName()!=null && !contro.getUserName().equals("")) {
			logm.setUser_log(contro.getUserName());
			}
		if (clasn!=null) {
			logm.setDescription(clfc.getClassContent(clasn));
		}
		else if (description!=null && !description.equals("")) {
			logm.setDescription(description);
		}

		if (type!=null && !type.equals("")) {
			logm.setType(type);
			}
		entityManager.persist(logm);
		
		entityManager.getTransaction().commit();

		entityManager.close();
		
		//entityManager.createNativeQuery("").getSingleResult()
		
		
	}
	catch (Exception ex) {
		System.out.println("error inserting into MongoDB: "+ex.toString());
		return false;
	}
	
	return true;
	
	

	//return clfc.addToNoSql(clasn, ConPool, status, description, contro, type);
	
}





public static String extractPageNameFromURLString(String urlString){
    if (urlString==null) return null;
    int lastSlash = urlString.lastIndexOf("/");
    //if (lastSlash==-1) lastSlash = 0;
    String pageAndExtensions = urlString.substring(lastSlash+1);
    int lastQuestion = pageAndExtensions.lastIndexOf("?");
    if (lastQuestion==-1) lastQuestion = pageAndExtensions.length();
    String result = pageAndExtensions.substring(0,lastQuestion);
    return result;
}













///////// send mails



private Properties props = new Properties();



private boolean sendMail(String mails,String pmmail,String subject,String body,com.popultrade.webapp.conPool ConPool) {
	
	try {

	 
	 Session sessione = Session.getDefaultInstance(props, null);
	
	
	
	
	
	
	
      Message msg = new MimeMessage(sessione);
      msg.setFrom(new InternetAddress(ConPool.getDefaultmail(), "popultrade "));
      msg.addRecipient(Message.RecipientType.TO,
                      new InternetAddress(pmmail));

      msg.addRecipients(Message.RecipientType.CC, 
                      InternetAddress.parse(mails));
      
      
      msg.setSubject(subject);
    

    msg.setContent(body, "text/html; charset=utf-8");
    
    Transport.send(msg);
	
	return true;
	}
	catch (Exception exmo) {
		System.out.println("Error in sending mails!!! "+exmo.toString());
		org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
		log.error(exmo.toString());
		return false;
	}
	

	
	
}










//////// end send mails



private Hashtable opispod = new Hashtable();



/// dobim opise podjetij

public String getOpispod(String ean,String podatek) {
	  
	  if (ean==null || podatek==null) {
		  return "";
	  }
	  
	try {
		
		if (this.opispod.containsKey(ean)) {
			
			OpisiPodjetij op = (OpisiPodjetij)this.opispod.get(ean);
			
			if (podatek.equals("naziv")) {
				return op.getNaziv();
			}
			if (podatek.equals("naslov")){
				return op.getNaslov();
			}
			if (podatek.equals("posta")){
				return op.getPosta();
			}
			if (podatek.equals("kraj")){
				return op.getKraj();
			}
			if (podatek.equals("tip")){
				return op.getTip();
			}
			if (podatek.equals("dza_sifra")){
				return op.getDza_sifra();
			}
			if (podatek.equals("ddv")){
				return op.getDdv();
			}
			if (podatek.equals("maticna")){
				return op.getMaticna();
			}
		}
		
		
	}
	catch (Exception ex) {
		System.out.println("Ne dobim opisa podajtja: "+ex.toString());
	}
	  
	  return "";
	  
}





















	}


