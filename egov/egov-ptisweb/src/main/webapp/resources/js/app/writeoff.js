/*
 *    eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) 2017  eGovernments Foundation
 *
 *     The updated version of eGov suite of products as by eGovernments Foundation
 *     is available at http://www.egovernments.org
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see http://www.gnu.org/licenses/ or
 *     http://www.gnu.org/licenses/gpl.html .
 *
 *     In addition to the terms of the GPL license to be adhered to in using this
 *     program, the following additional terms are to be complied with:
 *
 *         1) All versions of this program, verbatim or modified must carry this
 *            Legal Notice.
 *            Further, all user interfaces, including but not limited to citizen facing interfaces,
 *            Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
 *            derived works should carry eGovernments Foundation logo on the top right corner.
 *
 *            For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
 *            For any further queries on attribution, including queries on brand guidelines,
 *            please contact contact@egovernments.org
 *
 *         2) Any misrepresentation of the origin of the material is prohibited. It
 *            is required that all modified versions of this material be marked in
 *            reasonable ways as different from the original version.
 *
 *         3) This license does not grant any rights to any user of the program
 *            with regards to rights under trademark law for use of the trade names
 *            or trademarks of eGovernments Foundation.
 *
 *   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 *
 */
$( document ).ready(function() {
    $("#viewlink").hide();

	 var frominstallment;
	 var toinstallment;
	 var urlvalue;
	 instString = $("#instString").val();
	 var statevalue = $("#state").val();
	 var typevalue = $( "#writeOffType option:selected" ).text();
		if (typevalue == 'Full WriteOff' && statevalue == 'Rejected') {
			var flagvalue = $("#propertyDeactivateFlag").val();
			$("#frominstallments").attr('disabled', true);
			$("#toinstallments").attr('disabled', true);
			if(flagvalue==true)
			document.getElementById("check").style.display = "block";
		}
$("writeOffType").change(function()
	           {
	$("#demandDetailsTable").removeAttr('style');
	  instString.split(",").forEach((val,index)=> {
		  var queryIdentifier = ".row-"+val;
		  $(queryIdentifier).removeAttr('style');

	  });
	           });
	           
	 
	       $("#frominstallments").change(function()
	           {
	    
	    	   getselectedinstallments(); });
$("#toinstallments").change(function()
          {
	 getselectedinstallments();
          }); 
});

