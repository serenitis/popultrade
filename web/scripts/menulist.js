        function UpdateTableHeaders() {
            $("div.divTableWithFloatingHeader").each(function() {
                var originalHeaderRow = $(".tableFloatingHeaderOriginal", this);
                var floatingHeaderRow = $(".tableFloatingHeader", this);
                var offset = $(this).offset();
                var scrollTop = $(window).scrollTop();
                if ((scrollTop > offset.top) && (scrollTop < offset.top + $(this).height())) {
                    floatingHeaderRow.css("visibility", "visible");
                    floatingHeaderRow.css("top", Math.min(scrollTop - offset.top, $(this).height() - floatingHeaderRow.height()) + "px");

                    // Copy cell widths from original header
                    $("th", floatingHeaderRow).each(function(index) {
                        var cellWidth = $("th", originalHeaderRow).eq(index).css('width');
                      //  alert(cellWidth);
                        $(this).css('width', cellWidth);
                    });

                    // Copy row width from whole table
                  //  alert($(this).css("width"));
                    floatingHeaderRow.css("position", "absolute");
                    floatingHeaderRow.css("width", $(this).css("width"));
                }
                else {
                    floatingHeaderRow.css("visibility", "hidden");
                    floatingHeaderRow.css("top", "0px");
                }
            });
        }

        $(document).ready(function() {
            $(".tableWithFloatingHeader").each(function() {
                $(this).wrap("<div class=\"divTableWithFloatingHeader\" style=\"position:relative; background-color:white;width:100%\"></div>");

            var originalHeaderRow = $("tr:first", this)
                originalHeaderRow.before(originalHeaderRow.clone());
                 var clonedHeaderRow = $("tr:first", this)

      
                 
                 
               clonedHeaderRow.addClass("tableFloatingHeader");
              clonedHeaderRow.css("position", "absolute");
                clonedHeaderRow.css("top", "0px");
                clonedHeaderRow.css("left", $(this).css("margin-left"));
                
                
                clonedHeaderRow.css("visibility", "hidden");
                
              //  clonedHeaderRow.wrap("<div class=\"divTableWithFloatingHeader2\" style=\"position:relative; background-color:white;width:100%\"></div>");

               
                originalHeaderRow.addClass("tableFloatingHeaderOriginal");
               
            });
            UpdateTableHeaders();
            $(window).scroll(UpdateTableHeaders);
            $(window).resize(UpdateTableHeaders);
           // $(window).touchmove(UpdateTableHeaders);
             });
        
    //  $(function(){
    //  var onSampleResized = function(e){  
    		  //  var table = UpdateTableHeaders(); //reference to the resized table
    		//  };  

    //  $(".tableWithFloatingHeader").colResizable({liveDrag:true,draggingClass:"dragging",onResize:onSampleResized });
   //  });
      
        