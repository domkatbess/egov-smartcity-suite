<%--
  ~    eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
  ~    accountability and the service delivery of the government  organizations.
  ~
  ~     Copyright (C) 2017  eGovernments Foundation
  ~
  ~     The updated version of eGov suite of products as by eGovernments Foundation
  ~     is available at http://www.egovernments.org
  ~
  ~     This program is free software: you can redistribute it and/or modify
  ~     it under the terms of the GNU General Public License as published by
  ~     the Free Software Foundation, either version 3 of the License, or
  ~     any later version.
  ~
  ~     This program is distributed in the hope that it will be useful,
  ~     but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~     GNU General Public License for more details.
  ~
  ~     You should have received a copy of the GNU General Public License
  ~     along with this program. If not, see http://www.gnu.org/licenses/ or
  ~     http://www.gnu.org/licenses/gpl.html .
  ~
  ~     In addition to the terms of the GPL license to be adhered to in using this
  ~     program, the following additional terms are to be complied with:
  ~
  ~         1) All versions of this program, verbatim or modified must carry this
  ~            Legal Notice.
  ~            Further, all user interfaces, including but not limited to citizen facing interfaces,
  ~            Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
  ~            derived works should carry eGovernments Foundation logo on the top right corner.
  ~
  ~            For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
  ~            For any further queries on attribution, including queries on brand guidelines,
  ~            please contact contact@egovernments.org
  ~
  ~         2) Any misrepresentation of the origin of the material is prohibited. It
  ~            is required that all modified versions of this material be marked in
  ~            reasonable ways as different from the original version.
  ~
  ~         3) This license does not grant any rights to any user of the program
  ~            with regards to rights under trademark law for use of the trade names
  ~            or trademarks of eGovernments Foundation.
  ~
  ~   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
  ~
  --%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>

<div class="row">
	<div class="col-md-12">
		<form:form method="post" action="" modelAttribute="sewerageRatesMaster" id="sewerageMasterUpdateform" cssClass="form-horizontal form-groups-bordered">
			<c:if test="${not empty message}">
				<div class="alert alert-danger" role="alert">
					<spring:message code="${message}" />
				</div>
			</c:if>
			<div class="panel panel-primary" data-collapsed="0">
				<div class="panel-heading">
					<div class="panel-title">
						<strong><spring:message code="lbl.sewerage.rates.details"></spring:message></strong>
					</div>
				</div>
                 <div class="panel-body">
					<div class="row add-border">
						<div class="col-md-3 col-xs-6 add-margin">
							<spring:message code="lbl.propertytype" />
						</div>
						<div class="col-md-3 col-xs-6 add-margin view-content">
							<c:out value="${sewerageRatesMaster.propertyType}" />
						</div>
						<div class="col-md-3 col-xs-6 add-margin">
							<spring:message code="lbl.effective.fromdate" />
						</div>
						<div class="col-md-3 col-xs-6 add-margin view-content">
							<fmt:formatDate var="effectiveFormattedFromDate" pattern="dd/MM/yyyy" value="${sewerageRatesMaster.fromDate}" />							
							 <c:out value="${effectiveFormattedFromDate}" /> 
						</div>
						
					</div>
					
					
				<br>
					<table class="table table-bordered" id="sewerageMasterViewTable" style="width:65%; margin:0 auto">
					<thead>
						<tr>
							<th class="text-center"><spring:message code="lbl.noofclosets"/></th>
							<th class="text-right"><spring:message code="lbl.donation.amount" /></th>	
							<th class="text-left"><spring:message code="lbl.actions"/></th>
						</tr>	
					</thead>
					<tbody>
						<c:forEach var="sewerageRates" items="${sewerageRatesMaster.sewerageDetailmaster}" varStatus="status" >
							<tr>
								<td>
									<input type="text" class="form-control patternvalidation donationRatesNoOfClosets" 
									style="text-align: center; font-size: 12px;" data-pattern="number" 
									id="sewerageDetailmaster[${status.index}].noOfClosets" 
									value="${sewerageRates.noOfClosets}"  name="sewerageDetailmaster[${status.index}].noOfClosets" 
									maxlength="8" required="required" />
									<form:errors path="sewerageDetailmaster[${status.index}].noOfClosets" class="error-msg add-margin" />
								</td>
								<td>
									<input type="text" class="form-control patternvalidation donationRatesAmount" 
									id="sewerageDetailmaster[${status.index}].amount"  
									style="text-align: right; font-size: 12px;" value="${sewerageRates.amount}" data-pattern="decimalvalue" 
									name="sewerageDetailmaster[${status.index}].amount"  maxlength="8" required="required"/>
									<form:errors path="sewerageDetailmaster[${status.index}].amount" class="error-msg add-margin"/>
								</td>
								<form:hidden path="sewerageDetailmaster[${status.index}].id" id="id" value="${sewerageRates.id}"></form:hidden>
								<td>
									<button type="button" onclick="deleteCurrentRow(this)" id="Add" 
									class="btn btn-primary display-hide delete-button"><spring:message code="lbl.swtax.deleteRow" /></button>
								</td>
							</tr>
						</c:forEach>
						<script type="text/javascript">
						var curRow = $('#sewerageMasterViewTable tbody').children('tr').length;
						if(curRow!=1)
								$( "#sewerageMasterViewTable tr:last .delete-button").show();
						</script>
						
					</tbody>
				</table>
				<br>
				<div class=" text-center">
					<button type="button" id="btn-addNewRow" class="btn btn-primary btn-addNewRow"><spring:message code="lbl.swtax.addRow"></spring:message></button>
				</div>
				</div>
					</div>
</div>
				<div class="panel-body">
					<div class="row add-border">
						<div class="form-group text-center">
							<input type="submit" value="Submit" class="btn btn-primary" id="submitSewerageRates"/>
							<a onclick="self.close()" class="btn btn-default"
							href="javascript:void(0)"><spring:message code="lbl.close" /></a>
						</div>
					</div>
				</div>
			
		</form:form>
			</div>
			

<link rel="stylesheet" href="<cdn:url value='/resources/global/css/jquery/plugins/datatables/jquery.dataTables.min.css' context='/egi'/>"/>
<link rel="stylesheet" href="<cdn:url value='/resources/global/css/jquery/plugins/datatables/dataTables.bootstrap.min.css' context='/egi'/>">
<script
	src="<cdn:url  value='/resources/global/js/jquery/plugins/datatables/dataTables.bootstrap.js' context='/egi'/>"
	type="text/javascript"></script>
<script
	src="<cdn:url  value='/resources/js/masters/sewerageRates.js?rnd=${app_release_no}'/>"></script>
<script src="<cdn:url  value='/resources/javascript/helper.js?rnd=${app_release_no}'/>"></script>