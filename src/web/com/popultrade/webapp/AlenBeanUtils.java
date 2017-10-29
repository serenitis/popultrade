package com.popultrade.webapp;


import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.Converter;



//// clasa za konverzijo Long value vrednosti v null ne pa v 0 kot pri defaultu, potrebno za insert dao objektov

public class AlenBeanUtils extends BeanUtils implements Converter,java.io.Serializable  {

	


	/**
	 * 
	 */
	private static final long serialVersionUID = 4568654543644334531L;

	public Object convert(Class arg0, Object arg1) {
		// TODO Auto-generated method stub
		
		if (arg1==null) {
			return null;
		}
		else if (((String)arg1).equals("")) {
			System.out.println("je prazno!!!!");
			return null;
		}
		else {
			try {
			long lon = Long.parseLong(arg1.toString());
			
			if (lon==0) {
				return null;
			}
			else {
				System.out.println("NI null");
				
				return new Long(lon);
			}
			}
			catch (Exception ex) {
				System.out.println(ex.toString() +" error alen class");
			}
		}
		
		
		
		return null;
	}
	
	
	
	
	
}

