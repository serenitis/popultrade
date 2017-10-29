var spinn ;
/// show overlay
function setPageBlock() {
	
	if (spinn) {
	$("#spin").show();
	}
else {
spinn = $("#spin").spinner();
$("#spin").show();

}
}

/// hide overlay
function resetPageBlock() {
	

$("#spin").hide();

}