function getselectedinstallments(val){
	   
	  fromVal = $("#frominstallments").val();
	  toVal = $("#toinstallments").val();
	  instString = $("#instString").val();
	  
	  if(fromVal && toVal){
		  var fromValIndex = instString.split(",").indexOf(fromVal);
		  var toValIndex = instString.split(",").indexOf(toVal);
		  $("#demandDetailsTable").attr('style', 'display:none;');
		  instString.split(",").forEach((val,index)=> {
			  var queryIdentifier = ".row-"+val;
			  $(queryIdentifier).attr('style', 'display:none;');

		  });
		  
		  if(fromValIndex > toValIndex)
			return alert("To Installment cannot be greater than From Installment");
		   $("#demandDetailsTable").removeAttr('style');		  
		  instString.split(",").forEach((val,index)=> {
			  if(fromValIndex <= index && index <= toValIndex){
			  var queryIdentifier = ".row-"+val;
			  $(queryIdentifier).removeAttr('style');
			  }
		  });
	  }
}

	
	var fullwriteoffreasons = false;
	function enablecheckbox() {
		var writeofftypes = $( "#writeOffType option:selected" ).text();
		if (writeofftypes == 'Full WriteOff') {
			document.getElementById("check").style.display = "block";
			$("#frominstallments").attr('disabled', true);
			$("#toinstallments").attr('disabled', true);
			$("#frominstallments").val('');
			$("#toinstallments").val('');
			$("#demandDetailsTable").removeAttr('style');
			  instString.split(",").forEach((val,index)=> {
				  var queryIdentifier = ".row-"+val;
				  $(queryIdentifier).removeAttr('style');

			  });
			for(var i=0; i < $(".demandDetailBeanList").length; i++){
				 
				var actualCollection = 'demandDetailBeanList'+ i + '.actualCollection';
				var actualAmount = 'demandDetailBeanList'+ i + '.actualAmount';
				var revisedAmount = 'demandDetailBeanList'+ i + '.revisedAmount';
			
			document.getElementById(revisedAmount).value = document.getElementById(actualAmount).value - document.getElementById(actualCollection).value;
			var collectionAmount = document.getElementById(actualCollection).value;
			var actualAmount = document.getElementById(actualAmount).value;
			if(actualAmount == collectionAmount){
			document.getElementById(revisedAmount).disabled = true;
			}
			}
			
		} else {
			document.getElementById("check").style.display = "none";
			$("#frominstallments").attr('disabled', false);
			$("#toinstallments").attr('disabled', false);
			for(var i=0; i < $(".demandDetailBeanList").length; i++){
				var actualAmount = 'demandDetailBeanList'+ i + '.actualAmount';
				var revisedAmount = 'demandDetailBeanList'+ i + '.revisedAmount';
				var actualCollection = 'demandDetailBeanList'+ i + '.actualCollection';
				var collectionAmount = document.getElementById(actualCollection).value;
				var actualAmount = document.getElementById(actualAmount).value;
				console.log("dattab   "+actualCollection)
				if(actualAmount == collectionAmount){
					document.getElementById(revisedAmount).disabled = true;
					}else
			document.getElementById(revisedAmount).value = '';
			
			}
			
		}
	}
	
	function displayreasons(){
			var reasontype = $( "#writeOffType option:selected" ).text();
			jQuery.ajax({
				url: "/ptis/common/getwriteoffreason",
				dataType: "json",
		        type: "GET",
		        data:{"typevalue":reasontype},
				success: function (response) {
						jQuery('#reasons').prop("disabled", false); 
						jQuery('#reasons').html("");
						var select = jQuery(this).find("#reasons");
						select.empty();
						jQuery('#reasons').append(
								jQuery('<option>').text('Select').attr('value', ""));
					jQuery.each(response, function(index, reason) {
						jQuery('#reasons').append(
								"<option value='" + reason.id + "'>" + reason.name
										+ "</option>");
					});
				}, 
				error: function () {
				}
			});

	}
	
	function getcouncilrequest(){
		var resolutiontype = jQuery('#resolutionType').val();
		var resolutionNo = jQuery('#resolutionNo').val();
		var errormessage;
		var resolutionDate;
		if(resolutiontype!=null && resolutionNo!=null && resolutionNo!=undefined && resolutiontype!=undefined){
		jQuery.ajax({
			url: "/ptis/common/getcouncildetails",
			dataType: 'json',
	        type: "GET",
	       async : false,
	        data:{"resolutionType":resolutiontype,"resolutionNo":resolutionNo},
			success: function (response) {
					   for (var i=0;i<response.length;i++) {
					      $("#resolutionDate").val(response[i].resolutionDate);
					      resolutionDate = response[i].resolutionDate;
					      urlvalue = response[i].councilResolutionUrl;
					      errormessage = response[i].errorMessage;
					      if(urlvalue != null){
					    	  $("#url"). attr("href",urlvalue);
					    	  $("#viewlink").show();
					      }
					}
					   if(errormessage != null){
							   if(resolutionDate==null)
						  $("#resolutionDate").val("");
							      $("#viewlink").hide();
							      bootbox.alert(errormessage);
							   }
					   }, 
			error: function(){
				if(errormessage!=null)
				bootbox.alert(errormessage);
			} 				
			
		});
		}
	}

	$('#url').click(function(event){ 
	window.open(urlvalue,_blank); 
	window.focus();
	})
	
	
		