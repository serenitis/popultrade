<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<%

try {
/// kam me vrze po logoutu, ce je opcija
String logou = control.prvi_page;

if (request.getParameter("forw")!=null){
logou = request.getParameter("forw");
}

if (control.getUser().equals("anonymous")) {

%>


<script language=javascript>
top.document.location = "indexne.jsp";
</script><%

}
else {
  ///// dam iz obdelave vsa narocila, ki je obdeloval



  ConPool.userNeObdelujeVec(control.user_sifra);
 

/// logout
control.setUser(contextUtil,pageContext.getServletContext());
session.invalidate();
%><script language=javascript>
top.document.location = "indexne.jsp";  

</script><%
}


}
catch(Exception ex) {
}


%>
