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
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}

String lok_slik = control.css_datoteke;



try {

	
	
	if (nul.jeN(request.getParameter("remove")).equals("yes")) {
		File fim = new File(lok_slik+request.getParameter("filenamee"));
		fim.delete();
	}
	
	

}
catch (Exception ex) {

System.out.println("Ne moram zbrisati slike default : "+ex.toString());
}








/// dobim vse slike
//ServletContext scon=pageContext.getServletContext();
String path = lok_slik;
Vector ve = new Vector();
    try {

      //  System.out.println("Dzs dir:"+direktorij + " "+extension);
      File dir = new File(path);
      String[] fileti = dir.list();
      for (int h = 0; h < fileti.length; h++) {
     //   System.out.println(fileti[h] + " len> " + fileti.length);
        if (fileti[h].toString().indexOf(".")!=-1 && (fileti[h].toString().indexOf("css")!=-1)) { //////// najdem vse datoteke
          ve.add(fileti[h]);

        }
      }
    }
    catch (Exception ex) {
      System.out.println("Napaka pri branju filov: "+ex.toString());
    }











%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {

parent.frames[2].location="nic.jsp";
parent.frames[3].location="nic.jsp";
}


function godown(vredno) {

parent.frames[2].location = "m_css_file_edit.jsp?name="+vredno;


}

function PGAPP(){
}


function generiraj() {


}
//potrditev brisanja
function vprasaj() {
  var a = window.confirm("Potrdis brisanje?");

  if (a==true) {

    return true;
  }
  else {
    return false;
  }
}

</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">

<table border="0" width="100%" cellspacing=9 id="table1" height="100%"  bgcolor=#C3E1FC	>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="0" width="100%" id="table2" height="100%" cellspacing=3 cellpadding=5  >
			
				<tr>
				<td bgcolor="#E3F1FE" align="left" valign="middle" width="99%">
			CSS file
			</td>
			<td align="center" valign="middle" width="95%">
			 <a href="Javascript:PGAPP()" onCLick="return godown('new')">ADD</a>
	
			</td>
		
				</tr>
			<%
			
			int stej = 0;
			
			for (int i=0;i<ve.size();i++) {
			
			stej++;
			
		
			
			 %>
			<tr>
				<td bgcolor="#E3F1FE" align="left" valign="middle" width="95%">
			<a href="Javascript:PGAPP()" onCLick="return godown('<%=nul.jeNull(ve.get(i)+"")%>')"><%=nul.jeNull(ve.get(i)+"")%></a>
			</td>
			<td>
			 <a  href="m_css_list.jsp?remove=yes&filenamee=<%=nul.jeNull(ve.get(i)+"")%>" onclick="return vprasaj()">DEL</a>
	
			</td>
		
				</tr>
				<%
				
				}
				
			
				
				
				 %>
				
			
		</table>
		</td>
	</tr>
	

	
	
</table>

</body>

</html>

 
 
 

