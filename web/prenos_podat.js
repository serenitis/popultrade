/// izbira artikla - odpre okno

   var aWindow = null;

   self.name='mainwin';
   function op(URL, w, h,m){

     //// kontrola dobavitelja sifre

     var isci = "";

      if (m==1) {

         isci = document.dod.posiljatelj_op.value;

         URL = URL+ "?ladja="+isci+"&pre=1&ime_polja=posiljatelj";

     }

      else if (m==3) {

         isci = document.dod.prejemnik_op.value;

         URL = URL+ "?ladja="+isci+"&pre=3&ime_polja=prejemnik";

     }


     else if (m==2) {

     isci = document.dod.company_op.value;

         URL = URL+ "?ladja="+isci+"&pre=2&ime_polja=company";

     }

   aWindow = open(URL,'aWindow','width='+w+',height='+h+',scrollbars=yes, status=yes,resizable=yes');

   aWindow.opener = self;

}



