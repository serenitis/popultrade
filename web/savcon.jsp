<%@ page contentType="text/html\;" import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || (!control.getPrivilegijeUporabnika().equals("A") && !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsssp:forward page="logout.jsp"/><%}%><%String ress="";
try {
boolean bok=false;
if (true && !nul.jeN(request.getParameter("ido")).equals("") && !nul.jeN(request.getParameter("ids")).equals("") && !nul.jeN(request.getParameter("ida")).equals("")) {
	com.popultrade.dao.ConnectionsDAO doac = new com.popultrade.dao.ConnectionsDAO();
	com.popultrade.model.Connections modq = new com.popultrade.model.Connections();
	/// check if already exist
	
	modq.setId_question(request.getParameter("ida"));
	modq.setId_source(request.getParameter("ids"));
	modq.setId_target(request.getParameter("idt"));
//	System.out.println("++++++++++++xxx "+doac.getConnectionss(modq, ConPool.getEntman(),"",1,1).size());
	if (doac.getConnectionss(modq, ConPool.getEntman(),"",1,1).size()>0) {
		ress="--NIOK--";
		//return;
	}
	else {
	

com.popultrade.dao.ChaptersDAO doax = new com.popultrade.dao.ChaptersDAO();
com.popultrade.model.Chapters modx = new com.popultrade.model.Chapters();
//modx.setId(request.getParameter("ido").substring(2));
String dod_hql="";
modx=doax.getChapters(request.getParameter("ido").substring(2), ConPool.getEntman());

System.out.println("POSTION FOR ID "+request.getParameter("ido")+" SAdddddddddddddVED!");

String rezu_format="";
if (modx!=null) {
	List vsee = modx.getConnections();
	
	
	//for (int i=0;i<vsee.size();i++) {
	com.popultrade.model.Connections modc = new com.popultrade.model.Connections();
	
	
	modc.setId_source(request.getParameter("ids"));
	modc.setId_target(request.getParameter("idt"));
	modc.setId_question(request.getParameter("ida"));
	modc.setType(request.getParameter("typ"));
	modc.setType_d(request.getParameter("tdyp"));
	//modc.setId(nul.createID());
	doac.saveConnections(modc, ConPool.getEntman());
	vsee.add(modc);	
	modx.setConnections(vsee);
	
	doax.saveChapters(modx, ConPool.getEntman());
	ress="--OK--|"+modc.getId()+"|--";
	System.out.println("POSTION FOR ID "+request.getParameter("ido")+" SAVED!");
	//}
}

}

}
}
catch (Exception ex){
	System.out.println(ex.toString());
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}%><%=ress %>
