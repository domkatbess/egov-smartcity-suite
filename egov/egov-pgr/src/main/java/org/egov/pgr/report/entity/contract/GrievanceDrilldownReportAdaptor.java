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

package org.egov.pgr.report.entity.contract;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonSerializationContext;
import org.egov.infra.web.support.json.adapter.DataTableJsonAdapter;
import org.egov.infra.web.support.ui.DataTable;
import org.egov.pgr.report.entity.view.DrilldownReportView;

import java.lang.reflect.Type;
import java.util.List;

import static org.egov.infra.utils.StringUtils.defaultIfBlank;

public class GrievanceDrilldownReportAdaptor implements DataTableJsonAdapter<DrilldownReportView> {

    @Override
    public JsonElement serialize(DataTable<DrilldownReportView> drillDownReportResponse, Type type,
                                 JsonSerializationContext jsc) {
        List<DrilldownReportView> drilldownReportResult = drillDownReportResponse.getData();
        JsonArray reportData = new JsonArray();
        drilldownReportResult.forEach(reportObject -> {
            JsonObject jsonObject = new JsonObject();
            if (reportObject.getEmployeeName() != null)
                jsonObject.addProperty("name", defaultIfBlank(reportObject.getEmployeeName()));
            if (reportObject.getComplaintTypeName() != null)
                jsonObject.addProperty("name", defaultIfBlank(reportObject.getComplaintTypeName()));
            jsonObject.addProperty("completed", reportObject.getCompleted());
            jsonObject.addProperty("inprocess", reportObject.getInprocess());
            jsonObject.addProperty("registered", reportObject.getRegistered());
            jsonObject.addProperty("rejected", reportObject.getRejected());
            jsonObject.addProperty("withinsla", reportObject.getWithinSLA());
            jsonObject.addProperty("beyondsla", reportObject.getBeyondSLA());
            jsonObject.addProperty("total", reportObject.getTotal());
            jsonObject.addProperty("reopened", reportObject.getReopened());
            if (reportObject.getEmployeeId() != null)
                jsonObject.addProperty("usrid", reportObject.getEmployeeId());
            if (reportObject.getComplaintTypeId() != null)
                jsonObject.addProperty("complaintTyeId", reportObject.getComplaintTypeId());
            reportData.add(jsonObject);
        });
        return enhance(reportData, drillDownReportResponse);
    }

}
