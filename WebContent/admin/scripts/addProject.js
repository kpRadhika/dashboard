$(function(){

	    $("#addProject").validate({
	    	rules : {
	    		pname : {
	    			required : true
	    		},
	    		ptech : {
	    			required : true
	    		},
	    		ploc : {
	    			check_item_dropdown : true
	    		}
	    	},
	    	messages : {
	    		pname : {
					required : "Please enter Project Name"
				},
				ptech : {
					required : "Please enter Project Technology"
				}

	    	},
	    	errorElement : "div"

	    });
	    $.validator.addMethod("check_item_dropdown", function(b, a) {
			return $.trim(b) != ""
		}, "Please select Location");

});
