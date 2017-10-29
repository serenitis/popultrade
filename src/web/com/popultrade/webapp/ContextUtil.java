package com.popultrade.webapp;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class ContextUtil  implements java.io.Serializable {

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1980898786786545443L;
	private ServletContext servletContext;
	private WebApplicationContext ctx;
	
	
	public ContextUtil() {
		ConvertUtils.register(new AlenBeanUtils(),Long.class);
		ConvertUtils.register(new AlenBeanUtilsDate(),Date.class);
	}
	
	
	public Object getBeanDao(String daoname,ServletContext servletContext) {
		
		
		
		try {
		ctx = WebApplicationContextUtils.getWebApplicationContext(servletContext);	
			
		return ctx.getBean(daoname);
			
		}
		catch (Exception ex) {
			System.out.println("Erro in getting dao context: "+daoname + "  "+ex.toString());
		}
		return null;
		
	}
	
	/// cloniranje beana
	
	public Object cloneBean(Object ob) {
	
		try {
			
			return BeanUtils.cloneBean(ob);
			
		}
		catch (Exception er) {
			System.out.println("Napaka pri kloniranju beana: "+er.toString());
		}
		
		return null;
	
	}
	public Object getPopulatedObject(Object ob,HttpServletRequest request) {
		try {
			
			
			
			BeanUtils.populate(ob,request.getParameterMap());
			
			return ob;
		}
		catch (Exception ex) {
			System.out.println(ex.toString() +  "   error in populating with bean utils");
		}
		return null;
	}
	
	/// get bean utils
	
	public Object getPopulatedObject(Object ob,HttpServletRequest request, int kaj) {
		
		try {
			
			Map nw = new HashMap();
			  Map m=request.getParameterMap();
		        Set s = m.entrySet();
		        Iterator it = s.iterator();
		 
		            while(it.hasNext()){
		 
		                Map.Entry<String,String[]> entry = (Map.Entry<String,String[]>)it.next();
		 
		                String key             = entry.getKey();
		                String[] value         = entry.getValue();
		 
		          //      pw.println("Key is "+key+"<br>");
		 
		                    if(value.length>1){   
		                    	
		                        for (int i = 0; i < value.length; i++) {
		                        //    pw.println("<li>" + value[i].toString() + "</li><br>");
		                            
		                            value[i]=  escapeHTML(value[i].toString());
		                        }
		                        
		                        nw.put(key, value);
		                        
		                          
		                    }else
		                      //      System.out.println("Value is "+value[0].toString()+"");
		                //    System.out.println("Value esc is "+escapeHTML(value[0].toString()));
		                  //  pw.println("-------------------<br>");
		                    	value[0]=  escapeHTML(value[0].toString());
		                    nw.put(key, value);
		                    
		            }

			
			
			
			
			
			
			
			
			BeanUtils.populate(ob,nw);
			
			return ob;
		}
		catch (Exception ex) {
			System.out.println(ex.toString() +  "   error in populating with bean utils escape");
		}
		return null;
		//return BeanUtils;
	}
	
	private  String escapeHTML(String s) {
		
	
	    StringBuilder out = new StringBuilder(Math.max(16, s.length()));
	    for (int i = 0; i < s.length(); i++) {
	        char c = s.charAt(i);
	        if ( c == '<' || c == '>' || c == '"' ) {
	            out.append("&#");
	            out.append((int) c);
	            out.append(';');
	        } else {
	            out.append(c);
	        }
	    }
	    return out.toString();
	}
}
