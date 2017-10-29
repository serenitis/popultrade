function replaceAll(str, strFind, strReplace)
 {
  while (str.indexOf(strFind) > -1)
  {
   str = str.replace(strFind, strReplace);
  }
  return str;
 }
function trim(stringToTrim) {
	//alert(stringToTrim.replace(/^\s+|\s+$/g,""));
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
 

/// show missing required field message

function showRequiredMsg(objekto,messageen) {
	
	if (objekto.value == '') {
		objekto.setCustomValidity(messageen);
    }
   /* else if (objekto.validity.typeMismatch){{
    	objekto.setCustomValidity('please enter a valid email address');
    }*/
	else {
		objekto.setCustomValidity('');
	}
	
}


/// show calendars in input files
function showCalendar(derto) {

	   $( "#"+derto ).datepicker({

	      changeMonth: true,
	showButtonPanel: true,
	dateFormat:'dd-mm-yy',
	      changeYear: true

	    });
	$("#"+derto ).datepicker('show');

	} 
	





 function checkdatum(dt)  
{



var ara = new Array();
if (dt.indexOf("-")==-1) {
return false;
}
if (dt.indexOf("/")!=-1) {

ara = dt.split("/");
//alert(ara.length);
if (ara.length != 3) {
//alert(nadat);
return false;
}

}

else if (dt.indexOf(".")!=-1) {

ara = dt.split(".");
//alert(ara[1]);
if (ara.length != 3) {
alert(" 1");
return false;
}

}

else if (dt.indexOf("-")!=-1) {

ara = dt.split("-");

if (ara.length != 3) {
//alert(nadat +" 2");
return false;
}

}
else if (dt.indexOf(":")!=-1) {

ara = dt.split(":");

if (ara.length != 3) {
//alert(nadat +" 3");
return false;
}

}


var sel;
var tmp;

var datumok;

var godina;
var mjesec;
var dan;

var nowdate;
var nowchecksum;
var rezchecksum;

var trazi;



datumok=1;



var i;
var myform;

godina=ara[2];

//godina=se2.value;



mjesec=ara[1];

dan=ara[0];

if (!isNum(mjesec) || mjesec>12) {
return false;
}
if (!isNum(dan) || dan>31) {
return false;
}
if (!isNum(godina)) {
return false;
}

if
((mjesec==2  && (dan==30 || dan==31)) ||(mjesec==4  && dan==31) ||(mjesec==6  && dan==31) ||(mjesec==9  && dan==31) ||(mjesec==11 && dan==31))
{
datumok=0;
}

if
(
mjesec==2 && dan==29 &&
(
godina!=2000 &&
godina!=2004 &&
godina!=2008 &&
godina!=2012 &&
godina!=2016 &&
godina!=2020
)
)
{
datumok=0;
}
nowdate=new Date();
nowchecksum=(nowdate.getFullYear()*366)+((nowdate.getMonth()+1)*31)+(nowdate.getDate()*1);
rezchecksum=(godina*366)+(mjesec*31)+(dan*1);

if (nowchecksum>=rezchecksum)
{
//datumok=0;
}

if (datumok==0)
{
//alert('' + dan+'.'+mjesec+'.'+godina+nadat2);

return false;

}

//window.alert(datumok);

return true;
}

//// zaokrozim decimalke
function zaokrozi_dec(original, decimal) {
    var result1 = original * Math.pow(10, decimal)
    var result2 = Math.round(result1)
    var result3 = result2 / Math.pow(10, decimal)
    return pad_with_zeros(result3, decimal)
}

//// dodam decimalke, ce jih ni

    function pad_with_zeros(rounded_value, decimal_places) {

        // Convert the number to a string
        var value_string = rounded_value.toString()

        // Locate the decimal point
        var decimal_location = value_string.indexOf(".")

        // Is there a decimal point?
        if (decimal_location == -1) {

            // If no, then all decimal places will be padded with 0s
            decimal_part_length = 0

            // If decimal_places is greater than zero, tack on a decimal point
            value_string += decimal_places > 0 ? "." : ""
        }
        else {

            // If yes, then only the extra decimal places will be padded with 0s
            decimal_part_length = value_string.length - decimal_location - 1
        }

        // Calculate the number of decimal places that need to be padded with 0s
        var pad_total = decimal_places - decimal_part_length

        if (pad_total > 0) {

            // Pad the string with 0s
            for (var counter = 1; counter <= pad_total; counter++)
                value_string += "0"
            }
        return value_string
    }
    
   //// kontrola, da vnese le number values 
    function keyDowne(e)
{
var keynum;
var keychar;

var numcheck;


if(window.event){
keynum = e.keyCode;
}
else if(e.which) {
keynum = e.which;
}
if (keynum==13) {
prenosPodmap();
return false;
}
keychar = String.fromCharCode(keynum);
//alert(keynum);
if (keynum==8 || keychar==0 || keychar==1 || keychar==2 || keychar==3 || keychar==4 || keychar==5 || keychar==6 || keychar==7 || keychar==8 || keychar==9 || keychar=="\\.") {
return true;
} 
//alert(keychar);


//alert(keynum);
return false;
}
    function isNum(strString){
   var strValidChars = "0123456789.";
   var strChar;
   var blnResult = true;
   for (i = 0; i < strString.length && blnResult == true; i++)
      {
      strChar = strString.charAt(i);
      if (strValidChars.indexOf(strChar) == -1)
         {
         blnResult = false;
         }
      }
   if (Number(strString)<=0) {
	   blnResult = false;
   }
   return blnResult;
   }
    
    function isNumViaNic(strString){ /// da ok tudi ce je nula
    	   var strValidChars = "0123456789.";
    	   var strChar;
    	   var blnResult = true;
    	   for (i = 0; i < strString.length && blnResult == true; i++)
    	      {
    	      strChar = strString.charAt(i);
    	      if (strValidChars.indexOf(strChar) == -1)
    	         {
    	         blnResult = false;
    	         }
    	      }
    	   if (Number(strString)<0) {
    		   blnResult = false;
    	   }
    	   return blnResult;
    	   }
    
    
    
    function setReadOnly(fieldname,brisivrednost,setRO){
    
    	evi =eval("document.dod."+fieldname+"");
    	
    	//alert(0);
    	if (setRO==1) {
    		evi.readOnly=true;
    		
    		if (brisivrednost==1) {
    			evi.value="";
    		}
    		
    	//	evi.style.backgroundColor="eeeeee";
    	}
    	else if (setRO==9) {
    	//	alert(1);
	evi.disabled=true;
    		
    		if (brisivrednost==1) {
    			evi.value="";
    		}
    	//	alert(2);
    	}
    	else {
    		evi.readOnly=false;
    		evi.disabled=false;
    	//	evi.style.backgroundColor="white";
    		if (brisivrednost==1) {
    			evi.value="";
    		}
    	}
    	
    	
    	
    	   }
    
    
    
/////// kontrola pravilnosti sifranta za dropdown menu 
    function kontrolaSifre(kaj_reset,lokacija_kontrole,keykode) {
//alert(keykode);

    	if (keykode!="37" && keykode!="38" && keykode!="39" && keykode!="40" && keykode!="9") {

    	//if (keykode=="8") {

    	document.getElementById(lokacija_kontrole).value = "";

    	//} 
    	}



    }
    
    
//////// check po modulo 11
  /*  function checkM11(sifra) {



    dol = Number(sifra.length);

    if (dol>11) {
    return false;
    }

    sum=0;

    for (i=1;i<Number(dol);i++) {
    sum = sum + ((11-i)*Number(sifra.substring(i-1,i)));
    }
    if (sum%11==Number(sifra.substring(sifra.length-1,sifra.length))) {
  //  alert("OK");
    return true;
    }
    else {
  //  alert("NI OK "+sum%11);
    return false;
    }



    }*/

    function checkM11(sifra) {



    dol = Number(sifra.length);

    if (dol>11) {
    return false;
    }

    sum=0;
 /////// sestevek number 
    for (i=Number(dol)-1;i>=5;i--) {
    	//alert(sifra.substring(i-1,i));
    sum = (sum + Number(sifra.substring(i-1,i).charCodeAt(0))-48)*2;
    }
    
    for (i=4;i>=1;i--) {
    	//alert(sifra.substring(i-1,i));
sum = (sum + (Number(sifra.substring(i-1,i).charCodeAt(0))-55) + parseInt((Number(sifra.substring(i-1,i).charCodeAt(0))-56)/10))*2;

    }
  //  alert(sum);
summ = (sum/2)%11;

//alert(summ);
//alert(String.fromCharCode(((summ)%10)+48) + " ::: " + sifra.substring(sifra.length-1,sifra.length));

if (String.fromCharCode(((summ)%10)+48) != (sifra.substring(sifra.length-1,sifra.length)+"")) {
	return false;
}
else {
	return true;
}


    }
    
    var trenutni_id="";
    function setKlici(nezna,kaj) {
    	if (window.setAll){
    	if (kaj==1) {
		setAll();
		}
		}
		if (nezna!=null && nezna!='undefined') {
		//alert(nezna.id + " ::: "+trenutni_id);
		if (nezna.id != trenutni_id) {
		nezna.select();
		if (kaj==2) {
		trenutni_id = nezna.id;
		}
		}
		}
    }
    
    
    function checkUro(thetime) {
    	var a,b,c,f,err=0;
    	a=thetime;
    	if (a.length != 5) err=1;
    	b = a.substring(0, 2);
    	c = a.substring(2, 3); 
    	f = a.substring(3, 5); 
    	if (/\D/g.test(b)) err=1;
    	if (/\D/g.test(f)) err=1; 
    	if (b<0 || b>23) err=1;
    	if (f<0 || f>59) err=1;
    	if (c != ':') err=1;
    	if (err==1) {
    	return false;
    	}
    	return true;
    	}

    
    
    
    
    //////// ajax object
    function GetXmlHttpObject()
    { 
    var objXMLHttp=null
    if (window.XMLHttpRequest)
    {
    objXMLHttp=new XMLHttpRequest()
    }
    else if (window.ActiveXObject)
    {
    objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP")
    }
    return objXMLHttp
    }
    
    
    //// menja barvo na focusu in bluru
    function change(that, bgcolor){

    	that.style.backgroundColor = bgcolor;

    	}
    
    
    
    
    
    function jeDatumOdVecjiEnakDanes(datum1) {


    	var t1 = datum1;
    	//var t2 = eval("document.dod."+datum2);


    	if (trim(t1.value)!='' ) {

    	var spl1 = trim(t1.value).split("-");
    	//var spl2 = trim(t2.value).split("-");


    	var datod = new Date(spl1[2],Number(spl1[1])-1,spl1[0]);
    	//var datdo = new Date(spl2[2],spl2[1],spl2[0]);
    	
    	
    	date1 = new Date();
    	date1.setHours(0,0,0,0);
    	
    	
    	//alert(datod.getTime() + " ::: "+date1.getTime());

    	if (datod.getTime()<date1.getTime()) {

    	//alert("Napaka: Datum nadomescanje od je vecji od datuma nadomescanje do!");
    	return true;
    	}

    	}
    	else {

    	return false;
    	}
    	return false;

    	}
    

    
    
    
    
    function jeDatumOdVecjiDanes(datum1) {


    	var t1 = datum1;
    	//var t2 = eval("document.dod."+datum2);


    	if (trim(t1.value)!='' ) {

    	var spl1 = trim(t1.value).split("-");
    	//var spl2 = trim(t2.value).split("-");


    	var datod = new Date(spl1[2],Number(spl1[1])-1,spl1[0]);
    	//var datdo = new Date(spl2[2],spl2[1],spl2[0]);
    	
    	
    	date1 = new Date();
    	date1.setHours(23,59,59,0);
    	
    	
    	//alert(datod.getTime() + " ::: "+date1.getTime());

    	if (datod.getTime()<date1.getTime()) {

    	//alert("Napaka: Datum nadomescanje od je vecji od datuma nadomescanje do!");
    	return true;
    	}

    	}
    	else {

    	return false;
    	}
    	return false;

    	}
    
    
    
    
    
    
    
    function jeDatumVecjiOdSysdate(datum1,ura1) {


    	var t1 = datum1;
    	//var t2 = eval("document.dod."+datum2);


    	if (trim(t1.value)!='' ) {

    	var spl1 = trim(t1.value).split("-");
    	//var spl2 = trim(t2.value).split("-");

    	var splu = trim(ura1.value).split(":");
    	
    	var datod = new Date(spl1[2],Number(spl1[1])-1,spl1[0],splu[0],splu[1]);
    	//var datdo = new Date(spl2[2],spl2[1],spl2[0]);
    	
    	
    	date1 = new Date();
    	//date1.setHours(23,59,59,0);
    	
    	
    	//alert(datod.getTime() + " ::: "+date1.getTime());

    	if (datod.getTime()>(date1.getTime())) {

    	//alert("Napaka: Datum nadomescanje od je vecji od datuma nadomescanje do!");
    	return true;
    	}

    	}
    	else {

    	return false;
    	}
    	return false;

    	}
    
    
    // datum je vecji ali manjsi od stdni
    function jeDatumVModdni(datum1,stdni) {
    
    	
    	var newDatedo = new Date(Date.now() + stdni * 24*60*60*1000);
    	var newDateod = new Date(Date.now() - stdni * 24*60*60*1000);
    	var t1 = datum1;
    	var spl1 = trim(t1.value).split("-");
    	var datod = new Date(spl1[2],Number(spl1[1])-1,spl1[0]);
    	if (datod.getTime()<newDatedo.getTime() && datod.getTime()>newDateod.getTime()) {
    		return true;
    	}
    	return false;
    	
    	
    }
    
    function jeDatumVecjiOdSysdateMin(datum1,ura1,minute) {


    	var t1 = datum1;
    	//var t2 = eval("document.dod."+datum2);


    	if (trim(t1.value)!='' ) {

    	var spl1 = trim(t1.value).split("-");
    	//var spl2 = trim(t2.value).split("-");

    	var splu = trim(ura1.value).split(":");
    	
    	var datod = new Date(spl1[2],Number(spl1[1])-1,spl1[0],splu[0],splu[1]);
    	//var datdo = new Date(spl2[2],spl2[1],spl2[0]);
    	
    	
    	date1 = new Date();
    	//date1.setHours(23,59,59,0);
    	
    	
    	//alert(datod.getTime() + " ::: "+date1.getTime());

    	if (datod.getTime()>(date1.getTime()+(1000*60*Number(minute)))) {

    	//alert("Napaka: Datum nadomescanje od je vecji od datuma nadomescanje do!");
    	return true;
    	}

    	}
    	else {

    	return false;
    	}
    	return false;

    	}
    
    
    
    
    
    
    
    function jeDatumOdVecji(datum1,datum2) {


    	var t1 = eval("document.dod."+datum1);
    	var t2 = eval("document.dod."+datum2);


    	if (trim(t1.value)!='' && trim(t2.value)!='') {

    	var spl1 = trim(t1.value).split("-");
    	var spl2 = trim(t2.value).split("-");


    	var datod = new Date(spl1[2],spl1[1],spl1[0]);
    	var datdo = new Date(spl2[2],spl2[1],spl2[0]);

    	if (datod.getTime()>=datdo.getTime()) {

    	//alert("Napaka: Datum nadomescanje od je vecji od datuma nadomescanje do!");
    	return true;
    	}

    	}
    	else {

    	return false;
    	}
    	return false;

    	}



    	function jeDatumXMed(datumx,datum1,datum2) {

    		var tx = eval("document.dod."+datumx);
    		var t1 = eval("document.dod."+datum1);
    		var t2 = eval("document.dod."+datum2);

    		if (trim(t2.value)=='') {

    		t2.value = "12-12-2099";
    		//alert(1);
    		}

    	if (trim(t1.value)!='' && trim(t2.value)!='' && trim(tx.value)!='') {

    	var spl1 = trim(t1.value).split("-");
    	var spl2 = trim(t2.value).split("-");
    	var splx = trim(tx.value).split("-");

    	var datod = new Date(spl1[2],spl1[1],spl1[0]);
    	var datdo = new Date(spl2[2],spl2[1],spl2[0]);
    	var datx = new Date(splx[2],splx[1],splx[0]);



    	if (datx.getTime()>=datod.getTime() && datx.getTime()<=datdo.getTime()) {

    	//alert("Napaka: Datum nadomescanje od je vecji od datuma nadomescanje do!");
    	return true;
    	}

    	}

    	else {

    	return false;
    	}
    	return false;

    	}



    
    
    


    	var classname = ""; /// ime clase oz modela
    	var iddodatek = ""; /// dodatek k imenu geneirranega jspja
    	var ostalo = ""; /// parametri, loceni z & se pravi imeparametre=vrednost&


    	function dragStart(event,classname1,iddodatek1,ostalo1) {
    		classname=classname1;
    		iddodatek=iddodatek1;
    		ostalo=ostalo1;
    		//alert(1);
    		/// menjam ikono za move
    		//if (ostalo.indexOf("mmove=yes")!=-1) {
    		//	event.dataTransfer.dropEffect = "move";
    			
    		//} 
    		//else {
    			//event.dataTransfer.dropEffect = "copy";
    		//}
    		
    	}
    	/// kaksno claso lahko sprejemem iz draga in seveda kopiram, zareplace so imena polj v hibernate ki se setirajo z vrednostmi poslanimi preko drop, 
    	/// zareplace rabi _S<ime polja>=<vrednost> , _S=>string tip polja , _L=>long, _D=>double,_I=>integer , npr: &_Lveza_id=223&_Sstatus=1
    	function drop(classnamespre,zareplace) {
    		if (classnamespre==classname) { /// ce enako kopiram
    			//alert("drop ok "+classnamespre);
    			copyModel(zareplace);
    			document.location=document.location;
    		}
    		
    		
    	}

    	function copyModel(zarepl) {
    		
    		xmlHttp=GetXmlHttpObject2();
    		if (xmlHttp==null) {
    		alert ("Browser does not support HTTP Request");
    		return false;
    		} 
    		var url="m_templategen_copy.jsp";
    		url=url+"?modelname="+classname+"&modelid="+iddodatek+""+ostalo;
    		url=url+zarepl;
    		url=url+"&sid="+Math.random();
    		xmlHttp.open("GET",url,false);
    		xmlHttp.send(null);
    		if (xmlHttp.responseText.indexOf("OKCOPY")!=-1) {

    		}
    		else {
    		return false;
    		}
    		return true;

    		
    		
    		
    	}







    	function allowDrop(event) {
    	    event.preventDefault();
    	}

    
    	function GetXmlHttpObject2() {

    		var objXMLHttp=null;

    		if (window.XMLHttpRequest) {
    		objXMLHttp=new XMLHttpRequest();
    		}
    		else if (window.ActiveXObject){
    		objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
    		}
    		return objXMLHttp;
    		} 
    
    
    
    	
    	
    	
    	
    	
    	
    	function prisotnostUID2(idtr,stdok,clasn,us,pod,pagnn,imef,imeax,requ) {
    		
    		
    		
    		if (pagnn!=imef  && stdok==6) {

    		return; 
    		} 
    		if (document.getElementById("spr"+idtr)==null && stdok!=5 && stdok!=9) {
    		return; 
    		} 
    		if (document.getElementById("spr"+idtr)!=null && stdok==6) {
    		var row = document.getElementById('spr'+idtr);
	//	alert("x12");
    		row.parentNode.removeChild(row);
    		return; 
    		} 
    		xmlHttp=GetXmlHttpObject();
    		if (xmlHttp==null) {
    		alert ("Browser does not support HTTP Request");
    		return false;
    		} 
    		var url=imeax;

			
    		var barvaprej = "plava1";

if (stdok!=5 && stdok!=9) {
		barvaprej = document.getElementById("spr"+idtr).className;
}
//alert($("#table2 tr").eq(0).className);

    		var barvaprej2 = barvaprej;
    	//	alert(document.getElementById("spr"+idtr).id + " "+idtr);
    		if (barvaprej=='silver') {
    			barvaprej2="plava1";
    		}
		
    	//	alert(barvaprej2);


    		
    		url=url+"?stdok="+stdok+"&iddok="+idtr+"&clasn="+clasn+""+requ;
    		url=url+"&us="+us+"&pod="+pod+"&barp="+barvaprej2;
    		url=url+"&sid="+Math.random();
    		xmlHttp.open("POST",url,false);
    		xmlHttp.send(null);
    		
    		
    		if (xmlHttp.responseText.indexOf("NICCCC")!=-1) {
    		}
    		else if (xmlHttp.responseText.indexOf("DELETED")!=-1) {
    			
    			if (document.getElementById("spr"+idtr)!=null && stdok==9) {
    	    		var rowe = document.getElementById('spr'+idtr);
    	    		rowe.parentNode.removeChild(rowe);
    	    	
    	    		}	
    			
    		}
    		else {
    		if (document.getElementById("spr"+idtr)!=null && stdok!=5) {
    		//	alert(xmlHttp.responseText);
    		$("#spr"+idtr+"").replaceWith(xmlHttp.responseText);
    	//	alert(12);
    		if (barvaprej=='silver') {
    		//document.getElementById("spr"+idtr).className=barvaprej;
    		kliknivSivo(document.getElementById("spr"+idtr),'plava1');
    		//alert(13);
    		}
    		
    		}
    		else {
    		//	alert(122+xmlHttp.responseText);
    		$("#table2 tr").eq(1).before(xmlHttp.responseText);
    		barvaprej="plava1";
    		var prevElem = document.getElementById("spr"+idtr).nextElementSibling;
    		if (prevElem!=null && prevElem.nodeName=='TR' && (prevElem.id+"").indexOf("spr")!=-1) {
    		barvaprej=prevElem.className+"";
    		}
    		if (barvaprej=="plava1") {
    		barvaprej="plava2";
    		}
    		else {
    		barvaprej="plava1";
    		}
    		document.getElementById("spr"+idtr).className=barvaprej;
    		}
    		
    		
    		
    		
    		
    		}
    		}

    	
    	
    	
    	// kontrola datuma ce je v range od do vnesenega
    	// minuss st dni manj od datum
    	// pluss st dni vec od datum
    	
    	function dateInRange(datum,minuss,pluss) {

    		if (datum!=null && datum!='') {
    		
    		var parts = datum.match(/(\d+)/g);
    		datk =  new Date(parts[2], parts[1]-1, parts[0]);
    		datd = Number((new Date()).getTime());

    		var oddx =  Number(datk.getTime() - (Number(minuss) * 86400000)) ;
    		var doox =  Number(datk.getTime() + (Number(pluss) * 86400000)) ;

    		if (datd>=oddx && doox>=datd) {
    		return true;
    		}

    		return false;
    		}
    		return true;


    		}
    	
    	
    	
    	
    	
    	
    	
    