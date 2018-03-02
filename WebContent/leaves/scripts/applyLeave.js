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
});