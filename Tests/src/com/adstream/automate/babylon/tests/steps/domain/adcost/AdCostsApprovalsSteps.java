package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.Approvals;
import com.adstream.automate.babylon.JsonObjects.adcost.ApprovalMembers;
import com.adstream.automate.babylon.JsonObjects.adcost.Costs;
import com.adstream.automate.babylon.JsonObjects.adcost.Requisitioners;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Raja.Gone on 15/05/2017.
 */
public class AdCostsApprovalsSteps extends AdCostsHelperSteps {

    protected AdCostsApprovalsPage openAdCostsApprovalsPage() {
        AdCostsApprovalsPage approvalsPage = getSut().getPageNavigator().getAdCostsApprovalsPage();
        if (approvalsPage.waitUntilApprovalsPageVisible())
            return new AdCostsApprovalsPage(getSut().getWebDriver());
        else
            throw new Error("Unable to open Approvals page");
    }

    // btnName = {Add approvers | Add backup approver}
    // $approverSectionName = { technical | brand }
    @Given("{I |}clicked '$btnName' button in '$approverSectionName' approver section on Approvals page")
    @When("{I |}click '$btnName' button in '$approverSectionName' approver section on Approvals page")
    public void clickApproversButton(String btnName, String approverSectionName) {
        AdCostsApprovalsPage approvalsPage = openAdCostsApprovalsPage();
        String sectionName = approvalsPage.getApproverSectionLocator(approverSectionName);
        approvalsPage.clickBtnByName(btnName, sectionName);
    }

    @Given("{I am} on cost approval page of cost title '$costTitle'")
    @When("{I am} on cost approval page of cost title '$costTitle'")
    public AdCostsApprovalsPage openApprovalsPage(String costTitle) {
        String url = buildCostPageURL(wrapVariableWithTestSession(costTitle));
        Common.sleep(300);
        return getSut().getPageNavigator().getAdCostsApprovalsPage(url);

    }


