function popupon(text, eventObj,ope,vre)
{

if (ope!="") {
text=ope;
}
  ieLayer = 'document.all[\'popup\']';
  nnLayer = 'document.layers[\'popup\']';

  //-- Start Editable Area --
  borderColor = 'silver';
  bgColor = 'ADD9FF';
  border = 1;
  padding = 1;
  xOffset = 13;

  if (divBg.style.top!="" && parseInt(divBg.style.top)!=NaN) {
  yOffset = 1 + parseInt(divBg.style.top);
	}
	else {
	yOffset = 1;
	}
	//alert(divBg.style.top);
  Font = 'face="Verdana,Arial, Helvetica, sans-serif" size=1';
  //-- End Editable Area --

  if (!(document.all || document.layers)) return;
  if (null != document.all) document.popup = eval(ieLayer); else document.popup = eval(nnLayer);

  var table = "";
  var bigTable = ""; // Workaround for Netscape

  if (null != document.all)
    { // If IE4+
    table += "<table bgcolor= "+ bgColor +" border= "+ border +" cellpadding= "+ padding +" cellspacing=0>";
    table += "<tr><td>";
    table += "<table cellspacing=0 cellpadding="+ padding +">";
    table += "<tr><td bgcolor= "+ bgColor +"><font "+ Font +">" + text + "</font></td></tr>";
    table += "</table></td></tr></table>"
    }
  else
    { // If NN4+
    table += "<table cellpadding="+ padding +" border="+ border +" cellspacing=0 bordercolor="+ borderColor +">";
    bigTable += "<table width="+(document.width - xOffset - eventObj.layerX - 30)+"cellpadding="+ padding +" border="+ border +" cellspacing=0 bordercolor="+ borderColor +">";
    table += "<tr><td bgcolor="+ bgColor +"><font "+ Font +">" + text + "</font></td></tr></table>";
    bigTable += "<tr><td bgcolor="+ bgColor +"><font "+ Font +">" + text + "</font></td></tr></table>";
    }

  if (null != document.all)
    { // If IE4+
    document.popup.innerHTML = table;
    document.popup.style.left = eventObj.x + xOffset;
    document.popup.style.top  = eventObj.y + yOffset;
    document.popup.style.visibility = "visible";
    }
  else
    { // If NN4+
    document.popup.document.open();
    document.popup.document.write(table);
    document.popup.document.close();
    if ((document.popup.document.width + xOffset + eventObj.layerX) > document.width)
    { // If the layer runs off the right hand side
      document.popup.document.open();
      document.popup.document.write(bigTable);
      document.popup.document.close();
    }
    document.popup.left = eventObj.layerX + xOffset;
    document.popup.top  = eventObj.layerY + yOffset;
    document.popup.visibility = "visible";
  }
}


function popupoff()
{
  if (!(document.all || document.layers)) return;
  if (null == document.popup) {
  } else if (null != document.all)
    document.popup.style.visibility = "hidden";
  else
    document.popup.visibility = "hidden";
    document.popup = null;
}




/* http request for overtop div*/

function openOverTop(location) {
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
	alert ("Browser does not support HTTP Request");
	return false;
	} 
	
	var url=location;
	//url=url+"?sbedis="+document.dod.sbedis.value+"&oznskl="+document.dod.oznskl.value+"&sbeposil="+document.dod.sbeposil.value+"";
	url=url+(location.indexOf("?")!=-1?"&":"?")+"sid="+Math.random();
	xmlHttp.open("GET",url,false);
	xmlHttp.send(null);
	if (xmlHttp.responseText!="") {
		document.getElementById("overtop").style.display='block';
		document.getElementById("overtopin").innerHTML=xmlHttp.responseText;

	}
	else {
	return false;
	}
	return true;
	}




//////// ajax object
function GetXmlHttpObject()
{ 
var objXMLHttp=null;
if (window.XMLHttpRequest)
{
objXMLHttp=new XMLHttpRequest();
}
else if (window.ActiveXObject)
{
objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
}
return objXMLHttp;
}













