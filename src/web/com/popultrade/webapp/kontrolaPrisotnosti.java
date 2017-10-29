package com.popultrade.webapp;


import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class kontrolaPrisotnosti  implements java.io.Serializable {
  /**
	 * 
	 */
	private static final long serialVersionUID = 1658789776554364646L;
///// vnos narocil v obdelavi
  public Hashtable users = new Hashtable();
//// veza na web socket client
  private WebSocketClient wsc = null;

  

  
  
  //// datum zadnjega klica update
  private Date lastupdate=new Date();
  
  
  public void setWSUrl(String urllws) {
		if (wsc==null) {
			wsc = new WebSocketClient(urllws);
		}
  }
  
/// updatam iz db

public synchronized boolean updateFromDB() {
	
	
	
	/// vsako minuto
	
	//System.out.println("CCCCCCCCCCCCCCCCCCC "+(((new Date()).getTime()- lastupdate.getTime())/(1000*60)));
	if ((((new Date()).getTime()- lastupdate.getTime())/(1000*60)) >= 1 ) {
		
		lastupdate = new Date();
		System.out.println(" Klicem update statusov v DB "+lastupdate);
		
	
		
		
		return true;
	
	}
	return false;
}

  
  
  
  
  
  
  
  
  
  

public kontrolaPrisotnosti() {
  //// startam threat
  startPrisotnost sp=new startPrisotnost(this);
  sp.start();
} 

//// posljem message na ws
public void sendMessageToWS(String message) {
	
	
	
	try {
	
		if (message.equals("keepalive")) {
			
			wsc.sendMessage("keepalive");
		}
		else {
		wsc.sendMessage(message);
		}
	}
	catch (Exception exc) {
		System.out.println("Napaka posiljanja sporocila na websocket prisotnost: "+exc.toString());
	}
}
public synchronized boolean addUserNarocilo(String user, String idnarocila,
        Date dat, int dodaj,String classname,String user_login,String company) {
	
	System.out.println("------------------------ z1");
	return addUserNarocilo(user,idnarocila,dat,dodaj,classname,user_login,company,"");
}
public synchronized boolean addUserNarocilo(String user, String idnarocila,
        Date dat, int dodaj,String classname,String user_login,String company,String pagename) {
	  if (dodaj == 4) {
	        ///// removam dokument v obdelavi na podlagi username in updatam polja na listu
	      	removeDocuments(user);
	      	 sendMessageToWS(user+":-:"+idnarocila+":-:4:-:"+classname+":-:"+scramble(user_login)+":-:"+scramble(company)+":-:"+pagename);
	      	return true;
	          
	      }
	    else if (dodaj == 5) {
	        ///// removam dokument v obdelavi na podlagi username in dodam polja na listu
	      	removeDocuments(user);
	      	sendMessageToWS(user+":-:"+idnarocila+":-:5:-:"+classname+":-:"+scramble(user_login)+":-:"+scramble(company)+":-:"+pagename);
	      	return true;
	          
	      }
	    else if (dodaj == 6) {
	        ///// removam dokument
	      	removeDocuments(user);
	      	sendMessageToWS(user+":-:"+idnarocila+":-:6:-:"+classname+":-:"+scramble(user_login)+":-:"+scramble(company)+":-:"+pagename);
	      	return true;
	          
	      }
	    else if (dodaj == 9) {
	        ///// removam dokument za rocno logiko, ignorira pogoj za userja
	      	removeDocuments(user);
	      	sendMessageToWS(user+":-:"+idnarocila+":-:9:-:"+classname+":-:"+scramble(user_login)+":-:"+scramble(company)+":-:"+pagename);
	      	return true;
	          
	      }
	return false;
}


  public synchronized boolean addUserNarocilo(String user, String idnarocila,
                                           Date dat, int dodaj,String pagename) {

    if (dodaj == 1) {
      ///// dodam narocilo v status obdelave, ce ni v obdelavi
      if (!users.containsKey(idnarocila)) {
        users.put(idnarocila, new prisotnostPodatki(user, dat, idnarocila));
      System.out.println("Dokument : " + idnarocila + " v obdelavi. User:" +
                         user);
      sendMessageToWS(user+":-:"+idnarocila+":-:1"+":-:"+pagename);
      return true;
      }
      else {
        System.out.println("Dokument : "+idnarocila+" je ze v obdelavi!");
        return false;
      }


    }
//users.put()
    else if (dodaj == 2) {

      users.remove(idnarocila);
      ///// removano narocilo

      System.out.println("Dokument z id: " + idnarocila +
                         " ni vec v uporabi s strani userja: " + user);
      sendMessageToWS(user+":-:"+idnarocila+":-:2"+":-:"+pagename);
      return true;

    }
    else if (dodaj == 3) {
      ///// removam narocilo v obdelavi na podlagi username
    	removeDocuments(user);

    	return true;
        
    }
   
    
return false;
  }

  
  public synchronized void removeDocuments(String user) {
	  
      Enumeration en = users.keys();
      String um = "";
      prisotnostPodatki pp = null;
      while (en.hasMoreElements()) {
        um = en.nextElement().toString();

        if (users.containsKey(um)) {
          pp = (prisotnostPodatki) users.get(um);
          if (pp.user.equals(user)) {
            users.remove(um);
            sendMessageToWS(user+":-:"+um+":-:2");
            System.out.println("User: " + user + " ne obdeluje vec dokument!");
            break;

          }
        }

      }
	  
  }
  
  public synchronized String scramble(String vred) {
	  
	  String[] vs = {"c","s","d"};
	  
	  String ret = "";
	  if (vred==null || vred.equals("")) {
		  return "";
	  }
	 try {
		 int zak = 0;
		 for (int t=0;t<vred.length();t++) {
			 
			
			 
			 ret+=vred.substring(t,t+1)+vs[zak];
			
			 zak++;
			 if (zak==3) {
				 zak=0;
			 }
			 
		 }
		 return ret+ret;
		 
	 }
	 catch (Exception exo) {
		 System.out.println("error scrambling "+exo.toString());
	 }
	 return null;
	  
	  
  }
  
  

  ////// spreminjam datume

  public synchronized void spremeniDatum(String user) {

    Enumeration en = users.keys();
String um = "";
prisotnostPodatki pp = null;
while (en.hasMoreElements()) {
  um = en.nextElement().toString();

  if (users.containsKey(um)) {
    pp = (prisotnostPodatki) users.get(um);
    
  //  System.out.println("USERSAAA "+pp.user + " send "+user);
    if (pp.user.equals(user)) {
     // users.remove(um);
     pp.dt=new Date();
     System.out.println("User: " + user + " sprememba casa!");
      break;

    }
  }

}



  }

///// dobim id userja, ki je zaklenil record
public synchronized String getUserZaklenil(String idnaroc) {

	
	if (users.containsKey(idnaroc)) {
prisotnostPodatki pp = (prisotnostPodatki)users.get(idnaroc);
	
return pp.user;
	
	}
	return "NICCC";



}
///// kontrola, ce gre za isti user ki ima narocilo v obdelavi
  public synchronized boolean istiUserKontrola(String userr,String idnaroc) {

    prisotnostPodatki pp = (prisotnostPodatki)users.get(idnaroc);

    if (pp.user.equals(userr)) {
      return true;
    }
    return false;

  }






}
