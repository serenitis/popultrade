function checkdatum(dt)
{



var ara = new Array();

if (dt.indexOf("/")!=-1) {

ara = dt.split("/");
//alert(ara.length);
if (ara.length != 3) {
alert(nadat);
return false;
}

}

else if (dt.indexOf(".")!=-1) {

ara = dt.split(".");

if (ara.length != 3) {
alert(nadat +" 1");
return false;
}

}

else if (dt.indexOf("-")!=-1) {

ara = dt.split("-");

if (ara.length != 3) {
alert(nadat +" 2");
return false;
}

}
else if (dt.indexOf(":")!=-1) {

ara = dt.split(":");

if (ara.length != 3) {
alert(nadat +" 3");
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
var numers = 0;
if (document.bbbb.stdnidat.value!="") {
  numers = document.bbbb.stdnidat.value;
}
mjesec=ara[1];

dan=ara[0];

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
nowchecksum=(nowdate.getFullYear()*366)+((nowdate.getMonth()+1)*31)+((nowdate.getDate()*1))+parseInt(numers)-1;
rezchecksum=(godina*366)+(mjesec*31)+(dan*1);

if (nowchecksum>=rezchecksum)
{
datumok=0;
}

if (datumok==0)
{
alert('' + dan+'.'+mjesec+'.'+godina+nadat2);

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


