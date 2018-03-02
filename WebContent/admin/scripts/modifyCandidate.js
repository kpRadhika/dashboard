$(function(){
	$( "#interviewDate" ).datepicker({
    	changeMonth: true,
		monthRange:'12',
		dateFormat: 'dd-mm-yy'
    });

	$("#modifyCandidateForm").validate({
		rules: {
			skills : {
				required : true
			},
			interviewDate : {
				required : true
			}

		},
		messages : {
			skills : {
				required : "Please enter Skills."
			},
			interviewDate : {
				required : "Please select Date."
			}
		},
		errorPlacement : function(label, element) {
			label.addClass('error');
			label.insertAfter(element);
	    },
		wrapper : "div"

	});

});



