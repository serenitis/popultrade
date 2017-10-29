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
String imefile = "TemplateGumbi"; //// ime file mora biti isti kot ime class fileta zaradi kreacije insertov, prva crka velika, ce je tako ime class file ali hibernate file

try {
%>



<////%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%////>
<////jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<////jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<////jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<////jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />



<////%
////request.setCharacterEncoding(control.encoding);
////response.setContentType("text/html; charset="+control.encoding);
////response.addHeader("Pragma" , "No-cache") ;
////response.addHeader("Cache-Control", "no-cache") ;
////response.addDateHeader("Expires", 0);
////if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
%////><jsp////:forward page="m_loginu.html"/><////%
////}
%////>
<////%

// stevilo prikazov vrstic

int stpri = control.st_vrstic;


// steje stevilo vrstic
int stej = 0;

// barve vrstic
String[] colors = {"plava1","plava2","silver"};





// stevilo vrstic
int stvrstic=0;

String iskanje="";

try {

// get list from daoobject
com.popultrade.dao.<%=imefile %>DAO dao = (com.popultrade.dao.<%=imefile %>DAO)contextUtil.getBeanDao("<%=imefile.toLowerCase() %>DAO",pageContext.getServletContext());


if (request.getParameter("akcija")!=null && request.getParameter("akcija").equals("DELETE"))  {
	

	dao.remove<%=imefile %>(new Long(request.getParameter("id")));

	
}


int pagenum=1;
int stizpisov=stpri;

if (request.getParameter("pagenumber")!=null && !request.getParameter("pagenumber").equals("")) {

	pagenum = Integer.parseInt(request.getParameter("pagenumber"));
	session.putValue("pagenumber<%=imefile %>",pagenum+"");
	}
	else {
	if (session.getValue("pagenumber<%=imefile %>")!=null) {
	pagenum = Integer.parseInt(session.getValue("pagenumber<%=imefile %>")+"");
	}
	}


com.popultrade.model.<%=imefile %> sif = new com.popultrade.model.<%=imefile %>();
int strec = dao.getSt<%=imefile %>(sif);



List lis =null;

lis = dao.get<%=imefile %>s(sif);







%////>
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
</style>
<script language='javascript' src='colors.js' ></script>
<script type="text/javascript" language="JavaScript" src="tooltip.js"></script>

<script language=javascript>

////////// potrditev brisanja
function vprasaj() {
  var a = window.confirm("Potrdis brisanje?");
  if (a==true) {

    return true;
  }
  else {
    return false;
  }
}


function chg() {


    <%
if (request.getParameter("idback")!=null && !request.getParameter("idback").equals("null")) {
  %>
kliknivSivo(document.getElementById("sprememba"),document.getElementById("sprememba").className);
window.scroll(1,document.getElementById("sprememba").offsetTop-15);

  <%
}
  %>


  <////%
if (request.getParameter("idback")!=null && !request.getParameter("idback").equals("null") && !request.getParameter("idback").equals("")) {
  %////>
kliknivSivo(document.getElementById("sprememba"),document.getElementById("sprememba").className);
window.scroll(1,document.getElementById("sprememba").offsetTop-15);

  <////%
}
  %////>

parent.frames[2].location = "nic.jsp";
parent.frames[3].location = "nic.jsp";
}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster3.js"></script>

<script language=javascript>

<%
/////////// nastimam imena ko grem gor s misko

    BufferedReader  in = new BufferedReader(new InputStreamReader(new FileInputStream("c:/"+imefile+".txt"),"utf-8"));
         
          String linee="";
          String ime_polja="";
          String type_polja="";
          String length_polja="";
          //boolean jena=false;
          int stej=0;
          boolean emo = false;
          
     
          while ( (linee = in.readLine()) != null) {
        	  
        	  
        	  if (linee.indexOf("@hibernate.property")!=-1) {
                  // out.write(linee+"\r" +"\n");
                   if (!ime_polja.equals("")) {
                 	
                	   
                	   %>
                	   p<%=stej%>="<%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>";
                	   <%
                 	  stej++;
                 	
                  	  }
                 	  
                 	  ime_polja="";
                 	  type_polja="";
                 	  length_polja="";
                 	  stej++;
                   }
     				//jena=true;


     if (linee.indexOf("column=\"")!=-1) {
    
     	ime_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
     }
     if (linee.indexOf("type=\"")!=-1) {
     	type_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
     }
     if (linee.indexOf("length=\"")!=-1) {
     	length_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
     }
          }
          
          if (!ime_polja.equals("")) {
          
          System.out.println(ime_polja + " -----------------------");
             %>
                	   p<%=stej%>="<%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %>";
                	   <%
                	   System.out.println(ime_polja + " -----------------------+");
          }


%>

</script>


<body  style="margin: 0"   background="podlaga.jpg" bgproperties="fixed"  onLoad="chg();menuBarInit()" >
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<div id="divBg" style="width:100%">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style=" font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">


<%

 in = new BufferedReader(new InputStreamReader(new FileInputStream("c:/"+imefile+".txt"),"utf-8"));
     
      linee="";
      ime_polja="";
      type_polja="";
      length_polja="";
      //boolean jena=false;
      stej=0;
      int bar = 0;
      String[] barv = new String[2];
      barv[0]="ADD9FF";
      barv[1]="D2EAFF";
      Hashtable htvs= new Hashtable();
      int htvsst=0;
      while ( (linee = in.readLine()) != null) {
    	  
    	  
    	  if (linee.indexOf("@hibernate.property")!=-1) {
              // out.write(linee+"\r" +"\n");
               if (!ime_polja.equals("")) {
             	if (bar==2) {
             		bar=0;
             	}
            	   
            	   %>
            	   <td width=15% align=center bgcolor="<%=barv[bar] %>" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p<%=stej %>)"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %></td>
               
            	   <%
            	   
            	  String vsem="<td width=\"15%\" align=\"left\"><////%=nul.jeNull(vseb.get"+ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) +"())%////></td>";
            	  htvs.put(htvsst+"",vsem);
            	  htvsst++;
            	  
            	  bar++;
             	  stej++;
             	
              	  }
             	  
             	  ime_polja="";
             	  type_polja="";
             	  length_polja="";
             	  stej++;
               }
 				//jena=true;


 if (linee.indexOf("column=\"")!=-1) {
 	ime_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
 }
 if (linee.indexOf("type=\"")!=-1) {
 	type_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
 }
 if (linee.indexOf("length=\"")!=-1) {
 	length_polja=linee.substring(linee.indexOf("\"")+1,linee.lastIndexOf("\""));
 }
      }
      
      
      
              if (!ime_polja.equals("")) {
             
            	   //System.out.println("ime_polja ::: " + ime_polja);
            	   if (bar==2) {
             		bar=0;
             	}
            	   %>
            	   <td width=15% align=center bgcolor="<%=barv[bar] %>" onmouseout="hideddrivetip()" onmousemove="ddrivetip(p<%=stej %>)"><%=(ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length())).replaceAll("_"," ") %></td>
               
            	   <%
            	  // System.out.println("ime_polja ::: 0 " + ime_polja);
            	  String vsem="<td width=\"15%\" align=\"left\"><////%=nul.jeNull(vseb.get"+ime_polja.substring(0,1).toUpperCase()+ime_polja.substring(1,ime_polja.length()) +"())%////></td>";
            	   //System.out.println("ime_polja ::: 2 " + ime_polja);
            	  htvs.put(htvsst+"",vsem);
            	   //System.out.println("ime_polja ::: 3 " + ime_polja);
            	  htvsst++;
            	  
            	  bar++;
             	  stej++;
             	
              	  }
      
      
      

