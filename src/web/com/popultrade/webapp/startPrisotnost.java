package com.popultrade.webapp;



import java.util.*;
import java.sql.*;


public class startPrisotnost extends Thread   {


  /**
	 * 
	 */
	private static final long serialVersionUID = 4335467687655757501L;

private boolean star = false;

  private kontrolaPrisotnosti am=null;




public startPrisotnost(kontrolaPrisotnosti kp) {
am = kp;
}


public void run() {

this.vrti();

}

public void vrti() {
  casPrisotnosti cpp=null;
  

  while (true) {
try {

if (!star) {
  //// startam socket flasha, dam mu parameter porte in referenco na conpool
   cpp=new casPrisotnosti();

star=true;
}
  System.out.println("test1_prisotnost");
  this.sleep(30000);
  cpp.brisiPretekelCas(am);
  System.out.println("test2_prisotnost");
  

  
  
}
catch (Exception ex) {
  System.out.println(ex.toString());
}
}
}





}

