<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="genXML" scope="request" class="com.popultrade.webapp.ParseXML" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);

try {
 
	
	/// dam uploadan file v bazo
	
	/// id konverzije
	String idk = "250";//request.getParameter("idk");
	
	if (idk==null) {
		throw new Exception("Error: id conversion is null!");
	}
	
	BufferedReader br = new BufferedReader(new FileReader("E:/xml_files/006398.IH"));
    try {
    	
    	com.popultrade.dao.TemplateXmlappDAO daog = (com.popultrade.dao.TemplateXmlappDAO)contextUtil.getBeanDao("templateXmlappDAO",pageContext.getServletContext());
    	
        String line = br.readLine();
	int zapo = 5;
        while (line != null) {

        	if (!line.trim().equals("")) {
        	com.popultrade.model.TemplateXmlapp vseb =new com.popultrade.model.TemplateXmlapp();
        	
        	
        	vseb.setDescription(""+line.substring(0,1));
        	vseb.setId_conversion(new Long(idk));
        	vseb.setRow(line);
        	vseb.setZaporedje(zapo);
        	vseb.setLength(line.length());
        	
        	daog.saveTemplateXmlapp(vseb);
        	
        	zapo+=5;
        	
        	
        	}
        	
        	
            line = br.readLine();
        }
    }
      catch (Exception ex) {
    	  System.out.println("ERROR reading app file: "+ex.toString());
      }
     finally {
        br.close();
    }
	
	
	
	
	//System.out.println(genXML.getPathFromIdTag(new Long(443), contextUtil, pageContext.getServletContext()));
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
 
%>
 

