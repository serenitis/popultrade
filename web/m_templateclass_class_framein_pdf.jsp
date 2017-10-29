<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>


  <jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />


<%

if (control.getUser().equals("anonymous") || !control.getPrivilegijeUporabnika().equals("A")) {
	%><jsp:forward page="m_loginu.html"/><%
	}
	
String userAgent = request.getHeader( "User-Agent" );
boolean isFirefox = ( userAgent != null && userAgent.indexOf( "Firefox/" ) != -1 );
String size="0";
String scrol = "yes";
if (isFirefox) {
size="1";
scrol="auto";
}


session.setAttribute("idp",request.getParameter("idp"));/*
System.out.println("::::::::::::: "+request.getParameter("idg"));
session.setAttribute("idg",request.getParameter("idg"));
session.setAttribute("idt",request.getParameter("idt"));*/
session.setAttribute("predpona",request.getParameter("predpona"));
session.setAttribute("glavno",request.getParameter("glavno"));
%>

<html>



<link href='js/css/sm-core-css.css' rel='stylesheet' type='text/css' />
<!-- "sm-blue" menu theme (optional, you can use your own CSS, too) -->
<link href='js/css/sm-simple/sm-simple.css' rel='stylesheet' type='text/css' />



  <link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/styles/jqx.classic.css" type="text/css" />
    <script type="text/javascript" src="scripts/jquery.min.js"></script> <script type="text/javascript" src="scripts/jquery-migrate.min.js"></script>
    <script type="text/javascript" src="js/jqxcore.js"></script>
    <script type="text/javascript" src="js/jqxsplitter.js"></script>
<link rel="stylesheet" href="js/styles/jqx.base.css" type="text/css" />

<script src="js/jquery.smartmenus.js" type="text/javascript"></script>

    
<!-- #main-menu config - instance specific stuff not covered in the theme -->
<style type="text/css">
	#main-menu {
		position:relative;
		z-index:9999;
		width:auto;
	}
	#main-menu ul {
		width:12em; /* fixed width only please - you can use the "subMenusMinWidth"/"subMenusMaxWidth" script options to override this if you like */
	}
	
	
	
</style>


    
    <style type="text/css">

html, body
{
	margin: 0;			/* Remove body margin/padding */
	padding: 0;
	overflow: hidden;	/* Remove scroll bars on browser window */
}

</style>
  
  
  <body>
<table cellspacing=0 cellpadding=0 width=100% height=100%>
<tr><td>

    <div id="mainSplitter">
        <div id='topp' style="background-image:url('podlaga.jpg');">
       
<iframe noresize="noresize"  id="ifr2" name="prvain" target="drugain"  scrolling="yes" frameborder="0"   src="m_templateclass_class_pdf.jsp?idt=<%=request.getParameter("idt") %>&sifid=<%=request.getParameter("sifid") %>&idp=<%=request.getParameter("idp") %>&idg=<%=request.getParameter("idg") %>&glavno=<%=request.getParameter("glavno") %>"   style="width:100%;height:100%"  >b</iframe>
        </div>

            <div  style="background-image:url('podlaga.jpg');">


<iframe noresize="noresize" id="ifr3" name="drugain" target="prvain" src="nic.jsp" scrolling="yes" frameborder="0" style="width:100%;height:100%"  onload="collapseL(this.contentWindow.location)"  >b</iframe>

            </div>
          

    </div>
</td></tr>


</table>
  </body>




     <script language="javascript">

     $(document).ready(function () {
         var theme = 'classic';
  
         $('#mainSplitter').jqxSplitter({ theme: theme, width: '100%', height: '100%', orientation: 'vertical', panels: [{ size: '50%',collapsible:false }, { size: '50%',collapsible:true}] });

});


     var prej = "";
     function collapseL(kajj) {
    	 

     }
     
     
     
     
     
</script>

</html>
