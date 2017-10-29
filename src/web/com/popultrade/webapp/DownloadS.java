package com.popultrade.webapp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class DownloadS extends HttpServlet {

	private static final long serialVersionUID = 5151364782256414593L;

	
	
	

	        protected void doGet(HttpServletRequest request,
	                HttpServletResponse response) throws ServletException, IOException {
	       
	        	
	        	try {
	        		HttpSession session = request.getSession(true);
	        	   	  
              	
  					
  					
	        		
	        	}
	        	catch (Exception exxx) {
	        		System.out.println("Error: cant get image - "+exxx.toString());
	        	}
	        	
	        	
	        	
	        }
	
	
	
	
	
	
	
	
	
	

}
