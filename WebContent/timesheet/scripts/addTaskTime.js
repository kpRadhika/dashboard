$(document).ready(function(){
	
	$("#startDateTime").datetimepicker({
		dateFormat : "dd-mm-yy",
		changeMonth : true,
		changeYear : true,
		numberOfMonths : 1,
		showSecond:false,
		onSelect : function(selected) {
		}
	})
	
	$("#endDateTime").datetimepicker({
		dateFormat : "dd-mm-yy",
		changeMonth : true,
		changeYear : true,
		numberOfMonths : 1,
		onSelect : function(selected) {
		}
	})
	
	$('#addTaskTime').validate(
			{
				rules :
				{
					startDateTime : {
						required : true
					},
					endDateTime : {
						required : true
					}
				},

				messages :
				{
					
					startDateTime : {
						required : "Start date is required"
					},
					endDateTime : {
						required : "End date is required"
					}
					
				},

				errorElement: "div"
			});
	
})

function currentTime(dateTimePicker)
{
	var today=new Date();
	var date="0"+today.getDate();
	var month="0"+(today.getMonth()+1);
	var year=today.getFullYear();
	var hours="0"+today.getHours();
	var minuts="0"+today.getMinutes();
	var currentDateTime=date.slice(-2)+"-"+month.slice(-2)+"-"+year+" "+hours.slice(-2)+":"+minuts.slice(-2);
	
	$("#"+dateTimePicker).val(currentDateTime);
}

function resetVal()
{
	$("#taskStatus").val("");
}

function formSubmit()
{
	var fromDate=new Date($("#startDateTime").val().split("-")[1]+"-"+$("#startDateTime").val().split("-")[0]+"-"+$("#startDateTime").val().split("-")[2]);
	var toDate=	new Date($("#endDateTime").val().split("-")[1]+"-"+$("#endDateTime").val().split("-")[0]+"-"+$("#endDateTime").val().split("-")[2]);
	var diff = Math.abs(toDate - fromDate);
	var hours = Math.floor((diff/1000)/(60*60));
	
	$("#hours").val(hours);
	if(hours>12)
		{
		alert("End Date should not be greater than 12 hours from Start Date")
		return false;
		}
	
}

function setStatusOption(status)
{
	$("#taskStatus").val(status);
}
