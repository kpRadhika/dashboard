$( function() {
    $( "#datepicker" ).datepicker({
    	changeMonth: true,
		changeYear: true,
		maxDate:"0",
		yearRange: "-100:+0",
		dateFormat: 'dd-mm-yy'
    });

    $( "#interViewDate" ).datepicker({
    	changeMonth: true,
		monthRange:'12',
		minDate:"0",
		dateFormat: 'dd-mm-yy'
    });
  } );
function formSubmit(){

	$("#createCandidate").validate({
		rules : {
			firstName : {
				required : true
			},
			lastName : {
				required : true
			},
			DOB : {
				required : true
			},
			phone : {
				required : true,
				number : true,
				maxlength : 10
			},
			email : {
				required : true,
				email : true
			},
			qualification : {
				required : true
			},
			exp : {
				required : true
			},
			skills : {
				required : true
			},
			address : {
				required : true
			},
			uploadFile :{
				required: true
			}
		},
		messages : {
			firstName : {
				required : "Please enter the first name"
			},
			lastName : {
				required : "Please enter the last name"
			},
			DOB : {
				required : "Please select the DOB"
			},
			phone : {
				required : "Please enter the phone number"
			},
			email : {
				required : "Please enter the email id"
			},
			qualification : {
				required : "Please enter the qualification"
			},
			exp : {
				required : "Please enter the experience"
			},
			skills : {
				required : "Please enter the skills"
			},
			address : {
				required : "Please enter the address"
			},
			uploadFile : {
				required : "Please upload resume in pdf format"
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
	}, "Please Enter 10 digit mobile number only");
	$.validator.addMethod("email", function(b, a) {
		return this.optional(a) || /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/i.test(b)
	}, "Please Enter valid Email Id");

}




