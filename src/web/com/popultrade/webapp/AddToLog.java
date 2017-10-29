package com.popultrade.webapp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;

import javax.servlet.ServletContext;

import com.popultrade.dao.PgnLogClientDAO;
import com.popultrade.dao.PgnLogDAO;
import com.popultrade.model.PgnLog;
import com.popultrade.model.PgnLogClient;


public class AddToLog {
	

	

	public boolean addToLogByServlet(ContextUtil contextUtil, ServletContext servletContext,PgnLog logg,conPool ConPool) {
	
		URL url;
		try {
			
			System.out.println("CALL SERVLET FOR LOG ........ 1");
			
		    url = new URL(ConPool.getApplication_url()+"HLP");
		    HttpURLConnection urlCon = (HttpURLConnection) url.openConnection();
		    urlCon.setRequestMethod("POST");
		    urlCon.setDoOutput(true); // to be able to write.
		    urlCon.setDoInput(true); // to be able to read.

		    ObjectOutputStream out = new ObjectOutputStream(urlCon.getOutputStream());
		    out.writeObject(logg);
		    out.close();
		    System.out.println("CALL SERVLET FOR LOG ........ 2");
		 //   ObjectInputStream ois = new ObjectInputStream(urlCon.getInputStream());
		//    names = (Names) ois.readObject();
		 //   ois.close();
		    
		    
   InputStream is = urlCon.getInputStream();
		    
		    BufferedReader rd = new BufferedReader(new InputStreamReader(is));
		    StringBuffer response = new StringBuffer(); 
		    
		    String line;
		    while ((line = rd.readLine()) != null) {
		      response.append(line);
		    //  response.append('\r');
		    }
		    rd.close();
		 //   System.out.println("response "+response);
		    
		} catch (IOException e) {
		    e.printStackTrace();
		    System.out.println("CALL SERVLET FOR LOG ERR ........ "+e.toString());
		}
	
		
		
		return true;
	}
	
