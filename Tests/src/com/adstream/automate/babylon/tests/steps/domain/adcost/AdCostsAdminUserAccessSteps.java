package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.BudgetFormTemplates;
import com.adstream.automate.babylon.JsonObjects.adcost.BudgetFormsWrapper;
import com.adstream.automate.babylon.JsonObjects.adcost.CostUsers;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsAdminUserAccessPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AccessTypeInCostModule;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.babylon.sut.pages.adcost.elements.UserRoleInCostModule;
import com.adstream.automate.babylon.JsonObjects.adcost.enums.AdcostRoles;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

/**
 * Created by Raja.Gone on 24/04/2017.
 */
public class AdCostsAdminUserAccessSteps extends AdCostsHelperSteps {

    @Given("{I am} on admin section of adcost")
    @When("{I am} on admin section of adcost")
    public AdCostsAdminUserAccessPage openAdCostAdminPage() {
        return getSut().getPageNavigator().getAdCostAdminUserAccessPage();
    }

    @Given("{I |} try to access admin section using direct URL")
    @When("{I |} try to access admin section using direct URL")
    public void openAdCostAdminPageUsingDirectURL() {
        openAdCostAdminPage();
    }

    // Mandatory fields: | Email | User Role | Access Type | Condition |
    // Optional Field: | Approval limit | NotificationBudgetRegionId |
    @Given("{I |}assigned user with following access in cost module: $data")
    @When("{I |}assign user with following access in cost module: $data")
    public void assignUserRoleViaCore(ExamplesTable data) {
        List<String> missingMandatoryFields = new ArrayList<>();
        String agencyId =null;
        String userId= null;
        String businessRoleId= null;
        String approvalLimit=null;
        String accessType = null;
        String typeId = null;
        String labelName = null;
        User currentUser = null;
        String notificationBudgetRegionId = null;
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Email")) {
                String userName = row.get("Email");
                currentUser = getData().getUserByType(userName);
                if (currentUser == null) {
                    userName = wrapUserEmailWithTestSession(userName);
                    currentUser = getCoreApiAdmin().getUserByEmail(userName);
                }
                agencyId = currentUser.getAgency().getId();
                userId = getUserIdInCostModule(agencyId, currentUser.getEmail());
            } else missingMandatoryFields.add("Email");
            if (AdCostsData.containsField(AdCostsSchemaField.USERROLE, row, false)) {
                String userRole = UserRoleInCostModule.findByType(AdCostsData.getField(AdCostsSchemaField.USERROLE, row)).toString();
                if(userRole.equalsIgnoreCase("Finance Manager")){
                    if (row.containsKey("NotificationBudgetRegionId") && !row.get("NotificationBudgetRegionId").isEmpty() && row.get("NotificationBudgetRegionId") != null)
                        notificationBudgetRegionId = getBudgetRegionId(row.get("NotificationBudgetRegionId")).getId();
                    else
                        throw new Error("To Assign user with 'Finance Manager' role please specific to which 'Budget Region' user should be assigned. " +
                                "\n Check if 'NotificationBudgetRegionId' field passed at steplevel and value isn't empty/null");
                }
                businessRoleId = getBusinessRoleId(userRole);
            } else missingMandatoryFields.add(AdCostsSchemaField.USERROLE.toString());
            if (row.containsKey("Approval limit"))
                approvalLimit = row.get("Approval limit");
            if (AdCostsData.containsField(AdCostsSchemaField.ACCESSTYPE, row, false)) {
                accessType = AccessTypeInCostModule.findByType(AdCostsData.getField(AdCostsSchemaField.ACCESSTYPE, row)).toString();
            } else missingMandatoryFields.add(AdCostsSchemaField.ACCESSTYPE.toString());
            if (row.containsKey("Condition")) {
                typeId = getAgencyIdInCostModule(agencyId);
            } else missingMandatoryFields.add("Condition");

            if(accessType.equals("Region")) {
                if(AdCostsData.containsField(AdCostsSchemaField.LABELNAME, row, false))
                labelName = AdCostsData.getField(AdCostsSchemaField.LABELNAME, row);
            }

            if (missingMandatoryFields.size() > 0) {
                throw new IllegalArgumentException("Mandatory fields missing: " + Arrays.toString(missingMandatoryFields.toArray()));
            }

