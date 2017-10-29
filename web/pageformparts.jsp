<%@ page contentType="text/html; " 

import="java.sql.*,javax.naming.*,java.io.*,java.util.*,java.text.*,java.util.Date,java.net.URLDecoder"%>
<jsp:useBean id="ConPool" scope="application" class="com.popultrade.webapp.conPool"/>
<jsp:useBean id="control" scope="session" class="com.popultrade.webapp.control" />
<jsp:useBean id="nul" scope="session" class="com.popultrade.webapp.chkNull" />
<jsp:useBean id="contextUtil" scope="session" class="com.popultrade.webapp.ContextUtil" />
<jsp:useBean id="prisotnost" scope="application" class="com.popultrade.webapp.kontrolaPrisotnosti" />
<%
request.setCharacterEncoding(control.encoding);
response.setContentType("text/html; charset="+control.encoding);
response.addHeader("Pragma" , "No-cache") ;
response.addHeader("Cache-Control", "no-cache") ;
response.addDateHeader("Expires", 0);








// stevilo prikazov vrstic
int stpri = 1500;

int stej = 0;

int stvrstic=0;
boolean iskanje=false;
boolean lahkobrise=true;
try {

System.out.println("--------- 1");


int pagenum=1;
int stizpisov=stpri;
System.out.println("--------- 2");

String stolpci =nul.jeNull(control.getColumnsUser(contextUtil,pageContext.getServletContext(),"Bookcover206"));
String orderby = "";
 
String dodpog = "";
com.popultrade.model.Bookcover sif = new com.popultrade.model.Bookcover();
String dodaten_sql_pogoj = dodpog;
String sedodatno = "";
String metodo = "";
//System.out.println("--------- 3 "+request.getParameter("idem"));
//List lis =null;
com.popultrade.dao.ChaptersDAO daom = new com.popultrade.dao.ChaptersDAO();


/// original send id of chapter
com.popultrade.model.Chapters vseb = daom.getChapters(request.getParameter("idch"),ConPool.getEntman());

//9892a8a9-444f-4062-b557-e83f2b5784b1
//com.popultrade.model.Chapters vseb = daom.getChapters("56de30fb-51d8-4399-8b4e-ef482a964944",ConPool.getEntman());

request.getSession().setAttribute("idem", request.getParameter("idch"));
/// get all pageformparts

List pfp = vseb.getPageformparts();

int strec = 0;
//lis = vsebm.getChapters();
//strec = lis.size();










%>

<!doctype html>
<style>
.rightfloat {
z-index: 9993;  
position: absolute;  
right: 0;  
top: 0;
background-color:yellow;
width:150px;
hight:350px;
}

.bgCover2 { background:#000; position:absolute; left:0; top:0; display:none; overflow:hidden;z-index:9995 }
.overlayBox2 {
    border:8px solid silver;
    position:absolute;
    display:none;
    width:500px;
    height:300px;
    background:#fff;
    z-index:9999;
}

.tableclas {

  border: 1px outset grey / darkgray;
  padding: 11px;
}

</style>
<link rel="stylesheet" href="app.css">
<script src="jquery-1.11.1.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/rangy-core.min.js"></script>
<script language='javascript' src='datum2.js?verzija=<%=nul.jeNull(ConPool.getPrevod_admin("1000009","Y",control.getJezik()+""))%>' ></script>

<script language='javascript'>






$(function(){
 $('#sinistra').focus();
 $('#bold').click(function(){document.execCommand('bold', false, null);$('#sinistra').focus();return false;});
 $('#italic').click(function(){document.execCommand('italic', false, null);$('#sinistra').focus();return false;});
 $('#underline').click(function(){document.execCommand('underline', false, null);$('#sinistra').focus();return false;});

 $('#fontsize').click(function(){
var size = prompt('Enter a size 1 - 7', '');
document.execCommand('FontSize', false, size);$('#sinistra').focus();return false;});
 $('#forecolor').click(function(){
var color = prompt('Define a basic color or apply a hexadecimal color code for advanced colors:', '');
document.execCommand('ForeColor', false, color);$('#sinistra').focus();return false;});
 $('#inserthorizontalrule').click(function(){document.execCommand('inserthorizontalrule', false, null);$('#sinistra').focus();return false;});
 $('#InsertOrderedList').click(function(){document.execCommand('InsertOrderedList', false, null);$('#sinistra').focus();return false;});
 $('#InsertUnorderedList').click(function(){document.execCommand('InsertUnorderedList', false, null);$('#sinistra').focus();return false;});
 $('#CreateLink').click(function(){
var linkURL = prompt("Enter the URL for this link:", "http://"); 
document.execCommand('underline', false, linkURL);$('#sinistra').focus();return false;});
 $('#Unlink').click(function(){document.execCommand('Unlink', false, null);$('#sinistra').focus();return false;});

 $('#FontName').click(function(){
var fontnn = prompt("Font Name:", ""); 
document.execCommand('FontName', false, fontnn);$('#sinistra').focus();return false;});

 $('#FormatBlock').click(function(){
var fblock = prompt("Format block div,h1,h2,..:", ""); 
document.execCommand('FormatBlock', false, fblock);$('#sinistra').focus();return false;});


 $('#Justify').click(function(){

var juss = prompt("Justify (JustifyCenter,JustifyFull,JustifyNone,JustifyLeft,JustifyRight,):", ""); 
document.execCommand(juss);$('#sinistra').focus();return false;});

 $('#Redo').click(function(){document.execCommand('Redo');$('#sinistra').focus();return false;});
 $('#Undo').click(function(){document.execCommand('Undo');$('#sinistra').focus();return false;});
 $('#RemoveFormat').click(function(){document.execCommand('RemoveFormat');$('#sinistra').focus();return false;});
 $('#StrikeThrough').click(function(){document.execCommand('StrikeThrough');$('#sinistra').focus();return false;});
 $('#Subscript').click(function(){document.execCommand('Subscript');$('#sinistra').focus();return false;});

 $('#Superscript').click(function(){document.execCommand('Superscript');$('#sinistra').focus();return false;});




});













//data:{"ten":tempp,"sequence":"35","idem":"<%=request.getParameter("idem")%>"},

function gettemi(tempp,typp)
{
  /*  $.ajax({
        url : 'e_pfp.jsp',
        data:{"ten":tempp,"sequence":"35","idem":"9892a8a9-444f-4062-b557-e83f2b5784b1","akcijaXY":"insert"},
        
        type: 'POST',

        success: function(data){
           alert(data);
           return data;
        },
        async: false
    });*/
    
    return $.ajax({
        type: "POST",
        url: 'e_pfp.jsp',
        data:{"ten":tempp,"sequence":"35","idem":"9892a8a9-444f-4062-b557-e83f2b5784b1","akcijaXY":"insert","type":typp},
        async: false
    }).responseText;
    
    
}

function loadcon()
{
    $.ajax({
        url : 'pageformpartstem.jsp',
        data:{"id":""},
        type: 'GET',

        success: function(data){
            $('#destra').html(data);
        }
    });
    
    
    
    //// find deleted images

    
    setDet();
    
    
    
    
    
    
    
}
//// find deleted images

function setDet() {
$('.delclas').on('keydown', function(e) {
	  var ids= $(this).find('[id]'),
	      self= $(this),iim=e.target.id;
	  setTimeout(function() {
	    ids.each(function() {
	      if(!self.find('#'+this.id).length) {
	    	  alert(this.id);
	    	  alert(iim);
	    	  delObj(iim,this.id);
	      }
	    });
	  });
	});
}
	
	
/// delete image from db
function delObj(iddiv,idimg) {
	alert(1);
	  var resst = $.ajax({
	        type: "POST",
	        url: 'e_pfp_d.jsp?sid='+Math.random()+"&iddiv="+iddiv+"&idimg="+idimg,
	        async: false
	    }).responseText;
	  
	  // save all
	  savo();
	  alert(resst);
	
}

/// delete pageformpart with all objects
function delPfp(idpfp) {
//	alert(1);
	  var resst = $.ajax({
	        type: "POST",
	        url: 'e_pfp_d.jsp?sid='+Math.random()+"&idpfp="+idpfp,
	        async: false
	    }).responseText;
	  
	  
	  /// remove object pageformparts
	  $('#'+idpfp).remove();
	  
	  
	  
	  alert(resst);
	
}

/// remove answer

function remans(idans,idpfp) {
	  var resst = $.ajax({
	        type: "POST",
	        url: 'e_answ.jsp?sid='+Math.random()+"&tyy=1&tyyx=UP&idpfp="+idpfp+"&idans="+idans,
	        async: false
	    }).responseText;
	  
	  if (resst.indexOf("|OK DELETE|")!=-1) {
		  $('#'+idans).remove();
	  }
	  else {
		  alert("Error: answer was not removed!");
	  }
	  
	  return false;
	  /// remove object pageformparts
	  
	
	
}



function remint(idans,idpfp,tyxx) {
	  var resst = $.ajax({
	        type: "POST",
	        url: 'e_int.jsp?sid='+Math.random()+"&tyy=1&tyyx=UP&idpfp="+idpfp+"&idans="+idans,
	        async: false
	    }).responseText;
	  
	  if (resst.indexOf("|OK DELETE|")!=-1) {
		  
		  $('#'+idans).remove();
		  alert(tyxx);
		  if (tyxx=='I') {
			  
				alert(resst + " --- "+idpfp);
			  if (resst.indexOf("|0|")!=-1) {
				//  if (tyxx=='I') {
				
		            	document.getElementById("BU_"+idpfp.substring(3)).disabled=false;
		            //	}
			  }
		  }
		  
	  }
	  else {
		  alert("Error: interval was not removed!");
	  }
	  
	  return false;
	  /// remove object pageformparts
	  
	
	
}


	
function setTem(tempi,typp) {
	
	
	
	
	
	var idnex = gettemi(tempi,typp);
	alert(idnex);
	if (idnex.indexOf("IXO")!=-1) {
		
		idnex = idnex.substring(idnex.indexOf("|")+1,idnex.lastIndexOf("|"));
	}
	else {
		return false;
	}
	
	
	if (tempi=='te1') {
		
	$('#vsebina').html($('#vsebina').html()+"<div id=\"I_"+idnex+"\"  ondragstart='dragS(this)' drasggable='true' class=\"delclas\"  contenteditable=\"true\" style=\"width:100%;background:#F2F2F2;display:inline-block;float:left;\"><img src=\"te1.jpg\" id=\"N_"+idnex+"\" onclick=\"insImg(this,'N_"+idnex +"')\"  style=\"float:right;padding:5px\">&nbsp;</div>");
		
	}
		if (tempi=='te2') {
		
	$('#vsebina').html($('#vsebina').html()+"<div id=\"I_"+idnex+"\"  ondragstart='dragS(this)' drasggable='true'   class=\"delclas\"  contenteditable=\"true\" style=\"width:100%;background:#F2F2F2;display:inline-block;float:left;\"><img src=\"te1.jpg\" id=\"N_"+idnex+"\" onclick=\"insImg(this,'N_"+idnex +"')\" style=\"float:left;padding:5px\">&nbsp;</div>");
		
	}
		if (tempi=='te9') { /// question
			
			$('#vsebina').html($('#vsebina').html()+"<div id=\"I_"+idnex+"\"  ondragstart='dragS(this)' drasggable='true'   class=\"delclas\"  contenteditable=\"true\" style=\"width:80%;background:#F2F2F2;display:inline-block;float:left;\"><img src=\"te9.jpg\" id=\"N_"+idnex+"\" onclick=\"insImg(this,'N_"+idnex +"')\" style=\"float:left;padding:5px;\">&nbsp;</div><div style='width:20%;display: inline-block;background:red'>&nbsp;</div>");
				
			}
		if (tempi=='te10') { /// interval
			
			$('#vsebina').html($('#vsebina').html()+"<div id=\"I_"+idnex+"\"  ondragstart='dragS(this)' drasggable='true'   class=\"delclas\"  contenteditable=\"true\" style=\"width:80%;background:#F2F2F2;display:inline-block;float:left;\"><img src=\"te10.jpg\" id=\"N_"+idnex+"\" onclick=\"insImg(this,'N_"+idnex +"')\" style=\"float:left;padding:5px;\">&nbsp;</div><div style='width:20%;display: inline-block;background:green'>&nbsp;</div>");
				
			}
		if (tempi=='te11') { /// page start
			
			$('#vsebina').html($('#vsebina').html()+"<div id=\"I_"+idnex+"\"  ondragstart='dragS(this)' drasggable='true' class=\"delclas\"  contenteditable=\"true\" style=\"width:100%;background:#F2F2F2;display:inline-block;float:left;\"><img src=\"te11.jpg\" id=\"N_"+idnex+"\"   style=\"float:right;padding:5px\">&nbsp;</div>");
					
			}
		if (tempi=='te12') { /// button
			
			$('#vsebina').html($('#vsebina').html()+"<div id=\"I_"+idnex+"\"  ondragstart='dragS(this)' drasggable='true' class=\"delclas\"  contenteditable=\"true\" style=\"width:100%;background:#F2F2F2;display:inline-block;float:left;\"><img src=\"te12.jpg\" id=\"N_"+idnex+"\"   style=\"float:right;padding:5px\">&nbsp;</div>");
					
			}
	if (tempi=='te4') { /// alert
			
			$('#vsebina').html($('#vsebina').html()+"<div id=\"I_"+idnex+"\"  ondragstart='dragS(this)' drasggable='true'   class=\"delclas\"  contenteditable=\"true\" style=\"width:80%;background:#F2F2F2;display:inline-block;float:left;\"><img src=\"te4.jpg\" id=\"N_"+idnex+"\" onclick=\"insImg(this,'N_"+idnex +"')\" style=\"float:left;padding:5px;\">&nbsp;</div><div style='width:20%;display: inline-block;background:green'>&nbsp;</div>");
				
			}
		
		
		 setDet();
	return false;
	
}

if (!String.prototype.startsWith) {
	  String.prototype.startsWith = function(searchString, position) {
	    position = position || 0;
	    return this.indexOf(searchString, position) === position;
	  };
	}
/// save

function savo() {
	var seno = "sub=ok";
	//var ddtt = new Array();
	//ddtt["sub"]="ok";
	  var elements = document.getElementsByTagName("div");
	  for (i=0; i<elements.length; i++){
	    if (elements[i].id.startsWith("I_")) {
	    
	   	alert(elements[i].innerHTML);
	    	
		//ddtt[elements[i].id]=elements[i].innerHTML;
	    seno += "&"+elements[i].id+"="+encodeURIComponent(elements[i].innerHTML);
	    	
	    	
	    }
	  }
	  
	  
	  var resss = $.ajax({
	        type: "POST",
	        url: 'e_pfp.jsp?sid='+Math.random(),
	        data:seno,
	        async: false
	    }).responseText;
	  alert(resss);
	  /*
	    $.ajax({
	        url : 'e_pfp.jsp?sid='+Math.random(),
	        data:seno,
	        type: 'POST',

	        success: function(data){
	        	alert(data);
	            $('#destra').html(data);
	        },
	    async: false
	    });*/
	return false;
}

/*
$(function() {
	 
    var observer = new MutationObserver(function(mutations) {
      mutations.forEach(function(mutation) {
          //console.log($(mutation.removedNodes)); // <<-- includes text nodes
          
          $(mutation.removedNodes).each(function(value, index) {
              if(this.nodeType === 1) {
                  alert(this.id);
              }
          });
      });
    });
    
    var config = { attributes: true, childList: true, characterData: true };
 
    observer.observe($('.pinko')[0], config);
 observer.observe($('.pinko2')[0], config);
});*/


//// duble click works on mobile too



//the status of overlay box
var isOpen2 = false;
//function to display the box
function showOverlayBox2() {
    //if box is not set to open then don't do anything
    if( isOpen2 == false ) return;
    // set the properties of the overlay box, the left and top positions
    $('.overlayBox2').css({
        display:'block',
        left:( $(window).width() - $('.overlayBox2').width() )/2,
        top:( $(window).height() - $('.overlayBox2').height() )/2 -20,
        position:'absolute'
    });
    // set the window background for the overlay. i.e the body becomes darker
    $('.bgCover2').css({
        display:'block',
        width: $(window).width(),
        height:$(window).height(),
    });
}
function doOverlayOpen2() {
    //set status to open
    isOpen2 = true;
    showOverlayBox2();
    $('.bgCover2').css({opacity:0}).animate( {opacity:0.5, backgroundColor:'#000'} );
    // dont follow the link : so return false.
    return false;
}

/// close with setting answer, if exist
function doOverlayClose2() {

	
/*	if (getSelectedText('choi')!='') {
	connectionT.connection.setParameter("idqu",document.getElementById('choi').value);
	
	connectionT.connection.getOverlay("label").setLabel(getSelectedText('choi'));
	
	
	
	
	if (!addToDB(connectionT.source.id,connectionT.target.id,document.getElementById('choi').value)) {
		
		instance.detach(connectionT.connection);
		
	}
	
	
	
	}*/
	
	
	//set status to closed 
    isOpen2 = false;
    $('.overlayBox2').css( 'display', 'none' );
    // now animate the background to fade out to opacity 0
    // and then hide it after the animation is complete.
    $('.bgCover2').animate( {opacity:0}, null, null, function() { $(this).hide(); } );
 
}

/// only close
function doOverlayCloseO2() {
    isOpen2 = false;
    $('.overlayBox2').css( 'display', 'none' );
    $('.bgCover2').animate( {opacity:0}, null, null, function() { $(this).hide(); } );
 
}




/// add/update answer

function addAns(idans,idpfp,tyy) {
	
	doOverlayOpen2();
	
	  var ressx = $.ajax({
	        type: "POST",
	        url: 'e_answ.jsp?idans='+idans+'&idpfp='+idpfp+'&tyy='+tyy+'&sid='+Math.random(),
	        async: false
	    }).responseText;
	  
	  
	document.getElementById("contento2").innerHTML=ressx;
	
	
	
	var options = {
			
	        beforeSend : function() {
	               
	        },
	        uploadProgress : function(event, position, total, percentComplete) {
	              
	        },
	        success : function(ressd) {
	             
	        //	alert(ressd);
	            	if (ressd.indexOf("|OK INSERT|")!=-1) {
	            		
	            		/*ressd = ressd.substring(ressd.indexOf("|")+1,ressd.lastIndexOf("|"));
	            		document.getElementById(imgid).id="N_"+ressd;
	            		document.getElementById("N_"+ressd).src="servlet/Image?idi="+ressd;*/
	            		
	            	// save everything
	            //	savo();
	            	//	alert(document.getElementById("N_"+ressd).id);
	            		
	            		$('#'+idpfp+' tr:last').before(ressd.substring(ressd.indexOf("|OK INSERT|")+11));
	            	
	            	
	            	
	            	
	            		
	            	}
	            
	            	else if (ressd.indexOf("|OK UPDATE|")!=-1) {
	            		
	            		$('#X'+idans).html(ressd.substring(ressd.indexOf("|OK UPDATE|")+11));
	            		
	            	}
	            	
	            	
	            	
	            	
	                
	             //   alert(ressd);
	                
	                
	        },
	        complete : function(response) {
	        	
	        $("#anwer").html("<font color='blue'>Your answer has been updated!</font>");
	        },
	        error : function() {
	        $("#anwer").html("<font color='red'> ERROR: unable to update/insert files</font>");
	        }
	};

	$("#addanswer").ajaxForm(options);
	

	return false;
	
}




/// add/update interval, alert

function addInt(idans,idpfp,tyy,tyxx) {
	
	doOverlayOpen2();
	
	  var ressx = $.ajax({
	        type: "POST",
	        url: 'e_int.jsp?idans='+idans+'&idpfp='+idpfp+'&tyy='+tyy+'&tyxx='+tyxx+'&sid='+Math.random(),
	        async: false
	    }).responseText;
	  
	  
	document.getElementById("contento2").innerHTML=ressx;
	
	
	
	var options = {
			
	        beforeSend : function() {
	               
	        },
	        uploadProgress : function(event, position, total, percentComplete) {
	              
	        },
	        success : function(ressd) {
	             
	        //	alert(ressd);
	            	if (ressd.indexOf("|OK INSERT|")!=-1) {
	            		
	            		/*ressd = ressd.substring(ressd.indexOf("|")+1,ressd.lastIndexOf("|"));
	            		document.getElementById(imgid).id="N_"+ressd;
	            		document.getElementById("N_"+ressd).src="servlet/Image?idi="+ressd;*/
	            		
	            	// save everything
	            //	savo();
	            	//	alert(document.getElementById("N_"+ressd).id);
	            		
	            		$('#'+idpfp+' tr:last').before(ressd.substring(ressd.indexOf("|OK INSERT|")+11));
	            	
	            	if (tyxx=='I') {
	            	document.getElementById("BU_"+idpfp.substring(3)).disabled=true;
	            	}
	            		
	            	}
	            
	            	else if (ressd.indexOf("|OK UPDATE|")!=-1) {
	            		
	            		$('#X'+idans).html(ressd.substring(ressd.indexOf("|OK UPDATE|")+11));
	            		
	            	}
	            	
	            	
	            	
	            	
	                
	             //   alert(ressd);
	                
	                
	        },
	        complete : function(response) {
	        	
	        $("#anwer").html("<font color='blue'>Your interval has been updated!</font>");
	        },
	        error : function() {
	        $("#anwer").html("<font color='red'> ERROR: unable to update/insert files</font>");
	        }
	};

	$("#addanswer").ajaxForm(options);
	

	return false;
	
}


















function insImg(trenut,pfpid) {
	
	
	imgid = trenut.id;
	
	/// if is new
	//if (imgid.startsWith("NI_")) {
		
		
		doOverlayOpen2();
		
		  var ressx = $.ajax({
		        type: "POST",
		        url: 'e_upl.jsp?idpfp='+pfpid+'&idi='+imgid+'&sid='+Math.random(),
		        async: false
		    }).responseText;
		  
		  
		document.getElementById("contento2").innerHTML=ressx;
		
		
		
		var options = {
				
		        beforeSend : function() {
		                $("#progressbox").show();
		                // clear everything
		                $("#progressbar").width('0%');
		                $("#message").empty();
		                $("#percent").html("0%");
		        },
		        uploadProgress : function(event, position, total, percentComplete) {
		                $("#progressbar").width(percentComplete + '%');
		                $("#percent").html(percentComplete + '%');

		                // change message text to red after 50%
		                if (percentComplete > 50) {
		                $("#message").html("<font color='red'>File Upload is in progress</font>");
		                }
		        },
		        success : function(ressd) {
		                $("#progressbar").width('100%');
		                $("#percent").html('100%');
		                
		                
		            	if (ressd.indexOf("IDS")!=-1) {
		            		
		            		ressd = ressd.substring(ressd.indexOf("|")+1,ressd.lastIndexOf("|"));
		            		document.getElementById(imgid).id="N_"+ressd;
		            		document.getElementById("N_"+ressd).src="servlet/Image?idi="+ressd;
		            		
		            	// save everything
		            	savo();
		            		alert(document.getElementById("N_"+ressd).id);
		            		
		            		
		            	}
		            
		                
		                alert(ressd);
		                
		                
		        },
		        complete : function(response) {
		        	
		        $("#message").html("<font color='blue'>Your file has been uploaded!</font>");
		        },
		        error : function() {
		        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
		        }
		};
		
		
		
		
		
		
		$("#UploadForm").ajaxForm(options);
		
	//}
	
	
}



	function allowDrop(event) {
		
	    event.preventDefault();
	}
	
	var dragidd="";
	function delpfp(event) {
		
//		alert(dragidd+" ::: "+event.target.id);
		delPfp(dragidd);
		
	}
	
	function dragS(iddra) {
		dragidd = iddra.id;
		
		
	}

	
	
	/// add table
	
	
	
	function addTable(){
    rangy.init();
    var range = getFirstRange();
    var el = document.createElement("table");
   // el.createAttribute("style","border=55px");
    /*
    var atre = document.createAttribute("style");
    atre.value = "border:55px";
    el.setAttributeNode(atre);*/
    
    //el.style.cssText = 'border:1;';
    el.className='tableclas';
    var tableHtml = "<tr><td>table text</td><td>table text</td></tr><tr><td>table text</td><td>table text</td></tr>";
    $(el).html(tableHtml); 
    
    var badNodes = {a: 1, p: 1};
    
    var n = range.startContainer;
    var tag = n.nodeName;
    while (tag == '#text') {
        n = n.parentNode;
        tag = n.nodeName;
    }
    
    if (badNodes[tag.toLowerCase()]) {
        while (badNodes[n.parentNode.nodeName.toLowerCase()]) {
            n = n.parentNode;
            tag = n.nodeName;
        }        
        range.setEndAfter(n);
        var clipped = range.extractContents();
        n.parentNode.insertBefore(el, n.nextSibling);
        el.parentNode.insertBefore(clipped, el.nextSibling);
    } else {
        range.insertNode(el);
    }
    
    rangy.getSelection().setSingleRange(range);
    return false;
}


function getFirstRange() {
       var sel = rangy.getSelection();
       return sel.rangeCount ? sel.getRangeAt(0) : null;
    } 
	
	
	
	
</script>



<body id="bodd" onload="loadcon()" style="margin:0px;height:100%">

<!-- max overlay -->
<div class="bgCover2" onclick="doOverlayClose2()">&nbsp;</div>
<!-- overlay box -->
<div class="overlayBox2" id="contbox">
<div class="overlayContent2">
        <!--the close button-->
        <a href="javascript:void()" onclick="doOverlayClose2()" class="closeLink" id="closee">Close</a>
        <!--normal content-->
<div id="contento2"></div>

    </div>
</div>



<div id="contenitore"  >
<div id="sinistra" style="position:relative;width:80%;height:100vh;background:white;display:inline-block;float:left">
<div id="menurtf" style="position:absolute; float:right;;right:1px">
  <a id="bold" href="#"><b>B</b></a>
  <a id="italic" href="#" class="options"><b><i>I</i></b></a>
  <a id="underline" href="#" class="options"><b><u>U</u></b></a>
  <a  href="#" onclick="return addTable()"><b><u>ADD TABLE</u></b></a>
  <a  href="#" onclick="return savo()"><b><u>SAVE</u></b></a>
  
   <div id="remox"  ondrop="delpfp(event)"  ondragover="allowDrop(event)" style="width:100px;dispwlay:inline" >REMOVE</div>
 </div>

<div style="display:inline" id="vsebina">

<%

System.out.println("--------------- VVV");

if (pfp.size()>0) {
	Hashtable vee = new Hashtable();
	for (int h=0;h<pfp.size();h++) {
		
		com.popultrade.model.Pageformparts vpfp = (com.popultrade.model.Pageformparts) pfp.get(h);
		
		/// order
		vee.put(vpfp.getSequence(), h+"");
		
		
	}
	
	List<Integer> v = new ArrayList<Integer>(vee.keySet());
    Collections.sort(v);
	
    for (Integer str : v) {
    	System.out.println("---------------  "+str);
    	com.popultrade.model.Pageformparts vpfp = (com.popultrade.model.Pageformparts) pfp.get(Integer.parseInt(vee.get(str)+""));
    	System.out.println("------dddd-------  "+java.net.URLDecoder.decode(nul.jeN(vpfp.getText()),"UTF-8"));
    	
    	%>
    	
    	<%
    	
		if (nul.jeN(vpfp.getTemplate_name()).equals("te1")) {
		%>
		<div draggsable="true"  id="I_<%=vpfp.getId() %>"  class="delclas" ondragstart="dragS(this)" contenteditable="true" style="width:100%;background:#F2F2F2;display:inline-block;"><%=!nul.jeN(vpfp.getText()).equals("")?nul.jeN(vpfp.getText()).replace("D__D", "<").replace("C__C", ">").replace("&amp;", "&").replace("&apos;", "'"):"<img src=\"te1.jpg\" id=\"N_"+vpfp.getId()+"\" onclick=\"insImg(this,'N_"+vpfp.getId() +"')\" style=\"float:right;padding:5px\">&nbsp;" %></div>
		
		<%
		}
		else if (nul.jeN(vpfp.getTemplate_name()).equals("te2")) {
			%>
			<div draggsable="true"  id="I_<%=vpfp.getId() %>"  class="delclas"  ondragstart="dragS(this)" contenteditable="true" style="width:100%;background:#F2F2F2;display:inline-block;"><%=!nul.jeN(vpfp.getText()).equals("")?nul.jeN(vpfp.getText()).replace("D__D", "<").replace("C__C", ">").replace("&amp;", "&").replace("&apos;", "'"):"<img src=\"te1.jpg\" id=\"N_"+vpfp.getId()+"\" onclick=\"insImg(this,'N_"+vpfp.getId() +"')\" style=\"float:left;padding:5px\">&nbsp;" %></div>
			
			<%	
		}
		else if (nul.jeN(vpfp.getTemplate_name()).equals("te9")) {
			%>
			<div style="width:100%;margin: 0 auto;"><div draggsable="true"  id="I_<%=vpfp.getId() %>"  class="delclas"  ondragstart="dragS(this)" contenteditable="true" style="width:80%;background:#F2F2F2;float:left;difsplay:inline-block"><%=!nul.jeN(vpfp.getText()).equals("")?nul.jeN(vpfp.getText()).replace("D__D", "<").replace("C__C", ">").replace("&amp;", "&").replace("&apos;", "'"):"<img src=\"te9.jpg\" id=\"N_"+vpfp.getId()+"\" onclick=\"insImg(this,'N_"+vpfp.getId() +"')\" style=\"float:left;padding:5px\">&nbsp;" %></div><div  id="IQ_<%=vpfp.getId() %>"  style='float:left;width:20%;dissplay:inline-block;background:red'>
			<table  id="IT_<%=vpfp.getId() %>"><tr><td colspan=3>ANSWER SELECT TYPE</td></tr><%
			/// answers
			List ans = vpfp.getResults();
			for (int r=0;r<ans.size();r++) {
				com.popultrade.model.Results ress = (com.popultrade.model.Results)ans.get(r);
				
				%>
				<tr id="RE_<%=ress.getId()%>"><td width="80%"><span id='XRE_<%=ress.getId()%>'><%=nul.jeN(ress.getResult()) %></span></td><td width="10%"><a href="" onclick="return addAns('RE_<%=ress.getId()%>','IT_<%=vpfp.getId() %>','2')">U</a></td><td width="10%"><a href="" onclick="return remans('RE_<%=ress.getId()%>','IX_<%=vpfp.getId() %>')">X</a></td></tr>
				<%
			}
			%>
			<tr><td colspan=3><input type="button" value="Add new Answer" onclick="addAns('','IT_<%=vpfp.getId() %>','')"></td></tr></table></div></div>
			<%	
		}
		else if (nul.jeN(vpfp.getTemplate_name()).equals("te10")) { /// only one possible, 
			%>
			<div style="width:100%;margin: 0 auto;"><div draggsable="true"  id="I_<%=vpfp.getId() %>"  class="delclas"  ondragstart="dragS(this)" contenteditable="true" style="width:80%;background:#F2F2F2;float:left;difsplay:inline-block"><%=!nul.jeN(vpfp.getText()).equals("")?nul.jeN(vpfp.getText()).replace("D__D", "<").replace("C__C", ">").replace("&amp;", "&").replace("&apos;", "'"):"<img src=\"te10.jpg\" id=\"N_"+vpfp.getId()+"\" onclick=\"insImg(this,'N_"+vpfp.getId() +"')\" style=\"float:left;padding:5px\">&nbsp;" %></div><div  id="IQ_<%=vpfp.getId() %>"  style='float:left;width:20%;dissplay:inline-block;background:yellow'>
			<table  id="IT_<%=vpfp.getId() %>"><tr><td colspan=3>INTERVAL</td></tr><%
			/// intervals
			List ans = vpfp.getInterval();
			boolean lokt=false;
			for (int r=0;r<ans.size();r++) {
				
				com.popultrade.model.Interval ress = (com.popultrade.model.Interval)ans.get(r);
				lokt=true;
				%>
				<tr id="RE_<%=ress.getId()%>"><td width="80%"><span id='XRE_<%=ress.getId()%>'><%=nul.getDatumFormatFromDate(ress.getDate_from(),"dd-MM-yyyy") %>/<%=nul.getDatumFormatFromDate(ress.getDate_to(),"dd-MM-yyyy")%></span></td><td width="10%"><a href="" onclick="return addInt('RE_<%=ress.getId()%>','IT_<%=vpfp.getId() %>','2','I')">U</a></td><td width="10%"><a href="" onclick="return remint('RE_<%=ress.getId()%>','IX_<%=vpfp.getId() %>','I')">X</a></td></tr>
				<%
			}
			
			%>
			<tr><td colspan=3><input type="button"  <%=(!lokt)?"":"disabled=disabled" %>  id="BU_<%=vpfp.getId() %>" value="Add new Interval" onclick="addInt('','IT_<%=vpfp.getId() %>','','I')"></td></tr>
			<%
			
			%>
		</table></div></div>
			<%	
		}
		else if (nul.jeN(vpfp.getTemplate_name()).equals("te11")) {
			%>
			<div draggsable="true"  id="I_<%=vpfp.getId() %>"  class="delclas"  ondragstart="dragS(this)" contenteditable="true" style="width:100%;background:#F2F2F2;display:inline-block;"><%=!nul.jeN(vpfp.getText()).equals("")?nul.jeN(vpfp.getText()).replace("D__D", "<").replace("C__C", ">").replace("&amp;", "&").replace("&apos;", "'"):"<img src=\"te11.jpg\" id=\"N_"+vpfp.getId()+"\"  style=\"float:left;padding:5px\">&nbsp;" %></div>
			
			<%	
		}
		else if (nul.jeN(vpfp.getTemplate_name()).equals("te12")) {
			%>
			<div draggsable="true"  id="I_<%=vpfp.getId() %>"  class="delclas"  ondragstart="dragS(this)" contenteditable="true" style="width:100%;background:#F2F2F2;display:inline-block;"><%=!nul.jeN(vpfp.getText()).equals("")?nul.jeN(vpfp.getText()).replace("D__D", "<").replace("C__C", ">").replace("&amp;", "&").replace("&apos;", "'"):"<img src=\"te12.jpg\" id=\"N_"+vpfp.getId()+"\"  style=\"float:left;padding:5px\">&nbsp;" %></div>
			
			<%	
		}
		else if (nul.jeN(vpfp.getTemplate_name()).equals("te4")) { //alert inside page
			%>
			<div style="width:100%;margin: 0 auto;"><div draggsable="true"  id="I_<%=vpfp.getId() %>"  class="delclas"  ondragstart="dragS(this)" contenteditable="true" style="width:80%;background:#F2F2F2;float:left;difsplay:inline-block"><%=!nul.jeN(vpfp.getText()).equals("")?nul.jeN(vpfp.getText()).replace("D__D", "<").replace("C__C", ">").replace("&amp;", "&").replace("&apos;", "'"):"<img src=\"te4.jpg\" id=\"N_"+vpfp.getId()+"\" onclick=\"insImg(this,'N_"+vpfp.getId() +"')\" style=\"float:left;padding:5px\">&nbsp;" %></div><div  id="IQ_<%=vpfp.getId() %>"  style='float:left;width:20%;dissplay:inline-block;background:yellow'>
			<table  id="IT_<%=vpfp.getId() %>"><tr><td colspan=3>ALERT</td></tr><%
			/// answers
			List ans = vpfp.getInterval();
			for (int r=0;r<ans.size();r++) {
				com.popultrade.model.Interval ress = (com.popultrade.model.Interval)ans.get(r);
				
				%>
				<tr id="RE_<%=ress.getId()%>"><td width="80%"><span id='XRE_<%=ress.getId()%>'><%=nul.getDatumFormatFromDate(ress.getDate_from(),"dd-MM-yyyy") %>/<%=nul.getDatumFormatFromDate(ress.getDate_to(),"dd-MM-yyyy")%></span></td><td width="10%"><a href="" onclick="return addInt('RE_<%=ress.getId()%>','IT_<%=vpfp.getId() %>','2','A')">U</a></td><td width="10%"><a href="" onclick="return remint('RE_<%=ress.getId()%>','IX_<%=vpfp.getId() %>','A')">X</a></td></tr>
				<%
			}
			%>
			<tr><td colspan=3><input type="button" value="Add new alert" onclick="addInt('','IT_<%=vpfp.getId() %>','','A')"></td></tr></table></div></div>
			<%	
		}
    	
    	
	}
	
	
	
}

%>
 </div>
</div>
<div id="destra" style="width:20%;height:100vh;background:yellow;dispaly:inline-block;float:right;overflow:auto">XR</div>
</div>




</body>
</html>




<%
}
catch (Exception eco){
System.out.println("ECO "+eco.toString());
}
%>








