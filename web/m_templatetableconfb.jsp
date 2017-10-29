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
%>
<%

// stevilo prikazov vrstic

int stpri = 100;


// steje stevilo vrstic
int stej = 0;

// barve vrstic
String[] colors = {"plava1","plava2","silver"};





// stevilo vrstic
int stvrstic=0;

boolean iskanje = false;


try {

	
// get list from daoobject
com.popultrade.dao.TemplateTablesDAO dao = (com.popultrade.dao.TemplateTablesDAO)contextUtil.getBeanDao("templateTablesDAO",pageContext.getServletContext());




int pagenum=1;
int stizpisov=stpri;




Hashtable vseb = dao.getTableStructure(request.getParameter("tablename"));




/// dam manjkajoca polja v hibernate


if (nul.jeN(request.getParameter("kato")).equals("ino")) {
	//System.out.println("::: : 1x" );

// get list from daoobject
com.popultrade.dao.TemplateTablesColDAO daof = (com.popultrade.dao.TemplateTablesColDAO)contextUtil.getBeanDao("templateTablesColDAO",pageContext.getServletContext());


com.popultrade.model.TemplateTablesCol sifo = new com.popultrade.model.TemplateTablesCol();
sifo.setId_nad(new Long(request.getParameter("id_nad")));

List lis =null;
//System.out.println("::: : 2x" );
lis = daof.getTemplateTablesCols(sifo,pagenum,stizpisov,"","field_name","asc");
	
Hashtable ima = new Hashtable();


Iterator ito = lis.iterator();

while (ito.hasNext()) {
	
	com.popultrade.model.TemplateTablesCol tlo = (com.popultrade.model.TemplateTablesCol)ito.next();
	//System.out.println("::: : "+tlo.getField_name() );
	ima.put(tlo.getField_name(), nul.jeNull(tlo.getWidth()));
	
	
	
	
	
}
//System.out.println("::: : 2x" );

Enumeration iko = vseb.keys();


while (iko.hasMoreElements()) {
	
	String kok = (String)iko.nextElement();
	
	//System.out.println("::: : "+kok );
	
	/// dodam v bazo
	if (!ima.containsKey(kok)) {
		
		com.popultrade.model.TemplateTablesCol sif = new com.popultrade.model.TemplateTablesCol();
		sif.setId_nad(new Long(request.getParameter("id_nad")));
		
		String type= "";
		String h_type_java="";
		String[] vro = vseb.get(kok).toString().split("-----");
		
		int dolz=0;
		
		try {
			
			if (vro[1].indexOf("(")==-1) {
				dolz = Integer.parseInt(vro[1]);
			}
			else {
				String dek = vro[1].substring(vro[1].indexOf("(")+1,vro[1].lastIndexOf(")"));
				dolz = Integer.parseInt(dek);
				
				
			}
			
		}
		catch (Exception nom) {
			
		}
		
		
		
		if (vro[0].indexOf("char")!=-1 || vro[0].indexOf("var")!=-1) {
			type = "varchar";
			h_type_java = "String";
		}
		else if (vro[0].indexOf("timestamp")!=-1 || vro[0].indexOf("date")!=-1) {
			type = "timestamp";
			h_type_java = "Date";
		}
		else if (vro[0].indexOf("number")!=-1 && dolz==10) {
			type = "number";
			h_type_java = "Long";
		}
		else if (vro[0].indexOf("number")!=-1 && dolz<=5) {
			type = "number";
			h_type_java = "Integer";
		}
		else if (vro[0].indexOf("number")!=-1 && dolz>5) {
			type = "number";
			h_type_java = "Double";
		}
		else if (vro[0].indexOf("bigint")!=-1) {
			type = "number";
			h_type_java = "Long";
		}
		else if (vro[0].indexOf("int")!=-1) {
			type = "number";
			h_type_java = "Integer";
		}
		else if (vro[0].indexOf("double")!=-1) {
			type = "number";
			h_type_java = "Double";
		}
		else if (vro[0].indexOf("text")!=-1) {
			type = "text";
			h_type_java = "String";
		}
		else if (vro[0].indexOf("byte")!=-1) {
			type = "blob";
			h_type_java = "byte[]";
		}

		
	//	System.out.println(":::: "+type );
		
		sif.setType(type);
		sif.setH_type_java(h_type_java);

		if (kok.equals("id")) {
			
			sif.setIs_primarykey("1");
			sif.setIncrement_type("SEQUENCE");
			sif.setSequence_name("popultrade_seq");
		}
		
		
		sif.setField_name(kok);
		sif.setField_name_db(kok);
		sif.setH_connection_cascade("REMOVE");
		
		if (dolz>0) {
		sif.setWidth(dolz+"");
		}
		
		daof.saveTemplateTablesCol(sif);
		
		
		
		
	}
	
	
	
	
}






	
}








%>
<html><head><title></title></head>
<style>

A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>
<style type=text/css>

@import "barve.css";
@import "tooltipcss.css";
@import "sbuttoni.css";
</style>
<script language='javascript' src='colors.js' ></script>
<script type="text/javascript" language="JavaScript" src="tooltip.js"></script>
<script type="text/javascript" language="JavaScript" src="datum2.jsp"></script>
<script language=javascript>

// potrditev brisanja
function vprasaj() {
  var a = window.confirm("Potrdi brisanje?");

  if (a==true) {
//alert(a);
    return true;
  }
  else {
    return false;
  }
}








function chg() {


    <%
    if (nul.jeN(request.getParameter("kato")).equals("ino")) {

    %>
parent.frames[0].location = "m_templatetableconf.jsp?id_nad=<%=request.getParameter("id_nad") %>&tablename=<%=request.getParameter("tablename")%>&modelname=<%=request.getParameter("modelname")%>&idg=<%=request.getParameter("idg") %>";
<%
    }
%>
//parent.frames[1].location = "nic.jsp";
//parent.frames[2].location = "nic.jsp";

}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>


	               	   p1="Ime polja";
	               	   
	               	   p2="Type data";
					
	               	   p4="UDT name";
						
	               	   
	               	   </script>



<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="1" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:8pt">


        <tr bgcolor="2686D8">

 <td width=42% align=left bgcolor="ADD9FF" onmouseout="hideddrivetip()"  ondragover="allowDrop(event)"  ondrop="drop('TemplateTables','')"  onmousemove="ddrivetip(p1)"><b>Baza tabela</b> - Ime polja</td>

            	   <td width=28% align=center bgcolor="D2EAFF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p2)">Type</td>
               
            	

            	   <td width=28% align=center bgcolor="ADD9FF" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p4)">UDT</td>
         
               
            	    

              
                 <td  bgcolor="D2EAFF" align=center>
