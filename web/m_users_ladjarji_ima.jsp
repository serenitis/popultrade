<%@ page contentType="text/html; charset=windows-1250" import="java.sql.*,javax.naming.*,java.io.*,java.util.*"%>
<%@page import="com.popultrade.model.UsersPodjetja"%>

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

//// barve vrstic
String[] colors = {"plava1","plava2"};

    /// resultset
ResultSet rs=null;




/////////





//// v primeru, da gre za iskanje podatkov naredim stringo za iskanje



String a="0";
String b="50";



int stvrstic = 0;

//Hashtable pre = null;


try {


///////////// brisem customerja

if (request.getParameter("opcija")!=null && request.getParameter("opcija").equals("dodaj")) {

	
	com.popultrade.dao.UsersPodjetjaDAO dao = (com.popultrade.dao.UsersPodjetjaDAO)contextUtil.getBeanDao("usersPodjetjaDAO",pageContext.getServletContext());

	UsersPodjetja usp = new UsersPodjetja();
  
	usp.setOznladjar(request.getParameter("oznladjar"));
	usp.setUser_id(new Long(request.getParameter("id")));
	
	dao.saveUsersPodjetja(usp);
	
  %>
  <script language=javascript>
document.location = "m_users_ladjarji_ima.jsp?id=<%=request.getParameter("id")%>";
  </script>
  <%
  return;
  
}







%>

<html><head></head>
<style>

A:hover{color:red}
#divBg{position:absolute; top:0; left:0; visibility:hidden; height:10}
DIV.clSub{position:relative; top:-5; font-family:arial,helvetica; font-size:8px; padding:10px; visibility:hidden;
background-color:Silver; layer-background-color:2686D8}
</style>


<%
//System.out.println("JEZIK="+control.getJezik());
//////////// barve tr vrstic
%>
<style type=text/css>

@import "barve.css";

</style>

<%
//////////// funkcija za pobarvat vrstice v primeru checked in unchecked
%>

<script language='javascript' src='colors.js' ></script>




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
</script>




<script language="JavaScript1.2">

ie=document.all?1:0
n=document.layers?1:0

var moveOnScroll=true

var hideAll=true

function makeMenuBar(obj,nest,vis){
    nest=(!nest) ? '':'document.'+nest+'.'
    this.css=(n) ? eval(nest+'document.'+obj):eval(obj+'.style')
        this.hideIt=b_hideIt;	this.showIt=b_showIt; this.vis=b_vis
        if(ie && vis) this.css.visibility='hidden'
        this.state=1
        this.go=0
        this.height=n?this.css.document.height:eval(obj+'.offsetHeight')
        this.top=b_gettop
    this.obj = obj + "Object"; 	eval(this.obj + "=this")
}
function b_gettop(){
        var gleft=(n) ? eval(this.css.top):eval(this.css.pixelTop);
        return gleft;
}
function b_showIt(){
        this.css.visibility="visible"
}
function b_hideIt(){
        this.css.visibility="hidden"
}
function b_vis(){
        if(this.css.visibility=="hidden" || this.css.visibility=="hide") return true;
}

function checkScrolled(){

        if(!oMenu.go)oMenu.css.top=(!oMenu.state)?eval(scrolled):eval(scrolled)
        if(n) setTimeout('checkScrolled()',30)
}

function menuBarInit(){
        oSub=new Array()



        oMenu=new makeMenuBar('divBg')
        scrolled=n?"window.pageYOffset":"document.body.scrollTop"
        oMenu.css.top=eval(scrolled)
        oMenu.css.visibility='visible'

        if(moveOnScroll)window.onscroll=checkScrolled;
}

function extract(num){
        if(hideAll){
                for(i=0;i<oSub.length;i++){
                        if(num!=i) oSub[i].hideIt()
                }
        }
        !oSub[num].vis()?oSub[num].hideIt():oSub[num].showIt();

}






////// cekiram vse boxe
checkboxes=true;

function check() {
        var f = document.forms["sub"];
        for (var i = 0 ; i < f.elements.length ; i++) {
                if (f.elements[i].type == "checkbox")
                        f.elements[i].checked = checkboxes;
        }
        if (!checkboxes) {
          checkboxes = true;
        }
        else {
        checkboxes = false;
        }
}

</script>
<script language=javascript>
function chg() {

    parent.frames[1].location = "m_users_ladjarji_nima.jsp?id=<%=request.getParameter("id")%>";

}
</script>
<script type="text/javascript" language="JavaScript" src="helpmaster.js"></script>

<script language=javascript>
<%
/////////// nastimam imena ko grem gor s misko
%>
/// statusna vrstica z
p0 = "Oznaka";

p1 =  "Opis podjetja";
p2 =  "Type";





</script>

<body topmargin="0" leftmargin="0" onLoad="chg();menuBarInit()" background="podlaga.jpg" bgproperties="fixed">
<div id="popup" style="position:absolute; z-index:1; visibility: hidden"></div>
<form name=sub action="s_potrditev_naro.jsp" method="post">
<div id="divBg">
<table width="100%" border="0" cellspacing="1" cellpadding="0" align="CENTER" valign="MIDDLE" style="border-collapse:collapse; font-family:Verdana; font-size:7pt">
        <tr bgcolor="2686D8">
          <!--      <td width=2% align=center bgcolor="silver" onmouseout="popupoff()" onmousemove="popupon(p0,document.all||document.layers?event:null)"><a href="Javascript: CA();"></a></td>-->
                <td width=28% align=center bgcolor="ADD9FF" onmouseout="popupoff()" onmousemove="popupon(p0,document.all||document.layers?event:null)">Oznaka</td>
                <td width=56% align=center bgcolor="D2EAFF" onmouseout="popupoff()" onmousemove="popupon(p1,document.all||document.layers?event:null)">Opis</td>


                <td  bgcolor="D2EAFF" align=center ><a onClick="return godown('baza_isci.jsp')" href="Javascript: panteon()"><!--<img src="search.gif" border=0 alt="">--></a> <a onClick="return godown('customers_edit.jsp?opcija=new&siframm=new')" href="Javascript: panteon()"> </a> BRISI </td>
        </tr>

</table>
</div>












<table width=100% cellspacing=1  style="border-collapse: collapse; font-family: Verdana; font-size: 7pt">
<tr><td colspan=9>&nbsp</td></tr>
<%
com.popultrade.dao.UsersPodjetjaDAO dao = (com.popultrade.dao.UsersPodjetjaDAO)contextUtil.getBeanDao("usersPodjetjaDAO",pageContext.getServletContext());

/// menja barvo
int br = 0;

List lis =null;

lis = dao.getUsersPodjetjaIma(request.getParameter("id"));

Iterator it = lis.iterator();

System.out.println("AAAAAAAAAAAAA1");
while (it.hasNext()){  // while start

	
	System.out.println("AAAAAAAAAAAAA12");
	com.popultrade.model.UsersPodjetja vseb = (com.popultrade.model.UsersPodjetja)(it.next());

if (vseb.getLadjar()!=null && vseb.getLadjar().getOznladjar()!=null) {

	System.out.println("AAAAAAAAAAAAA13");
if (br==2){
  br=0;
}

%>

<tr class="<%=colors[br]%>" onMouseOver="colors(this,'rollOver')" onMouseOut="colors(this,'<%=colors[br]%>')">

<td width=28% align=center><%=vseb.getLadjar().getOznladjar()%></td>

<td  width=56% align=left><%=nul.jeNull(vseb.getLadjar().getNaziv())%></td>



<td  valign=middle align=center>
  <a  href="Javascript:panteon()" onCLick="return go('m_users_ladjarji_nima.jsp?ido=<%=vseb.getId()%>&id=<%=request.getParameter("id")%>&opcija=brisi')"><img src="desno.gif" alt="Odstrani" border=0  ></a>

</td>
</tr>

<%
br++;
}

}/////////////// while end

%>



<%

}
catch (Exception ex){
	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
	
	log.error(ex.toString());
}
/// zaprem statement

%>
</table></form>
<script language=javascript>
function go(asd){

    parent.frames[1].location = asd;




return false;

}

function panteon(){
}


</script>
<%
if (stvrstic > 50) {
%>
 <table  style="font-family: Verdana; font-size: 8pt; border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="1" height="38">
<tr><td colspan=30><font size=1>Najdenih
<%=stvrstic%></font></td></tr><tr>
<%
long ost =stvrstic%50;
long max =stvrstic - ost;
max = max /50;
int i =1;
int f=0;
int pos=1;
for (int e=0; e < max; e++) {
%>

<td bgcolor=silver align=center><a href="m_users_ladjarji_ima.jsp?a=<%=f%>&b=<%=f+50+1%>&id=<%=request.getParameter("id")%>"> <%=i%> </a></td>

<%
i++;
f = f+50;
if (pos==30) {

%>
</tr><tr>
<%
pos=0;
}
pos++;
}

if (ost != 0) {
%>

<td bgcolor=silver align=center><a href="m_users_ladjarji_ima.jsp?a=<%=f%>&b=<%=ost+f+1%>&id=<%=request.getParameter("id")%>"> <%=i%> </a></td>

<%


}



%>
</tr></table>
<%
}
%>


</td></body></html>
