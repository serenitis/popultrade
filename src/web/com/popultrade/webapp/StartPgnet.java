package com.popultrade.webapp;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class Startpopultrade  extends Thread  implements java.io.Serializable  {



	  /**
		 * 
		 */
		private static final long serialVersionUID = 4335467682345757501L;

	private boolean star = false;

	public void run() {
	System.out.println("Start popultrade 1");
	this.vrti();
	System.out.println("Start popultrade 2");
	}


	public Startpopultrade() {

		//this.vrti();

		this.start();
		
	}
	int stevilo=0;
	public void vrti() {
	
	
		while (true) {
	
		
	//	while ( true) {
		try {
		//	this.sleep(10000); /// da se klice jsp page
		//	stevilo++;
			if (stevilo==0) {
			Parametri param = new Parametri();
			String urli = param.getParametri().getProperty("index_url")+"?stevilo="+stevilo;
			System.out.println("Start popultrade set clients ("+urli+") ...");
		    URL myURL = new URL(urli);
		    URLConnection myURLConnection = myURL.openConnection();
		    myURLConnection.connect();
		    myURLConnection.getContent();
		    stevilo++;
			}
			System.out.println("---------------------------------------------------------------------------------- 1");
			if (true) {
			Parametri param = new Parametri();
			String urli = param.getParametri().getProperty("index_url").replace("startpopultrade", "startpopultradeOption")+"?stevilo="+stevilo;
			System.out.println("Start popultrade set options response ("+urli+") ...");
		    URL myURL = new URL(urli);
		    URLConnection myURLConnection = myURL.openConnection();
		    myURLConnection.connect();
		    myURLConnection.getContent();
		    stevilo++;
			
			}
			System.out.println("---------------------------------------------------------------------------------- 2");
			/*if (true) {
			Parametri param = new Parametri();
			String urli = param.getParametri().getProperty("index_url")+"?stevilo="+stevilo;
			System.out.println("Start popultrade sender ("+urli+") ...");
		    URL myURL = new URL(urli);
		    URLConnection myURLConnection = myURL.openConnection();
		    myURLConnection.connect();
		    myURLConnection.getContent();
			}*/
		    /*
		    if (stevilo==25920) {
		    	stevilo=0;
		    }*/
		    
		    
		    
		    
		    
		    System.out.println("Start popultrade OK.");
		}
		catch (MalformedURLException e) { 
		    // new URL() failed
		    // ...
			System.out.println("Napaka start converzije: "+e.toString());
		} 
		catch (Exception e) {   
		    // openConnection() failed
		    // ...
			System.out.println("Napaka start converzije: "+e.toString());
		}
		//}
		
		
		try {
			sleep(35000);
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} /// da se zloada tomcat
		}
	}




}
