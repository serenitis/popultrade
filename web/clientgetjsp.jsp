<%@ page contentType="text/html; " import="java.sql.*,javax.crypto.spec.SecretKeySpec,java.security.*,org.xml.sax.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,org.w3c.dom.*,javax.xml.parsers.*"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />

<%!




com.popultrade.webapp.chkNull nul = new com.popultrade.webapp.chkNull();
	
	
com.popultrade.webapp.EncDecUtil encdec = new com.popultrade.webapp.EncDecUtil();
	
 

	public void doReceive(HttpServletRequest request, HttpServletResponse response,com.popultrade.webapp.conPool ConPool,com.popultrade.webapp.ContextUtil contextUtil,ServletContext context)
			throws ServletException, IOException {
		com.popultrade.model.PgnLog logp = new com.popultrade.model.PgnLog();
	//	com.popultrade.webapp.AddToLog logadd = new com.popultrade.webapp.AddToLog();
		
		String error = "";
		
		//com.popultrade.webapp.ContextUtil contextUtil =	(com.popultrade.webapp.ContextUtil)context.getAttributeNames();
		
		/*Enumeration eed = context.getAttributeNames();
		
		while (eed.hasMoreElements()) {
			String nex = (String)eed.nextElement();
			
			System.out.println("nex: "+nex);
			
			
		}*/
		
		/*UsersDAO usersDAO = (UsersDAO)cu.getBeanDao("usersDAO",context);
		Users uppm = new Users();
		uppm.setUsername("admin");
		uppm.setGeslo("a");
		uppm.setStatus("1");
		
		List li = usersDAO.getUserssExactly(uppm);
		
		System.out.println(li.size());
		}
		catch (Exception nip) {
			System.out.println("NI POVEZAVE DO SCOPE "+nip.toString());
		}*/
		
		response.setContentType("text/plain");
		
		PrintWriter out = response.getWriter();
	
		//System.out.println(getBody(request));
	//	out.print(getBody(request));
		
		 DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();  
		    DocumentBuilder builder;  
		    try  
		    {  
		    	System.out.println("ECO --- 1");
		    	String ddo =getBody(request);
		        builder = factory.newDocumentBuilder();  
		        Document document = builder.parse( new InputSource( new StringReader( ddo ) ) );  
		        
		      NodeList ell=  document.getElementsByTagName("MESSAGE");
		        
		      System.out.println("ECO --- 12");
		      
		      Element elo = (Element)ell.item(0);
		      
		      String receiver = getElementvalue(getXMLValue(elo,"HEADER/RECEIVER"));
		      
		      logp.setSender(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/CLIENTNAME")))+" ("+nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/CLIENTID")))+")");
		      
		      logp.setMsg_id(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/FILE_INFO_SOURCE/FILE_NAME_NEW"))));
		      
		      logp.setOrig_filename(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/FILE_INFO_SOURCE/FILE_NAME"))));
		      
		      logp.setMsg_class(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/CLASS"))));
		      logp.setMsg_subject(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/SUBJECT"))));
		      
		      logp.setMsg_receiver_end(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/END_RECEIVER"))));
		      
		      logp.setMsg_receiver(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/RECEIVER"))));
		      
		      logp.setMsg_type(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/MSGTYP"))));
		      
		   // logp.setType("2");
		      
		      logp.setMsg_options(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/OPTIONS")))); /// dir in node db
		      
		      logp.setRefer(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/SOURCEURL"))));
		      logp.setSender_id(nul.jeNull(getElementvalue(getXMLValue(elo,"HEADER/CLIENTID"))));
		      
		      
		      
		     
		    //  logp.setStatus("ALE");
		    //  logp.setMessage("");
		    //  logp.setPhase("R4");
		      
		   //   logp.setArchived(""); // arhived file location
		  //   logp.setFile_orig(""); // orig file name 
		      
		      //logp.setMsg_destination("");
		      
		      
		      
		      
		     if (ConPool.getClients()!=null && receiver!=null && ConPool.getClients().containsKey(receiver)) {
		      
		    	 
		    	 String msgtyp = getElementvalue(getXMLValue(elo,"HEADER/MSGTYP"));
		    	 String msgclass = getElementvalue(getXMLValue(elo,"HEADER/CLASS"));
		    	 
		    	 if (msgtyp!=null && !msgtyp.trim().equals("") && msgclass!=null && !msgclass.trim().equals("")) {
		    	 
		    	 
		    		 com.popultrade.webapp.PgnClientsc pgnclient = (com.popultrade.webapp.PgnClientsc)ConPool.getClients().get(receiver);
		    		 com.popultrade.webapp.Pgnclientsreceivefromsrc pgncsrc = new com.popultrade.webapp.Pgnclientsreceivefromsrc();
		    		 com.popultrade.webapp.Pgnclientsreceivefromc pgncs = new com.popultrade.webapp.Pgnclientsreceivefromc();
		    	 
		    	 List<com.popultrade.webapp.Pgnclientsreceivefromc> pgncsl = pgnclient.getPgnclientsreceivefromc();
		    	 /// if msgtyp and class is found
		    	 boolean msgtc= false;
		    	 for (int k=0;k<pgncsl.size();k++) {
 
		    	  pgncs = pgncsl.get(k);
		    	 List<com.popultrade.webapp.Pgnclientsreceivefromsrc> pgncsrcl = pgncs.getPgnclientsreceivefromsrc();
		    	 
		    	 for (int t=0;t<pgncsrcl.size();t++) {
		    		 
		    		  pgncsrc = pgncsrcl.get(t);
		    		 
		    		 if ( nul.jeNull(pgncsrc.getMsg_type()).equals(msgtyp) && nul.jeNull(pgncsrc.getMsg_class()).equals(msgclass)) {
		    			 msgtc = true;
		    			 
		    			 logp.setId_pgnclients(pgnclient.getId());
		    			 
		    			 break;
		    		 }
		    		 
		    		 
		    		 
		    	 }
		    	 
		    	 if (msgtc) {
		    		 break;
		    	 }
		    	 

		    	 }
		    	 
		      
		      String valtpass = getElementvalue(getXMLValue(elo,"HEADER/CRYPTTEXT"));
		      String valt = getElementvalue(getXMLValue(elo,"BODY/CONTENT"));
		      
		      System.out.println("ECO --- 122");
		      
		      /// check if encrypt/decrypt code is ok
		      if (encdec.DecryptPass(valtpass, pgncs.getSender_enccode()).equals("PANTEON_GROUP")) {
		      
		     // System.out.println(encdec.DecryptPass(valtpass, pgncs.getSender_enccode()));
		      
		    	  
		    	  
		    	  
		    	  //// decrypt content and put in receive location
		    	  
		    	  /// chk dir
		    	  
		    	  File fii = new File(finishDir(pgncsrc.getSave_file_to()));
		    	  
		    	  String newfn="";
		    	  if (fii.exists() && fii.isDirectory()) {
		    		  
		    		  
		    		  PrintWriter tulos = null;
		    		  try {
		    			  
		    			  
		    			  String newfn2 = getElementvalue(getXMLValue(elo,"HEADER/FILE_NAME_NEW"));
		    			  
		    			  if (newfn2==null || newfn2.trim().equals("")) {
		    				  newfn2=  getDatumFormatFromDate(new Date(),"yyyyMMddHHmmss")+this.randomString(9);
		    			  }
		    			   newfn = newfn2;
		    			  if (!nul.jeNull(pgncsrc.getFile_extension()).trim().equals("") && !nul.jeNull(pgncsrc.getFile_extension()).trim().equals("*")) {
		    				  newfn = newfn+"."+nul.jeNull(pgncsrc.getFile_extension()).trim();
		    			  }
		    			  else {
		    				  newfn = newfn+"."+msgtyp;
		    			  }
		    			  
		    			  String decmes =encdec.DecryptMsg(valt, pgncs.getSender_enccode());
		    		  tulos = new PrintWriter(new FileOutputStream(finishDir(pgncsrc.getSave_file_to()) + newfn), true);
		    		    tulos.write(decmes);
		    		  tulos.close();
		    		  
		    		  
		    		  /// put to archive if needed
		    		  
		    		  if (nul.jeNull(pgncs.getArchive_sent_file()).equals("1") ) {
		    			  
		    			  
		    			String archive =   createArchiveDir(finishDir(pgncsrc.getSave_file_to()) );
		    			
		    			
		    			  tulos = new PrintWriter(new FileOutputStream(archive + newfn), true);
			    		    tulos.write(decmes);
			    		  tulos.close();
			    		  
			    		  /// write xml to archive
			    		  
			    		  tulos = new PrintWriter(new FileOutputStream(archive + newfn2+".xml"), true);
			    		    tulos.write(ddo);
			    		  tulos.close();
		    			
			    		  logp.setStatus("ALE");
			  		      logp.setMessage("File added to archive! ("+archive + newfn+")");
			  		      logp.setPhase("R4");
			  		      
			  		   //   logp.setArchived(""); // arhived file location
			  		  //   logp.setFile_orig(""); // orig file name 
			  		      
			  		      //logp.setMsg_destination("");
			  		    addToLog(contextUtil, context, logp);
		    		  }
		    		  
		    	        
			     	  logp.setStatus("OK");
		  		      logp.setMessage("Document received from "+logp.getSender()+"("+logp.getSender_id()+")"+" and put in: '"+finishDir(pgncsrc.getSave_file_to()) + newfn+"'!");
		  		      logp.setPhase("R5");
		  		      
		  		   //   logp.setArchived(""); // arhived file location
		  		  //   logp.setFile_orig(""); // orig file name 
		  		      
		  		      //logp.setMsg_destination("");
		  		    addToLog(contextUtil, context, logp);
		  		    
		  		    
		    		  response.setStatus(HttpServletResponse.SC_OK);
		    		  }
		    		  catch (FileNotFoundException ex) {
		    		   // System.out.println("Ne moram narediti Lock file alen.lck: "+ex.toString());
		    		    error = "Error: Can't save file! "+ex.toString();
		    		    response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
		    		    
		    		    
		    			  logp.setStatus("ERR");
			  		      logp.setMessage("Error saving the document in: '"+finishDir(pgncsrc.getSave_file_to()) + newfn+"' !"+ex.toString());
			  		      logp.setPhase("RE6");
			  		      
			  		   //   logp.setArchived(""); // arhived file location
			  		  //   logp.setFile_orig(""); // orig file name 
			  		      
			  		      //logp.setMsg_destination("");
			  		    addToLog(contextUtil, context, logp);
		    		    
		    		    
		    		  }
		    		  
		    		  
		    		  //  System.out.println();
		  		    
		   		      
		    		  
		    	  }
		    	  else {
		    		  response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
				    	 error = "Error: Can't save file!";
				   	  logp.setStatus("ERR");
		  		      logp.setMessage("Error: Can't save file! ");
		  		      logp.setPhase("RE6");
		  		      
		  		   //   logp.setArchived(""); // arhived file location
		  		  //   logp.setFile_orig(""); // orig file name 
		  		      
		  		      //logp.setMsg_destination("");
		  		    addToLog(contextUtil, context, logp);
		    	  }
		    	  
		  
		      }
		      else {
		    	  response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			    	 error = "Error: Wrong encrypt code!";
			    	 
			      	  logp.setStatus("ERR");
		  		      logp.setMessage("Error: can not decrypt the message! ");
		  		      logp.setPhase("RE5");
		  		      
		  		   //   logp.setArchived(""); // arhived file location
		  		  //   logp.setFile_orig(""); // orig file name 
		  		      
		  		      //logp.setMsg_destination("");
		  		    addToLog(contextUtil, context, logp);
			    	 
		      }
		    	 }
		    	 else {
		    		 response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			    	 error = "Error: Class or MsqTyp not found!";
			    	 
			      	  logp.setStatus("ERR");
		  		      logp.setMessage("Error: Class or MsqTyp not found! ");
		  		      logp.setPhase("RE9");
		  		      
		  		   //   logp.setArchived(""); // arhived file location
		  		  //   logp.setFile_orig(""); // orig file name 
		  		      
		  		      //logp.setMsg_destination("");
		  		    addToLog(contextUtil, context, logp);
			    	 
		    	 }
		     }
		     else {
		    	 response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		    	 error = "Error: Receiver not found!";
		    	 
		    	 
		     	  logp.setStatus("ERR");
	  		      logp.setMessage("Error: document is not intended for this receiver!");
	  		      logp.setPhase("RE7");
	  		      
	  		   //   logp.setArchived(""); // arhived file location
	  		  //   logp.setFile_orig(""); // orig file name 
	  		      
	  		      //logp.setMsg_destination("");
	  		    addToLog(contextUtil, context, logp);
		    	 
		     }
		        
		        
		    } catch (Exception e) {  
		        System.out.println("ERROR "+e.toString());
		        error = "Undefined error: "+e.toString();
		        response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
		        
		        
		     	  logp.setStatus("ERR");
	  		      logp.setMessage("Error: Unexpected error while receiving a message!");
	  		      logp.setPhase("RE4");
	  		      
	  		   //   logp.setArchived(""); // arhived file location
	  		  //   logp.setFile_orig(""); // orig file name 
	  		      
	  		      //logp.setMsg_destination("");
	  		    addToLog(contextUtil, context, logp);
		        
		        
		    } 
		
		if (!error.equals("")) {
			out.println(error);
		}
		else {
			out.print("File successfully received!");
		}

		
		out.flush();
		out.close();
	}
	
	
	
	
	
	
	
	
	private  String getBody(HttpServletRequest request) throws IOException {

	    String body = null;
	    StringBuilder stringBuilder = new StringBuilder();
	    BufferedReader bufferedReader = null;

	    try {
	        InputStream inputStream = request.getInputStream();
	        if (inputStream != null) {
	            bufferedReader = new BufferedReader(new InputStreamReader(inputStream,"utf-8"));
	            char[] charBuffer = new char[128];
	            int bytesRead = -1;
	            while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
	                stringBuilder.append(charBuffer, 0, bytesRead);
	            }
	        } else {
	            stringBuilder.append("");
	        }
	    } catch (IOException ex) {
	        throw ex;
	    } finally {
	        if (bufferedReader != null) {
	            try {
	                bufferedReader.close();
	            } catch (IOException ex) {
	                throw ex;
	            }
	        }
	    }

	    body = stringBuilder.toString();
	    return body;
	}
	
	


    
    
    
    
	
	
	
	
	
	    private  String getElementvalue(Element sov) {

	        if (sov!=null && sov.getTextContent()!=null) {
	          return sov.getTextContent();
	        }
	        return "";

	      }
	

	    private  Element getXMLValue(Element sob,String pot) {

	  try {
	    return getXMLValue2(sob,pot);
	  }
	  catch(Exception ex) {
	    System.out.println("Napaka: "+ex.toString());
	  }

	  return null;

	}






	    private  Element getXMLValue2(Element sob,String pot) throws Exception {
	    //  pot = "DataArea/PurchaseOrder/Header/Parties/SoldToParty/PartyId/Id";
	    Iterator iy = null;
	      NodeList it =null;
	          Node elo2 = null;
	          Vector vec = new Vector();
	     vec  = (new com.popultrade.webapp.split()).split(pot,"/");
	      try {
	      ////
	      iy = null;
	      it = sob.getChildNodes();
	      boolean tes = false;
	      for (int h=0;h<vec.size();h++) {
	        tes = false;
	        for (int m=0;m<it.getLength();m++) {
	//System.out.println("ADE");
	          elo2 = it.item(m);
	          //System.out.println("ADEw");
	          if (elo2.getNodeName().equalsIgnoreCase((String)vec.get(h))) {

	           // System.out.println("Elementi "+vec.get(h));
	            tes = true;
	            if ((vec.size()-1)==h) {
	              return (Element)elo2;
	            }
	            break;
	            }
	        }
	        if (tes) {
	          it = elo2.getChildNodes();
	        }
	        else {
	          throw new Exception("Given path is not correct! Path: "+pot+" not found >" + vec.get(h));
	         // return null;
	        }
	      }
	      }
	      catch (Exception ex) {
	       // System.out.println("AC:"+ex.toString());
	      }
	      return null;
	    }
	
	
	
	
	
	
	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	private String finishDir(String srcd) {
	    
	     if (srcd.endsWith("/") || srcd.endsWith("\\")) { 
	     }
	     else {
	    	 srcd +="/";
	     }
	     
	     return srcd;
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
	





	public boolean addToLog(com.popultrade.webapp.ContextUtil contextUtil, ServletContext servletContext,com.popultrade.model.PgnLog logg) {
		
		
		
		try {
			//com.popultrade.webapp.ContextUtil contextUtil = new com.popultrade.webapp.ContextUtil();
			com.popultrade.dao.PgnLogDAO pgnlogDAO = (com.popultrade.dao.PgnLogDAO)contextUtil.getBeanDao("pgnLogDAO",servletContext);
			logg.setLog_date(new Date());
			com.popultrade.model.PgnLog loggc = (com.popultrade.model.PgnLog)contextUtil.cloneBean(logg);
		
			pgnlogDAO.savePgnLog(loggc);
			
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






%>

<%
System.out.println("JSPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP ---- ");
doReceive(request,response,ConPool,contextUtil,pageContext.getServletContext());
/*try {
com.popultrade.dao.PgnLogDAO pgnlogDAO = (com.popultrade.dao.PgnLogDAO)contextUtil.getBeanDao("pgnLogDAO",pageContext.getServletContext());

//com.popultrade.model.PgnLog loggc = (com.popultrade.model.PgnLog)contextUtil.cloneBean(logg);
com.popultrade.model.PgnLog lom = new com.popultrade.model.PgnLog();
lom.setArchived("1");
lom.setLog_date(new Date());
lom.setId_pgnclients(1L);
pgnlogDAO.savePgnLog(lom);
}
catch (Exception jeb) {
	
System.out.println("jeb "+jeb.toString());
}*/

%>