	public boolean addToLog(ContextUtil contextUtil, ServletContext servletContext,PgnLog logg,conPool ConPool) {
		
		
		
		try {
			//com.popultrade.webapp.ContextUtil contextUtil = new com.popultrade.webapp.ContextUtil();
			PgnLogDAO pgnlogDAO = (PgnLogDAO)contextUtil.getBeanDao("pgnLogDAO",servletContext);
			
			PgnLog loggc = (PgnLog)contextUtil.cloneBean(logg);
			loggc.setLog_date(new Date());
			/*
			PgnLog lom = new PgnLog();
			lom.setArchived("aaa");
			lom.setLog_date(new Date());*/
			pgnlogDAO.savePgnLog(loggc);
			
			/// add log
			
			if (logg.getId()==null) {
			com.popultrade.webapp.kontrolaPrisotnosti prisotnost =	(com.popultrade.webapp.kontrolaPrisotnosti)servletContext.getAttribute("prisotnost");
			prisotnost.addUserNarocilo("100000000000",loggc.getId()+"",new Date(),9,"PgnLog","loguser","","PgnLog_list200");
			}
			else {
				com.popultrade.webapp.kontrolaPrisotnosti prisotnost =	(com.popultrade.webapp.kontrolaPrisotnosti)servletContext.getAttribute("prisotnost");
				prisotnost.addUserNarocilo("100000000000",loggc.getId()+"",new Date(),4,"PgnLog","loguser","","PgnLog_list200");
			}
			
			/// add to nosql log
			
			com.popultrade.model.Pgnlognosql vseb =new com.popultrade.model.Pgnlognosql();
			com.popultrade.dao.PgnlognosqlDAO dao = new com.popultrade.dao.PgnlognosqlDAO();
			
			
			vseb.setArchived(loggc.getArchived());
			vseb.setClient_log_id(loggc.getClient_log_id());
			vseb.setDir(loggc.getDir());
			vseb.setFile_orig(loggc.getFile_orig());
			//vseb.setId(String)
			vseb.setId_pgnclients(loggc.getId_pgnclients());
			vseb.setId_user(loggc.getId_user());
			vseb.setLog_date(loggc.getLog_date());
			vseb.setMessage(loggc.getMessage());
			vseb.setMsg_class(loggc.getMsg_class());
			vseb.setMsg_destination(loggc.getMsg_destination());
			vseb.setMsg_id(loggc.getMsg_id());
			vseb.setMsg_options(loggc.getMsg_options());
			vseb.setMsg_receiver(loggc.getMsg_receiver());
			vseb.setMsg_receiver_end(loggc.getMsg_receiver_end());
			vseb.setMsg_subject(loggc.getMsg_subject());
			vseb.setMsg_type(loggc.getMsg_type());
			vseb.setOrig_filename(loggc.getOrig_filename());
			vseb.setPhase(loggc.getPhase());
			vseb.setRefer(loggc.getRefer());
			vseb.setSender(loggc.getSender());
			vseb.setSender_id(loggc.getSender_id());
			vseb.setServlet_todo(loggc.getServlet_todo());
			vseb.setStatus(loggc.getStatus());
			vseb.setType(loggc.getType());
			vseb.setUsername(loggc.getUsername());
			
			
			
			
			dao.savePgnlognosql(vseb,ConPool.getEntman());
			
			/// update log
			
			
			
			
			logg.setId(null);
			
			 
			/*
			 logtow.datei = nowe;//dateFormat(nowe,"dd-mm-yyyy HH:MM:ss");

//alert('LOG');
logtow.sender = isender;
logtow.msgid = imsgid;
logtow.org_f_name = iorg_f_name;
logtow.classs = iclasss;
logtow.subject = isubject;
logtow.end_receiver = iend_receiver;
logtow.receiver = ireceiver;
logtow.msg_type = imsg_type;
logtow.type = itype;
logtow.dir = idir;
logtow.status = istatus;
logtow.message = imessage;
logtow.phase = iphase;
logtow.filorg=ifilorg; // only if maxresend
logtow.archived=iarchived;
if (irefer && irefer!="") {
logtow.referer=irefer;
}
if (idest && idest!="") {
logtow.destin=idest;
}
			 */
		
			
			
			return true;
		}
		catch (Exception exx) {
			System.out.println("Error: can't add to log! "+exx.toString());
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error("Error: can't add to log! "+exx.toString());
		}
		
		return false;
		
		
		
	}
	
	
	
	
	
	
	public boolean addToLogClient(ContextUtil contextUtil, ServletContext servletContext,PgnLog logg) {
		
		
		
		try {
			
			
			PgnLogClient loggc=new PgnLogClient();
			
			loggc.setArchived(logg.getArchived());
			loggc.setClient_log_id(logg.getClient_log_id());
			loggc.setDir(logg.getDir());
			loggc.setFile_orig(logg.getFile_orig());
//			loggc.setId(Long)
			loggc.setId_pgnclients(logg.getId_pgnclients());
			loggc.setLog_date(logg.getLog_date());
		
			loggc.setMessage(logg.getMessage());
			loggc.setMsg_class(logg.getMsg_class());
			loggc.setMsg_destination(logg.getMsg_destination());
			loggc.setMsg_id(logg.getMsg_id());
			loggc.setMsg_options(logg.getMsg_options());
			loggc.setMsg_receiver(logg.getMsg_receiver());
			loggc.setMsg_receiver_end(logg.getMsg_receiver_end());
			loggc.setMsg_subject(logg.getMsg_subject());
			loggc.setMsg_type(logg.getMsg_type());
			loggc.setOrig_filename(logg.getOrig_filename());
			loggc.setPgnClients(logg.getPgnClients());
			loggc.setPhase(logg.getPhase());
			loggc.setRefer(logg.getRefer());
			loggc.setSender(logg.getSender());
			loggc.setSender_id(logg.getSender_id());
			loggc.setStatus(logg.getStatus());
			loggc.setType(logg.getType());
			
			
			
			
			
			
			
			
			
			
			//com.popultrade.webapp.ContextUtil contextUtil = new com.popultrade.webapp.ContextUtil();
			PgnLogClientDAO pgnlogDAO = (PgnLogClientDAO)contextUtil.getBeanDao("pgnLogClientDAO",servletContext);
			
		//	PgnLogClient loggc = (PgnLogClient)contextUtil.cloneBean(logg);
			loggc.setLog_date(new Date());
			/*
			PgnLog lom = new PgnLog();
			lom.setArchived("aaa");
			lom.setLog_date(new Date());*/
			pgnlogDAO.savePgnLogClient(loggc);
			
			/// add log
			
			if (logg.getId()==null) {
			com.popultrade.webapp.kontrolaPrisotnosti prisotnost =	(com.popultrade.webapp.kontrolaPrisotnosti)servletContext.getAttribute("prisotnost");
			prisotnost.addUserNarocilo("100000000000",loggc.getId()+"",new Date(),9,"PgnLogClient","loguser","","pgnlogclient_list1354");
			}
			else {
				com.popultrade.webapp.kontrolaPrisotnosti prisotnost =	(com.popultrade.webapp.kontrolaPrisotnosti)servletContext.getAttribute("prisotnost");
				prisotnost.addUserNarocilo("100000000000",loggc.getId()+"",new Date(),4,"PgnLogClient","loguser","","pgnlogclient_list1354");
			}
			/// update log
			
			
			
			
			logg.setId(null);

			
			return true;
		}
		catch (Exception exx) {
			System.out.println("Error: can't add to log! "+exx.toString());
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error("Error: can't add to log! "+exx.toString());
		}
		
		return false;
		
		
		
	}
	
	
	
	
	
	
}








