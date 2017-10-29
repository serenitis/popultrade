var detect = navigator.userAgent.toLowerCase();
var OS,browser,version,total,thestring;


if (checkIt('konqueror'))
{
	browser = "Konqueror";
	OS = "Linux";
}
else if (checkIt('safari')) browser = "Safari"
else if (checkIt('omniweb')) browser = "OmniWeb"
else if (checkIt('opera')) browser = "Opera"
else if (checkIt('webtv')) browser = "WebTV";
else if (checkIt('icab')) browser = "iCab"
else if (checkIt('msie')) browser = "IE"
else if (checkIt('firefox')) browser = "FireFox"
else if (!checkIt('compatible'))
{
	browser = "NN"
	version = detect.charAt(8);
}
else browser = "An unknown browser";



if (!version) version = detect.charAt(place + thestring.length);

if (!OS)
{
	if (checkIt('linux')) OS = "Linux";
	else if (checkIt('x11')) OS = "Unix";
	else if (checkIt('mac')) OS = "Mac"
	else if (detect.indexOf("win") != -1) {
   
    if (detect.indexOf("3.1") != -1) OS = "Windows 98"
    if (detect.indexOf("98") != -1) OS = "Windows 98"
    if (detect.indexOf("95") != -1) OS = "Windows 95"
    if (detect.indexOf("nt") != -1) OS = "Windows NT"
    if (detect.indexOf("nt 5") != -1) OS = "Windows 2K"
    if (detect.indexOf("nt 5.1") != -1) OS = "Windows XP"
    if (detect.indexOf("nt 6.0") != -1) OS = "Windows Vista"
    if (detect.indexOf("nt 6.1") != -1) OS = "Windows 7"
    if (detect.indexOf("xp") != -1) OS = "Windows XP"
  	}
	else if (checkIt('win95')) OS = "Windows 95"
	else if (checkIt('win98')) OS = "Windows 98"
	else if (checkIt('winnt')) OS = "Windows NT"
	else if (checkIt('windows 3.1')) OS = "Windows 3.1"
	
	
	else OS = "Unknown";
}

function checkIt(string)
{
	place = detect.indexOf(string) + 1;
	thestring = string;
	return place;
}


var im = new Image();


function imgs(si2,sta2) {

var bs="";
if (document.referrer !=null || document.referrer != "") {
var tre = document.referrer;

as = tre.replace(/\&/g,"|");
bs=as.replace(/\?/g,"^");
cs=bs.replace(/\=/g,"*");
}

var cde = screen.colorDepth;
var wh = screen.width + "x" + screen.height;



im.src = "stati.jsp?si="+si2+"&statistik="+sta2+"&r="+cs+"&os="+OS+"&br="+browser+" "+version+"&cd="+cde+"&re="+wh;


}