%>

              
                 <td  bgcolor="D2EAFF" align=center><a onClick="return godown('m_<%=imefile.toLowerCase() %>_edit.jsp?opcija=new&siframm=new&sifrant=<%=request.getParameter("sifrant")%>')" href="Javascript: PGAPP()"><img title="Dodaj nov <%=imefile %>" border="0" src="vnos.gif" /></a></td>
        </tr>
 

</table>
</div>






<table width=100% cellspacing=1  style=" font-family: Verdana; font-size: 7pt">
<tr><td colspan=3>&nbsp</td></tr>
<////%

/// menja barvo
int br = 0;
String oe_kup_nap = "";


Iterator it = lis.iterator();


while (it.hasNext()){  // while start
	
	com.popultrade.model.<%=imefile %> vseb = (com.popultrade.model.<%=imefile %>)(it.next());
		stvrstic++;

if (br==2){
  br=0;
}

if (vseb.getId().toString().equals(nul.jeNull(request.getParameter("idback")))) {
%////>
<tr class="<////%=colors[br]%////>" id=sprememba onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<////%=colors[br]%////>')">
<////%
}
else {
%////>
<tr class="<////%=colors[br]%////>"  onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<////%=colors[br]%////>')">
<////%
}

%////>
<%
for (int i=0;i<htvsst;i++) {
	%>
	<%=htvs.get(i+"") %>
	<%
}
%>


<td  align="center">

 <a href="Javascript:PGAPP()" onCLick="return go('<////%=vseb.getId()%////>&opcija=spremeni&siframm=new&idback=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter("sifrant")%////>',1)"><img src="u.gif" border=0 onClick="kliknivSivo(this,'<////%=colors[br]%////>');" title="Spremeni podatke"></a>


 <a onClick="return vprasaj()" href="m_<%=imefile.toLowerCase() %>.jsp?akcija=DELETE&id=<////%=vseb.getId()%////>&sifrant=<////%=request.getParameter("sifrant")%////>"><img src="x.gif" border=0 title="Brisi"></a>



</td>
</tr>

<////%
br++;

}/////////////// while end


 %////>
  
