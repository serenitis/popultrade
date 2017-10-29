package com.popultrade.webapp;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.popultrade.dao.PgnClientsDAO;
import com.popultrade.model.PgnClients;
import com.popultrade.model.PgnLog;

public class HttpGetLog  extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 133424234234234234L;

	public HttpGetLog() {
		super();
	}
	
	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}	
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		System.out.println("GET LOG FOR SERVLET");
		ObjectInputStream in = new ObjectInputStream(request.getInputStream());
		try {
			com.popultrade.webapp.ContextUtil cu = new com.popultrade.webapp.ContextUtil();
			AddToLog logadd = new AddToLog();
			
			PgnLog	pgnLog = (PgnLog) in.readObject();
			
			if (pgnLog.getServlet_todo()!=null && pgnLog.getServlet_todo().equals("UPDATE_CLIENT")) {
				
				System.out.println("::::--------------------:::: UPDATE CLIENT FROM SERVLET ");
				
				PgnClientsDAO pgncliDAO = (PgnClientsDAO)cu.getBeanDao("pgnClientsDAO",request.getServletContext());
				
				PgnClients plop = (PgnClients)pgncliDAO.getPgnClients(pgnLog.getId_pgnclients());
				
				plop.setLast_check(new Date());
				
				if (pgnLog.getStatus()!=null && !pgnLog.getStatus().equals("ERR")) {
					plop.setLast_check_ok(new Date());
					plop.setClient_check_error(null);
				/*	if (plop.getErr_num()!=null) {
					plop.setErr_num(plop.getErr_num()+1);
					}
					else {
						plop.setErr_num(1);
					}*/
					
					/// add to client log
					
					
					
				}
				else {
					plop.setClient_check_error(pgnLog.getMessage());
					logadd.addToLogClient(cu, request.getServletContext(), pgnLog);
					
					
					
				}
					
			
				pgncliDAO.savePgnClients(plop);
				
			//	if (pgnLog.getStatus()!=null && !pgnLog.getStatus().equals("ERR")) {
				com.popultrade.webapp.kontrolaPrisotnosti prisotnost =	(com.popultrade.webapp.kontrolaPrisotnosti)request.getServletContext().getAttribute("prisotnost");
				prisotnost.addUserNarocilo("100000000000",plop.getId()+"",new Date(),4,"PgnClients","loguser","","pgnclients_list1410");
				
			}
			else {
			System.out.println("::::--------------------:::: ADD TO LOG FROM SERVLET ");
			com.popultrade.webapp.conPool ConPool =	(com.popultrade.webapp.conPool)request.getServletContext().getAttribute("ConPool");
			
			
			logadd.addToLog(cu, request.getServletContext(), pgnLog,ConPool);
			}
			
			
			
			
		} catch (ClassNotFoundException e) {
		    e.printStackTrace();
		}
		in.close();
		
		
		//response.setStatus(200);
		
	
	}
	
	
	public void init() throws ServletException {
		// Put your code here
	}
	
	
	
	
	
	
}
