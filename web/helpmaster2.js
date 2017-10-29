function popupon2(text, eventObj,xi)
{

  ieLayer = 'document.all[\'popup2\']';
  nnLayer = 'document.layers[\'popup2\']';

  //-- Start Editable Area --
  borderColor = 'silver';
  bgColor = 'ADD9FF';
  border = 1;
  padding = 1;
  xOffset =xi;

  if (divBg.style.top!="" && parseInt(divBg.style.top)!=NaN) {
  yOffset = 1 + parseInt(divBg.style.top);
	}
	else {
	yOffset = 1;
	}
	//alert(divBg.style.top);
  Font = 'face="Arial, Helvetica, sans-serif" size=2';
  //-- End Editable Area --

  if (!(document.all || document.layers)) return;
  if (null != document.all) document.popup2 = eval(ieLayer); else document.popup2 = eval(nnLayer);

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
    document.popup2.innerHTML = table;
    document.popup2.style.left = eventObj.x + xOffset;
    document.popup2.style.top  = eventObj.y + yOffset;
    document.popup2.style.visibility = "visible";
    }
  else
    { // If NN4+
    document.popup2.document.open();
    document.popup2.document.write(table);
    document.popup2.document.close();
    if ((document.popup2.document.width + xOffset + eventObj.layerX) > document.width)
    { // If the layer runs off the right hand side
      document.popup2.document.open();
      document.popup2.document.write(bigTable);
      document.popup2.document.close();
    }
    document.popup2.left = eventObj.layerX + xOffset;
    document.popup2.top  = eventObj.layerY + yOffset;
    document.popup2.visibility = "visible";
  }
}


function popupoff2()
{
  if (!(document.all || document.layers)) return;
  if (null == document.popup2) {
  } else if (null != document.all)
    document.popup2.style.visibility = "hidden";
  else
    document.popup2.visibility = "hidden";
    document.popup2 = null;
}
