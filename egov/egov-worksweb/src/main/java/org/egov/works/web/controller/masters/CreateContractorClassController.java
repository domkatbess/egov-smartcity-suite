/*
 * eGov suite of products aim to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) <2015>  eGovernments Foundation
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
 */
package org.egov.works.web.controller.masters;

import javax.servlet.http.HttpServletRequest;

import org.egov.commons.ContractorGrade;
import org.egov.infra.exception.ApplicationException;
import org.egov.works.masters.service.ContractorGradeService;
import org.egov.works.utils.WorksConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/masters")
public class CreateContractorClassController extends BaseContractorClassController {

    @Autowired
    private ContractorGradeService contractorGradeService;

    @Autowired
    @Qualifier("messageSource")
    private MessageSource messageSource;

    @RequestMapping(value = "/contractorclass-newform", method = RequestMethod.GET)
    public String showContractorClassForm(final Model model) {
        final ContractorGrade contractorGrade = new ContractorGrade();
        model.addAttribute(CONTRACTORGRADE, contractorGrade);
        return "contractorclass-form";
    }

    @RequestMapping(value = "/contractorclass-save", method = RequestMethod.POST)
    public String createContractorClass(@ModelAttribute final ContractorGrade contractorGrade,
            final BindingResult resultBinder, final Model model, final HttpServletRequest request)
            throws ApplicationException {
        validateContractorClass(contractorGrade, resultBinder, request.getParameter(WorksConstants.MODE));
        if (resultBinder.hasErrors()) {
            model.addAttribute(CONTRACTORGRADE, contractorGrade);
            return "contractorclass-form";
        }
        contractorGradeService.save(contractorGrade);
        return "redirect:/masters/contractorclass-success?contractorClassId=" + contractorGrade.getId();

    }

    @RequestMapping(value = "/contractorclass-success", method = RequestMethod.GET)
    public String successView(final Model model, final HttpServletRequest request) {
        final Long contractorGradeId = Long.valueOf(request.getParameter("contractorClassId"));
        final ContractorGrade newContractorGrade = contractorGradeService.getContractorGradeById(contractorGradeId);
        final String mode = request.getParameter(WorksConstants.MODE);
        model.addAttribute(CONTRACTORGRADE, newContractorGrade);
        if (mode != null && mode.equalsIgnoreCase(WorksConstants.EDIT)) {
            model.addAttribute(WorksConstants.MODE, mode);
            model.addAttribute("modifySuccess", messageSource.getMessage("msg.contractorclass.modify.success",
                    new String[] { newContractorGrade.getGrade() }, null));
        } else
            model.addAttribute("createSuccess", messageSource.getMessage("msg.contractorclass.create.success",
                    new String[] { newContractorGrade.getGrade() }, null));
        return "contractorclass-success";

    }

}
