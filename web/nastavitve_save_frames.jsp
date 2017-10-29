<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%><jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/><jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" /><jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" /><jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" /><jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" /><%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
boolean jetr = false;
if (jetr) { //(control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("U"))) {
%><jsp:forward page="logout.jsp"/><%}%><%
try {
boolean bok=false;
com.popultrade.model.FrameSize vseb =new com.popultrade.model.FrameSize();
com.popultrade.dao.FrameSizeDAO dao = (com.popultrade.dao.FrameSizeDAO)contextUtil.getBeanDao("frameSizeDAO",pageContext.getServletContext());
String jspp = nul.jeNull(request.getParameter("jsp_page"));

if (jspp.indexOf("?")!=-1) {
	jspp = jspp.substring(0,jspp.indexOf("?"));
}

vseb= dao.getFrameSize(control.getUser(),jspp);


if (vseb!=null) {
	
	vseb.setFrame1(Integer.parseInt(nul.jeNull(request.getParameter("frame1"))));
	vseb.setFrame2(Integer.parseInt(nul.jeNull(request.getParameter("frame2"))));
	vseb.setFrame3(Integer.parseInt(nul.jeNull(request.getParameter("frame3"))));
	
	dao.saveFrameSize(vseb);
	
	/// setam nove podatke v control
	control.getFrames().put(nul.jeNull(jspp),new com.popultrade.webapp.FrameSizeClass(control.getUser(),vseb.getFrame1(),vseb.getFrame2(),vseb.getFrame3()));
	
}
else {
	vseb =new com.popultrade.model.FrameSize();
	vseb.setFrame1(Integer.parseInt(nul.jeNull(request.getParameter("frame1"))));
	vseb.setFrame2(Integer.parseInt(nul.jeNull(request.getParameter("frame2"))));
	vseb.setFrame3(Integer.parseInt(nul.jeNull(request.getParameter("frame3"))));
	vseb.setJsp_page_name(jspp);
	vseb.setUsername(control.getUser());
	dao.saveFrameSize(vseb);
	
	/// setam nove podatke v control
	control.getFrames().put(nul.jeNull(jspp),new com.popultrade.webapp.FrameSizeClass(control.getUser(),vseb.getFrame1(),vseb.getFrame2(),vseb.getFrame3()));
	
}




}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
	
}
%>TRUE