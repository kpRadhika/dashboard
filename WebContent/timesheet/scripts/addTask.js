$(function(){
	$("#projectDropDown").change(function(){
		$("#clientTaskId").attr("disabled",false);
		$("#taskDesc").attr("disabled",false);
		$("#remarks").attr("disabled",false);
		showResources($(this).val());
	}	);


	$("#addTask").validate({
		rules: {
			taskDesc : {
				required : true
			},
			projectDropDown : {
    			check_item_dropdown : true
    		},
    		remarks : {
    			required : true
    		},
    		'resMapping[]' : {
    			required : true

    		}

		},
		messages : {

			taskDesc : {
				required : "Please enter Task Description."
			},
			remarks : {
				required : "Please enter Remark."
			},
			'resMapping[]' : {
				required : "Please select alteast one check box."
			}
		},
		errorPlacement : function(label, element) {
			label.addClass('error');
			label.insertAfter(element);
	    },
		wrapper : "div"

	});
	$.validator.addMethod("check_item_dropdown", function(b, a) {
		return $.trim(b) != ""
	}, "Please select Project");
	$.validator.addMethod("check_item_dropdown", function(b, a) {
		return $.trim(b) != ""
	}, "Please select Project");


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
									e = e + '<tr><td><input type="checkbox" name="resMapping[]" onclick="selectResources('+id+')" value="' + id + '">'+name+'</td></tr>'
								});
					});
			  e = e+"</table>"
			  $("#resMapping").html(e);
			  $("#resMapping").show();

		}
	});
}
