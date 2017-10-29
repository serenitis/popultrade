package com.popultrade.webapp;


import java.util.Enumeration;
import java.util.Date;


public class casPrisotnosti implements java.io.Serializable {

  /**
	 * 
	 */
	private static final long serialVersionUID = 1463456345576575674L;


public casPrisotnosti() {






  }








  public synchronized void brisiPretekelCas(kontrolaPrisotnosti kp) {

    Enumeration en = kp.users.keys();
    String enn = "";
    prisotnostPodatki pp = null;
    Date dt = new Date();
    while (en.hasMoreElements()) {
      enn = en.nextElement().toString();
      if (kp.users.containsKey(enn)) {

        pp = (prisotnostPodatki)kp.users.get(enn);

        if (((dt.getTime()-pp.dt.getTime())/(1000*60))>2) {
          System.out.println("REMOVE: Uporabik: "+pp.user+" removan! Narocilo: "+pp.idnarocila +" Razlog: Potekel cas.");
          kp.users.remove(enn);
          
        kp.sendMessageToWS("ODPOVEZAN PREKO KONTROLE PRISOTNOSTI POTEKEL CAS ! "+enn);
        kp.sendMessageToWS(pp.user+":-:"+enn+":-:2");
        }
        else {
          System.out.println("UPORABNIK: Uporabnik: "+pp.user+" obdeluje narocilo: "+pp.idnarocila+" cas update: "+((dt.getTime()-pp.dt.getTime())/(1000*60)));
        }


      }




    }



  }



}

