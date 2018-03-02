$(function(){
	$("#fromDate").datepicker({
    	changeMonth: true,
		changeYear: true,
		yearRange: "-100:+0",
		dateFormat: 'dd-mm-yy',
		onSelect : function(selected) {
				$("#toDate").datepicker("option", "minDate", selected)
			}
    });
	$("#toDate").datepicker({
    	changeMonth: true,
		changeYear: true,
		yearRange: "-100:+0",
		dateFormat: 'dd-mm-yy',
		onSelect : function(selected) {
			$("#fromDate").datepicker("option", "maxDate", selected)
		}
    });

	$("#viewTaskTbl").validate({
		rules: {
			fromDate : {
				required : true
			},
			toDate : {
				required : true
			},
			projectDropDown : {
    			check_item_dropdown : true
    		}

		},
		messages : {
			fromDate : {
				required : "Please select from date."
			},
			toDate : {
				required : "Please select to date."
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
});