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
   return blnResult;
   }