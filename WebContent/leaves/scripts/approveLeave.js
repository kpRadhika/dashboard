function enableDisable(i){
	var j=0;
	$('.radioCheck').each(function() {

		if(i==j)
		{
			$("#emlId"+j).prop("disabled",false);
			$("#isApproved"+j).prop("disabled",false);
			$("#empName"+j).prop("disabled",false);
			$("#emplLeaveFrom"+j).prop("disabled",false);
			$("#emplLeaveTo"+j).prop("disabled",false);
			$("#emplType"+j).prop("disabled",false);

			$("#emlId"+j).attr("name","emlId");
			$("#isApproved"+j).attr("name","isApproved");
			$("#emlSel"+j).attr("name","emlSel");
			$("#emplType"+j).attr("name","empLeaveType");
			$("#emplLeaveFrom"+j).attr("name","emplLeaveFrom");
			$("#emplLeaveTo"+j).attr("name","emplLeaveTo");

		}
		else{
			$("#emlId"+j).prop("disabled",true);
			$("#isApproved"+j).prop("disabled",true);
			$("#empName"+j).prop("disabled",true);
			$("#emplLeaveFrom"+j).prop("disabled",true);
			$("#emplLeaveTo"+j).prop("disabled",true);
			$("#emplType"+j).prop("disabled",true);

		}
		j++;
	});
	$("#submit").prop("disabled",false);

}