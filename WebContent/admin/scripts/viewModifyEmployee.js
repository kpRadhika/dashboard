$(function(){
	$("#searchOption").hide();
	$("#projectOption").hide();
	document.getElementById("searchErrorMsg").style.display ="none";
	document.getElementById("projectNameError").style.display ="none";
	$('input:radio[name="viewModify"]').click(function() {
		if($("#name").is(":checked")){
			$("#searchOption").show();
			$("#projectOption").hide();
			$("#projectDropDown").val("");
			$("#empltable").hide();
			$("#sumbitTable").hide();
		}else{
			showDropDown();
			 $("#searchText").val("");
			 $("#empltable").hide();
			 $("#sumbitTable").hide();
		}
	});

if($("#skills").is(":checked")){
	showDropDown();
}
if($("#name").is(":checked")){
	$("#searchOption").show();
	$("#projectOption").hide();

}

$("#viewModifyEmolyeeForm").validate({
	rules: {
		phone : {
			required : true,
			number : true,
			maxlength : 10
		},
		panno : {
			required : true,
			panCheck : true,
			maxlength : 10
		},
		aadharNo : {
			aadharNo : true
		},


	},
	messages : {
		phone : {
			required : "Please enter the phone Number."
		},
		panno : {
			required : "Please enter the pan Number."
		}
	},
	errorPlacement : function(label, element) {
		label.addClass('error');
		label.insertAfter(element);
    },
	wrapper : "div"

});
$.validator.addMethod("number", function(b, a) {
	return this.optional(a) || /^\s*(?:[0-9]{10})\s*$/i.test(b)
}, "Invalid phone number");
$.validator.addMethod("panCheck", function(value, element)
{
	return this.optional(element) || /^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/i.test(value);
}, "Invalid pan number");
$.validator.addMethod("aadharNo", function(b, a) {
	return this.optional(a) || /^\d{12}$/i.test(b)
}, "Invalid Aadhar Number.");

});

function showDropDown(){
	$.ajax({
		type: "POST",
		dataType: 'xml',
		url : "viewModifyEmployeeAjax.jsp",
		async: false,
		error: function() {
			ajaxNoResultFound("Error");
		},
		success: function(d) {
			var e = "";
			e = e + '<option value=""> Select </option>';
			$(d).find("projectOption").each(
					function() {
						$(this).find("option").each(
								function() {
									var h = $.trim($("#projectDropDown").val());
									var g = $(this).attr("value");
									if (h == $(this).attr("value")) {
										e = e + '<option value="' + $(this).attr("value") + '" selected>' + $(this).text() + "</option>"
									} else {
										e = e + '<option value="' + $(this).attr("value") + '" >' + $(this).text() + "</option>"
									}
								});
					});
			  $("#projectDropDown").html(e);
			  $("#projectOption").show();
			  $("#searchOption").hide();

		}
	});
}
function formSubmit(){
	document.getElementById("searchErrorMsg").style.display ="none";
	document.getElementById("projectNameError").style.display ="none";
	var searchVal = document.viewModifys.searchText.value;
	if($("#name").is(":checked") && searchVal == ""){
		document.getElementById("searchErrorMsg").innerHTML = "Please Enter value" ;
		document.getElementById("searchErrorMsg").style.display ="block";
		return false;
	}
	if($("#skills").is(":checked") && $("#projectDropDown").val() == ""){
		document.getElementById("projectNameError").innerHTML = "Please select value" ;
		document.getElementById("projectNameError").style.display ="block";
		return false;
	}
}

function enableDisable(i){
	var j=0;
	$('.radioCheck').each(function() {

		if(i==j)
		{
			$("#phone"+j).prop("disabled",false);
			$("#panno"+j).prop("disabled",false);
			$("#aadharNo"+j).prop("disabled",false);
			$("#passportNo"+j).prop("disabled",false);
			$("#skills"+j).prop("disabled",false);
			$("#isActive"+j).prop("disabled",false);

			$("#phone"+j).attr("name","phone");
			$("#panno"+j).attr("name","panno");
			$("#aadharNo"+j).attr("name","aadharNo");
			$("#passportNo"+j).attr("name","passportNo");
			$("#skills"+j).attr("name","skills");
			$("#isActive"+j).attr("name","isActive");

		}
		else{
			$("#phone"+j).prop("disabled",true);
			$("#panno"+j).prop("disabled",true);
			$("#aadharNo"+j).prop("disabled",true);
			$("#passportNo"+j).prop("disabled",true);
			$("#skills"+j).prop("disabled",true);
			$("#isActive"+j).prop("disabled",true);

		}
		j++;
	});
	$("#submit").prop("disabled",false);


}







