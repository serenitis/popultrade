 
 ///// navodila
function navod() {

//alert(parent.frames[1].location);
var loca = parent.frames[0].location+"";
//alert(loca);
if (loca.indexOf("nic.jsp")!=-1) {

if (jelog=="anonymous") {

window.open("navodila"+jezik+"/login/login.html","navodila");
}
else {
 
window.open("navodila"+jezik+"/index.html","navodila");

}

}


else if (loca.indexOf("esd10.jsp")!=-1) {
window.open("navodila"+jezik+"/overview.htm","navodila");
}
else if (loca.indexOf("esd60.jsp")!=-1) {
window.open("navodila"+jezik+"/preusmeritve.htm","navodila");
}
else if (loca.indexOf("esd50.jsp")!=-1) {
	window.open("navodila"+jezik+"/predlozitev___prvi_urad.htm","navodila");
	}
else if (loca.indexOf("esd50_2.jsp")!=-1) {
	window.open("navodila"+jezik+"/predlozitev___naslednji_urad.htm","navodila");
	}
else if (loca.indexOf("plan.jsp")!=-1) {
	window.open("navodila"+jezik+"/ifranti.htm","navodila");
	}
else if (loca.indexOf("stranke.jsp")!=-1) {
	window.open("navodila"+jezik+"/ifranti.htm","navodila");
	}
else if (loca.indexOf("prevozniki.jsp")!=-1) {
	window.open("navodila"+jezik+"/ifranti.htm","navodila");
	}
else if (loca.indexOf("nastavitve.jsp")!=-1) {
	window.open("navodila"+jezik+"/okno_za_nastavitve.htm","navodila");
	}

else {

if (jelog=="anonymous") {

window.open("navodila"+jezik+"/login/login.html","navodila");

}
else {
  
window.open("navodila"+jezik+"/index.html","navodila");

}

}
return false;
}