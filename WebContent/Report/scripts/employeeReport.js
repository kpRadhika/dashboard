$(function(){
	showDropDown();

	$("#monthYear").MonthPicker({
		MaxMonth: -1,
		MinMonth: new Date(((new Date).getFullYear())-1, 10,(new Date).getDay())

	});

	if($("#projectDropDown").val()!="")
		$("#monthPicker").show();


$("#report").validate({
	rules : {

		monthYear : {
			required : true
		},
		projectDropDown : {
			check_item_dropdown : true
		}
	},
	messages : {
		monthYear : {
			required : "Please enter month"
		}

	},
	errorElement : "div"

});
$.validator.addMethod("check_item_dropdown", function(b, a) {
	return $.trim(b) != ""
}, "Please select Project");

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
			$("#role"+j).prop("disabled",false);
			$("#projectName"+j).prop("disabled",false);

			$("#phone"+j).attr("name","phone");
			$("#panno"+j).attr("name","panno");
			$("#aadharNo"+j).attr("name","aadharNo");
			$("#passportNo"+j).attr("name","passportNo");
			$("#skills"+j).attr("name","skills");
			$("#isActive"+j).attr("name","isActive");
			$("#role"+j).attr("name","role");
			$("#projectName"+j).attr("name","projectName");

		}
		else{
			$("#phone"+j).prop("disabled",true);
			$("#panno"+j).prop("disabled",true);
			$("#aadharNo"+j).prop("disabled",true);
			$("#passportNo"+j).prop("disabled",true);
			$("#skills"+j).prop("disabled",true);
			$("#isActive"+j).prop("disabled",true);
			$("#role"+j).prop("disabled",true);
			$("#projectName"+j).prop("disabled",true);

		}
		j++;
	});
	$("#submit").prop("disabled",false);


}







