


  ie=document.all?1:0
  ie=1;
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







function colors (element,clasa) {

while (element.tagName.toUpperCase() != 'TR' && element != null) {
      element = document.all ? element.parentElement : element.parentNode;
    //element.className = newClassName;
    }

     if (element.className=='silver' || element.className=='Checked' || element.className=='green') {
     //clasa='silver';
     }
     else {
       element.className = clasa;
     }

}

function colors2 (element,clasa) {

	while (element.tagName.toUpperCase() != 'TR' && element != null) {
	      element = document.all ? element.parentElement : element.parentNode;
	    //element.className = newClassName;
	    }

	     if (element.className=='silver2' || element.className=='Checked' || element.className=='green') {
	     //clasa='silver';
	     }
	     else {
	       element.className = clasa;
	     }

	}



var zdaj=" ";
var valueprej=" ";
var zeenkrat=1;
function doll(doltre) {

	if ( zdaj==doltre && document.getElementById(doltre).value=='' && zeenkrat==1) {
		zeenkrat=2;
		return true;
	}
	
	
	if (zdaj!=doltre || valueprej!=document.getElementById(doltre).value) {
zdaj = doltre;
zeenkrat=1;
valueprej = document.getElementById(doltre).value;
return true;
}

return false;

}




function HR (element,clasa) {
 // newClassName="unChecked"


  while (element.tagName.toUpperCase() != 'TR' && element != null) {

  element = document.all ? element.parentElement : element.parentNode;



  //element.className = newClassName;
  }

   if (element.className=='Checked') {
   element.className = clasa;
   }
   else {
   element.className = 'Checked';
   }
}




var ty = true;
var ara = new Array('plava1','plava2');
var m=0;
function CA (element){
m=0;

   for (var i=0;i<document.sub.elements.length;i++)
  {
       var e = document.sub.elements[i];

        e.checked = ty;



        if (!ty) {
          HR(e,ara[m]);
          //alert(i + " ---- " +ara[i]);
        m++;
        if (m==2) {
          m=0;
        }
        }
        else {
          HR(e,'Checked');
        }
  }
  if (ty) {
    ty=false;
  }
  else {
    ty=true;
  }
}


staro = new Object();
var starabarva="";
var fre = 1;
function kliknivSivo (element,clasa){

if (fre==2) {

HR2(staro,starabarva);
}



  HR2(element,'silver');

if (fre==1) {
fre=2;
}

if (staro!=element) {
staro=element;
starabarva=clasa;

}



}





staro2 = new Object();
var starabarva2="";
var fre2 = 1;
function kliknivSivo2 (element,clasa){

if (fre2==2) {

HR2(staro2,starabarva2);
}



  HR2(element,'silver2');

if (fre2==1) {
fre2=2;
}

if (staro2!=element) {
staro2=element;
starabarva2=clasa;

}



}







function UNcheckAll (element,clasa){
m=0;

   for (var i=0;i<document.sub.elements.length;i++)
  {
       var e = document.sub.elements[i];
          HR2(e,ara[m]);
        m++;
        if (m==2) {
          m=0;
        }

  }
  HR2(element,'silver');

}


function HR2 (element,clasa) {
try {
	while (element.tagName.toUpperCase() != 'TR' && element != null) {

  element = document.all ? element.parentElement : element.parentNode;



  //element.className = newClassName;
  }
if (element.className != 'Checked') {


element.className = clasa;
}
}
catch (ert) {
	
}
}




















//// javascript db dropdown

var findMatch = function(strs,table,iddx,valuex,setx,orderbyy) {

  return function findMatches(q, cb) {
//alert(table+ " ::: "+strs);
    var matches;


//// naredim vrednosti
var quero = {};

reqqu = strs.split("&");
for (var kk=0;kk<reqqu.length;kk++) {

if (reqqu[kk].indexOf("=")!=-1) {
splix = reqqu[kk].split("=");
var column= splix[0];

var operator = "leftnocase";


var value = splix[1] ;
//alert(splix[1]);
if (splix[1].indexOf("document.dod")!=-1) {

	vrto = splix[1].substring(13);

	value = document.getElementById(vrto).value;
	
	//value = eval(splix[1]).value;
//alert(value);
}


quero[column]={};
quero[column][operator]=value;
}
}


//alert(quero);
eva = eval("top.parent."+table);

if (typeof eva === 'undefined') {
	   
}
else {

matches = [];
iddy = [];
if (iddx.indexOf(" ___ ")!=-1) {
iddy = iddx.split(" ___ ");
}
else {
iddy[0] = iddx;
}

valuey = [];
if (valuex.indexOf(" ___ ")!=-1) {
valuey = valuex.split(" ___ ");
}
else {
valuey[0] = valuex;
}

var proxe=1;

eva(quero).order(orderbyy).each(function (r) {
//alert(eval("r.priimek"));


	
iddv = "";
ikoo = 1;
for(var p=0;p<iddy.length;p++) {
if (ikoo==1) {ikoo=2;}
else {
iddv += " ___ ";
}
iddv +=  eval("r."+iddy[p]);
}
valuev = "";
ikoo = 1;
for(var p=0;p<valuey.length;p++) {
if (ikoo==1) {ikoo=2;}
else {
valuev += " ";
}
valuev +=  eval("r."+valuey[p]);
}

if (proxe==1) {
	proxe=2;
	matches.push({
        idd: iddv, 
        value:  "",
    set: setx
    });

}
//alert(iddv);


matches.push({
            idd: iddv, 
            value:  valuev,
	    set: setx
        });


});






    cb(matches);
}

  };

};



function resetLoadingOverlay() {
	
	try {
	top.resetPageBlockAll();
	if(typeof(parent) == 'undefined') {
	}else {
	parent.resetPageBlockAll();
	if(typeof(parent.parent) == 'undefined') {
	}else {
	parent.parent.resetPageBlockAll();
	if(typeof(parent.parent.parent) == 'undefined') {
	}else {
	parent.parent.parent.resetPageBlockAll();
	if(typeof(parent.parent.parent.parent) == 'undefined') {
	}else {
	parent.parent.parent.parent.resetPageBlockAll();
	}
	}
	}
	}
	}
	catch (jk){
		
	}
	
	
}


















