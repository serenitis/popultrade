package com.popultrade.webapp;


import java.util.Properties;
import java.io.FileInputStream;



public class Parametri  implements java.io.Serializable {

/**
	 * 
	 */
	private static final long serialVersionUID = 5476864363464364331L;
private String path = "popultrade.ini";
  
public  Parametri() {
}

public  Parametri(String path) {
this.path = path;
}
 public Properties getParametri() {
   try {
     Properties p = new Properties();
     p.load(new FileInputStream(path));

     return p;

     } 
   catch (Exception e) {
     System.out.println(e);
   // throw new Exception("Ne najdem lokacije datoteke s parametri - popultrade 2");
     }

 return null;
   }

}
