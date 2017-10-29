
package com.popultrade.webapp;

import java.util.Date;
public class prisotnostPodatki  implements java.io.Serializable  {

/**
	 * 
	 */
	private static final long serialVersionUID = 1656554434343365545L;
public Date dt = null;
  public String user="";
public String idnarocila="";
public prisotnostPodatki(String user,Date datum,String idnar) {

  this.user=user;
  this.dt=datum;
  this.idnarocila=idnar;
}


}