</table>


<script language=javascript>
function go(asd,vv){
  if (vv == 1){
    aaa = "m_<%=imefile.toLowerCase() %>_edit.jsp?id="+asd;
    parent.frames[2].location = aaa;
  }

return false;
}
function godown(asd){
parent.frames[2].location = asd;
return false;
}
function PGAPP(){
}

</script>


<////%
// st izpisov
if (strec>stizpisov) {
	String iskk="";
	if (iskanje) {
		iskk="&isk=1";
		}
%////><p align=center>
<table  border="0" cellpadding="7" cellspacing="1" style="border-collapse: collapse; font-family:Verdana; font-size:8pt;">
<tr bgcolor="ededed">
<td align=center >
Browse page: </td><td>
 <a style="text-decoration:none;color:black"  href="m_<%=imefile.toLowerCase() %>.jsp?pagenumber=1<////%=iskk%////>">first</a></td><td>|</td>


<////%
int vse=0;
int ststr=0;

int prvii=nul.jeNull(session.getValue("pagenumber<%=imefile %>")+"").equals("")?1:Integer.parseInt(session.getValue("pagenumber<%=imefile%>")+"");

if (prvii>1) {
int prej = prvii-1;
%////>
<td>
 <a style="text-decoration:none;color:black"  href="m_<%=imefile.toLowerCase() %>.jsp?pagenumber=<////%=prej%////><////%=iskk%////>">previous</a></td>

<td>|</td>
<////%
}
%////>
<////%

for (int y=0;y<strec;y++) {
vse++;
if (vse==stizpisov) {
vse=0;

ststr++;
if ((prvii-5)<ststr && ststr<(prvii+5)) {
%////>
<td align=center bgcolor="<////%=nul.jeNull(session.getValue("pagenumber<%=imefile %>")+"").equals(ststr+"")?"white":"ededed" %////>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_<%=imefile.toLowerCase() %>.jsp?pagenumber=<////%=ststr %////><////%=iskk%////>"><////%=ststr %////></a> </td><td>|</td>
<////%

}
}
%////>

<////%
}
if (vse!=0) {
	%////>
	<td align=center bgcolor="<////%=nul.jeNull(session.getValue("pagenumber<%=imefile %>")+"").equals(ststr+1+"")?"white":"ededed" %////>"> <a hrefs="" style="text-decoration:none;color:black"  href="m_<%=imefile.toLowerCase() %>.jsp?pagenumber=<////%=ststr+1 %////><////%=iskk%////>"><////%=ststr+1 %////></a> </td><td>|</td>
	<////%
	
	
}



if (prvii<=ststr) {
int prej = prvii+1;
%////>
<td>
 <a style="text-decoration:none;color:black"  href="m_<%=imefile.toLowerCase() %>.jsp?pagenumber=<////%=prej%////><////%=iskk%////>">next</a></td>

<td>|</td>
<////%
}
%////>



<td><a style="text-decoration:none;color:black"  href="m_<%=imefile.toLowerCase() %>.jsp?pagenumber=<////%=ststr+1%////><////%=iskk%////>">last</a></td>
<td>|</td>
<td >
page: <////%=nul.jeNull(session.getValue("pagenumber<%=imefile %>")+"").equals("")?"1":session.getValue("pagenumber<%=imefile %>")%////> of <////%=ststr+1%////> </td>
<td>|</td>
<td>
records: <////%=strec%////></td>
</tr>
</table></p>
<////%
}
%////>

</body></html>
 <////%

}
catch (Exception ex){
	////org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	////log.error(ex.toString());
}

%////>


<%

}
catch (Exception ex){
System.out.println("Nastavitve: "+ex.toString());
}
%>
