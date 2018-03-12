$(function() {
	showDropDown();
	$("#projectDropDown").change(function() {
		fetchProjectDetails($(this).val());
	})
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
function fetchProjectDetails(val){
	$.ajax({
		data:
		{
			projectId:val
		},
		type: "POST",
		dataType: 'xml',
		url : "modifyProjectAjax.jsp",
		async: false,
		error: function() {
		},
		success: function(d) {
			var e = "";
			$(d).find("PROJOPTION").each(
					function() {
						$(this).find("PROJLOC").each(
								function() {
									 $("#ploc").html($(this).text());
									 $("#ploc").attr("disabled",false);
									});
						$(this).find("PROJTECH").each(
								function() {
									$("#ptech").html($(this).text());
									 $("#ptech").attr("disabled",false);
								});
						$(this).find("PROJLOC").each(
								function() {
									var lead = $(this).text().split("|");
									var id = lead[0];
									var name = lead[1];
									e = e + '<option value="'+id+'">'+name+'</option>';

								});
					});

			  $("#plead").html(e);
			  $("#plead").attr("disabled",false);

		}
	});
}