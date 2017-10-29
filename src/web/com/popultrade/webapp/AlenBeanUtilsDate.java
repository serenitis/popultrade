package com.popultrade.webapp;


	import java.text.SimpleDateFormat;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.Converter;



////	 clasa za konverzijo Long value vrednosti v null ne pa v 0 kot pri defaultu, potrebno za insert dao objektov

	public class AlenBeanUtilsDate extends BeanUtils implements Converter,java.io.Serializable  {

		


		/**
	 * 
	 */
	private static final long serialVersionUID = 6867674645454423441L;

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
					
					SimpleDateFormat formatter=null;
					if (arg1.toString().length()<=10) {
					formatter = new SimpleDateFormat ("dd-MM-yyyy");
					}
					else {
						formatter = new SimpleDateFormat ("dd-MM-yyyy HH:mm");	
					}
					System.out.println("Parsan date: " + formatter.parse(arg1.toString()));
				return	formatter.parse(arg1.toString());
					//return formatter.format(dt);
			
				}
				catch (Exception ex) {
					System.out.println(ex.toString() +" error alen class");
				}
			}
			
			
			
			return null;
		}
		
		
		
		
		
	}



