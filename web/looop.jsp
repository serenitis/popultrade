<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="javaScript" scope="request" class="com.popultrade.webapp.JavaScriptControl" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);

%>  
<%
try {
boolean bok=false;
for (int i=1;i<=5000000;i++) {
com.popultrade.model.Novice vseb =new com.popultrade.model.Novice();
com.popultrade.dao.NoviceDAO dao = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());




vseb = (com.popultrade.model.Novice)contextUtil.getPopulatedObject(vseb,request);
vseb.setDatum_novice(new Date());
vseb.setDatum_vnosa(new Date());
vseb.setNaslov_novice("Novica naslov: "+i);
vseb.setOpis_novice("Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: Novica Opis: "+i);
dao.saveNovice(vseb);

System.out.println("Zap: "+i);

}


}
catch (Exception ex){
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
%>
