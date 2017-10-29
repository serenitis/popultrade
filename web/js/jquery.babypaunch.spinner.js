
$.fn.spinner = function(data){

	$.each(["show", "hide"], function(i, e) {
		var $e = $.fn[e];
		$.fn[e] = function(){
			this.trigger(e);
			return $e.apply(this, arguments);
		};
	});

	//options
	var $spinner = {
		color: "white"
		, background: "rgba(0,0,0,0.5)"
		, html: "&#x21BB;"
	};

	this.init = function($spinner){
		return "<style id='data-spinner-style'>\n"
			+ "body.unselectable {\n"
				+ "\t-webkit-user-select: none;"
				+ "\t-moz-user-select: none;"
				+ "\t-ms-user-select: none;"
				+ "\t-o-user-select: none;"
				+ "\tuser-select: none;\n"
			+ "}\n"
			+ "[data-spinner-layer] {\n"
				+ "\tdisplay: none; position: fixed; top: 0; left: 0;"
				+ "\tbackground: " + $spinner.background + ";"
				+ "\twidth: 100%; height: 100%; padding: 0; margin: 0;\n"
			+ "}\n"
			+ "[data-spinner-bar] {\n"
				+ "\tcolor: " + $spinner.color + ";"
				+ "\tposition: absolute; top: calc(50% - 30px); left: calc(50% - 15px); font-weight: bold; font-size: 40px;"
				+ "\t-webkit-animation: data-spinner 2s linear infinite; -moz-animation: data-spinner 2s linear infinite; animation: data-spinner 2s linear infinite;\n"
			+ "}\n"
			+ "\t@-moz-keyframes data-spinner {100% {-moz-transform: rotate(360deg); transform: rotate(360deg);}}\n"
			+ "\t@-webkit-keyframes data-spinner {100% {-webkit-transform: rotate(360deg); transform: rotate(360deg);}}\n"
			+ "\t@keyframes data-spinner {100% {-webkit-transform: rotate(360deg); transform: rotate(360deg);}}\n"
		+ "</style>";
	}

	$.extend($spinner, data);
	var $style = this.init($spinner);

	return this.each(function(){
		if($("#data-spinner-style").length === 0){
			$("head").append($style);
		}

		$spin = $(this);
		$spin
			.attr({"data-spinner-layer": "", "data-spinner-body": $("body").css("overflow")})
			.append("<div data-spinner-bar>" + $spinner.html + "</div>")
			.on("show", function(){
			//	$("body").css("overflow", "hidden");
			})
			.on("hide", function(){
				//$("body").css("overflow", $spin.attr("data-spinner-body")).removeClass("unselectable");
				//$("body").css("overflow", "scroll");
				//$("body").css("overflow-x", "hidden");
			})
		;

		$("body").addClass("unselectable");
	});
}