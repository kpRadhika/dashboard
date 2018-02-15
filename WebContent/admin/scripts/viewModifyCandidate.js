$(function(){

	$( "#interdate" ).datepicker({
    	changeMonth: true,
		changeYear: true,
		dateFormat: 'dd-mm-yy'
    });

	$("#searchOption").hide();
	$("#dateSelection").hide();

	$('input:radio[name="viewModify"]').click(function() {
		if($("#interviewDate").is(":checked")){
			$("#dateSelection").show();
			$("#searchOption").hide();
		}
		else{
			$("#searchOption").show();
			$("#dateSelection").hide();
		}

	});

});
function modifyCandidate(i){
	$("#count").val(i);
	$("#viewModifys").submit();
}



