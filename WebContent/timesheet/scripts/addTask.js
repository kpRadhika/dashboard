$(function(){
	$("#projectDropDown").change(function(){
		$("#clientTaskId").attr("disabled",false);
		$("#taskDesc").attr("disabled",false);	
		showResources($(this).val());
	}	);

});
function selectResources(i){
	var existing = $("#selectedRes").val();
	$("#selectedRes").val(existing+i+",");	
	
}

function showResources(val){
	$.ajax({
		data: 
		{
			projectId:val			
		},
		type: "POST",
		dataType: 'xml',
		url : "addTaskAjax.jsp",
		async: false,
		error: function() {
			//ajaxNoResultFound("Error");
		},
		success: function(d) {
			var e = "<table>";
			$(d).find("RESOPTION").each(
					function() {
						$(this).find("RESNAME").each(
								function() {
									var resource = $(this).text().split("|");
									var id = resource[0];
									var name = resource[1];
									e = e + '<tr><td><input type="checkbox"  onclick="selectResources('+id+')" value="' + id + '">'+name+'</td></tr>'
								});
					});
			  e = e+"</table>"
			  $("#resMapping").html(e);
			  $("#resMapping").show();

		}
	});
}
