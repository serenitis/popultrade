package com.popultrade.model;

import java.lang.reflect.Method;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

public class CreateLogFromClass {

	public synchronized String getSearchFromClass(Object clasn ) {
		StringBuffer sb = new StringBuffer();
		
		try {
			 
			// get the Class
	       //  Class thisClass = Class.forName(clasn);
	         // get an instance 
	        
	    
			
		   Class testClass = clasn.getClass();
		   Class params[] = {};
		 //  Object iClass = testClass.newInstance();
		   
           Method methods[] = testClass.getDeclaredMethods();
           Method arr$[] = methods;
           
           Hashtable zeje = new Hashtable();
           int len$ = arr$.length;
           boolean prvi=true;
           for(int i$ = 0; i$ < len$; i$++)
           {
        	   
        	//   System.out.println("ISCEM 111");
               Method method = arr$[i$];
               if(method.getName() != null && method.getName().startsWith("get")) {
                 
            	  // System.out.println("ISCEM 111 :"+method.getName());
            	   //metode.put(method.getName(), (method.getReturnType()+""));
            	 try {
            		 
            		 String rt = method.getReturnType().toString();
            		 
            		 if (rt.indexOf("String")!=-1 || rt.indexOf("Integer")!=-1 || rt.indexOf("Long")!=-1 || rt.indexOf("Double")!=-1 || 
            				 rt.indexOf("Date")!=-1 || rt.indexOf("TimeStamp")!=-1) {

            		 
            		 Object rez=  method.invoke(clasn, params);
            		 
            		 if (rez!=null) {
            		 
            			 if (prvi) {
            				 sb.append("");
            				 prvi=false;
            			 }
            			 else {
            				 sb.append(",");
            			 }
            			 
              // System.out.println("Metoda::: "+method.getName()+" : "+rez);
//               sb.append("F: "+method.getName().replaceFirst("get", "")+" V: "+rez);
            			 if (rt.indexOf("String")!=-1) {
            				 String v=method.getName().replaceFirst("get", "").toLowerCase();
            				 if (v.equals("id")) {
            					 v = "_id";
            				 }
            				 
            			 sb.append("'"+v+"':'"+rez+"'");
            			 }
            			 else if (rt.indexOf("Date")!=-1 && method.getName().endsWith("1")) {
                			 sb.append("'"+method.getName().replaceFirst("get", "").toLowerCase()+"':{$gte: ISODate('"+rez+"')");
                			 
                			 Method method2 = testClass.getMethod(method.getName().substring(0,method.getName().length()-1)+"2");
                			 boolean jek = false;
                			 if (method2!=null)  {
                				 Object rex = method2.invoke(clasn, params);
                				 
                				 if (rex!=null) {
                					 jek=true;
                					 sb.append(",$lte: ISODate('"+rex+"')}");
                					 zeje.put(method.getName(), "");
                				 }
                				 
                			 }
                			 if (!jek) {
                				 sb.append("}");
                			 }

            			 }
            			 else if (rt.indexOf("Date")!=-1 && method.getName().endsWith("2") && !zeje.containsKey(method.getName())) {
                			 sb.append("'"+method.getName().replaceFirst("get", "").toLowerCase()+"':{$lte: ISODate('"+rez+"')}");
            			 }
            			 else if (rt.indexOf("Date")!=-1 && !zeje.containsKey(method.getName())) {
                			 sb.append("'"+method.getName().replaceFirst("get", "").toLowerCase()+"':new ISODate('"+rez+"')");
            			 }
            			 else {
            				 
            				 String v=method.getName().replaceFirst("get", "").toLowerCase();
            				 if (v.equals("id")) {
            					 v = "_id";
            				 }
            				 
            				 sb.append("'"+v+"':'"+rez+"'"); 
            			 }
            		 }
               
            		 }
            	 }
            	 catch (Exception j) {
            		 System.out.println("Error getting classcontent (CreateLogFromClass) c "+j.toString());
            	 }
            	 }
               
           }
		}
		catch (Exception exo) {
			System.out.println("Error getting classcontent (CreateLogFromClass) "+exo.toString());
		}
		
		if (!sb.toString().equals("")) {
			sb.append("");
		}
		
		
		return sb.toString();
	}

	
	public synchronized String getClassContent(Object clasn) {
		StringBuffer sb = new StringBuffer();
		
		try {
			
			// get the Class
	       //  Class thisClass = Class.forName(clasn);
	         // get an instance 
	        
	    
			
		   Class testClass = clasn.getClass();
		   Class params[] = {};
		 //  Object iClass = testClass.newInstance();
		   
           Method methods[] = testClass.getDeclaredMethods();
           Method arr$[] = methods;
           int len$ = arr$.length;
           for(int i$ = 0; i$ < len$; i$++)
           {
               Method method = arr$[i$];
               if(method.getName() != null && method.getName().startsWith("get")) {
                 
            	 
            	   //metode.put(method.getName(), (method.getReturnType()+""));
            	 try {
            		 
            		 String rt = method.getReturnType().toString();
            		 
            		 if (rt.indexOf("String")!=-1 || rt.indexOf("Integer")!=-1 || rt.indexOf("Long")!=-1 || rt.indexOf("Double")!=-1 || 
            				 rt.indexOf("Date")!=-1 || rt.indexOf("TimeStamp")!=-1) {

            		 
            		 Object rez=  method.invoke(clasn, params);
            		 
            		 if (rez!=null) {
            		 
             //  System.out.println("Metoda::: "+method.getName()+" : "+rez);
               sb.append("F: "+method.getName().replaceFirst("get", "")+" V: "+rez);
            		 }
               
            		 }
            	 }
            	 catch (Exception j) {
            		 
            	 }
            	 }
               
           }
		}
		catch (Exception exo) {
			System.out.println("Error getting classcontent (CreateLogFromClass) "+exo.toString());
		}
		
		return sb.toString();
	}
	
	
	/*
	
	/// dam v bazo
	public synchronized boolean addToNoSql(Object clasn,conPool ConPool,String status,String description,control contro,String type) {
		
		
		try {
			EntityManagerFactory  entityManagerFactory = ConPool.getEntman(); //Persistence.createEntityManagerFactory( "com.popultrade.pers" );
			
			
			
			
			System.out.println("A---------------------------------- 2");	
			EntityManager entityManager = entityManagerFactory.createEntityManager();
			System.out.println("A---------------------------------- 3");	
			entityManager.getTransaction().begin();
			
			
			com.popultrade.webapp.modelnosql.LogAll logm = new com.popultrade.webapp.modelnosql.LogAll();
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
				logm.setDescription(this.getClassContent(clasn));
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
			
			
			
			
		}
		catch (Exception ex) {
			System.out.println("error inserting into MongoDB: "+ex.toString());
			return false;
		}
		
		return true;
		
		
	}
	*/
	

}
