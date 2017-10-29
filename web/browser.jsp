<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,java.util.Date"  contentType="text/html; charset=utf-8"%>
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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}
%>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">


<jsp:include page="glavast.jsp"/>

<%


    String query="";
String sifra="";
//String dan="";
String imestatistike="";
String kategorijastatistike = "";

ResultSet rs;
ResultSet rs2;
String a = "1";
String b="100";

if (request.getParameter("a")!=null && !request.getParameter("a").equals("")) {
a = request.getParameter("a");
}
if (request.getParameter("b")!=null && !request.getParameter("b").equals("")) {
b = request.getParameter("b");
}


  try {
      System.out.println("-+-------a");
	  com.popultrade.dao.GlavnaStatistikaDAO dao = (com.popultrade.dao.GlavnaStatistikaDAO)contextUtil.getBeanDao("glavnaStatistikaDAO",pageContext.getServletContext());
	  
	
	  List lis = dao.getGlavnaStatistikaBySifra(request.getParameter("sifraa"),Integer.parseInt(a),Integer.parseInt(b));
	  
	  System.out.println("-+-------b");
   


%>









<%
int ins=0;




%>

 <table cellspacing=1 cellpadding=2 width=100% style="font-family: Verdana; font-size: 10px; border-collapse: collapse" bordercolor="#111111">
 <tr><td colspan=4 bgcolor="#646D87" align=center><b><font color=white><%=request.getParameter("imee")%></font></b></td></tr>
<tr>

<%
String[] mess = {"","Nedelja","Ponedeljek","Torek","Sreda","Cetrtek","Petek","Sobota","Nedelja"};

int[] call = {Calendar.JANUARY,Calendar.JANUARY,Calendar.FEBRUARY,Calendar.MARCH,Calendar.APRIL,Calendar.MAY,Calendar.JUNE,Calendar.JULY,Calendar.AUGUST,Calendar.SEPTEMBER,Calendar.OCTOBER,Calendar.NOVEMBER,Calendar.DECEMBER};

Calendar calendar = Calendar.getInstance();
//calendar = new GregorianCalendar(Integer.parseInt(request.getParameter("leto")), call[Integer.parseInt(request.getParameter("mesec"))], 1);
//calendar = new GregorianCalendar(
int days = 0;
int week = 0;
//System.out.println(week + " week "+call[Integer.parseInt(request.getParameter("mesec"))]+ " days " + days);


String[] mesec = {"","Januar","Februar","Marec","April","Maj","Junij","Julij","Avgust","September","Oktober","November","December"};
String en="";
String mes= "";
boolean endd = false;
int stejj=1;
String let="";
boolean letob=false;

int stejob = 0;

String inn = "";

Iterator it = lis.iterator();
while (it.hasNext()) {
	Object[] sif = (Object[])it.next();	
	
	System.out.println(sif[0] +" ------------ "+sif[1]);
	
//inn  = "select count(*) as cou,MONTH(datum),YEAR(datum),referel from glavna_statistika where MONTH(datum)='"+rs2.getString(1)+"' and YEAR(datum)='"+rs2.getString(2)+"' and sifra='"+request.getParameter("sifraa")+"'  group by referel order by cou desc limit 30";
List lim = dao.getGlavnaStatistikaBySifra2(request.getParameter("sifraa"),Integer.parseInt(a),Integer.parseInt(b),sif[0]+"",sif[1]+"","browser");

//rs = dbConnect.queryString(inn, con);

Iterator im = lim.iterator();

while (im.hasNext()) {
	
	Object[] omo = (Object[])im.next();
	
if (!(sif[1]+"").equals(let)) {
let =(sif[1]+"");
if (letob) {

%>


</table>
</td>
<%
stejob=0;

for (int g=stejj;g<4;g++) {

%>
<td><table></table></td>
<%
}
%>
</tr><tr>
<%
}
letob=true;
%>
<td colspan=4><table cellspacing=1 cellpadding=2 width=100% style="font-family: Verdana; font-size: 10px; border-collapse: collapse" bordercolor="#111111">
 <tr><td bgcolor=#CC3300	 align=center ><b><font color=white ><%=let%></font></b></td></tr></table></td></tr><tr>
<%
 stejj=1;
endd=false;
}
//MONTH(datum),YEAR(datum),

if (!(sif[0]+"").equals(mes)) {
mes = (sif[0]+"");

calendar = new GregorianCalendar(Integer.parseInt(let), call[Integer.parseInt(mes)], 1);
//calendar = new GregorianCalendar(
days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
week = calendar.get(Calendar.DAY_OF_WEEK);


if (endd) {
//en=true;

%>

</table>
</td>


<%
stejob=0;
if (stejj==4) {
%>
</tr><tr>
<%
stejj=0;
}
stejj++;

}
%>
<td width=25% valign=top bgcolor=#F2F2F2	>
<table cellspacing=1 cellpadding=0 width=100% style="font-family: Verdana; font-size: 10px; border-collapse: collapse" bordercolor="#111111">
 <tr><td bgcolor="#646D87" align=center colspan=2><b><font color=white ><%=mesec[Integer.parseInt(mes)]%></font></b></td></tr>
<%
endd=true;
}
//mes = 
%>

<tr>



  <td bgcolor=#C0DBFA	align=left> 
   <a href="<%=nul.jeNull((omo[1]+""))%>" alt="<%=nul.jeNull((omo[1]+""))%>" target="_blank" style="text-decoration: none">
<%=nul.cutString(nul.jeNull((omo[1]+"")),25)%></a>
  </td>
  <td bgcolor=#DCE9F9	align=right>
    <%=(omo[0]+"")%>
  </td>


  
  
  </tr>

<%
week++;
  if (week == 8) {
    week=1;
  }
}





}
%>

</table>
</td></tr>
</table>
</body></html>

<%
   }
        catch (Exception ex) {

        System.out.println(ex.toString());
             }

  %>