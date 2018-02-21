$(function(){
	$("#projectDropDown").change(function(){
		$("#clientTaskId").attr("disabled",false);
		$("#taskDesc").attr("disabled",false);	
		showResources();
	}	);
});

function showResources(){
	$.ajax({
		type: "POST",
		dataType: 'xml',
		url : "addTaskAjax.jsp",
		async: false,
		error: function() {
			ajaxNoResultFound("Error");
		},
		success: function(d) {
			var e = "";
			$(d).find("resOption").each(
					function() {
						$(this).find("input").each(
								function() {
									e = e + '<tr><td>' + $(this).text() + '</td></tr>'
								});
					});
			  $("#resMapping").html(e);
			  $("#resMapping").show();

		}
	});
}
