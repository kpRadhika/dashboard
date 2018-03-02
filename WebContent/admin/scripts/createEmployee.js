$(function(){
	 $( "#fromDate" ).datepicker({
	    	changeMonth: true,
			changeYear: true,
			yearRange: "-100:+0",
			dateFormat: 'dd-mm-yy'
	    });

	    $( "#toDate" ).datepicker({
	    	changeMonth: true,
	    	changeYear: true,
			yearRange: "-100:+0",
			dateFormat: 'dd-mm-yy'
	    });

	    $('input[type="radio"]').click(function() { 
	    	$("#subbutton").attr("disabled",false);
	    });
	    
	    $( "#doj" ).datepicker({
	    	changeMonth: true,
	    	changeYear: true,
	    	minDate:0,
			monthRange: ":+12",
			dateFormat: 'dd-mm-yy'
	    });

	    $("#createEmployee").validate({
	    	rules : {
	    		fromDate : {
	    			required : true
	    		},
	    		toDate : {
	    			required : true
	    		}
	    	},
	    	messages : {
	    		fromDate : {
					required : "Please select from Date"
				},
				toDate : {
					required : "Please select end Date"
				}
	    	},
	    	errorPlacement : function(label, element) {
				label.addClass('error');
				label.insertAfter(element);
		    },
			wrapper : "div"

	    });

	    $("#createEmpl").validate({
	    	rules : {
	    		doj : {
	    			required : true
	    		},
	    		role : {
	    			check_item_dropdown : true
	    		}
	    	},
	    	messages : {
	    		doj : {
					required : "Please select Date"
				},
				role : {
					required : "Please select end Date"
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
		}, "Please select Statement Status");
});

function performNextStep(){
	
		$("#modal").show();
	
	
}
function popUpSubmit(){
	$("#createEmpl").submit();
}