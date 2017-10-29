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



%>

<script type="text/javascript" language="JavaScript">



</script>
 <table  border="0" width="262" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111"  id="AutoNumber1" cellpadding="0">
<tr><td><font size=1>&nbsp;</font></td><td >


<%








String mon = nul.getDatumFormat("MM");
String day = nul.getDatumFormat("yyyy");


Calendar cal = Calendar.getInstance();

Date dt = new Date();

cal.setTime(dt);

cal.set(Calendar.DAY_OF_MONTH, 1);
String next = "";
String prev = "";

//System.out.println(cal.get(Calendar.DAY_OF_WEEK) + " WWWWWWWWWWWWWWWWWWWWWWWWWWW");
String reti = "";
if (request.getParameter("month")!=null) {

	int yum = Integer.parseInt(request.getParameter("month"))-1;
	
	System.out.println("YUMMMMMMMMMMM ::: "+yum);
cal.set(Calendar.MONTH,yum);
reti = reti + "&month="+request.getParameter("month");
mon = request.getParameter("month");





}

if (request.getParameter("year")!=null) {

cal.set(Calendar.YEAR,Integer.parseInt(request.getParameter("year")));
reti = reti + "&year="+request.getParameter("year");
day = request.getParameter("year");
}


next = ((Integer.parseInt(mon)+1)==13?"1":(Integer.parseInt(mon)+1))+"";
prev = ((Integer.parseInt(mon)-1)==0?"12":(Integer.parseInt(mon)-1))+"";



if (next.length()==1) {
	next = "0"+next;
}
if (prev.length()==1) {
	prev = "0"+prev;
}


String[] mesi = {"JAN","FEB","MAR","APR","MAJ","JUN","JUL","AUG","SEP","OKT","NOV","DEC"};

System.out.println("CALENDAR: "+Calendar.MONTH);

int month = cal.get(Calendar.MONTH);

int month0 = month -1;
int month2= month+1;

int year = cal.get(Calendar.YEAR);

//if (request.getParameter("year")!=null) {
//year = Integer.parseInt(request.getParameter("year"));
//}

int year0 = year;
int year2 = year;
boolean jey=true;
//boolean jey2=false;
if (month0<0) {
month0 = 11;
//jey=true;
year0 = year0-1;
}


if (month2==12) {
month2 = 0;
//jey2=true;
year2=year2+1;
}


System.out.println("CALENDAR: "+month0 + " ::: "+month2 + " ::: "+month);


int dayf = cal.get(Calendar.DAY_OF_WEEK);
int stday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

cal.set(Calendar.MINUTE,0);
cal.set(Calendar.HOUR,-12);
cal.set(Calendar.SECOND,0);
cal.set(Calendar.MILLISECOND,0);


Date od = cal.getTime();

cal.set(Calendar.DAY_OF_MONTH,stday);
cal.set(Calendar.MINUTE,59);
cal.set(Calendar.HOUR,59);
cal.set(Calendar.SECOND,59);
cal.set(Calendar.MILLISECOND,999);
Date doo = cal.getTime();
/// dobim vse datume v mesecu

 com.popultrade.dao.MatchesDAO dao = (com.popultrade.dao.MatchesDAO)contextUtil.getBeanDao("matchesDAO",pageContext.getServletContext());
		List li = dao.getMatchesCal(mon,day);

		Iterator itt = li.iterator();
System.out.println("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE "+od + " :::::::::: "+doo);

Hashtable dni = new Hashtable();

		while (itt.hasNext()) {
			
			
			com.popultrade.model.Matches nj = (com.popultrade.model.Matches)itt.next();

dni.put(nul.getDatumFormatFromDate(nj.getMatch_date(),"dd"),nj.getId()+"" );
System.out.println("DODAMMMMMMMMMMMMM ::: "+nul.getDatumFormatFromDate(nj.getMatch_date(),"dd"));

}





%>




