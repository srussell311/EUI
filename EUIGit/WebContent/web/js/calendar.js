$(document).ready(function() {
	alert("calendar js file function")
    $("#nslaunchDate").datepicker();
        var nslaunchDate = $("#nslaunchDate").val();

        if (nslaunchDate === "") {
			alert("Please select a launch date.");
        } 

});