<a onClick="document.location='m_templatetableconfb.jsp?kato=ino&id_nad=<%=request.getParameter("id_nad") %>&tablename=<%=request.getParameter("tablename")%>&modelname=<%=request.getParameter("modelname")%>&idg=<%=request.getParameter("idg") %>'" href="Javascript: PGAPP()"><img title="Dodaj manjkajoca polja v hibernate iz baze" border="0" src="a.gif" /></a>
             
                 
                 </td>
        </tr>
 

</table>
</div>






<table width=100% cellspacing=1  cellpadding=1  style=" font-family: Verdana; font-size: 7pt">

<tr><td colspan=4><font style="font-size:9pt">&nbsp;</font></td></tr>

<%

/// menja barvo
int br = 0;
String oe_kup_nap = "";

List tmp = Collections.list(vseb.keys());
Collections.sort(tmp);
Iterator it = tmp.iterator();

while(it.hasNext()){
    String element =(String)it.next();
    //here you can get ordered things: 'your_hashtable'.get(element);
if (br==2) {
	br=0;
}

%>
<tr class="<%=colors[br]%>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')" >

<td width="42%" align="left"   >



<%=element%></td>

<%
String[] spl = vseb.get(element).toString().split("-----");

%>


	<td width="28%" align="left"><%=nul.jeNull(spl[0])%></td>

<td width="28%" align="left"><%=nul.jeNull(spl[1])%></td>



<td  align="center">

&nbsp;
&nbsp;
</td>
</tr>




<%
br++;
System.out.println("ZZZZZZZZZZZZZZZZZ 2");
}/// while end


 %>
  
</table>


<script language=javascript>
function go(asd,vv){


return false;
}
function godown(asd){
	top.parent.frames[3].location = asd;
return false;
}
function godown2(asd){
	top.top.parent.frames[3].location = asd;
return false;
}
function PGAPP(){
}

</script>


</body></html>
 <%

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}

%>