<table style="width: 250px; font-size:10px;font-family:Verdana;color:white" border="0" cellspacing="0" cellpadding="4">
	
	<tr>
	<td colspan="7" align="center" bgcolor="8c2208" height="25">
		<table style="width: 100%;font-size:12px;font-family:Verdana;color:white" cellpadding="0" cellspacing="1">
			<tr >
				<td align="center" > <b><%=year%></b>&nbsp;</td>
				
			</tr>
			</table></td>
	</tr>
	<tr>
	
		<td colspan="7" align="center" bgcolor="8c2705" height="25">
	
		<table style="width: 100%;font-size:12px;font-family:Verdana;color:white" cellpadding="0" cellspacing="1">
			
			<tr >
				<td align="center" width="25"><a href="index.jsp?month=<%=prev%><%=jey?"&year="+year0:""%>" style="text-decoration:none;color:white">&lt;</a></td>
				<td align="center"><a href="index.jsp?month=<%=prev%><%=jey?"&year="+year0:""%>" style="text-decoration:none;color:white"><%=mesi[month0]%></a></td>
				<td align="center"><%=mesi[month]%></td>
				<td align="center"><a href="index.jsp?month=<%=next%><%=jey?"&year="+year2:""%>" style="text-decoration:none;color:white"><%=mesi[month2]%></a></td>
				<td align="center" width="25"><a href="index.jsp?month=<%=next%><%=jey?"&year="+year2:""%>" style="text-decoration:none;color:white">&gt;</a></td>

			</tr>
		</table>
		</td>
	</tr>
	<tr height="20" bgcolor="ba3307">
		<td align="center" valign="middle" style="width: 36px">PON</td>
		<td align="center" valign="middle" style="width: 36px">TOR</td>
		<td align="center" valign="middle" style="width: 36px">SRE</td>
		<td align="center" valign="middle" style="width: 36px">CET</td>
		<td align="center" valign="middle" style="width: 36px">PET</td>
		<td align="center" valign="middle" style="width: 36px">SOB</td>
		<td align="center" valign="middle" style="width: 36px">NED</td>
	</tr>
	

<%






if (dayf==1) {
dayf = 7;
} 
else {
dayf=dayf-1;
}

int sr =0;
int sume = 1;

for (int i=1;i<=stday+(dayf-1);i++) {

if (i>=dayf) {
if (sr==0) {
%>
	<tr height="20" bgcolor="d4481a">
	<%
	}
	sr++;
	
	if (dni.containsKey(""+sume) || dni.containsKey("0"+sume)) {
	String inm = "";
	if (dni.containsKey(""+sume)) {
	inm = ""+dni.get(""+sume);	
	}
	else {
	inm = ""+dni.get("0"+sume);
	}
	
	%>
	<td align="center" valign="middle" bgcolor="ba3307" style="width: 36px" onMouseOver="showMatch('<%=inm%>')"><a href="index.jsp?includee=matches.jsp?idd=<%=inm+reti%>" style="text-decoration:none;color:white"><%=sume%></a></td>
	
		
<%
}
else {
%>
<td align="center" valign="middle" style="width: 36px"><%=sume%></td>
<%
}
%>
	
	<%
	sume++;
	if (sr==7) {
	%>
	</tr>
	<%
	sr=0;
	}
	%>
	
	
	


<%
}
else {
if (sr==0) {
	%>
	<tr height="20" bgcolor="d4481a">
<%
}
%>
		<td align="center" valign="middle" style="width: 36px">&nbsp;</td>

	
	<%
	sr++;
}
}
while (sr<=6) {
sr++;
%>

<td align="center" valign="middle" style="width: 36px">&nbsp;</td>

<%
}

%>
</tr>

	<tr>
		<td colspan="7" align="center" bgcolor="8c2705" height="35">
		<table style="width: 100%;font-size:10px;font-family:Verdana;color:white" cellpadding="0" cellspacing="1">
			<tr >
				<td align="center" ><div id="tekma"></div></td>
			

			</tr>
		</table>
		</td>
	</tr>

</table>























</td></tr>

<tr><td></td><td  height="15">&nbsp;</td></tr>

<tr><td></td><td height="25"><font color="8c2705" size="2" style="font-weight:bold">&nbsp;&nbsp;NOVICE</font></td></tr>

<tr><td></td><td>
<table border="0" cellspacing="4" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="5">
		
		
		<%
				 
		 com.popultrade.dao.NoviceDAO daol = (com.popultrade.dao.NoviceDAO)contextUtil.getBeanDao("noviceDAO",pageContext.getServletContext());
		List lil = daol.getNovices(new com.popultrade.model.Novice());

		Iterator itti = lil.iterator();
int zap= 3;
		while (itti.hasNext()) {
			if (zap>0)  {
				zap=zap-1;
			com.popultrade.model.Novice nj = (com.popultrade.model.Novice)itti.next();
			
//		System.out.println("+++++++++++++++++++++++++++++++ ::: "+nj.length);
		
		 
		%>
		<tr><td><b><font size=1><%=nul.getDatumFormatFromDate(nj.getDatum_novice(),"dd-MM-yyyy")%></font>
		<font color="8c2705" size=1><%=nul.cutStringAddPoints(nul.jeNull(nj.getNaslov_novice()),25)%><br>&nbsp;<br></font></b>
		<font size=1>

		
		<%=nul.cutString(nj.getOpis_novice(),70) %>
		</font><br>
		</td></tr>
		 <tr><td align="right"><a href="index.jsp?includee=novice_p.jsp?id=<%=nj.getId()%>"><img src="more.gif" border=0></a></td></tr>
		
		<%
		}
			else {
				break;
			}
		
		
	}
		
		%>
</table>
</td></tr>
</table>

<table border=0>
<tr>
<td align=center>
<img src="popultradeflag.gif" border=0>
</td>
</tr>
</table>



