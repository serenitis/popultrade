<%@ page contentType="text/html; " import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
<script type="text/javascript" language="JavaScript">



</script>
 <html>

 <%
 /// setam ws url
 //prisotnost.setWSUrl(ConPool.getWebsocket_url());
 
 
 // farames number
 int frames=4;
 
 
 
 if (!control.getUser().equals("anonymous")) {
	 
	 
	 
	// request.set
	 
	 
	 
  %>
<script language="JavaScript">


var wsUri = "<%=ConPool.getWebsocket_url()%>prisotnost";


            var dela = 0;
           
            function init() {
             //   output = document.getElementById("output");
send_message();
            }
            function send_message() {
            
           // if (jeodprt==0) {
                websocket = new WebSocket(wsUri);
                websocket.onopen = function(evt) {
                    onOpen(evt);
                    dela=1;
                };
                websocket.onmessage = function(evt) {
                    onMessage(evt);
                };
                websocket.onerror = function(evt) {
                    onError(evt);
                };
                websocket.onclose = function(evt) {
                    dela=0;
                };
             // / }
             //   else {
             //   doSend(document.getElementById("textID").value);
              //  }
            }
            var jeodprt = 0;
            
            function onOpen(evt) {
             //   writeToScreen("Connected to Endpoint!");
				jeodprt=1;
                
            }
            
            
 
            
            function onMessage(evt) {
             //   writeToScreen("Message Received: " + evt.data);
           //  alert(evt.data)
             var dt = evt.data+"";
             
             vse = dt.split(":-:");
           // alert(vse[0]);
             
             if (vse[0]!='<%=control.idUporabnikaLock%>' || vse[2]==9) {
             
             for (ik=0;ik<<%=frames%>;ik++) {
             
             if (vse[2]!=4 && vse[2]!=5 && vse[2]!=6 && vse[2]!=9) {
             
             if(typeof window.frames[ik] !== 'undefined' && typeof window.frames[ik].setPrisotnost === 'function'){
             	window.frames[ik].setPrisotnost(vse[1],vse[2]);
             	
             }
                if(typeof window.frames[ik] !== 'undefined' && typeof window.frames[ik].blokPrisotnost === 'function'){
          
             window.frames[ik].blokPrisotnost(vse[1],vse[2]);
             }
             
             
             }
             else if (vse[2]==9){

                 if(typeof window.frames[ik] !== 'undefined' && typeof window.frames[ik].prisotnostUID === 'function'){
          
             window.frames[ik].prisotnostUID(vse[1],vse[2],vse[3],vse[4],vse[5],vse[6]);

           
             
             if (vse[0]=='<%=control.idUporabnikaLock%>' && window.frames[ik].document.getElementById("spr"+vse[1])!=null) {
            	// alert("tuuu");
            	
            	
            	
            	if (window.frames[ik].document.getElementById("spr"+vse[1]).className!="") {
		    	 window.frames[ik].kliknivSivo(window.frames[ik].document.getElementById("spr"+vse[1]),window.frames[ik].document.getElementById("spr"+vse[1]).className );
            	}
		     }

             }
             
             }
             else {
                 if(typeof window.frames[ik] !== 'undefined' && typeof window.frames[ik].prisotnostUID === 'function'){
          
             window.frames[ik].prisotnostUID(vse[1],vse[2],vse[3],vse[4],vse[5],vse[6]);
             }
             
             }
             
             }
             
             
             
             
             
             
             /// subframes
             
                          for (ik=0;ik<<%=frames%>;ik++) {
                        	  for (iks=0;iks<2;iks++) {
             if (vse[2]!=4 && vse[2]!=5 && vse[2]!=6 && vse[2]!=9) {
             
             if(typeof window.frames[ik][iks] !== 'undefined' && typeof window.frames[ik][iks].setPrisotnost === 'function'){
             	window.frames[ik][iks].setPrisotnost(vse[1],vse[2]);
             	
             }
                if(typeof window.frames[ik][iks] !== 'undefined' && typeof window.frames[ik][iks].blokPrisotnost === 'function'){
          
             window.frames[ik][iks].blokPrisotnost(vse[1],vse[2]);
             }
             
             
             }
             else if (vse[2]==9){

                 if(typeof window.frames[ik][iks] !== 'undefined' && typeof window.frames[ik][iks].prisotnostUID === 'function'){
          
             window.frames[ik][iks].prisotnostUID(vse[1],vse[2],vse[3],vse[4],vse[5],vse[6]);

           
             
             if (vse[0]=='<%=control.idUporabnikaLock%>' && window.frames[ik][iks].document.getElementById("spr"+vse[1])!=null) {
            	// alert("tuuu");
            	
            	
            	
            	if (window.frames[ik][iks].document.getElementById("spr"+vse[1]).className!="") {
		    	 window.frames[ik][iks].kliknivSivo(window.frames[ik][iks].document.getElementById("spr"+vse[1]),window.frames[ik][iks].document.getElementById("spr"+vse[1]).className );
            	}
		     }

             }
             
             }
             else {
                 if(typeof window.frames[ik][iks] !== 'undefined' && typeof window.frames[ik][iks].prisotnostUID === 'function'){
          
             window.frames[ik][iks].prisotnostUID(vse[1],vse[2],vse[3],vse[4],vse[5],vse[6]);
             }
             
             }
             
             }
             
                          }
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             }
             
             
            }
            function onError(evt) {
            	
             //   writeToScreen('ERROR: ' + evt.data);
            }
            function doSend(message) {
             //   writeToScreen("Message Sent: " + message);
                websocket.send(message);
              // websocket.close();
            }
            function writeToScreen(message) {
            //    var pre = document.createElement("p");
            //    pre.style.wordWrap = "break-word";
            //    pre.innerHTML = message;
                 
              //  output.appendChild(pre);
            }
         //   window.addEventListener("load", init, false);














var keepali = 12; /// keep alive za ws vsakih 3minut
var stek = 1;

function loadVars() {

if (dela==1) {
var myImage = new Image;
myImage.src = "jsp1.jsp?mat="+Math.random();

if (stek==keepali) {
stek=1;
doSend("keepalive");
}
stek++;
}
 // alert(Math.random());
  setTimeout('loadVars()',25000);


}

setTimeout('loadVars()',25000);




</script>
<%
}
%>
<body  style="margin: 0"  link="#000000" vlink="#000000" alink="#000000" >

 <table border="0" width="100%" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">
