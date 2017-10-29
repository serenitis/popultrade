/************************************************************************************************************
Ajax dynamic list
Copyright (C) 2006  DTHMLGoodies.com, Alf Magne Kalleland

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

Dhtmlgoodies.com., hereby disclaims all copyright interest in this script
written by Alf Magne Kalleland.

Alf Magne Kalleland, April 2006
Owner of DHTMLgoodies.com


************************************************************************************************************/

	var ajaxBox_offsetX = 0;
	var ajaxBox_offsetY = 0;
	var ajax_list_externalFile = 'list_drzav.jsp';	// Path to external file
	var minimumLettersBeforeLookup = 1;	// Number of letters entered before a lookup is performed.

	var ajax_list_objects = new Array();
	var ajax_list_cachedLists = new Array();
	var ajax_list_activeInput = false;
	var ajax_list_activeItem;
	var ajax_list_optionDivFirstItem = false;
	var ajax_list_currentLetters = new Array();
	var ajax_optionDiv = false;
	var ajax_optionDiv_iframe = false;

	var ajax_list_MSIE = false;
	if(navigator.userAgent.indexOf('MSIE')>=0 && navigator.userAgent.indexOf('Opera')<0)ajax_list_MSIE=true;

	var currentListIndex = 0;

	function ajax_getTopPos(inputObj)
	{

	  var returnValue = inputObj.offsetTop;
	  while((inputObj = inputObj.offsetParent) != null){
	  	returnValue += inputObj.offsetTop;
	  }
	  return returnValue;
	}
	function ajax_list_cancelEvent()
	{
		return false;
	}


	function controla_obstoja(besed) {



	var x=0;


	if (besed!="") {
	
	try {

	document.getElementById(besed).value;
	x=1;
	return besed;
	}
	catch(erf) {
	
	}


	}


	// kontrola besede dokler ne dobim pravo ime
	
	

	besed2 = besed;
	// ena velika zacetnica
	for (i=0;i<besed.length;i++) {
	
	besed2 =besed.substring(0,i)+ besed.substring(i,i+1).toUpperCase()+besed.substring(i+1,besed.length);

	try {
	document.getElementById(besed2).value;
	x=1;
return besed2;
	}
	catch(erf) {
	
	}
	}


	


	
	
	

	
	return besed;

	}




	function ajax_getLeftPos(inputObj)
	{
	  var returnValue = inputObj.offsetLeft;
	  while((inputObj = inputObj.offsetParent) != null)returnValue += inputObj.offsetLeft;

	  return returnValue;
	}

	function ajax_option_setValue(e,inputObj)
	{
		if(!inputObj)inputObj=this;
		var tmpValue = inputObj.innerHTML;
		if(ajax_list_MSIE)tmpValue = inputObj.innerText;else tmpValue = inputObj.textContent;
		if(!tmpValue)tmpValue = inputObj.innerHTML;
		
		if (dodatna_lokacija!="" && dodatna_lokacija.indexOf(" ___ ")!=-1) {
			
			if (inputObj.id.indexOf(" ___ ")!=-1) {
				//
			
			var spli = inputObj.id.split(" ___ ");
			var splid = dodatna_lokacija.split(" ___ ");
			//ajax_list_activeInput.value = tmpValue;
			///tmpValue=spli[0];
			
			
			for (var k=0;k<spli.length;k++) {
			
			//alert("ASD "+splid[k]+" ::: " + spli[k]);
			try {
				
				if (rabikontrolo=="1") {
					if (k==0) {
						document.getElementById(splid[k]).value = spli[k];
					}
					else if (document.getElementById(splid[k]).value=="") {
						document.getElementById(splid[k]).value = spli[k];
					}
					
				} 
				else {
				
			document.getElementById(splid[k]).value = spli[k];
				}
			}
			catch (napak) {

	if (rabikontrolo=="1") {
					if (k==0) {
						document.getElementById(controla_obstoja(splid[k].toLowerCase())).value = spli[k];
						
					}
		
					else if (document.getElementById(controla_obstoja(splid[k].toLowerCase())).value=="") {
						document.getElementById(controla_obstoja(splid[k].toLowerCase())).value = spli[k];
					}
	}
	else {
					
			document.getElementById(controla_obstoja(splid[k].toLowerCase())).value = spli[k];
	}
			}
			//var spli2 = tmpValue.split(" - ");
			//ajax_list_activeInput.value = spli[0];
			//document.getElementById(dodatna_lokacija).value = spli2[1];
			
			
			
			}
			
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		}
		
		else if (dodatna_lokacija!="" && dodatna_lokacija.indexOf(" ___ ")==-1) {
			
			document.getElementById(dodatna_lokacija).value =inputObj.id;
		}
		
		else if (zapisi_id_v_polje=="9") {
			
		
			ajax_list_activeInput.value = tmpValue;
			///tmpValue=spli[0];
			document.getElementById(dodatna_lokacija).value = inputObj.id;
		}
		else if (zapisi_id_v_polje=="3") {
			
			if (inputObj.id.indexOf(" ___ ")!=-1) {
				//
			
			var spli = inputObj.id.split(" ___ ");
			
			document.getElementById(dodatna_lokacija).value = spli[1];
			document.getElementById(dodatna_lokacija2).value = spli[2];
			document.getElementById(dodatna_lokacija3).value = spli[3];
			document.getElementById(dodatna_lokacija4).value = spli[4];
			document.getElementById(dodatna_lokacija5).value = spli[5];
			ajax_list_activeInput.value = tmpValue;
			}
		}
		else {
		if (zapisi_id_v_polje=="1") {
		ajax_list_activeInput.value = inputObj.id;
		}
		else {
			ajax_list_activeInput.value = tmpValue;
		}
		if (dodatna_lokacija!="") {
			var dell = tmpValue;
			if (tmpValue.indexOf(" - ")!=-1) {
				//
			
			var spli = tmpValue.split(" - ");
			
			tmpValue=spli[1];
			
			if (dodatna_lokacija2=="") {
				dell = tmpValue.substring(tmpValue.indexOf(" - ")+1,tmpValue.length);
			document.getElementById(dodatna_lokacija).value=dell;
			}
			
			
			if (dodatna_lokacija2!="") { //// datum le za datum !!!!!!!!!!!!!!!!
				
				if (spli[1].indexOf(" ")!=-1) {
					document.getElementById(dodatna_lokacija).value = spli[1].substring(0,spli[1].indexOf(" "));
					document.getElementById(dodatna_lokacija2).value = spli[1].substring(spli[1].indexOf(" ")+1,spli[1].length);
					
				}
				
				if (dodatna_lokacija3!="") { 
					
					document.getElementById(dodatna_lokacija3).value = spli[2];
				}
				
			}
			
			
			}
			
			
		}
		
		
		
		
		
		
		if(document.getElementById(ajax_list_activeInput.name + '_hidden'))document.getElementById(ajax_list_activeInput.name + '_hidden').value = inputObj.id;
		}
  		//var f1=setTimeout('ajax_list_activeInput.focus()',1);
  		//var f2=setTimeout('ajax_list_activeInput.value = ajax_list_activeInput.value',1);

		ajax_options_hide();
		if (window.setAll){
			//alert(2);
		setAll();

		}
	}
	

function jeVidnoDD() {

if (ajax_optionDiv) {
if (ajax_optionDiv.style.display!='none') {
return true;
}
}
return false;
}

	
	function ajax_options_visible()
	{


		if (ajax_optionDiv_iframe && ajax_optionDiv) {

		if(ajax_optionDiv.style.display!='none' && ajax_optionDiv_iframe.style.display!='none')return true;
		}
		else {
			return false;
		}
		}

	function ajax_options_hide()
	{
		
		if(ajax_optionDiv)ajax_optionDiv.style.display='none';
		if(ajax_optionDiv_iframe)ajax_optionDiv_iframe.style.display='none';
		xyx = 0;
		xyz = 0;


		
	}

	function ajax_options_rollOverActiveItem(item,fromKeyBoard)
	{
		if(ajax_list_activeItem)ajax_list_activeItem.className='optionDiv';
		item.className='optionDivSelected';
		ajax_list_activeItem = item;

		if(fromKeyBoard){
			if(ajax_list_activeItem.offsetTop>ajax_optionDiv.offsetHeight){
				ajax_optionDiv.scrollTop = ajax_list_activeItem.offsetTop - ajax_optionDiv.offsetHeight + ajax_list_activeItem.offsetHeight + 2 ;
			}
			if(ajax_list_activeItem.offsetTop<ajax_optionDiv.scrollTop)
			{
				ajax_optionDiv.scrollTop = 0;
			}
		}
	}

	function ajax_option_list_buildList(letters,paramToExternalFile)
	{

		ajax_optionDiv.innerHTML = '';
		ajax_list_activeItem = false;
		if(ajax_list_cachedLists[paramToExternalFile][letters.toLowerCase()].length<=1){
			ajax_options_hide();
vidno=0;
			return;
		}



		ajax_list_optionDivFirstItem = false;
		var optionsAdded = false;
		for(var no=0;no<ajax_list_cachedLists[paramToExternalFile][letters.toLowerCase()].length;no++){
			if(ajax_list_cachedLists[paramToExternalFile][letters.toLowerCase()][no].length==0)continue;
			optionsAdded = true;
			var div = document.createElement('DIV');
			var items = ajax_list_cachedLists[paramToExternalFile][letters.toLowerCase()][no].split(/###/gi);

			if(ajax_list_cachedLists[paramToExternalFile][letters.toLowerCase()].length==1 && ajax_list_activeInput.value == items[0]){
				ajax_options_hide();
				return;
			}


			div.innerHTML = items[items.length-1];
			div.id = items[0];
			div.className='optionDiv';
			div.onmouseover = function(){ ajax_options_rollOverActiveItem(this,false) }
			div.onclick = ajax_option_setValue;
			if(!ajax_list_optionDivFirstItem)ajax_list_optionDivFirstItem = div;
			ajax_optionDiv.appendChild(div);
		}
		if(optionsAdded){
			ajax_optionDiv.style.display='block';
			if(ajax_optionDiv_iframe)ajax_optionDiv_iframe.style.display='';
			ajax_options_rollOverActiveItem(ajax_list_optionDivFirstItem,true);
		}

	}

	function ajax_option_list_showContent(ajaxIndex,inputObj,paramToExternalFile,whichIndex)
	{
		if(whichIndex!=currentListIndex)return;
		var letters = inputObj.value;
		var content = ajax_list_objects[ajaxIndex].response;
		var elements = content.split('|');
		ajax_list_cachedLists[paramToExternalFile][letters.toLowerCase()] = elements;
		ajax_option_list_buildList(letters,paramToExternalFile);

	}

	function ajax_option_resize(inputObj)
	{
		ajax_optionDiv.style.top = (ajax_getTopPos(inputObj) + inputObj.offsetHeight + ajaxBox_offsetY) + 'px';
		ajax_optionDiv.style.left = (ajax_getLeftPos(inputObj) + ajaxBox_offsetX) + 'px';
		if(ajax_optionDiv_iframe){
			ajax_optionDiv_iframe.style.left = ajax_optionDiv.style.left;
			ajax_optionDiv_iframe.style.top = ajax_optionDiv.style.top;
		}

	}
	
///// setam opis vrednos se na odatno lokacijo
var vidno =0;
var zapisi_id_v_polje="0";
var dodatna_lokacija="";
var rabikontrolo="";
var xyx = 0;
var xyz = 0;
function ajax_showOptionsID(inputObj,paramToExternalFile,e,lokacija,zap_id,dodatna_lokacije,min_st_znakov,rabikontrolov)
{
	if (xyx==0) {
		xyx=1;
////// v primeru da gre za minimalno stevilo znakov, ce je znakov manj od minimalno se iskanje po bazi ne izvede
	if (Number(min_st_znakov)>0) {
		//alert(inputObj.value.length);
		if (inputObj.value.length<Number(min_st_znakov)) {
			xyx=0;
			return false;
		}
		
	}
	

	rabikontrolo=rabikontrolov;

//	alert(1);
	
	ajax_showOptions(inputObj,paramToExternalFile,e,lokacija,zap_id,dodatna_lokacije);
	xyx=0;
	}
	else {
		xyx=0;
	}

}





var imeprej = "";
	function ajax_showOptions(inputObj,paramToExternalFile,e,lokacija,zap_id,dodatna_lokacije)
	{

if ((e.keyCode==40 || e.keyCode==38) && jeVidnoDD()) {
return;
}


		//alert(e.keyCode);
		if (xyz==0) {
		
			xyz=1;
			zapisi_id_v_polje = zap_id;
			dodatna_lokacija=dodatna_lokacije;
			
		if (imeprej!=inputObj.name) {
			ajax_options_hide();
				vidno=0;
			imeprej=inputObj.name;
		}
		//alert(e.keyCode);
		

		
		if(e.keyCode==13 || e.keyCode==9)return;
		if ((e.keyCode==38 && e.keyCode==40) || ajax_options_visible()){
		
		if(ajax_list_currentLetters[inputObj.name]==inputObj.value)return;
		}
		if(!ajax_list_cachedLists[paramToExternalFile])ajax_list_cachedLists[paramToExternalFile] = new Array();
		ajax_list_currentLetters[inputObj.name] = inputObj.value;
		//alert(1);
		if(!ajax_optionDiv){
			vidno=1;
			ajax_optionDiv = document.createElement('DIV');
			ajax_optionDiv.id = 'ajax_listOfOptions';
			ajax_optionDiv.style.width="300px";
			document.body.appendChild(ajax_optionDiv);

			if(ajax_list_MSIE){
				ajax_optionDiv_iframe = document.createElement('IFRAME');
				ajax_optionDiv_iframe.border='0';
				ajax_optionDiv_iframe.style.width = ajax_optionDiv.clientWidth + 'px';
				ajax_optionDiv_iframe.style.height = ajax_optionDiv.clientHeight + 'px';
				ajax_optionDiv_iframe.id = 'ajax_listOfOptions_iframe';

				document.body.appendChild(ajax_optionDiv_iframe);
			}

			/*var allInputs = document.getElementsByTagName('INPUT'); ///////// onemogoceno zaradi focus eventa, dam ga direkt pod formo
			for(var no=0;no<allInputs.length;no++){
				if(!allInputs[no].onkeyup)allInputs[no].onfocus = ajax_options_hide;
			}
			var allSelects = document.getElementsByTagName('SELECT');
			for(var no=0;no<allSelects.length;no++){
				allSelects[no].onfocus = ajax_options_hide;
			}*/

			var oldonkeydown=document.body.onkeydown;
			if(typeof oldonkeydown!='function'){
				document.body.onkeydown=ajax_option_keyNavigation;
			}else{
				document.body.onkeydown=function(){
					oldonkeydown();
				ajax_option_keyNavigation() ;}
			}
			var oldonresize=document.body.onresize;
			if(typeof oldonresize!='function'){
				document.body.onresize=function() {ajax_option_resize(inputObj); };
			}else{
				document.body.onresize=function(){oldonresize();
				ajax_option_resize(inputObj) ;}
			}

		}
//alert(inputObj.value.length+"::::"+minimumLettersBeforeLookup);
		if(inputObj.value.length<minimumLettersBeforeLookup && e.keyCode!=38 && e.keyCode!=40){
			ajax_options_hide();
			xyz=0;
			vidno=0;
			return;
		}

		

		ajax_optionDiv.style.top = (ajax_getTopPos(inputObj) + inputObj.offsetHeight + ajaxBox_offsetY) + 'px';
		ajax_optionDiv.style.left = (ajax_getLeftPos(inputObj) + ajaxBox_offsetX) + 'px';
		if(ajax_optionDiv_iframe){
			ajax_optionDiv_iframe.style.left = ajax_optionDiv.style.left;
			ajax_optionDiv_iframe.style.top = ajax_optionDiv.style.top;
		}

		ajax_list_activeInput = inputObj;
		ajax_optionDiv.onselectstart =  ajax_list_cancelEvent;
		currentListIndex++;
		//if(paramToExternalFile!="getLukeByLetters" && ajax_list_cachedLists[paramToExternalFile][inputObj.value.toLowerCase()]){
			//ajax_option_list_buildList(inputObj.value,paramToExternalFile,currentListIndex);
			//alert(1);
		//}else{
			var tmpIndex=currentListIndex/1;
			//alert(2);
			ajax_optionDiv.innerHTML = '';
			var ajaxIndex = ajax_list_objects.length;
			ajax_list_objects[ajaxIndex] = new sack();
			var url = lokacija  + paramToExternalFile + '=1&letters=' + inputObj.value.replace(" ","+");
			

			var ven = url.replaceAll("Š", "_SLSS_");

			ven = ven.replaceAll("š", "_SLss_");
			ven = ven.replaceAll("Ð", "_SLDD_");
			ven = ven.replaceAll("ð", "_SLdd_");
			
			ven = ven.replaceAll("È", "_SLCC_");
			ven = ven.replaceAll("è", "_SLcc_");
			ven = ven.replaceAll("Æ", "_SLCI_");
			ven = ven.replaceAll("æ", "_SLci_");
			ven = ven.replaceAll("Ž", "_SLZZ_");
			ven = ven.replaceAll("ž", "_SLzz_");
			
			//alert(ven);
			
			url=ven;
			ajax_list_objects[ajaxIndex].requestFile = url;	// Specifying which file to get
			ajax_list_objects[ajaxIndex].onCompletion = function(){ ajax_option_list_showContent(ajaxIndex,inputObj,paramToExternalFile,tmpIndex); };	// Specify function that will be executed after file has been found
			ajax_list_objects[ajaxIndex].runAJAX();		// Execute AJAX function
			//vidno=1;
		//}
			xyz=0;
		}
		else {
			xyz=0;	
		}
		
	}

	String.prototype.replaceAll = function (find, replace) {
	    var str = this;
	    return str.replace(new RegExp(find.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'), 'g'), replace);
	};
	
	
	function ajax_option_keyNavigation(e)
	{
		if(document.all)e = event;

		if(!ajax_optionDiv)return;
		if(ajax_optionDiv.style.display=='none')return;

		if(e.keyCode==38){	// Up arrow
			//alert("up");
			if(!ajax_list_activeItem)return;
			if(ajax_list_activeItem && !ajax_list_activeItem.previousSibling)return;
			ajax_options_rollOverActiveItem(ajax_list_activeItem.previousSibling,true);
		}

		if(e.keyCode==40){	// Down arrow
			if(!ajax_list_activeItem){
				ajax_options_rollOverActiveItem(ajax_list_optionDivFirstItem,true);
			}else{
				if(!ajax_list_activeItem.nextSibling)return;
				ajax_options_rollOverActiveItem(ajax_list_activeItem.nextSibling,true);
			}
		}

		if(e.keyCode==13 || e.keyCode==9){	// Enter key or tab key
			if(ajax_list_activeItem && ajax_list_activeItem.className=='optionDivSelected')ajax_option_setValue(false,ajax_list_activeItem);
			if(e.keyCode==13) {
				xyz=0;
				xyx=0;
				vidno=0;
				return false; 
				
			}else {
				xyx=0;
				xyz=0;
				vidno=0;
			return true;
			}
		}
		if(e.keyCode==27){	// Escape key
			ajax_options_hide();
vidno=0;
		}
	}


	document.documentElement.onclick = autoHideList;

	function autoHideList(e)
	{
vidno=0;
		if(document.all)e = event;

		if (e.target) source = e.target;
			else if (e.srcElement) source = e.srcElement;
			if (source.nodeType == 3) // defeat Safari bug
				source = source.parentNode;
		if(source.tagName.toLowerCase()!='input' && source.tagName.toLowerCase()!='textarea')ajax_options_hide();

	}
	
	
	
	
	
	
	