    // $approverSectionName = { technical | brand }
    @Given("{I |}filled below approvers for cost title '$costTitle':$data")
    @When("{I |}fill below approvers for cost title '$costTitle':$data")
    public void fillApproverDetails(String costTitle,ExamplesTable data) {
        AdCostsApprovalsPage approvalsPage = getSut().getPageNavigator().getAdCostsApprovalsPage();
        String[] allApprovers;
        Map<String, String> row = parametrizeTabularRow(data);

        if (AdCostsData.containsField(AdCostsSchemaField.TECHNICALAPPROVER, row, false)) {
            allApprovers = AdCostsData.getField(AdCostsSchemaField.TECHNICALAPPROVER, row).split(";");
            List<String> approversFullName= getApproverUsersFullName(allApprovers);
            fillApprovers(approvalsPage,approversFullName,"Add approver");
            Common.sleep(500);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.COSTCONSULTANT, row, false)) {
            allApprovers = AdCostsData.getField(AdCostsSchemaField.COSTCONSULTANT, row).split(";");
            List<String> approversFullName= getApproverUsersFullName(allApprovers);
            fillApprovers(approvalsPage,approversFullName,"Add approver");
            Common.sleep(500);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.COUPAREQISITIONER, row, false)) {
            allApprovers = AdCostsData.getField(AdCostsSchemaField.COUPAREQISITIONER, row).split(";");
            List<String> approversFullName= getApproverUsersFullName(allApprovers);
            fillApprovers(approvalsPage,approversFullName,"Add Coupa Requisitioner");
            Common.sleep(500);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.BRANDMANAGEMENTAPPROVER, row, false)) {
            allApprovers = AdCostsData.getField(AdCostsSchemaField.BRANDMANAGEMENTAPPROVER, row).split(";");
            List<String> approversFullName= getApproverUsersFullName(allApprovers);
            fillApprovers(approvalsPage,approversFullName,"Add Brand Management Approver");
            Common.sleep(500);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.ADDWATCHER, row, false)) {
            Common.sleep(1000);
            allApprovers = AdCostsData.getField(AdCostsSchemaField.ADDWATCHER, row).split(";");
            List<String> approversFullName= getApproverUsersFullName(allApprovers);
            fillApprovers(approvalsPage,approversFullName,"Add Watcher");
            Common.sleep(1000);
        }
    }

    private List<String> getApproverUsersFullName(String[] approvers){
        List<String> approversList = new ArrayList<>();
        for(String userName:approvers) {
            User user = getData().getUserByType(userName);
            if (user == null) {
                userName = wrapUserEmailWithTestSession(userName);
                user = getCoreApiAdmin().getUserByEmail(userName, 0);
                approversList.add(user.getFullName());
            } else approversList.add(user.getFullName());
        }
            return approversList;
    }

    private void fillApprovers(AdCostsApprovalsPage approvalsPage,List<String> allApprovers,String btnName){
        AdCostsApprovalsPage.ApproverFormPage formPage = null;
        for(String approverName:allApprovers){
            Common.sleep(2000);
            approvalsPage.clickBtnByName(btnName);
            switch (btnName){
                case "Add approver":
                    formPage = approvalsPage.waitForApproverFormPageToLoad();
                    break;
                case "Add Coupa Requisitioner":
                    formPage = approvalsPage.waitForApproverFormPageToLoadForBrandApprover();
                    break;
                case "Add Watcher":
                    Common.sleep(500);
                    formPage = approvalsPage.waitForApproverFormPageToLoadForWatchers();
                    break;
                case "":
                    formPage = approvalsPage.waitForApproverFormPageToLoad();
                    break;
                case "Add Brand Management Approver":
                    formPage = approvalsPage.waitForApproverFormPageToLoadForBrandApprover();
                    break;
                default:
                    throw new IllegalArgumentException("Unknown buttonName: "+btnName);
            }
            formPage.selectApproverNameOnFormPage(approverName,btnName);
            approvalsPage.clickBtnByName("Save",formPage.getFormPageParentLocator());
            approvalsPage.waitUntilApprovalsPageVisible();
        }
    }

    // $action = Delete
    @Given("{I |}'$action' approver '$approverName' from '$approverSectionName' approver section on approvals page")
    @When("{I |}'$action' approver '$approverName' from '$approverSectionName' approver section on approvals page")
    public void editApprover(String action, String approverName, String approverSectionName) {
        AdCostsApprovalsPage approvalsPage = openAdCostsApprovalsPage();
        String sectionName = approvalsPage.getApproverSectionLocator(approverSectionName);
        int approversCount = approvalsPage.getApproversCount(sectionName);
        AdCostsApprovalsPage.ApproverSection approverSection = openAdCostsApprovalsPage().getApproverSection();

        for (int i = 1; i <= approversCount; i++) {
            approverSection.loadApprovalName(i, sectionName);
            if (approverSection.getApproverName().contains(getUserFullName(approverName))) {
                approverSection.selectOptionFromApproverMenu(action, i, sectionName);
                break;
            }
        }
    }

    @Given("{I |}{added|editted} below approvers for cost title '$costTitle':$data")
    @When("{I |}{add|edit} below approvers for cost title '$costTitle':$data")
    public void addApproversViaCore(String costTitle, ExamplesTable fieldsTable) {
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        String costId = costs.getId();
        String costStageId = getCostStageId(costId);
        String revisionId = getCostRevisionId(costId, costStageId);
        Map<String, String> row = parametrizeTabularRow(fieldsTable);

        Approvals[] listOfApprovers = getApproversListForCost(costId, costStageId, revisionId);
        List<Approvals> addApprovals = new ArrayList<>();
        Approvals approvals_IPM = new Approvals();
        String[] allApprovers;
        List<ApprovalMembers> addApprovalMembers;
        List<Requisitioners> addRequisitioners;

        if (AdCostsData.containsField(AdCostsSchemaField.TECHNICALAPPROVER, row, false)) {
            allApprovers = AdCostsData.getField(AdCostsSchemaField.TECHNICALAPPROVER, row).split(";");
            approvals_IPM = buildRequestPayloadForAllApprovers(listOfApprovers, allApprovers, "IPM");
        } else {
            addApprovalMembers =  new ArrayList<>();
            addApprovalMembers = checkForExistingApprovalMembers(listOfApprovers, "IPM",addApprovalMembers);
            approvals_IPM.setApprovalMembers(addApprovalMembers);
        }

        Approvals approvals_BRANDMANAGEMENTAPPROVER = new Approvals();

        if (AdCostsData.containsField(AdCostsSchemaField.BRANDMANAGEMENTAPPROVER, row, false)) {
            allApprovers = AdCostsData.getField(AdCostsSchemaField.BRANDMANAGEMENTAPPROVER, row).split(";");
            approvals_BRANDMANAGEMENTAPPROVER = buildRequestPayloadForAllApprovers(listOfApprovers, allApprovers, "Brand");
        } else {
            addApprovalMembers =  new ArrayList<>();
            addApprovalMembers = checkForExistingApprovalMembers(listOfApprovers, "Brand",addApprovalMembers);
            approvals_BRANDMANAGEMENTAPPROVER.setApprovalMembers(addApprovalMembers);
        }

        Approvals approvals_coupaRequisitioner = new Approvals();

        if (AdCostsData.containsField(AdCostsSchemaField.COUPAREQISITIONER, row, false)) {
            allApprovers = AdCostsData.getField(AdCostsSchemaField.COUPAREQISITIONER, row).split(";");
            approvals_coupaRequisitioner = buildRequestPayloadForAllRequisitioners(listOfApprovers, allApprovers, "Brand");
        } else {
            addRequisitioners = new ArrayList<>();
            addRequisitioners = checkForExistingRequisitioners(listOfApprovers, "Brand",addRequisitioners);
            approvals_coupaRequisitioner.setRequisitioners(addRequisitioners);
        }

        if (AdCostsData.containsField(AdCostsSchemaField.TECHNICALAPPROVER, row, false)) {
            addApprovals = buildApproversDetails(listOfApprovers, addApprovals, "IPM", approvals_IPM);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.COUPAREQISITIONER, row, false)) {
            addApprovals = buildApproversDetails(listOfApprovers, addApprovals, "Brand", approvals_coupaRequisitioner);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.BRANDMANAGEMENTAPPROVER, row, false)) {
            addApprovals = buildApproversDetails(listOfApprovers, addApprovals, "Brand", approvals_BRANDMANAGEMENTAPPROVER);
        }
        getAdcostApi().addApprovers(costId, costStageId, revisionId, addApprovals);
    }

    // Submit|Cancel
    @Given("{I |}'$action' the cost with title '$costTitle'")
    @When("{I |}'$action' the cost with title '$costTitle'")
    public void submitCostForApproval(String action, String costTitle) {
        actionsOnCost(action,"", costTitle);
        Common.sleep(2000); // slown-down for cost sync-up
    }

    // Submit|Cancel|Approve|Request Changes
    @Given("{I |}'$action' the cost with comments '$comments' and title '$costTitle'")
    @When("{I |}'$action' the cost with comments '$comments' and title '$costTitle'")
    public void actionsOnCost(String action, String comments, String costTitle) {
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        String costId = costs.getId();
        getAdcostApi().submitCostForApproval(costId, getCostAprrovalType(action),comments);
    }

    // btnName: Submit|Cancel
    // action: Send for approval | Cancel
    @Given("{I |}clicked '$btnName' button and '$action' on approval Page")
    @When("{I |}click '$btnName' button and '$action' on approval Page")
    public void submitCostForApprovalviaUI(String btnName, String action) {
        AdCostsApprovalsPage approvalsPage = getSut().getPageCreator().getAdCostsApprovalsPage();
        approvalsPage.clickBtnByName(btnName);
        approvalsPage.clickBtnByNameOnFormPage(action);
        if(action.equalsIgnoreCase("Send for approval")) {
            approvalsPage.waitUntilApproverFormPageDisappear();
            approvalsPage.waitUntilCostItemsToLoad();
        }
    }

    private Approvals[] getApproversListForCost(String costId, String costStageId, String revisionId) {
        return getAdcostApi().getApproversListForCost(costId, costStageId, revisionId);
    }

    private ApprovalMembers[] getApprovalMembers(String approvalId) {
        return getAdcostApi().getApproverDetails(approvalId);
    }

    private String getCostAprrovalType(String action) {
        switch (action) {
            case "Submit":
                return action;
            case "Cancel":
                return action;
            case "Approve":
                return action;
            case "Request Changes":
                return "Reject";
            case "Recall":
                return action;
            case "Reopen":
                return action;
            case "NextStage":
                return action;
            case "CreateRevision":
                return action;
            case "Delete":
                return action;
            case "RequestReopen":
                return action;
            case "ApproveReopen":
                return action;
            case "RejectReopen":
                return action;
            default:
                throw new IllegalArgumentException("Found unknown Approval type '"+action+"'. Expected one of {Submit or Cancel or Approve}");
        }
    }

    private ApprovalMembers getApprovalMemberDetails(String approverName, Approvals[] listOfApprovers, String type) {
        String approverEmailId = wrapUserEmailWithTestSession(approverName);
        String id;
        for (Approvals approver : listOfApprovers) {
            if (approver.getType().equals(type)) {
                id = approver.getId();
                ApprovalMembers[] appMembers = getApprovalMembers(id);
                for (ApprovalMembers member : appMembers) {
                    if (member.getEmail().equals(approverEmailId)) {
                        return member;
                    }
                }
            }
        }
        return null;
    }

    private ApprovalMembers getRequisitionersDetails(String approverName, Approvals[] listOfApprovers) {
        String brandApproverEmailId = wrapUserEmailWithTestSession(approverName);
        String id;
        for (Approvals approver : listOfApprovers) {
            if (approver.getType().equals("Brand")) {
                id = approver.getId();
                ApprovalMembers[] appMembers = getApprovalMembers(id);
                for (ApprovalMembers member : appMembers) {
                    if (member.getEmail().equals(brandApproverEmailId)) {
                        return member;
                    }
                }
            }
        }
        return null;
    }

    private Approvals getApprovalsDetails(String approverName, Approvals[] listOfApprovers) {
        for (Approvals approver : listOfApprovers) {
            ApprovalMembers[] appMembers = getApprovalMembers(approver.getId());
            for (ApprovalMembers member : appMembers) {
                if (member.getFullName().equals(approverName)) {
                    return approver;
                }
            }
        }
        return null;
    }

    private Approvals buildRequestPayloadForAllApprovers(Approvals[] listOfApprovers, String[] allApprovers,String type) {
        Approvals approvals = new Approvals();
        ApprovalMembers approvalMembers;
        List<ApprovalMembers> addApprovalMembers = new ArrayList<>();

        if(isApprovalMembersAlreadyExists(listOfApprovers,type)){
            addApprovalMembers = checkForExistingApprovalMembers(listOfApprovers,type,addApprovalMembers);
        }

        for (String approverName : allApprovers) {
            approvalMembers = new ApprovalMembers();
            ApprovalMembers member = getApprovalMemberDetails(approverName, listOfApprovers, type);
            approvalMembers.setId(member.getId());
            approvalMembers.setFirstName(member.getFirstName());
            approvalMembers.setLastName(member.getLastName());
            approvalMembers.setFullName(member.getFullName());
            approvalMembers.setEmail(member.getEmail());
            approvalMembers.setBusinessRole(member.getBusinessRole());
            addApprovalMembers.add(approvalMembers);
            approvals.setApprovalMembers(addApprovalMembers);
        }
        return approvals;
    }

    private List<Approvals> buildApproversDetails(Approvals[] listOfApprovers, List<Approvals> addApprovals, String type, Approvals approvals) {
        Approvals approver = getApprovalsDetailsByType(type, listOfApprovers);
        approvals.setId(approver.getId());
        approvals.setStatus(approver.getStatus());
        approvals.setType(approver.getType());
        approvals.setCreatedById(approver.getCreatedById());
        approvals.setCreated(approver.getCreated());
        approvals.setModified(approver.getModified());
        approvals.setValidBusinessRoles(approver.getValidBusinessRoles());
        addApprovals.add(approvals);
        return addApprovals;
    }

    private Approvals buildRequestPayloadForAllRequisitioners(Approvals[] listOfApprovers, String[] allApprovers,String type) {
        Approvals approvals = new Approvals();
        Requisitioners requisitioners ;
        List<Requisitioners> addRequisitioners = new ArrayList<>();

        if(isRequisitionersAlreadyExists(listOfApprovers,type)){
            addRequisitioners = checkForExistingRequisitioners(listOfApprovers,type,addRequisitioners);
        }

        for (String approverName : allApprovers) {
            requisitioners = new Requisitioners();
            ApprovalMembers member = getRequisitionersDetails(approverName, listOfApprovers);
            requisitioners.setId(member.getId());
            requisitioners.setFullName(member.getFullName());
            requisitioners.setEmail(member.getEmail());
            requisitioners.setBusinessRole(member.getBusinessRole());
            addRequisitioners.add(requisitioners);
            approvals.setRequisitioners(addRequisitioners);
        }
        return approvals;
    }

    private Approvals getApprovalsDetailsByType(String type, Approvals[] listOfApprovers) {
        for (Approvals approver : listOfApprovers) {
            if (approver.getType().equals(type)) {
                return approver;
            }
        }
        return null;
    }

    private boolean isApprovalMembersAlreadyExists(Approvals[] listOfApprovers, String type) {
        for (Approvals approver : listOfApprovers) {
            if (approver.getType().equals(type)) {
                List<ApprovalMembers> existingMembers = approver.getApprovalMembers();
                if (existingMembers.isEmpty())
                    return false;
            }
        }
        return true;
    }

    private boolean isRequisitionersAlreadyExists(Approvals[] listOfApprovers, String type) {
        for (Approvals approver : listOfApprovers) {
            if (approver.getType().equals(type)) {
                List<Requisitioners> existingRequisitioners = approver.getRequisitioners();
                if (existingRequisitioners.isEmpty())
                    return false;
            }
        }
        return true;
    }

    private List<ApprovalMembers> checkForExistingApprovalMembers(Approvals[] listOfApprovers, String type,List<ApprovalMembers> addApprovalMembers) {
        for (Approvals approver : listOfApprovers) {
            if (approver.getType().equals(type)) {
                List<ApprovalMembers> existingMembers = approver.getApprovalMembers();
                if(existingMembers.isEmpty()) return new ArrayList<>(); else
                for (ApprovalMembers member : existingMembers) {
                    ApprovalMembers approvalMembers = new ApprovalMembers();
                    approvalMembers.setId(member.getId());
                    approvalMembers.setFirstName(member.getFirstName());
                    approvalMembers.setLastName(member.getLastName());
                    approvalMembers.setFullName(member.getFullName());
                    approvalMembers.setEmail(member.getEmail());
                    approvalMembers.setBusinessRole(member.getBusinessRole());
                    addApprovalMembers.add(approvalMembers);
                }
            }
        }
        return addApprovalMembers;
    }

    private List<Requisitioners> checkForExistingRequisitioners(Approvals[] listOfApprovers, String type,List<Requisitioners> addRequisitioners) {
        for (Approvals approver : listOfApprovers) {
            if (approver.getType().equals(type)) {
                List<Requisitioners> existingRequisitioners = approver.getRequisitioners();
                if(existingRequisitioners.isEmpty()) return new ArrayList<>(); else
                    for (Requisitioners requisitioner : existingRequisitioners) {
                        Requisitioners requisitioners = new Requisitioners();
                        requisitioners.setId(requisitioner.getId());
                        requisitioners.setFullName(requisitioner.getFullName());
                        requisitioners.setEmail(requisitioner.getEmail());
                        requisitioners.setBusinessRole(requisitioner.getBusinessRole());
                        addRequisitioners.add(requisitioners);
                    }
            }
        }
        return addRequisitioners;
    }

    @Then("{I |}'$condition' see below approvers on cost approval page:$data")
    public void isApproversVisible(String condition, ExamplesTable data){
        AdCostsApprovalsPage approvalsPage = getSut().getPageCreator().getAdCostsApprovalsPage();
        Map<String, String> row = parametrizeTabularRow(data);

        List<String> expectedApprovers = new ArrayList<>();
        if (AdCostsData.containsField(AdCostsSchemaField.TECHNICALAPPROVER, row, false)) {
            for(String expected: AdCostsData.getField(AdCostsSchemaField.TECHNICALAPPROVER, row).split(";"))
            checkApproverInApproverSection(condition, approvalsPage, "Technical Approver", (getUserFullName(expected).concat(" (Integrated Production Manager)")));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.COSTCONSULTANT, row, false)) {
            expectedApprovers.clear();
            for(String expected: AdCostsData.getField(AdCostsSchemaField.COSTCONSULTANT, row).split(";"))
            checkApproverInApproverSection(condition, approvalsPage, "Technical Approver", (getUserFullName(expected).concat(" (Cost Consultant)")));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.COUPAREQISITIONER, row, false)) {
            expectedApprovers.clear();
            for(String expected: AdCostsData.getField(AdCostsSchemaField.COUPAREQISITIONER, row).split(";"))
            checkApproverInApproverSection(condition, approvalsPage, "Coupa Requisitioner", (getUserFullName(expected).concat(" (Brand Management Approver)")));
        }
    }

    @Then("{I |}'$condition' see '$approverType' approver section on cost approval page")
    public void isApproverVisible(String condition, String approverType){
        AdCostsApprovalsPage approvalsPage = getSut().getPageCreator().getAdCostsApprovalsPage();
        boolean actualResult = approvalsPage.isApproverSectionVisible(approverType);
        boolean expectedResult = condition.equals("should");
        assertThat(actualResult, equalTo(expectedResult));
    }

    // $approverSectionName = { technical | brand }
    @Then("{I |}'$should' see below approvers on approval form page for cost title '$costTitle':$data")
    public void checkApprovers(String condition, String costTitle,ExamplesTable data) {

       AdCostsApprovalsPage approvalsPage = openApprovalsPage(costTitle);
       approvalsPage.waitUntilApprovalsPageVisible();
        Map<String, String> row = parametrizeTabularRow(data);
        String userType;

        List<String> expectedApprovers = new ArrayList<>();
        if (AdCostsData.containsField(AdCostsSchemaField.TECHNICALAPPROVER, row, false)) {
            Common.sleep(500); // slow-down the process as element selection is too fast on the page. To ensure flakyness is handled
            userType = "Integrated Production Manager";
            for(String expected: AdCostsData.getField(AdCostsSchemaField.TECHNICALAPPROVER, row).split(";"))
                expectedApprovers.add(getUserFullName(expected).concat(" (".concat(userType).concat(")")));
            approvalsPage.clickBtnByName("Add approver");
            AdCostsApprovalsPage.ApproverFormPage formPage = approvalsPage.waitForFormPageToload(userType);
            List<String> userList = formPage.getAllApproversOnFormPage(userType);
            approvalsPage.closeApproverFormPage(userType);
            for(String expectedApprover:expectedApprovers)
                assertThat(userList, condition.equalsIgnoreCase("should") ? hasItem(expectedApprover) : not(hasItem(expectedApprover)));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.COSTCONSULTANT, row, false)) {
            Common.sleep(500); // slow-down the process as element selection is too fast on the page. To ensure flakyness is handled
            expectedApprovers.clear();
            userType = "Cost Consultant";
            for(String expected: AdCostsData.getField(AdCostsSchemaField.COSTCONSULTANT, row).split(";"))
                expectedApprovers.add(getUserFullName(expected).concat(" (".concat(userType).concat(")")));
            approvalsPage.clickBtnByName("Add approver");
            AdCostsApprovalsPage.ApproverFormPage formPage = approvalsPage.waitForFormPageToload(userType);
            List<String> userList = formPage.getAllApproversOnFormPage(userType);
            approvalsPage.closeApproverFormPage(userType);
            for(String expectedApprover:expectedApprovers)
                assertThat(userList, condition.equalsIgnoreCase("should") ? hasItem(expectedApprover) : not(hasItem(expectedApprover)));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.COUPAREQISITIONER, row, false)) {
            Common.sleep(500); // slow-down the process as element selection is too fast on the page. To ensure flakyness is handled
            expectedApprovers.clear();
            userType="Brand Management Approver";
            for(String expected: AdCostsData.getField(AdCostsSchemaField.COUPAREQISITIONER, row).split(";"))
                expectedApprovers.add(getUserFullName(expected).concat(" (".concat(userType).concat(")")));
            approvalsPage.clickBtnByName("Add Coupa Requisitioner");
            AdCostsApprovalsPage.ApproverFormPage formPage = approvalsPage.waitForFormPageToload("Coupa Requisitioner");
            List<String> userList = formPage.getAllApproversOnFormPage("Coupa Requisitioner");
            approvalsPage.closeApproverFormPage("Coupa Requisitioner");
            for(String expectedApprover:expectedApprovers)
                assertThat(userList, condition.equalsIgnoreCase("should") ? hasItem(expectedApprover) : not(hasItem(expectedApprover)));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.BRANDMANAGEMENTAPPROVER, row, false)) {
            Common.sleep(500); // slow-down the process as element selection is too fast on the page. To ensure flakyness is handled
            expectedApprovers.clear();
            userType="Brand Management Approver";
            for(String expected: AdCostsData.getField(AdCostsSchemaField.BRANDMANAGEMENTAPPROVER, row).split(";"))
                expectedApprovers.add(getUserFullName(expected).concat(" (".concat(userType).concat(")")));
            approvalsPage.clickBtnByName("Add Brand Management Approver");
            AdCostsApprovalsPage.ApproverFormPage formPage = approvalsPage.waitForFormPageToload(userType);
            List<String> userList = formPage.getAllApproversOnFormPage(userType);
            Common.sleep(500);
            approvalsPage.closeApproverFormPage(userType);
            for(String expectedApprover:expectedApprovers)
                assertThat(userList, condition.equalsIgnoreCase("should") ? hasItem(expectedApprover) : not(hasItem(expectedApprover)));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.ADDWATCHER, row, false)) {
            expectedApprovers.clear();
            for(String expected: AdCostsData.getField(AdCostsSchemaField.ADDWATCHER, row).split(";"))
                expectedApprovers.add(getUserFullName(expected));
            checkUsersInAddWatcher(condition, approvalsPage,expectedApprovers);
        }
    }

    @Then("{I |}'$should' see '$message' pop up")
    public void checkCostCannotBeSubmittedPopUp(String condition,String message){
        AdCostsApprovalsPage approvalsPage = getSut().getPageNavigator().getAdCostsApprovalsPage();
        boolean actual = approvalsPage.isCostCannotBeSubmittedPopUpVisible(message);
        boolean expected = condition.equalsIgnoreCase("should");
        assertThat("Check if Vendor details",actual,is(expected));
    }

    private void checkSpecificApprover(String condition,AdCostsApprovalsPage approvalsPage,String btnName, String userType, List<String> expectedApproversList) {
        approvalsPage.clickBtnByName(btnName);
        AdCostsApprovalsPage.ApproverFormPage formPage = approvalsPage.waitForApproverFormPageToLoad();
        List<String> userList = formPage.getAllApproversOnFormPage(userType);
        approvalsPage.closeFormPage(userType);
        for(String expectedApprovers:expectedApproversList) {
            assertThat(userList, condition.equalsIgnoreCase("should") ? hasItem(expectedApprovers) : not(hasItem(expectedApprovers)));
        }
    }

    private void checkUsersInAddWatcher(String condition,AdCostsApprovalsPage approvalsPage,List<String> expectedApproversList) {
        Boolean expected = condition.equalsIgnoreCase("should");
        approvalsPage.clickBtnByName("Add Watcher");
        AdCostsApprovalsPage.ApproverFormPage formPage = approvalsPage.waitForApproverFormPageToLoadForWatchers();
        for(String expectedApprovers:expectedApproversList) {
            assertThat("Check user in Add Watcher: "+expectedApprovers, formPage.checkUserInWatcherList(expectedApprovers),equalTo(expected));
        }
    }

    private String getUserFullName(String userName){
        String name = "shouldNot";
        if(!(userName.equals("") || userName.isEmpty() || userName.equals(null)))
            return getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName), 0).getFullName();
        return name;
    }

    private void checkApproverInApproverSection(String condition,AdCostsApprovalsPage approvalsPage, String sectionName, String expectedApprover) {
        String actual = approvalsPage.getApproverName(sectionName);
        assertThat("Check Approver Name: ",actual,
                condition.equalsIgnoreCase("should")?is(expectedApprover):not(is(expectedApprover)));
    }
}