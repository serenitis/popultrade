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

String lok_slik = control.lokacija_default_slik;

if (nul.jeNull(request.getParameter("slik")+"").equals("splosne")) {
 lok_slik = control.lokacija_splosno_slik;
}
else if (nul.jeNull(request.getParameter("slik")+"").equals("css")) {
lok_slik = control.lokacija_css_slik;
}



try {
//ServletContext scon=pageContext.getServletContext();
//String path = scon.getRealPath(lok_slik);

String path =request.getRealPath("")+"/"+ lok_slik;
//System.out.println("2222222222222");
if (!nul.jeNull(request.getParameter("imd")).equals("")) {

File dell = new File(path+"/"+request.getParameter("imd"));
System.out.println(path+request.getParameter("imd"));
dell.delete();


}
}
catch (Exception ex) {

System.out.println("Ne moram zbrisati slike default : "+ex.toString());
}




/// dobim vse slike
/*ServletContext scon=pageContext.getServletContext();
String path = scon.getRealPath(lok_slik);*/
String path =request.getRealPath("")+"/"+ lok_slik;
Vector ve = new Vector();
    try {

      //  System.out.println("Dzs dir:"+direktorij + " "+extension);
      File dir = new File(path);
      String[] fileti = dir.list();
      for (int h = 0; h < fileti.length; h++) {
     //   System.out.println(fileti[h] + " len> " + fileti.length);
        if (fileti[h].toString().indexOf(".")!=-1 && (fileti[h].toString().indexOf("png")!=-1 || fileti[h].toString().indexOf("gif")!=-1 || fileti[h].toString().indexOf("jpg")!=-1 )) { //////// najdem vse datoteke
          ve.add(fileti[h]);

        }
      }
    }
    catch (Exception ex) {
      throw new Exception("Napaka pri branju filov: "+ex.toString());
    }











%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>
<script language="javascript">

function gum() {

//parent.frames[2].location="nic.jsp";
}
</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">

<table border="0" width="100%" cellspacing=9 id="table1" height="100%"  bgcolor=#C3E1FC	>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="0" width="100%" id="table2" height="100%" cellspacing=3 cellpadding=5  >
			<tr>
			
			<%
			
			int stej = 0;
			
			for (int i=0;i<ve.size();i++) {
			
			stej++;
			
			if (stej==8) {
			stej=0;
			%>
			</tr><tr>
			<%
			}
			
			 %>
			
				<td bgcolor="#E3F1FE" align="center" valign="middle">
			<img src="<%=lok_slik+nul.jeNull(ve.get(i)+"")%>"><br>
			
			<%
			if (request.getParameter("op")==null) {
			 %>
			<a href="m_upload_d.jsp?imd=<%=nul.jeNull(ve.get(i)+"")%>&slik=<%=nul.jeNull(request.getParameter("slik")) %>" >REMOVE</a>
			<%
			}
			else {
			
			if (nul.jeNull(request.getParameter("slik")).equals("splosne")) {
			%>
			
			<a href="#" onclick="parent.setImage2('<%=nul.jeNull(ve.get(i)+"") %>')" >SELECT</a>
			
			<%
			}
			else {
			
			%>
			
			<a href="#" onclick="parent.setImage('<%=nul.jeNull(ve.get(i)+"") %>')" >SELECT</a>
			
			<%
			}
			}
			 %>
			
				</td>
				
				<%
				
				}
				
				for (int k=stej;k<8;k++){
				%>
				<td></td>
				<%
				}
				
				
				 %>
				
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>

</html>

 
 
 

