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
			$("#candidateTbl").hide();
			$("#searchText").val("");
			$("#interdate").val("");
			document.getElementById("searchErrorMsg").style.display ="none";
			document.getElementById("dateErrorMsg").style.display ="none";
		}
		else{
			if($("#candidateId").is(":checked")){
				$("#searchText").val("");
				$("#candidateTbl").hide();
			}else if($("#skills").is(":checked")){
				$("#searchText").val("");
				$("#candidateTbl").hide();
			}else if($("#name").is(":checked")){
				$("#searchText").val("");
				$("#candidateTbl").hide();
			}
			$("#searchOption").show();
			$("#dateSelection").hide();
			document.getElementById("searchErrorMsg").style.display ="none";
			document.getElementById("dateErrorMsg").style.display ="none";
		}

	});

	if($("#name").is(":checked") || $("#skills").is(":checked") || $("#candidateId").is(":checked")){
		$("#searchOption").show();
	}
	if($("#interviewDate").is(":checked")){
		$("#dateSelection").show();
	}

});
function modifyCandidate(i){
	$("#count").val(i);
	$("#viewModifys").submit();
}

function TextValidation(){
	document.getElementById("searchErrorMsg").style.display ="none";
	document.getElementById("dateErrorMsg").style.display ="none";
	if(!$("#interviewDate").is(":checked") && $("#searchText").val() == ""){
		document.getElementById("searchErrorMsg").innerHTML = "Please Enter value" ;
		document.getElementById("searchErrorMsg").style.display ="block";
		return false;
	}
	if($("#interviewDate").is(":checked") && $("#interdate").val() == ""){
		document.getElementById("dateErrorMsg").innerHTML = "Please select date" ;
		document.getElementById("dateErrorMsg").style.display ="block";
		return false;
	}
}


