package com.popultrade.webapp;


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.FutureTask;

import javax.servlet.ServletContext;




import org.apache.xml.security.utils.Base64;

import javax.xml.parsers.*;
import org.w3c.dom.*;

import com.popultrade.model.PgnClients;

import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.dom.*;




/// send files 
 public class RequestInfos {


	private PgnClients pgnclient;
	private ContextUtil contextUtil;
	private Pgnclientssendfromc pgns;
	private Pgnclientssendfromsrc pgnsrc;
	private ServletContext servletContext;
	private EncDecUtil encdec = new EncDecUtil();
	private chkNull nul = new chkNull();
	private com.popultrade.model.PgnLog logp = new com.popultrade.model.PgnLog();
	private AddToLog logadd = new AddToLog();
	private conPool ConPool=null;
	
	
	public RequestInfos(PgnClients tim,ContextUtil contextUtil,ServletContext servletContext,conPool ConPool ) {
		
		pgnclient=tim;
		this.contextUtil=contextUtil;
	
		this.servletContext=servletContext;
		this.ConPool=ConPool;
	}
	
	public String getRequestInfos()  {
		// TODO Auto-generated method stub
		
		try {
	
			return	createXML();
		
		}
		catch (Exception emo) {
			System.out.println("Error requesting info: "+emo.toString());
			return "Error requesting info: "+emo.toString();
		}
		
		//Thread.sleep(timm);
	//	return "";
		
	
	}


	
	
	public String createXML() throws ParserConfigurationException, Exception, TransformerException {
	
		
		
		try {
			
		
			
			/// new file name
			
			String newfilename = getDatumFormatFromDate(new Date(),"yyyyMMddHHmmss")+this.randomString(9);
			
			
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();

		DocumentBuilder db = dbf.newDocumentBuilder();
		DOMImplementation di = db.getDOMImplementation();

		Document doc =  di.createDocument("", "MESSAGE", null);
		
		
		Element Message = doc.getDocumentElement();

		Element HEADER = doc.createElement("HEADER");

		Element DOCUMENT_NAME = doc.createElement("DOCUMENT_NAME");
	    Text txt = doc.createTextNode("XMLENVELOPSE");

	    DOCUMENT_NAME.appendChild(txt);
		HEADER.appendChild(DOCUMENT_NAME);
		
		
		Element DOCUMENT_VERSION = doc.createElement("DOCUMENT_VERSION");
	     txt = doc.createTextNode("1.01");

	     DOCUMENT_VERSION.appendChild(txt);
		HEADER.appendChild(DOCUMENT_VERSION);
		
		
	Element DOCUMENT_CREATE = doc.createElement("DOCUMENT_CREATE");
	     txt = doc.createTextNode(getDatumFormatFromDate(new Date(),"dd-MM-yyyy HH:mm:ss"));
	     DOCUMENT_CREATE.appendChild(txt);
		HEADER.appendChild(DOCUMENT_CREATE);
		
		
		Element RECEIVER = doc.createElement("RECEIVER");
	     txt = doc.createTextNode(nul.jeNull(pgnclient.getClient_id()));
	     RECEIVER.appendChild(txt);
		HEADER.appendChild(RECEIVER);
		
		
	
		
		
		Element CLIENTID = doc.createElement("CLIENTID");
	     txt = doc.createTextNode(nul.jeNull(pgnclient.getClient_id()));
	     CLIENTID.appendChild(txt);
		HEADER.appendChild(CLIENTID);
		
	
		
		
		Element CRYPTTEXT = doc.createElement("CRYPTTEXT");
		
		
		
		
	     txt = doc.createTextNode(encdec.encrypt("PANTEON_GROUP", pgnclient.getClient_cryptcode(), true)); /// crypted PANTEON_GROUP
	     
	     
	     CRYPTTEXT.appendChild(txt);
		HEADER.appendChild(CRYPTTEXT);
		
		
		
	    
	     Message.appendChild(HEADER);
	     
	     
	     Element BODY = doc.createElement("BODY");
	     
	     Element CONTENT = doc.createElement("CONTENT");
	     
	
	     
	     txt = doc.createTextNode("OIINIUBIN32832982em3nrh3487cr2g34mr8324rg8342gncr834gr834g8rcn348xrm34xmr3478mxgr834grcn834gnr834ncrg348r34xm");
	     

	     
	    CONTENT.appendChild(txt);
	   
	     BODY.appendChild(CONTENT);
	   //  System.out.println("AX121");
	     Message.appendChild(BODY);
	  //   doc.appendChild(Message);
	     
	     
	      logp.setSender(nul.jeNull(pgnclient.getClient_id()));
	      
	      logp.setMsg_id(nul.jeNull(newfilename));
	      
	     
	   
	
	      
	    logp.setType("4");
	      
	
	      
	      logp.setRefer("");
	      logp.setSender_id(nul.jeNull(pgnclient.getClient_id()));
	    	 
	    	
	     
	    	 TransformerFactory tf = TransformerFactory.newInstance();
	    	 Transformer transformer = tf.newTransformer();
	    	 transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
	    	 StringWriter writer = new StringWriter();
	    	 transformer.transform(new DOMSource(doc), new StreamResult(writer));
	    	 String output = writer.getBuffer().toString().replaceAll("\n|\r", "");
	    	// System.out.println("AX13 --------------------   "+output+" ------------------------");
	    	 
	    	 
	    	 
	    return	 executePost((pgnclient.getClient_url().endsWith("/")?pgnclient.getClient_url()+"INF":pgnclient.getClient_url()+"/INF"),output);
	    	 
	     
	  //   System.out.println("AX13   "+iio);
	     }
	     catch (Exception ee) {
	    	 System.out.println("Error creating/sending infos xml: " +ee);
	    	 org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
				
				log.error("Error creating/sending infos xml: "+ee.toString());
				
				
				logp.setId_pgnclients(pgnclient.getId());
				logp.setLog_date(new Date());
				logp.setId_user(pgnclient.getId_user());
			    logp.setStatus("ERR");
			    logp.setMessage("Error creating/sending infos xml: "+ee.toString());
			    logp.setPhase("E1");
			      logp.setType("1");
			      
			      
			   //   logp.setArchived(""); // arhived file location
			  //   logp.setFile_orig(""); // orig file name 
			      
			      //logp.setMsg_destination("");
			      logadd.addToLogByServlet(contextUtil, servletContext, logp,ConPool);
				throw new Exception(ee.toString());
				
	     }
	     
	 /*   StringWriter writer = new StringWriter();
	     transformer.transform(new DOMSource(doc), new StreamResult(writer));
	     String output = writer.getBuffer().toString().replaceAll("\n|\r", "");*/
	     
		//System.out.println(output);
		
	//	return "";
	}
	
	
	
	
	private  String executePost(String targetURL, String content) throws Exception {
		  HttpURLConnection connection = null;
		  boolean eror = false;
		  String rett = "";
		  try {
		    //Create connection
			  
			  System.out.println("targetURL " + targetURL);
			  
		    URL url = new URL(targetURL);
		    
		    connection = (HttpURLConnection) url.openConnection();
		    connection.setRequestMethod("POST");
		    
		    
		    connection.setRequestProperty("Content-Type",  "text/xml");

		    connection.setRequestProperty("Content-Length", 
		        Integer.toString(content.getBytes().length));
		  //  connection.setRequestProperty("Content-Language", "en-US");  

		    connection.setUseCaches(false);
		    connection.setDoOutput(true);

		    //Send request
		    DataOutputStream wr = new DataOutputStream (
		        connection.getOutputStream());
		    wr.writeBytes(content);
		    wr.close();

		    
		    
		    //Get Response  
		    
		    
		    
		    
		    InputStream is = connection.getInputStream();
		    
		    BufferedReader rd = new BufferedReader(new InputStreamReader(is));
		    StringBuffer response = new StringBuffer(); 
		    
		    String line;
		    while ((line = rd.readLine()) != null) {
		      response.append(line);
		    //  response.append('\r');
		    }
		    rd.close();
		    
		    if (connection.getResponseCode()==200) {
		    	logp.setId_pgnclients(pgnclient.getId());
		    	logp.setId_user(pgnclient.getId_user());
				logp.setLog_date(new Date());
			    logp.setStatus("OK");
			    
			    logp.setMessage("<b>Sent infos request:</b> . <b>Response ("+response+")</b> ");
			    logp.setPhase("A2c");
			      logp.setType("4");
			      
			   
			     
			      //logp.setMsg_destination("");
			      logadd.addToLogByServlet(contextUtil, servletContext, logp,ConPool);
			      
			      
			
				
			      
		    }
		    else {
		    
		    	
		    	eror = true;
		    	
		     	System.out.println("Error sending infos request. Response: "+response);
		    	logp.setId_pgnclients(pgnclient.getId());
		    	logp.setId_user(pgnclient.getId_user());
				logp.setLog_date(new Date());
			    logp.setStatus("ERR");
			    logp.setMessage("Error sending infos request. Response: "+response);
			    logp.setPhase("E2c");
			      logp.setType("4");
			      
			      
			   //   logp.setArchived(""); // arhived file location
			  //   logp.setFile_orig(""); // orig file name 
			      
			      //logp.setMsg_destination("");
			      logadd.addToLogByServlet(contextUtil, servletContext, logp,ConPool);
		    	
		    	
		    }
		      
		    
		    rett= response.toString();
		    
		    
		    
		  } catch (Exception e) {
		    e.printStackTrace();
		    eror = true;
		    
			logp.setId_pgnclients(pgnclient.getId());
			logp.setId_user(pgnclient.getId_user());
			logp.setLog_date(new Date());
		    logp.setStatus("ERR");
		    logp.setMessage("Error sending infos request "+e.toString()+" ");
		    logp.setPhase("E6c");
		      logp.setType("4");
		      
		   
		      //logp.setMsg_destination("");
		      logadd.addToLogByServlet(contextUtil, servletContext, logp,ConPool);
		    
		    
		    rett = "";
		    if (connection != null) {
			      connection.disconnect();
			    }
throw new Exception (e.toString()+" ");
		    
		  } finally {
		    if (connection != null) {
		      connection.disconnect();
		    }

		    
		  }
		  
		  
		
		  
		  return rett;
		  
		  
		  
		  
		  
		  
		  
		  
		  
		}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	private String createArchiveDir(String dirr) throws Exception {
		
		try {
			
		     if (dirr.endsWith("/") || dirr.endsWith("\\")) {
		    	 
		     }
		     else {
		    	 dirr +="/";
		     }
		     
		     String arc = dirr+"archive/"+getDatumFormatFromDate(new Date(),"yyyy/MM/dd")+"/";
		     
			File fim = new File(arc);
			
			if (!fim.exists()) {
				fim.mkdirs();
			}
			
			return arc;
		}
		catch (Exception exc) {
			System.out.println("Error creating archive dir! "+exc.toString());
		//	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			
			//log.error("Error creating archive dir! "+exc.toString());
			
			throw new Exception("Error creating archive dir! "+exc.toString());
			
		}
		
		//return "";
		
	}
	
	
	
	private final String AB = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_$";
	private SecureRandom rnd = new SecureRandom();

	private String randomString( int len ){
	   StringBuilder sb = new StringBuilder( len );
	   for( int i = 0; i < len; i++ ) {
	      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
	}
	   return sb.toString();
	}
	
	
	
	private String getDatumFormatFromDate(Date dt,String formm) {
		if (dt!=null) {
		SimpleDateFormat formatter = new SimpleDateFormat (formm);//"dd-MM-yyyy HH:mm:ss");

		

		return formatter.format(dt);
		}
		return "";
		}
	

	
	


}