            CostUsers user= getCostUserDetails(agencyId,currentUser.getEmail());
            getAdcostCoreAdminApi().grantUserAccessInCostModule(userId, businessRoleId, approvalLimit, accessType, typeId, labelName,notificationBudgetRegionId);

        }
    }

    @Then("{I |}'$condition' see admin page")
    public void checkAdminSection(String condition){
        AdCostsAdminUserAccessPage adCostsAdminUserAccessPage = getSut().getPageCreator().getAdCostsAdminUserAccessPage();
        assertThat("Check Admin section should: ", adCostsAdminUserAccessPage.checkAdminPagePresent(), is(condition.equalsIgnoreCase("should")) );
    }

    @Then("{I |}'$condition' see users '$email' in admin section to assign roles")
    public void checkAdminSection(String condition, String userName){
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        for (String user : userName.split(",")) {
            String userEmail = wrapUserEmailWithTestSession(user);
            adminUserAccessPage.searchUserOnadminPage(userEmail);
            Common.sleep(500);
            assertThat("Check user in admin section: ", adminUserAccessPage.isUserPresent(userEmail), is(condition.equalsIgnoreCase("should")));
        }
    }

    @Then("{I |}'$condition' see '$options' tabs under admin section")
    public void checkOptionsInAdminSection(String condition, String option) {
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        for (String opt : option.split(",")) {
            assertThat("Check options under admin tab: ", adminUserAccessPage.isOptionPresentUnderAdmin(opt), is(condition.equalsIgnoreCase("should")));
        }
    }

    @Then( "{I |}'$should' be able to see assigned '$role' role to the user '$userName' under admin section")
    public void validateAssignedRole(String condition, String role, String userName){
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        getRoleAssignPageforUser(adminUserAccessPage,userName);
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = adminUserAccessPage.getUserRoleAccessAssignSectionNew();
        assertThat("User is assigned with the given role: ", userRoleAssignSection.checkTheAssignedRole(role), is(condition.equalsIgnoreCase("should")) );
    }

    @Then( "{I |}'$should' be able to assign following '$role' role to the user '$userName' under admin section")
    public void validateRoleCanBeAssigned(String condition, String role, String userName){
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        getRoleAssignPageforUser(adminUserAccessPage,userName);
        AdcostRoles.findByName(role);
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = adminUserAccessPage.getUserRoleAccessAssignSectionNew();
        assertThat("User is assigned with the given role: ", userRoleAssignSection.checkRoleExists(role), is(condition.equalsIgnoreCase("should")) );
    }

    @Then("{I }see below roles in user role drop down on user access page for '$userName' user:$data")
    public void checkUserAccessRoles(String userName,ExamplesTable filesTable){
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
            getRoleAssignPageforUser(adminUserAccessPage,userName);
            adminUserAccessPage.waitUntilUserAssignRoleSectonLoaded();
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            List<String> actualRoles = adminUserAccessPage.getUserRoleAccessAssignSectionNew().getUserRoles();
            String condition = row.get("Condition");
            if (row.containsKey("User Roles")) {
                String roles = row.get("User Roles");
                for (String expectedRole : roles.split(";")) {
                    assertThat("Check User-Roles: ",actualRoles ,
                            condition.equalsIgnoreCase("should") ? hasItem(expectedRole.trim()) : not(hasItem(expectedRole.trim())));
                }
            }
        }
    }

    @Given( "{I  |}assigned '$role' role to the user '$userName' under admin section")
    @When( "{I  |}assign '$role' role to the user '$userName' under admin section")
    public void AssignRoletoUsers(String role, String userName){
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        String region= null;
        boolean smoUser=false;
        getRoleAssignPageforUser(adminUserAccessPage,userName);
        adminUserAccessPage.clickBtnByName("Add Access Rule");
        adminUserAccessPage.waitUntilUserAssignRoleSectonLoaded();
        AdcostRoles.findByName(role);
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = adminUserAccessPage.getUserRoleAccessAssignSectionNew();
        userRoleAssignSection.assignRoleForUser(role, region, smoUser);
        userRoleAssignSection.clickSaveButton();
    }

    @Given( "{I  |}assigned '$role' role to the user '$userName' for '$region' region under admin section")
    @When( "{I  |}assign '$role' role to the user '$userName' for '$region' region under admin section")
    public void AssignRoletoUsers(String role, String userName, String region){
        boolean smoUser = false;
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        getRoleAssignPageforUser(adminUserAccessPage,userName);
        adminUserAccessPage.clickBtnByName("Add Access Rule");
        adminUserAccessPage.waitUntilUserAssignRoleSectonLoaded();
        AdcostRoles.findByName(role);
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = adminUserAccessPage.getUserRoleAccessAssignSectionNew();
        userRoleAssignSection.assignRoleForUser(role, region, smoUser);
        userRoleAssignSection.clickSaveButton();
    }

    @Given( "{I  |}assigned '$role' role to the user '$userName' under admin section with SMO region '$smoregion'")
    @When( "{I  |}assign '$role' role to the user '$userName' under admin section with SMO region '$smoregion'")
    public void AssignRoletoUsersWithSMO(String role, String userName, String smoregion){
        boolean smoUser = true;
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        getRoleAssignPageforUser(adminUserAccessPage,userName);
        adminUserAccessPage.clickBtnByName("Add Access Rule");
        adminUserAccessPage.waitUntilUserAssignRoleSectonLoaded();
        AdcostRoles.findByName(role);
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = adminUserAccessPage.getUserRoleAccessAssignSectionNew();
        userRoleAssignSection.assignRoleForUser(role, smoregion, smoUser);
        userRoleAssignSection.clickSaveButton();
    }

    @Given( "{I  |}clicked on '$option' under admin section")
    @When( "{I  |}click on '$option' under admin section")
    public void goToAdminOptions(String option){
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        adminUserAccessPage.clickOnAdminOptions(option);
        adminUserAccessPage.waitUntilBudgetFormPageLoaded();
    }

    @Then("{I }'$condition' see below budget regions in budget regions drop down on user access page for '$userName' user and '$role' user role:$data")
    public void checkBudgetRegionsForFMRole(String condition, String userName, String role, ExamplesTable filesTable){
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            boolean smoUser = false;
            AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
            getRoleAssignPageforUser(adminUserAccessPage,userName);
            adminUserAccessPage.clickBtnByName("Add Access Rule");
            adminUserAccessPage.waitUntilUserAssignRoleSectonLoaded();
            AdcostRoles.findByName(role);
            List<String> actualRegions = adminUserAccessPage.getUserRoleAccessAssignSectionNew().checkBudgetRegionsUnderConditionDropdown(role,"Budget Region");
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            if (row.containsKey("Budget Regions")) {
                String regions = row.get("Budget Regions");
                for (String expectedRole : regions.split(";")) {
                    assertThat("Check User-Roles: ",actualRegions ,
                            condition.equalsIgnoreCase("should") ? hasItem(expectedRole.trim()) : not(hasItem(expectedRole.trim())));
                }
            }
        }
    }

    @Given( "{I  |}tried to assign '$role' role to the user '$userName' under admin section without passing mandatory fields")
    @When( "{I  |}try to assign '$role' role to the user '$userName' under admin section without passing mandatory fields")
    public void tryAssigningRolesToUsers(String role, String userName){
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        String region= null;
        boolean smoUser=false;
        getRoleAssignPageforUser(adminUserAccessPage,userName);
        adminUserAccessPage.clickBtnByName("Add Access Rule");
        adminUserAccessPage.waitUntilUserAssignRoleSectonLoaded();
        AdcostRoles.findByName(role);
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = adminUserAccessPage.getUserRoleAccessAssignSectionNew();
        userRoleAssignSection.assignRoleForUser(role, region, smoUser);
    }

    @Then( "{I |}'$should' see save button is disabled")
    public void validateRoleNotAssigned(String condition){
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = getSut().getPageCreator().getAdCostsAdminUserAccessPage().getUserRoleAccessAssignSectionNew();
        assertThat("Save button should not enabled: ", userRoleAssignSection.checkSaveButtonEnabledOrNot(), is(condition.equalsIgnoreCase("should")) );
    }


    @Then( "{I |}'$should' be able to see assigned '$role' role  and '$region' budget region to the user '$userName' under admin section")
    public void validateAssignedRoleAndBudgetRegion(String condition, String role, String budgetRegion,  String userName){
        AdCostsAdminUserAccessPage adminUserAccessPage = openAdCostAdminPage();
        getRoleAssignPageforUser(adminUserAccessPage,userName);
        AdCostsAdminUserAccessPage.UserRoleAccessAssignSection userRoleAssignSection = adminUserAccessPage.getUserRoleAccessAssignSectionNew();
        assertThat("User is assigned with the given role: ", userRoleAssignSection.checkTheAssignedRole(role), is(condition.equalsIgnoreCase("should")) );
        assertThat("User is assigned with the given budget region: ", userRoleAssignSection.checkTheAssignedCondition(budgetRegion), is(condition.equalsIgnoreCase("should")) );
    }

    @When ("{I |}upload '$filePath' budget form template")
    public void uploadBudgetFormOnAdminSection(String filePath){
        AdCostsAdminUserAccessPage adminUserAccessPage = getSut().getPageCreator().getAdCostsAdminUserAccessPage();
        AdCostsAdminUserAccessPage.BudgetFormSection  budgetFormSection = adminUserAccessPage.getBudgetFormSection();
        budgetFormSection.uploadBudgetFormTemplateOnAdminSection(filePath);

    }

    @Given("{I |}upload following budget form template in admin section:$data")
    @When("{I |}upload following budget form template in admin section:$data")
    @Then("{I |}should able to upload following budget form template in admin section:$data")
    public void uploadBudgetFormOnAdminSectionViaAPI(ExamplesTable filesTable){
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            uploadDocs(row.get("FileName"), row.get("FormName"));
        }
    }

    @When("{I |} download '$templateName' template with '$fileName' budget form")
    @Then("{I |} should able to download '$templateName' template with '$fileName' budget form")
    public void downloadBudgetFormViaAPI(String templatename, String fileName){
        BudgetFormTemplates[] docsCount = getAdcostApi().getBudgetFormsTemplates();
        String budgetFormTemplateId = null;
        for(BudgetFormTemplates docs:docsCount) {
            if (docs.getKey().equalsIgnoreCase(templatename)) {
                budgetFormTemplateId = docs.getId();
                break;
            }
        }
        String downloadResponse = getAdcostApi().downloadBudgetForms(budgetFormTemplateId);
        assertThat("Check Content-type is correct",downloadResponse.contains("Content-Type: application/octet-stream"), equalTo(true));
        assertThat("Check file name in content-disposition",checkDownloadResponseHeaders(downloadResponse, "Content-Disposition").contains(fileName));
    }

    public String checkDownloadResponseHeaders(String response, String headerType) {
        String downloadedFileName = null;
        if (response.contains(headerType)) {
            String[] temp = response.split("filename=");
            downloadedFileName = temp[1];
        }
        return downloadedFileName;
    }

    @When("{I |}download '$fileName' file")
    public void downloadBudgetForm(String fileName) throws Exception {
        AdCostsAdminUserAccessPage adminUserAccessPage = getSut().getPageCreator().getAdCostsAdminUserAccessPage();
        AdCostsAdminUserAccessPage.BudgetFormSection  budgetFormSection = adminUserAccessPage.getBudgetFormSection();
        budgetFormSection.downloadBudgetForm(fileName,"Download");
    }

    @When("{I |}search for user '$userName' on adcost admin user access page")
    public void searchUser(String userName){
        String userEmail = wrapUserEmailWithTestSession(userName);
        openAdCostAdminPage().searchUserOnadminPage(userEmail);
    }

    @Then("{I |}'$should' see user with below details:$data")
    public void verifyUserDetails(String should,ExamplesTable data){
        AdCostsAdminUserAccessPage page = openAdCostAdminPage();
        page.loadUserDetails();
        boolean condition = should.equalsIgnoreCase("should");
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if(row.containsKey("Cost User")) {
                String expected = getUsersFullName(row.get("Cost User"));
                if(row.containsKey("Flag"))
                            expected = expected.concat(" "+row.get("Flag"));
                assertThat("Check 'Cost User': ",page.getCostUser(),condition?is(expected):not(is(expected)));
            } if(row.containsKey("Disabled"))
                assertThat("Check 'Disabled': ",page.getDiabled(),condition?is(row.get("Disabled")):not(is(row.get("Disabled"))));
            if(row.containsKey("Not Editable")) {
                boolean expected = row.get("Not Editable").equals("true")?true:false;
                assertThat("Check if user editable: ", page.isUserDisabledAndNotEditable(), condition ? is(expected) : not(is(expected)));
            }
        }

    }

    protected void uploadDocs(String fileName, String formName){
        String filePath = getFilePath(fileName);
        File file = new File(filePath);

        BudgetFormTemplates[] docsCount = getAdcostApi().getBudgetFormsTemplates();
        String budgetFormTemplateId = null;
        for(BudgetFormTemplates docs:docsCount) {
            if (docs.getKey().equalsIgnoreCase(formName)) {
                budgetFormTemplateId = docs.getId();
                break;
            }
        }
        BudgetFormsWrapper budgetFormsWrapper = new BudgetFormsWrapper(budgetFormTemplateId,file,formName);
        getAdcostApi().uploadBudgetFormsInAdCost(budgetFormsWrapper);
    }


    private void getRoleAssignPageforUser(AdCostsAdminUserAccessPage adminUserAccessPage,String userName){
        String userEmail = wrapUserEmailWithTestSession(userName);
        adminUserAccessPage.searchUserOnadminPage(userEmail);
        String userFullName = getUsersFullName(userName);
        adminUserAccessPage.clickUsernameOnAdminPage(userFullName);
    }
}