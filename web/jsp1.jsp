<%@ page contentType="text/html; charset=windows-1250"  import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
 <jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<%
  request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
  response.addHeader("Pragma" , "No-cache") ;
  response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);



if (prisotnost.updateFromDB()) {
	
try {
		
		//System.out.println("CCCCCCCCCCCCCCCCCCC "+am.servletcontext);
		
	 com.popultrade.dao.Gt1dbchangeDAO daoup = (com.popultrade.dao.Gt1dbchangeDAO)contextUtil.getBeanDao("gt1dbchangeDAO",pageContext.getServletContext());

	 List lico = daoup.getGt1dbchanges(null);
	 
	 Iterator ito = lico.iterator();
	 
	Hashtable ideo = new Hashtable();
	 while (ito.hasNext()) {
		 
		 com.popultrade.model.Gt1dbchange uprr = (com.popultrade.model.Gt1dbchange)ito.next();
		 
		 /// klicem webservice za update userjem
		// System.out.println("CCCCCCCCCCCCCCCCCCC "+uprr.getTable_name());
		//prisotnost.sendMessageToWS("AUTOMATIC",uprr.getRecord_id()+"",new Date(),9,uprr.getTable_name(),uprr.getUser_name(),"");
		 
		 if (uprr.getTable_name()!=null && uprr.getRecord_id()!=null && uprr.getUser_name()!=null && ConPool.table_names.containsKey(uprr.getTable_name().toLowerCase())) {
		 prisotnost.sendMessageToWS("AUTOMATIC"+":-:"+uprr.getRecord_id()+":-:9:-:"+ConPool.table_names.get( uprr.getTable_name().toLowerCase())+":-:"+prisotnost.scramble(uprr.getUser_name())+":-::-:");
		 }
		 else if (uprr.getTable_name()!=null && uprr.getRecord_id()!=null && uprr.getUser_name()!=null ) {
			 prisotnost.sendMessageToWS("AUTOMATIC"+":-:"+uprr.getRecord_id()+":-:9:-:"+uprr.getTable_name()+":-:"+prisotnost.scramble(uprr.getUser_name())+":-::-:");
			 }
		 //		daoup.removeGt1dbchange(uprr.getId());
		ideo.put(uprr.getId()+"", "");
		 
	 }
	 
	 Enumeration ert = ideo.keys();
	 daoup = (com.popultrade.dao.Gt1dbchangeDAO)contextUtil.getBeanDao("gt1dbchangeDAO",pageContext.getServletContext());

	 while (ert.hasMoreElements()) {
		 
		 String lok = (String)ert.nextElement();
		 
		 daoup.removeGt1dbchange(new Long(lok));
		 
	 }
	 
	 
	 
	 
	}
	catch (Exception nn) {
		System.out.println("Error: error in retrieving db gt1dbchange : "+nn.toString());
	}
	
	
}


if (control.getUser().equals("anonymous")) {

%><%

}
else {


	
	
prisotnost.spremeniDatum(control.getIdUporabnikaLock());
System.out.println("KLICEM UPDATE DATUMA");
}
%>



