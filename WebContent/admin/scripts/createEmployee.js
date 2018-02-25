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
});

function performNextStep(){
	
		$("#modal").show();
	
	
}
function popUpSubmit(){
	$("#createEmpl").submit();
}