<tr><td background="botb.jpg" ><img src="bot1.jpg" border="0"></td><td  background="botb.jpg" >

<table border="0" width="100%" cellspacing="0" style="border-collapse: collapse; font-family: Verdana; font-size: 8pt" bordercolor="#111111" width="100%" id="AutoNumber1" cellpadding="0">
<tr>
<td align=center>
<%=nul.jeNull(ConPool.getPrevod_admin("1000001","Y",control.getJezik()+""))%>
</td>
<td align=center>
 <a href="https://3s.panteon.biz/skupno/POGOJI_SL/POGOJI_UPORABE_<%=control.getJezik().toUpperCase() %>.htm" target="_blank" style="text-decoration:none"><%=nul.jeNull(ConPool.getPrevod_admin("1000002","Y",control.getJezik()+""))%></a> 
</td>
<td align=center>
<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>
</td>
<td align=center> 
 <a href="https://3s.panteon.biz/skupno/POGOJI_SL/ZASEBNOST_VARNOST_<%=control.getJezik().toUpperCase() %>.htm" target="_blank" style="text-decoration:none"><%=nul.jeNull(ConPool.getPrevod_admin("1000003","Y",control.getJezik()+""))%></a> 
</td>
<td align=center>
 <a href="mailto:<%=nul.jeNull(ConPool.getPrevod_admin("1000004","Y",control.getJezik()+""))%>"><%=nul.jeNull(ConPool.getPrevod_admin("1000004","Y",control.getJezik()+""))%></a>
 </td>
 </tr>
 
 </table>

</td><td  align="right" background="botb.jpg" >
	<img src="bot2.jpg" height="22"></td></tr>



</table>

</body></html>






