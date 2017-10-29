<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />


<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
String imefile = "C:/Tomcat5.0/webapps/popultrade/esd10_edit.jsp"; //// ime jsp file za spremembo v prevode
String konec = "</form>";
String zacetek = "<table";
try {
%>


<%
//// preberem file in naredim inserte

        BufferedReader  in = new BufferedReader(new InputStreamReader(new FileInputStream(imefile),"utf-8"));
         
          String linee="";
          String ime_polja="";
          String type_polja="";
          String length_polja="";
          //boolean jena=false;
          int stej=-1;
          
          Hashtable htdat = new Hashtable();
          int htdatst=0;
          Hashtable htdat2 = new Hashtable();
          int htdatst2=0;
          
          Hashtable checki = new Hashtable();
          int checkist=0;
          
          StringBuffer sb = new StringBuffer();
          
          while ( (linee = in.readLine()) != null) {
          
			sb.append(linee);




          }
          
          
          String str = sb.toString().substring(sb.indexOf(zacetek),sb.lastIndexOf(konec));
          
          %>
          <%=str%>
          <%
      


}
catch (Exception ex){
System.out.println("Nastavitve: "+ex.toString());
}
%>