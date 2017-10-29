<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
 <jsp:useBean id="templateUtil" scope="session" class="com.popultrade.webapp.TemplateUtils" />
 
 
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);
if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%><jsp:forward page="m_loginu.html"/><%
}


try {
	
	
	
	if (request.getParameter("avtomatika")!=null && request.getParameter("avtomatika").equals("yes"))  {

com.popultrade.dao.TemplateViewDAO dao2 = (com.popultrade.dao.TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO",pageContext.getServletContext());

Enumeration eno = request.getParameterNames();

com.popultrade.model.TemplateView sif = new com.popultrade.model.TemplateView();
while (eno.hasMoreElements()) {

String name = (String)eno.nextElement();

System.out.println("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ "+name);

if (name.indexOf("ID_")!=-1) {

///zapisem v bazo elemente
String imo = request.getParameter(name);

sif = new com.popultrade.model.TemplateView();


sif.setZaporedje(Integer.parseInt(request.getParameter("SI_"+imo)));
 sif.setStolpec_metoda(imo.replace("Y_Y",".").replace("X_X","()"));
sif.setStolpec_align("left");
sif.setTip_polja("NP");
sif.setStolpec_naziv(imo.substring(3).replace("Y_Y",".").replace("X_X","()"));

String dolz = request.getParameter("I"+name);

if (dolz!=null && !dolz.equals("")) {

	
}


sif.setTemplatehead_id(new Long(request.getParameter("idt")));
dao2.saveTemplateView(sif);
}





}

%>

<table border="0" cellspacing="1" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt"  width="100%" >
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
<tr>
<td width="100%"  class="valuecell">
<p align="center">PODATKI VNESENI/SPREMENJENI</td>
</tr>
<tr>
<td width="100%"  class="opiscell">&nbsp;</td>
</tr>
</table>

<script language=javascript>


  document.location = "m_templateview.jsp?idt=<%=request.getParameter("idt")%>";


</script>

<%


}
	
	else {
	
	

// get list from daoobject
com.popultrade.dao.TemplateViewDAO dao = (com.popultrade.dao.TemplateViewDAO)contextUtil.getBeanDao("templateViewDAO",pageContext.getServletContext());
com.popultrade.model.TemplateView sif = new com.popultrade.model.TemplateView();
sif.setTemplatehead_id(new Long(request.getParameter("idt")));


List lis =null;

lis = dao.getTemplateViews(sif);


Iterator it = lis.iterator();
Hashtable obstaja= new Hashtable();
boolean prvi = false;
int zaporedje = 5;
while (it.hasNext()){  // while start
	
	com.popultrade.model.TemplateView vseb = (com.popultrade.model.TemplateView)(it.next());
	
	if (vseb.getStolpec_metoda()!=null && vseb.getZaporedje()!=null ){
	obstaja.put(vseb.getStolpec_metoda(),vseb.getZaporedje()+"");
	
	if (vseb.getZaporedje()>zaporedje) {
	zaporedje = vseb.getZaporedje();
	}
	}
	}
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

</head>

<style> 
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  text-shadow: 1px 1px 3px #666666;
  font-family: Arial;
  color: #ffffff;
  font-size: 12px;
  padding: 0px 4px 0px 4px;
  border: solid #377499 2px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
</style>
<script language="javascript">

function gum() {

parent.frames[3].location="nic.jsp";
}


zapt = <%=zaporedje%>;

function dodajZaporedje(kam,trenutnozap) {

var tree = eval("document.dod."+kam+"");
var tree2 = eval("document.dod."+trenutnozap+"");
if (tree.value==(zapt+'') && !tree2.checked) {
tree.value="";
zapt = zapt-5;
}
else if (tree2.checked) {
zapt = zapt+5;

tree.value=zapt;
}
else {tree.value="";}
}
/// kontrola, ce vsi chekirani imajo zaporedje
function chek() {

  var elements = document.forms['dod'].elements;
  for (i=0; i<elements.length; i++){
    
    
    if (elements[i].type=="checkbox" && elements[i].checked) {
    
    smot = elements[i].value;
  //  alert(smot);
    evv = eval("document.dod.SI_"+smot);
    if (evv.value!="") {
    
    }
    else {
    alert("Napaka: element "+smot +" nima vnesenega zaporedja!");
    return false;
    }
    
    
    }
    
  }


}


</script>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="gum()">


<form name=dod action="m_templateview_avt.jsp" method="post" onsubmit="return chek()" >
<input type=hidden name="avtomatika" value="yes">
<input type=hidden name="idt" value="<%=nul.jeNull(request.getParameter("idt"))%>">
<table border="0" width="100%" cellspacing=9 id="table1" height="100%"  bgcolor=#C3E1FC	>


<tr>
<td width="100%"  class="opiscell" bgcolor="#E3F1FE"  colspan=5>Izberi polja za katera zelis avtomatsko generacijo. Ob izbiri se doda avtomaticno zaporedje, zaporedje je mogoce tudi rocno popraviti. Polja , ki se ne da izbrati so ze generirana.</td>
</tr>
	<tr>
		<td align="center" valign="middle"><font style="font-size: 4pt">&nbsp;
		</font>
		<table border="0" width="100%" id="table2" height="100%" cellspacing=3 cellpadding=5  >
			<tr>
			
			
							
					<%
					 
					String headname="";
					int stej = 0;
						if (true) {
					
					//// dobim ime model clase iz headerja
					
					com.popultrade.model.TemplateHead thead =new com.popultrade.model.TemplateHead();
com.popultrade.dao.TemplateHeadDAO daoth = (com.popultrade.dao.TemplateHeadDAO)contextUtil.getBeanDao("templateHeadDAO",pageContext.getServletContext());


					thead = daoth.getTemplateHead(new Long(request.getParameter("idt")));
					
					headname=nul.jeNull(thead.getHead_class_name());
					
					
					
					//// dobim iz templatetables , ce je
					
					
					com.popultrade.model.TemplateTables ttt =new com.popultrade.model.TemplateTables();
					com.popultrade.dao.TemplateTablesDAO dattt = (com.popultrade.dao.TemplateTablesDAO)contextUtil.getBeanDao("templateTablesDAO",pageContext.getServletContext());

					
					ttt.setTable_name_hibernate(headname);
					Hashtable cols = new Hashtable();
					
					List rex = dattt.getTemplateTabless(ttt, 1, 1, "", "", "");
					
					if (rex.size()==1) {
						
						com.popultrade.model.TemplateTables  ttx = (com.popultrade.model.TemplateTables)rex.get(0);
						
						List rp = ttx.getTemplateTablesCol();
						
						if (rp!=null) {
							
							Iterator itx = rp.iterator();
							while (itx.hasNext()) {
								
								com.popultrade.model.TemplateTablesCol ttc = (com.popultrade.model.TemplateTablesCol)itx.next();
								
								
								cols.put(nul.jeNull(ttc.getField_name()).toLowerCase(), ttc.getDescription()+"-----"+nul.jeNull(ttc.getWidth()));
								
								
							}
							
						}
						
						
					}
					
					
				//// konec dobim iz templatetables , ce je
					 
					List li = templateUtil.getClassMetodeImena(contextUtil,this.getServletContext(),"com.popultrade.model."+thead.getHead_class_name());
					
					Iterator itti = li.iterator();

					while (itti.hasNext()) {
					
						String nex =(String)itti.next();
						if (stej==5) {
			stej=0;
			%>
			</tr><tr>
			<%
			}
			stej++;
							
							%><td bgcolor="#E3F1FE"  valign="middle">
							<table border="0" width="100%"  height="100%" >
										<%
							String ino = nex.substring(0,nex.indexOf(" ----XXX---- "));
							
							ino = ino.toLowerCase().replace("get", "");
							
							System.out.println("::::::::::::::::: "+ino + " ::::: ");
							String vredd = "";
							String dolz = "";
							if (cols.containsKey(ino)) {
								String bo = cols.get(ino).toString();
								
								vredd = bo.substring(0,bo.indexOf("-----"));
								dolz = bo.substring(bo.indexOf("-----")+5);
								
						%>
							
								<tr><td colspan=3 bgcolor='#f7fbff'>
						
							<%=nul.jeN(vredd) %>&nbsp;
							</td></tr>
							
							<%		
							}
							%>
							
							<tr>
							<td align="center" width=5><input type="text"  <%=obstaja.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  id="SI_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  name="SI_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" value="<%=obstaja.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?obstaja.get(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")):"" %>" style="font-family: Verdana; width:33; border:0px; font-size: 10pt;background-color:#E3F1FE; font-weight:bold;color:red" ></td>
							<td  align="center" valign="middle" width=15>
							<input type='checkbox' <%=obstaja.containsKey(nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X"))?"disabled":"" %>  onclick="dodajZaporedje('SI_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>','ID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>')" name="ID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>"  id="ID_<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>" style="font-family: Verdana; font-size: 8pt" value="<%=nex.substring(0,nex.indexOf(" ----XXX---- ")).replace(".","Y_Y").replace("()","X_X")%>">
						
							</td>
							<td  align="left" valign="middle" >
							<b><%=nex.replaceAll(" ----XXX---- ","</b> (") +")"%>
							</td>
							
							
							
							
							
		<!-- 					<td width=25 align=center>

   
          <a class="btn" href="">Z</a>
     



</td>-->
							</tr>
							</table></td>
							<%	
							
							
						
					}
					}
					
			
			
					for (int k=stej;k<5;k++){
				%>
				<td></td>
				<%
				}
			%>
			 
	
				
			</tr>
			
			<tr><td colspan=5 align=center>	<input type="submit" value="Generiraj polja" style="font-family: Verdana; font-size: 8pt">
                		</td></tr>
			
		</table>
		</td>
	</tr>
</table>
</form>
</body>

</html>

 
  <%
}
}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
%>
 

