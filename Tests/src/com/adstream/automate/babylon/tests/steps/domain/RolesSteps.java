package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.admin.roles.GlobalAdminRolesPage;
import com.adstream.automate.babylon.sut.pages.admin.roles.RolesPage;
import com.adstream.automate.babylon.sut.pages.admin.roles.elements.CreateNewRolePopUpWindow;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.*;
import static com.adstream.automate.hamcrest.SortingCheck.sortedAlphabetically;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.hasItem;

/**
 * User: ruslan.semerenko
 * Date: 05.06.12 11:17
 */
public class RolesSteps extends BaseStep {
    private static Map<String, String> permissionsMap = new HashMap<>();

    // last updated on build version  5.0.2.960   11.10.2012
    static {
        // For: NGN-14650
        permissionsMap.put("Manage project templates", "Manage project templates");
        permissionsMap.put("Manage roles", "Manage roles");
        permissionsMap.put("Manage users", "Manage users");

        // global
        permissionsMap.put("acl.change", "acl.change");
        permissionsMap.put("adkit.complete", "adkit.complete");
        permissionsMap.put("adkit.create", "adkit.create");
        permissionsMap.put("adkit.delete", "adkit.delete");
        permissionsMap.put("adkit.read", "adkit.read");
        permissionsMap.put("adkit.write", "adkit.write");
        permissionsMap.put("adkit_template.read", "adkit_template.read");
        permissionsMap.put("adkit_template.create", "adkit_template.create");
        permissionsMap.put("agency.read", "agency.read");
        permissionsMap.put("agency.write", "agency.write");
        permissionsMap.put("agency_team.create", "agency_team.create");
        permissionsMap.put("agency_team.delete", "agency_team.delete");
        permissionsMap.put("agency_team.read", "agency_team.read");
        permissionsMap.put("agency_team.write", "agency_team.write");
        permissionsMap.put("group.agency_enums.create", "group.agency_enums.create");
        permissionsMap.put("group.agency_enums.delete", "group.agency_enums.delete");
        permissionsMap.put("group.agency_enums.read", "group.agency_enums.read");
        permissionsMap.put("group.agency_enums.write", "group.agency_enums.write");
        permissionsMap.put("enum.create", "enum.create");
        permissionsMap.put("enum.delete", "enum.delete");
        permissionsMap.put("enum.write", "enum.write");
        permissionsMap.put("enum.read", "enum.read");
        permissionsMap.put("asset.add_to_presentation", "asset.add_to_presentation");
        permissionsMap.put("asset.create", "asset.create");
        permissionsMap.put("asset.delete", "asset.delete");
        permissionsMap.put("asset.write", "asset.write");
        permissionsMap.put("asset.read", "asset.read");
        permissionsMap.put("asset.share", "asset.share");
        permissionsMap.put("asset.usage_rights.read", "asset.usage_rights.read");
        permissionsMap.put("asset.usage_rights.write", "asset.usage_rights.write");
        permissionsMap.put("asset_filter_category.create", "asset_filter_category.create");
        permissionsMap.put("asset_filter_category.delete", "asset_filter_category.delete");
        permissionsMap.put("asset_filter_category.write", "asset_filter_category.write");
        permissionsMap.put("asset_filter_category.read", "asset_filter_category.read");
        permissionsMap.put("asset_filter_collection.create", "asset_filter_collection.create");
        permissionsMap.put("asset_filter_collection.delete", "asset_filter_collection.delete");
        permissionsMap.put("asset_filter_collection.write", "asset_filter_collection.write");
        permissionsMap.put("asset_filter_collection.read", "asset_filter_collection.read");
        permissionsMap.put("trash.read", "trash.read");
        permissionsMap.put("traffic.tab.default.view.all", "traffic.tab.default.view.all");
        permissionsMap.put("traffic.order.view.all", "traffic.order.view.all");
        permissionsMap.put("trash.undelete", "trash.undelete");
        permissionsMap.put("role.create", "role.create");
        permissionsMap.put("role.delete", "role.delete");
        permissionsMap.put("role.read", "role.read");
        permissionsMap.put("role.write", "role.write");
        permissionsMap.put("user.create", "user.create");
        permissionsMap.put("user.delete", "user.delete");
        permissionsMap.put("user.invite", "user.invite");
        permissionsMap.put("user.read", "user.read");
        permissionsMap.put("user.write", "user.write");
        permissionsMap.put("user_group.create", "user_group.create");
        permissionsMap.put("user_group.delete", "user_group.delete");
        permissionsMap.put("user_group.read", "user_group.read");
        permissionsMap.put("user_group.write", "user_group.write");
        permissionsMap.put("users.create", "users.create");
        permissionsMap.put("users.delete", "users.delete");
        permissionsMap.put("users.read", "users.read");
        permissionsMap.put("users.write", "users.write");
        permissionsMap.put("inbox.read", "inbox.read");
        permissionsMap.put("tv_order.complete", "tv_order.complete");
        permissionsMap.put("tv_order.create", "tv_order.create");
        permissionsMap.put("tv_order.delete", "tv_order.delete");
        permissionsMap.put("tv_order.read", "tv_order.read");
        permissionsMap.put("tv_order.write", "tv_order.write");
        permissionsMap.put("tv_order_item.usage_rights.read", "tv_order_item.usage_rights.read");
        permissionsMap.put("tv_order_item.usage_rights.write", "tv_order_item.usage_rights.write");
        permissionsMap.put("tv_order_item_music.usage_rights.read", "tv_order_item_music.usage_rights.read");
        permissionsMap.put("tv_order_item_music.usage_rights.write", "tv_order_item_music.usage_rights.write");
        permissionsMap.put("tv_order_music.complete", "tv_order_music.complete");
        permissionsMap.put("tv_order_music.create", "tv_order_music.create");
        permissionsMap.put("tv_order_music.delete", "tv_order_music.delete");
        permissionsMap.put("tv_order_music.read", "tv_order_music.read");
        permissionsMap.put("tv_order_music.write", "tv_order_music.write");
        permissionsMap.put("tv_order.add_media_mandatory", "tv_order.add_media_mandatory");
        permissionsMap.put("tv_order_music.add_media_mandatory", "tv_order_music.add_media_mandatory");
        permissionsMap.put("tv_order.view_billing", "tv_order.view_billing");
        permissionsMap.put("tv_order_music.view_billing", "tv_order_music.view_billing");
        permissionsMap.put("user.impersonate", "user.impersonate");
        permissionsMap.put("asset.master.expired.usage_rights.download", "asset.master.expired.usage_rights.download");
        permissionsMap.put("asset.proxy.expired.usage_rights.download", "asset.proxy.expired.usage_rights.download");
        permissionsMap.put("element.master.expired.usage_rights.download", "element.master.expired.usage_rights.download");
        permissionsMap.put("element.proxy.expired.usage_rights.download", "element.proxy.expired.usage_rights.download");
        permissionsMap.put("element.proxy.expired.usage_rights.download", "element.proxy.expired.usage_rights.download");
        permissionsMap.put("adkit.complete", "adkit.complete");
        permissionsMap.put("adkit.create", "adkit.create");
        permissionsMap.put("adkit.delete", "adkit.delete");
        permissionsMap.put("adkit.read", "adkit.read");
        permissionsMap.put("adkit.write", "adkit.write");
        permissionsMap.put("dictionary.add_on_the_fly", "dictionary.add_on_the_fly");
        permissionsMap.put("tv_order.completed.edit", "tv_order.completed.edit");
        permissionsMap.put("delivery.edit", "delivery.edit");
        // library
        permissionsMap.put("reel.create", "reel.create");
        permissionsMap.put("presentation.create", "presentation.create");
        permissionsMap.put("presentation.delete", "presentation.delete");
        permissionsMap.put("presentation.write", "presentation.write");
        permissionsMap.put("presentation.read", "presentation.read");
        permissionsMap.put("asset.public_share.create", "asset.public_share.create");
        permissionsMap.put("presentation.public_share.create", "presentation.public_share.create");

        // project
        permissionsMap.put("approval.admin", "approval.admin");
        permissionsMap.put("approval.create", "approval.create");
        permissionsMap.put("attached_file.create", "attached_file.create");
        permissionsMap.put("attached_file.read", "attached_file.read");
        permissionsMap.put("attached_file.delete", "attached_file.delete");
        permissionsMap.put("activity.read", "activity.read");
        permissionsMap.put("comment.create", "comment.create");
        permissionsMap.put("comment.delete", "comment.delete");
        permissionsMap.put("comment.read", "comment.read") ;
        permissionsMap.put("folder.create", "folder.create");
        permissionsMap.put("folder.delete", "folder.delete");
        permissionsMap.put("folder.read", "folder.read");
        permissionsMap.put("folder.share", "folder.share");
        permissionsMap.put("folder.write", "folder.write");
        permissionsMap.put("element.create", "element.create");
        permissionsMap.put("element.delete", "element.delete");
        permissionsMap.put("element.read", "element.read");
        permissionsMap.put("element.send_to_library", "element.send_to_library");
        permissionsMap.put("element.write", "element.write");
        permissionsMap.put("element.usage_rights.read", "element.usage_rights.read");
        permissionsMap.put("element.usage_rights.write", "element.usage_rights.write");
        permissionsMap.put("element.version_history.read", "element.version_history.read");
        permissionsMap.put("element.share", "element.share");
        permissionsMap.put("element.public_share.create", "element.public_share.create");
        permissionsMap.put("file.download", "file.download");
        permissionsMap.put("proxy.download", "proxy.download");
        permissionsMap.put("project.activity", "project.activity");
        permissionsMap.put("project.create", "project.create");
        permissionsMap.put("project.delete", "project.delete");
        permissionsMap.put("project.write", "project.write");
        permissionsMap.put("project.read","project.read");
        permissionsMap.put("element.related_files.create", "element.related_files.create");
        permissionsMap.put("element.related_files.delete", "element.related_files.delete");
        permissionsMap.put("element.related_files.read", "element.related_files.read");
        permissionsMap.put("project_template.delete", "project_template.delete");
        permissionsMap.put("project_template.write", "project_template.write");
        permissionsMap.put("project_template.read", "project_template.read");
        permissionsMap.put("project_template.create", "project_template.create");
        permissionsMap.put("project.settings.read","project.settings.read");
        permissionsMap.put("project_team.delete", "project_team.delete");
        permissionsMap.put("project_team.read", "project_team.read");
        permissionsMap.put("project_team.write", "project_team.write");
        permissionsMap.put("head.read", "head.read");
        permissionsMap.put("notifications.read", "notifications.read");
        permissionsMap.put("print_order.create", "print_order.create");
        permissionsMap.put("print_order.delete", "print_order.delete");
        permissionsMap.put("print_order.read", "print_order.read");
        permissionsMap.put("print_order.write", "print_order.write");

        // Can Share To Section - NGN-17777
        permissionsMap.put("project.contributor", "project.contributor");
        permissionsMap.put("project contributor", "Project Contributor");
        permissionsMap.put("project.observer", "project.observer");
        permissionsMap.put("project observer", "Project Observer");
        permissionsMap.put("public_project_template.reader", "public_project_template.reader");
        permissionsMap.put("folder.or.element.owner", "folder.or.element.owner");
        permissionsMap.put("approver", "approver");
        permissionsMap.put("project.user", "project.user");
        permissionsMap.put("project user", "Project User");
        permissionsMap.put("traffic.tab.default.view.awaiting.master.approval", "traffic.tab.default.view.awaiting.master.approval");
        permissionsMap.put("traffic.tab.default.view.awaiting.proxy.approval", "traffic.tab.default.view.awaiting.proxy.approval");
        permissionsMap.put("traffic.tab.default.view.proxy.approved", "traffic.tab.default.view.proxy.approved");
        permissionsMap.put("traffic.tab.default.view.proxy.rejected", "traffic.tab.default.view.proxy.rejected");
        permissionsMap.put("traffic.tab.default.view.master.rejected", "traffic.tab.default.view.master.rejected");
        permissionsMap.put("traffic.tab.default.view.master.approved", "traffic.tab.default.view.master.approved");
        permissionsMap.put("traffic.metadata.editable","traffic.metadata.editable");
        permissionsMap.put("traffic.tab.default.view.all", "traffic.tab.default.view.all");
        permissionsMap.put("traffic.edit.housenumber","traffic.edit.housenumber");
        permissionsMap.put("traffic.csv.export","traffic.csv.export");
        permissionsMap.put("traffic.file.download","traffic.file.download");
        permissionsMap.put("traffic.master.restore","traffic.master.restore");
        permissionsMap.put("traffic.proxy.restore","traffic.proxy.restore");
        permissionsMap.put("traffic.tab.configure","traffic.tab.configure");
        permissionsMap.put("traffic.tab.create","traffic.tab.create");
        permissionsMap.put("traffic.tab.global.create","traffic.tab.global.create");
        permissionsMap.put("traffic.tab.global.delete","traffic.tab.global.delete");
        permissionsMap.put("traffic.tab.global.edit","traffic.tab.global.edit");

    }
 /*
    @Given("I am on Create New Role pop-up")
    @When("I go to Create New Role pop-up")
    public CreateNewRolePopUpWindow openNewRolePage() {
        return getSut().getPageCreator().getGlobalRolesPage().clickCreateNewRole();
    }
*/
    // Below method for NGN-14650
    @Given("I am on Create New Role pop-up")
    @When("I go to Create New Role pop-up")
    public void openNewRolePage() {
     getSut().getPageCreator().getGlobalRolesPage().clickCreateNewRole_new();
    }

    @Given("I am click on Create New Role button")
   //NGN-14650 public CreateNewRolePopUpWindow openNewRolePageWithoutPageReload() {
    public void openNewRolePageWithoutPageReload() {
       // NGN-14650 return getSut().getPageCreator().getGlobalRolesPage().clickCreateNewRole();
        getSut().getPageCreator().getGlobalRolesPage().clickCreateNewRole_new();
    }

    @Given("{I |}am on {R|r}oles page")
    @When("{I |}go to roles page")
    public RolesPage openRolesPage() {
        return getSut().getPageNavigator().getRolesDefPage();
    }

    @Given("{I |}am on global roles page")
    @When("{I |}go to global roles page")
    @Then("{I |}should see global roles page")
    public GlobalAdminRolesPage getGlobalRolesPage() {
        GenericSteps.refreshPage();
        return getSut().getPageNavigator().getGlobalRolesPage();
    }

    @Given("{I |}am on global roles page of '$agency' business unit")
    public GlobalAdminRolesPage getGlobalRolesPageForBU(Agency agencyName ) {
        return getSut().getPageNavigator().getGlobalRolesPage(agencyName.getId());
    }

    @When("{I |}create '$roleName' role in '$groupName' group")
      public void createRole(String roleName, String groupName) {
        openNewRolePage();
        // NGN-14650  fillPageCreateNewRolePopUpWindow(roleName, groupName).action.click();
        fillPageCreateNewRolePopUpWindow(roleName, groupName).clickAction();
    }

    // Below method for NGN-14650
    @When("{I |}create new '$roleName' role in '$groupName' group")
    public void createRole_new(String roleName, String groupName) {
        GlobalAdminRolesPage rolesPage = getGlobalRolesPage();
        openNewRolePage();
        ExamplesTable fieldsTable = new ExamplesTable(String.format("|Role Name||Role Type|\n|%s||%s|", roleName, groupName));
        Map<String,String> fields = parametrizeTableRows(fieldsTable).get(0);
        rolesPage.setRoleName(wrapRoleName(fields.get("Role Name")));
        rolesPage.setRoleType(checkRolesGroup_fill(fields.get("Role Type")));
        rolesPage.clickSaveButtonInCreateNewRoleSectionVisible();
    }

    @When("{I |}create '$roleName' role in '$groupName' group for organization '$agency'")
    public void createRole(String roleName, String groupName, Agency agency) {
        GlobalAdminRolesPage rolesPage = getGlobalRolesPage();
        searchAdvertiser(agency);
        selectAdvertiser(agency);
      //..  rolesPage.clickCreateNewRole();
        rolesPage.clickCreateNewRole_new();
        fillPageCreateNewRolePopUpWindow(roleName, groupName).clickAction();
    }

   //.. public CreateNewRolePopUpWindow fillPageCreateNewRolePopUpWindow(String roleName, String groupName) {
   public GlobalAdminRolesPage fillPageCreateNewRolePopUpWindow(String roleName, String groupName) {
        ExamplesTable fieldsTable = new ExamplesTable(String.format("|Role Name||Role Type|\n|%s||%s|", roleName, groupName));
        return fillPageCreateNewRolePopUpWindow(fieldsTable);
    }



   @When("I fill Create New Role page with following fields: $fieldsTable")
   //.. public CreateNewRolePopUpWindow fillPageCreateNewRolePopUpWindow(ExamplesTable fieldsTable) {
   // ..CreateNewRolePopUpWindow page = getSut().getPageCreator().getCreateNewRolePopUpWindow();
    public GlobalAdminRolesPage fillPageCreateNewRolePopUpWindow(ExamplesTable fieldsTable) {
    // NGN-14650 GlobalAdminRolesPage page = getGlobalRolesPage();
       GlobalAdminRolesPage page = new GlobalAdminRolesPage(getSut().getWebDriver());
       GenericSteps.refreshPageWithoutDelay();
        page.clickCreateNewRole_new();
        Map<String,String> fields = parametrizeTableRows(fieldsTable).get(0);
        page.setRoleName(wrapRoleName(fields.get("Role Name")));
        page.setRoleType(checkRolesGroup_fill(fields.get("Role Type")));

        return page;
    }

    // For NGN-14650
    @When("I fill Create New Role for '$roleName' with parent '$agencyName' page with following fields: $fieldsTable")
    public GlobalAdminRolesPage fillCreateNewRoleSection(Role role, Agency agency,ExamplesTable fieldsTable) {
        GlobalAdminRolesPage page = getSut().getPageNavigator().getGlobalRolesPage(role.getId(), agency.getId());
        Map<String,String> fields = parametrizeTableRows(fieldsTable).get(0);
        page.setRoleName(wrapRoleName(fields.get("Role Name")));
        page.setRoleType(checkRolesGroup_fill(fields.get("Role Type")));

        return page;
    }

    @When("I fill Create New Role for '$roleName' with parent '$agencyName' page with following fields for Agency: $fieldsTable")
    public GlobalAdminRolesPage fillCreateNewRoleSectionForSpecificBU(Role role, Agency agency,ExamplesTable fieldsTable) {
        GlobalAdminRolesPage page = getSut().getPageNavigator().getGlobalRolesPage(role.getId(), agency.getId());
        GenericSteps.refreshPageWithoutDelay();
        page.clickCreateNewRole_new();
        Map<String,String> fields = parametrizeTableRows(fieldsTable).get(0);
        page.setRoleName(wrapRoleName(fields.get("Role Name")));
        page.setRoleType(checkRolesGroup_fill(fields.get("Role Type")));
        return page;
    }
    // For NGN-14650
    @When("{I |} click element '$elementName' button on create new role section")
    public void clickElementonRolesSection(String fieldName)
    {
        if(fieldName.equalsIgnoreCase("Save"))
            getSut().getPageCreator().getGlobalRolesPage().clickSaveButtonInCreateNewRoleSectionVisible();
        else if(fieldName.equalsIgnoreCase("Cancel"))
            getSut().getPageCreator().getGlobalRolesPage().clickCancelButtonInCreateNewRoleSectionVisible();
    }


    @Then("I should see roles list in alphabetical order")
    public void checkAlphabeticalOrderOfRolesList() {
        for (String groupName : new String[] {"global roles", "library roles", "project roles"}) {
            List<String> rolesList = getSut().getPageCreator().getGlobalRolesPage().getVisibleRoles(groupName);
            assertThat(rolesList, sortedAlphabetically());
        }
    }

    @Then("I '$shoudState' see '$roleName' role on in the roles list")
    public void checkRoleInRoleList(String shouldState, String roleName) {
        boolean isRolePresent = shouldState.equalsIgnoreCase("should");
        List<String> rolesList = getSut().getPageCreator().getGlobalRolesPage().getVisibleRoles();
        String[] expected = convertRoles(roleName);
       // assertThat("I " + shouldState + " see role on global admin roles page",rolesList, isRolePresent ? hasItem(expected[0]) : not(hasItem(expected[0])));
        roleName = wrapRoleName(roleName); // NGN-14650
        assertThat("I " + shouldState + " see role on global admin roles page", rolesList, isRolePresent ? hasItem(roleName) : not(hasItem(roleName))); //NGN-14650
    }

    @Then("I '$shouldState' see '$roleName' role on BU admin roles page")
    public void checkRoleInBURolesList(String shouldState, String roleName) {
        boolean isRolePresent = shouldState.equalsIgnoreCase("should");
        List<String> rolesList = getSut().getPageCreator().getRolesPage().getVisibleRoles();
        roleName = roleName.equals("Agency admin") ? roleName : wrapRoleName(roleName);
        assertThat("I " + shouldState + " see role on BU admin roles page",
                rolesList, isRolePresent ? hasItem(roleName) : not(hasItem(roleName)));
    }

    @Then("{I should see |}role '$roleName' in '$groupName' group")
    public void checkRoleInRoleGroup(String roleName, String groupName) {
        GlobalAdminRolesPage globalRolesPage = getSut().getPageCreator().getGlobalRolesPage();
        roleName = wrapRoleName(roleName);
        groupName = checkRolesGroup(groupName) + " roles";
        assertThat("I should see role on global admin roles page", globalRolesPage.getVisibleRoles(groupName), hasItem(roleName.replaceAll("_", " ")));
    }


    // role names in $roleNames - separate by comma
    @Then("I should see roles '$roleNames' on global roles page in '$groupName' group")
    public void checkRolesInRoleGroup(String roleNames, String groupName) {
        String[] expected = convertRoles(roleNames);
        for(String role : expected) {
            checkRoleInRoleGroup(role,groupName);
        }
    }

    @Then("I '$should' see red inputs on global roles page")
    public static void checkPageErrors(String message) {
        boolean should = message.equals("should");
        By elementLocator=By.cssSelector(".ui-input.ng-valid.ng-dirty.ng-touched.ng-not-empty.ng-valid-parse.error");
        boolean pageOnErrors = getSut().getWebDriver().isElementPresent(elementLocator);
        assertThat(pageOnErrors, is(should));
    }

    // role names in $roleNames - separate by comma
    @Then("I should see only following roles '$roleNames' on global roles page")
    public void checkRolesInRoleListOnly(String roleNames) {
        GlobalAdminRolesPage globalRolesPage = getSut().getPageNavigator().getGlobalRolesPage();  //maybe PageCreator?
        List<String> actualRolesList = globalRolesPage.getVisibleRoles();
        String[] expected = convertAndWrapRoles(roleNames);
        List<String> expectedRolesList = Arrays.asList(expected);
        Collections.sort(actualRolesList, String.CASE_INSENSITIVE_ORDER);
        Collections.sort(expectedRolesList, String.CASE_INSENSITIVE_ORDER);
        assertThat("I should see only expected role names on global roles page", actualRolesList, equalTo(expectedRolesList));

    }

    // role names in $roleNames - separate by comma
    @Then("I should see only following roles '$roleNames' in '$groupName' roles group on global roles page")
    public void checkRolesInRoleGroupOnly(String roleNames, String groupName) {
        GlobalAdminRolesPage rolesPage = getSut().getPageNavigator().getGlobalRolesPage();       //maybe PageCreator?
        String[] expectedRoles = convertAndWrapRoles(roleNames);
        groupName = checkRolesGroup(groupName) + " roles";
        List<String> actualRolesList = rolesPage.getVisibleRoles(groupName);
        List<String> expectedRolesList = Arrays.asList(expectedRoles);
        Collections.sort(actualRolesList, String.CASE_INSENSITIVE_ORDER);
        Collections.sort(expectedRolesList, String.CASE_INSENSITIVE_ORDER);
        assertThat("I should see only expected role names in roles group on global roles page", actualRolesList, equalTo(expectedRolesList));
    }

    @Then("{I should see |}current permission is equal to '$expectedName'")
    public void checkCurrentPermission(String expectedName) {
      // NGN-14650  String currentRoleName = getSut().getPageCreator().getGlobalRolesPage().getCurrentRoleName();
      // NGN-14650 assertThat("Selected Role Name", currentRoleName, equalTo(wrapRoleName(expectedName)));
        String currentRoleName = getSut().getPageCreator().getGlobalRolesPage().getAgencyRolePermissionHeader();
        assertThat("Selected Role Name", currentRoleName, containsString("Permissions for " + wrapRoleName(expectedName)));
    }

    @Then("{I should see |}current permission is equal to '$expectedName' after creating role")
    public void checkCurrentPermissionWithPlaceHolder(String expectedName) {
        String currentRoleName = getSut().getPageCreator().getGlobalRolesPage().getCurrentRoleNamePlaceHolder();
        assertThat("Selected Role Name", currentRoleName, containsString(wrapRoleName(expectedName)));
    }

    @Then("{I should see |}current permission is matches to '$expectedName'")
    public void checkCurrentPermissionMatches(String expectedName) {
      //  String currentRoleName = getSut().getPageCreator().getGlobalRolesPage().getCurrentRoleName_new();
        String currentRoleName = getSut().getPageCreator().getGlobalRolesPage().getCurrentRoleNamePlaceHolder();
        assertThat("Selected Role Name", currentRoleName.matches(expectedName), is(true)); // write matcher
    }

    @Given("{I |}created '$roleName' role in '$groupName' group for advertiser '$agencyName'")
    @When("{I |}create '$roleName' role in '$groupName' group for advertiser '$agencyName'")
    public void createRoleOverCore(String roleName, String groupName, String agencyName) {
        createRoleWithPermissionsOverCore(roleName, "", groupName, agencyName);
    }

    // on / off
    @Given("{I |}set hide status for role '$roleName' to state '$state'")
    public void hideRoleOverCore(Role role, String state) {
        getCoreApi().getWrappedService().hideRole(role.getId(), state.equalsIgnoreCase("on"));
    }

    // | RoleName | Group | Agency |
    @Given("{I |}created following roles: $rolesTable")
    public void createRolesOverCore(ExamplesTable rolesTable) {
        for (Map<String, String> row : rolesTable.getRows()) {
            String agencyName = row.get("Agency") != null ? row.get("Agency") : "DefaultAgency";
            if (getData().getAgencyByName(agencyName) == null) agencyName = wrapVariableWithTestSession(agencyName);
            createRoleOverCore(row.get("RoleName"), row.get("Group"), agencyName);
        }
    }

    // | Permission |
    @Given("{I |}created '$roleName' role in '$groupName' group for advertiser '$agencyName' with following permissions: $permissions")
    @When("{I |}create '$roleName' role in '$groupName' group for advertiser '$agencyName' with following permissions: $permissions")
    public void createRoleWithPermissions(String roleName, String groupName, String agencyName, ExamplesTable permissions) {
        String permissionsString = "";

        for(Map<String, String> row : parametrizeTableRows(permissions)) {
            permissionsString += row.get("Permission") == null || row.get("Permission").isEmpty() ? "" : String.format("%s,", row.get("Permission"));
        }

        agencyName = getData().getAgencyByName(agencyName) == null ? wrapVariableWithTestSession(agencyName) : agencyName;
        createRoleWithPermissionsOverCore(roleName, permissionsString, groupName, agencyName);
    }

    @Given("{I |}created '$roleName' role with '$permissions' permissions in '$groupName' group for advertiser '$agencyName'")
    @When("{I |}create '$roleName' role with '$permissions' permissions in '$groupName' group for advertiser '$agencyName'")
    public void createRoleWithPermissionsOverCore(String roleName, String permissions, String groupName, String agencyName) {
        String[] allow = convertPermissions(permissions);
        roleName = wrapVariableWithTestSession(roleName);
        groupName = checkRolesGroup(groupName);
        String agencyId = getAgencyIdByName(agencyName);
        if (getCoreApiAdmin().getRoleByName(roleName, 0, false) == null) {
            getCoreApiAdmin().createRole(roleName, groupName, splitPermissions(allow), agencyId);
            getCoreApiAdmin().getRoleByName(roleName,false); // wait for index
        }
    }

    @Given("{I |}update role '$roleName' role by following '$permissions' permissions for advertiser '$agencyName'")
    @When("{I |}update role '$roleName' role by following '$permissions' permissions for advertiser '$agencyName'")
    public void updateRoleByPermissionsOverCore(String roleName, String permissions, String agencyName) {
        String[] allow = convertPermissions(permissions);
        String agencyId = getAgencyIdByName(agencyName);
        String roleId = getCoreApiAdmin().getRoleByName(wrapRoleName(roleName),false).getId();
        getCoreApiAdmin().updateRole(wrapRoleName(roleName), roleId, agencyId, allow);
    }

    @Given("{I |}opened role '$roleName' page")
    @When("{I |}open role '$roleName' page")
    public RolesPage openRolePage(String roleName) {
        if(!roleName.equals("project.admin")) {
            if (!isDefaultRole(roleName.replace(" ", "."))) {
                roleName = wrapRoleName(roleName);
            }
        }
        String roleId = getCoreApiAdmin().getRoleByName(roleName, false).getId();
        RolesPage rolesPage= getSut().getPageNavigator().getRolesPage(roleId, "");
        if(!rolesPage.isRoleOverviewSectionLoaded())
            rolesPage.clickRoleByRoleName(roleName);
        return rolesPage;
    }

    @Given("{I |}opened role '$roleName' on global role page")
    @When("{I |}open role '$roleName' on global role page")
    public void openRoleOnPage(String roleName) {
     getSut().getWebDriver().findElement(By.linkText(wrapRoleName(roleName))).click();
    }

    @Given("{I |}waited role '$roleName' on global role page to load")
    @When("{I |}wait role '$roleName' on global role page to load")
    public void waitRoleOnPage(String roleName) {
        By roleText = By.linkText(wrapRoleName(roleName));
        if(!(getSut().getWebDriver().isElementVisible(roleText))) {
            getSut().getWebDriver().waitUntilElementAppearVisible(roleText);
        }
    }

    @Given("{I |}opened role '$roleName' page with parent '$agencyName'")
    @When("{I |}open role '$roleName' page with parent '$agencyName'")
    public GlobalAdminRolesPage openGlobalRolePage(Role role, Agency agency) {
        return getSut().getPageNavigator().getGlobalRolesPage(role.getId(), agency.getId());
    }

    @Then("{I |}should see current role is equal to created role '$rolename'")
    public void verifyNewlyCreatedRole(String rolename) {
        By editRoleName = By.xpath("//input[@ng-model='vm.editedRoleName']");
        getSut().getWebDriver().isElementPresent(editRoleName);
        String currentRoleName =  getSut().getWebDriver().findElement(editRoleName).getAttribute("placeholder");
        assertThat("Selected Role Name", currentRoleName, containsString(wrapRoleName(rolename)));
    }

    @Given("{I |}selected advertiser '$agency' on global roles page")
    @When("{I |}select advertiser '$agency' on global roles page")
    public void selectAdvertiser(Agency agency) {
        GlobalAdminRolesPage page = getSut().getPageCreator().getGlobalRolesPage();
        page.selectAdvertizer(agency.getName());
        Common.sleep(2000);
    }

    @When("{I |}refresh when required for role")
    public void refreshWhenRequired() {
        if(!getSut().getWebDriver().getCurrentUrl().contains("roleId")){
            getSut().getWebDriver().navigate().refresh();
        }
        Common.sleep(1000);
    }

    @Given("{I |}search advertiser '$agency' on global roles page")
    @When("{I |}search advertiser '$agency' on global roles page")
    public void searchAdvertiser(Agency agency) {
        getSut().getPageCreator().getGlobalRolesPage().searchAdvertiser(agency.getName());
        Common.sleep(1000);
    }

    @When("{I |}click Save button on role '$roleName' page")
    public void clickSaveBtn(String roleName) {
        if(!roleName.equals("project.admin")) {
            roleName = wrapRoleName(roleName);
        }
        String roleId = getCoreApiAdmin().getRoleByName(roleName, false).getId();
        GlobalAdminRolesPage rolesPage = getSut().getPageNavigator().getGlobalRolesPage(roleId, "");
        rolesPage.save.click();
    }

    @Given("I changed role name to '$newName'")
    @When("I change role name to '$newName'")
    public void changeRoleName(String newName) {
        newName = wrapRoleName(newName);
        GlobalAdminRolesPage page = getSut().getPageCreator().getGlobalRolesPage();
        page.changeRoleName(newName);
    }

    @When("{I |}change role permissions to '$permissions'")
    public void selectPermissions(String permissions) {
        String[] allow = convertPermissions(permissions);
        GlobalAdminRolesPage page = getSut().getPageCreator().getGlobalRolesPage();
        GenericSteps.refreshPage();
        page.selectPermissions(allow);
    }

    @Given("{I |}added following permissions '$permissions' to role '$roleName' in agency '$agencyName'")
    @When("{I |}add following permissions '$permissions' to role '$roleName' in agency '$agencyName'")
    public void addPermissions(String permissions, Role role, Agency agency) {
        GlobalAdminRolesPage page = openGlobalRolePage(role, agency);
        Set<String> selectedPermissions = new HashSet<>(page.getSelectedPermissions());
        Collections.addAll(selectedPermissions, convertPermissions(permissions));

        page.selectPermissions(selectedPermissions.toArray(new String[selectedPermissions.size()]));
        page.save.click();
        Common.sleep(1000);
    }

    @Given("{I |}changed '$roleName' permissions to '$permissions' in agency '$agencyName'")
    @When("{I |}change '$roleName' permissions to '$permissions' in agency '$agencyName'")
    public void selectPermissions(Role role,String permissions,Agency agency) {
        GlobalAdminRolesPage page = openGlobalRolePage(role, agency);
        String[] allow = convertPermissions(permissions);
        page.selectPermissions(allow);
    }

    @Given("{I |}selected '$permission' in can share to section for '$roleName' role in agency '$agencyName'")
    public void selectPermissionCanShareToSection(String permissions,Role role,Agency agency){
        GlobalAdminRolesPage page = openGlobalRolePage(role, agency);
        String[] allow = convertPermissions(permissions);
        page.selectPermissionsInCanShareToSection(allow);
    }


    @Given("{I |}saved changes in can share to section")
    @When("{I |}save changes in can share to section")
    public void SaveChangesInCanShareToSection(){
        getSut().getWebDriver().findElement(By.xpath("//button[contains(@ng-if,'vm.isCustomRole')]")).click();
        Common.sleep(3000);
    }

    @When("{I |}click on user '$userName' logo in role '$roleName' page")
    public void clickUserLogo(String userName, String roleName) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        RolesPage page = openRolePage(roleName);
        page.clickUserLogo(user);
    }

    @When("{I |}uncheck following '$permissions' permissions in role page")
    public void checkParameter(String permissions) {
        String[] per = permissions.split(",");
        getSut().getPageCreator().getGlobalRolesPage().selectPermissions(per);
    }

    // NGN-17777
    @Given("{I |}selected '$buttonName' for '$roleName' with parent '$agencyName'")
    @When("{I |}select '$buttonName' for '$roleName' with parent '$agencyName'")
    public void selectPermissionButton(String buttonName, Role role,Agency agency){
        boolean isEnabled= false;
        if(buttonName.equalsIgnoreCase("Enable Sharing permissions"))
            isEnabled=false;
        if(buttonName.equalsIgnoreCase("Disable permissions"))
            isEnabled=true;

        getSut().getPageCreator().getGlobalRolesPage().enableCanShareToSection(isEnabled);
    }

    @Given("{I |}selected '$buttonName' for '$roleName' with parent '$agencyName' if not already clicked")
    @When("{I |}select '$buttonName' for '$roleName' with parent '$agencyName' if not already clicked")
    public void selectPermissionButtonifAvailable(String buttonName, Role role,Agency agency){
        boolean isEnabled= false;
        if(buttonName.equalsIgnoreCase("Enable Sharing permissions"))
            isEnabled=false;
        if(buttonName.equalsIgnoreCase("Disable permissions"))
            isEnabled=true;

        getSut().getPageCreator().getGlobalRolesPage().enableCanShareToSectionifNotalreadyDone(isEnabled);
    }

    @Given("{I |}updated the role '$roleName' with the following permissions for agency '$agencyName': $permissions")
    @When("{I |} update the role '$roleName' with the following permissions for agency '$agencyName': $ permissions")
    public void updatedGivenPermissions(Role roleName, Agency agencyName, ExamplesTable permissionsList) {
        GlobalAdminRolesPage page = openGlobalRolePage(roleName, agencyName);
        for (Map<String,String> row : permissionsList.getRows()) {
            String permission = row.get("Permission");
            String state = row.get("Enabled");
            Boolean expected = page.isPermissionSelected(permission);
            if( expected != Boolean.parseBoolean(state)) {
                page.selectPermission(permission);
            }
        }
        System.out.println();
    }

    // NGN-17777
    @Then("{I }'$should' see CanShareTo section")
    public void checkCanShareToSection(String shouldState){
        Common.sleep(1000);
        assertThat("Check CanShareTo Section", getSut().getPageCreator().getGlobalRolesPage().isCanShareToSectionEnabled(), equalTo(shouldState.equals("should")));
    }

    @Then("{I should see |}role '$roleName' contains '$permissions'")
    public void checkRolePermissions(Role role, String permissions) {
        GlobalAdminRolesPage page = openGlobalRolePage(role, getData().getAgencyByName("DefaultAgency"));
        String[] expectedPermissions = convertPermissions(permissions);
        List<String> selectedPermissions = page.getSelectedPermissions();
        int counter = 0;
        for (String perm : expectedPermissions) {
            if (perm == null) continue;
            counter += perm.split(",").length;
        }
        assertThat("Permissions count", selectedPermissions.size(), equalTo(counter));
        for (String expectedPermission : expectedPermissions) {
            for (String eP : expectedPermission.split(",")) {
                assertThat(selectedPermissions, hasItem(eP));
            }
        }
        expectedPermissions = splitPermissions(expectedPermissions);
        assertThat("Permissions count", role.getAllow().length, equalTo(expectedPermissions.length));
        for (String expectedPermission : expectedPermissions) {
            assertThat(role.getAllow(), hasItemInArray(expectedPermission));
        }
    }

    @Then("{I should see |}role '$roleName' that '$shouldState' contains following selected permissions '$permissions'")
    public void checkRolesContainsPermissions(Role role, String shouldState, String permissions) {
        GlobalAdminRolesPage page = openGlobalRolePage(role, getData().getAgencyByName("DefaultAgency"));
        GenericSteps.refreshPage();
        boolean should = shouldState.equals("should");
        String[] expectedPermissions = convertPermissions(permissions);
        Common.sleep(3000);
       List<String> selectedUIPermissions = page.getSelectedPermissions();
        Map<Integer,String> convertedPermissionsMap = new HashMap<>();
        for (int i = 0; i < selectedUIPermissions.size(); i++) {
            convertedPermissionsMap.put(i, selectedUIPermissions.get(i));
        }

        List<String> selectedCorePermissions = new ArrayList<String>(convertedPermissionsMap.values());
        for (String expectedPermission : expectedPermissions) {
            if (should) {
                assertThat(selectedCorePermissions, hasItem(expectedPermission));
            } else {
                assertThat(selectedCorePermissions, not(hasItem(expectedPermission)));
            }
        }
    }

    @Then("{I should see |}role '$roleName' and '$shouldState' contains following selected permissions '$permissions' for Agency")
    public void checkRolesContainsPermissionsForSpecificBu(String rolename, String shouldState, String permissions) {
        boolean should = shouldState.equals("should");
        String[] expectedPermissions = convertPermissions(permissions);
        By locator = By.cssSelector("[type='checkbox']:checked");
        List<String> selectedUIPermissions =getSut().getWebDriver().isElementPresent(locator) ? getSut().getWebDriver().findElementsToStrings(locator, "name") : new ArrayList<String>();
        Map<Integer,String> convertedPermissionsMap = new HashMap<>();
        for (int i = 0; i < selectedUIPermissions.size(); i++) {
            convertedPermissionsMap.put(i, selectedUIPermissions.get(i));
        }

        List<String> selectedCorePermissions = new ArrayList<String>(convertedPermissionsMap.values());
        for (String expectedPermission : expectedPermissions) {
            if (should) {
                assertThat(selectedCorePermissions, hasItem(expectedPermission));
            } else {
                assertThat(selectedCorePermissions, not(hasItem(expectedPermission)));
            }
        }
    }

    @Then("{I should see |}role '$roleName' that '$shouldState' contains following permissions '$permissions' available for selecting")
    public void checkRolesContainsPermissionsAvailableForSelecting(Role role, String shouldState, String permissions) {
        GlobalAdminRolesPage page = getSut().getPageNavigator().getGlobalRolesPage(role.getId(), "");
        // Below step for NGN-14650
        GenericSteps.refreshPage();
        boolean should = shouldState.equals("should");
        String[] expectedPermissions = convertPermissions(permissions);
        List<String> availablePermissions = page.getVisiblePermissions();
        for (String expectedPermission : expectedPermissions) {
            assertThat(availablePermissions.contains(expectedPermission), is(should));
        }
    }

    // For NGN-14650: with agency
    @Then("{I should see |}role '$roleName' that '$shouldState' contains following permissions '$permissions' available for selecting for '$agencyName'")
    public void checkRolesContainsPermissionsAvailableForSelectingForAgency(Role role, String shouldState, String permissions,String agencyName) {
        GlobalAdminRolesPage page = getSut().getPageNavigator().getGlobalRolesPage(role.getId(), getAgencyIdByName(agencyName));
        // Below step for NGN-14650
        GenericSteps.refreshPage();
        boolean should = shouldState.equals("should");
        String[] expectedPermissions = convertPermissions(permissions);
        List<String> availablePermissions = page.getVisiblePermissions();
        for (String expectedPermission : expectedPermissions) {
            assertThat(availablePermissions.contains(expectedPermission), is(should));
        }
    }

    @Then("{I |}'$condition' see '$assertionCriteria' permissions '$permissions' on opened global role page")
    public void checkRolePermissions(String condition, String assertionCriteria, String permissions) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        GlobalAdminRolesPage page = getSut().getPageCreator().getGlobalRolesPage();
        List<String> actualPermissions;
        if (assertionCriteria.equalsIgnoreCase("selected")) {
            actualPermissions = page.getSelectedPermissions();
            //System.out.println(actualPermissions);
        } else if (assertionCriteria.equalsIgnoreCase("unselected")) {
            actualPermissions = page.getUnselectedPermissions();

        } else if (assertionCriteria.equalsIgnoreCase("available")) {
            actualPermissions = page.getVisiblePermissions();
        } else {
            throw new IllegalArgumentException(String.format("Unknown assertion criteria '%s'", assertionCriteria));
        }
        for (String expectedPermission : convertPermissions(permissions)) {
            assertThat(actualPermissions, shouldState ? hasItem(expectedPermission) : not(hasItem(expectedPermission)));
        }
    }


    @Then("{I should see |}permissions checkboxes are '$boxState' on role '$roleName' page")
    public void checkPermissionsState(String boxState, Role role) {
        if (boxState.equalsIgnoreCase("enabled")) {
            checkPermissionsEnable(true, role);
        } else if (boxState.equalsIgnoreCase("disabled")) {
            checkPermissionsEnable(false, role);
        } else if (boxState.equalsIgnoreCase("checked")) {
            checkPermissionsChecked(true, role);
        } else if (boxState.equalsIgnoreCase("unchecked")) {
            checkPermissionsChecked(false, role);
        }
    }

    public void checkPermissionsChecked(boolean isCheckedAll, Role role) {
        GlobalAdminRolesPage page = openGlobalRolePage(role, getData().getAgencyByName("DefaultAgency"));
        assertThat("Permission checkbox checked", page.getSelectedPermissions().size() != 0, is(isCheckedAll));
    }

    public void checkPermissionsEnable(boolean enableState, Role role) {
        GlobalAdminRolesPage page = openGlobalRolePage(role, getData().getAgencyByName("DefaultAgency"));
        for (String permission : page.getVisiblePermissions()) {
            assertThat("Permission checkbox enabled ", page.isPermissionEnabled(permission), equalTo(enableState));
        }
    }

    @Then("{I should see |}role name text field is '$enabledState' on role '$role' page")
    public void checkRoleNameEditable(String enabledState, Role role) {
        boolean isEnabled = enabledState.equalsIgnoreCase("enabled");
        GlobalAdminRolesPage page = openGlobalRolePage(role, getData().getAgencyByName("DefaultAgency"));
        assertThat("Role name editable", page.isRoleNameEditable(), equalTo(isEnabled));
    }

    @Then("I should see that cancel button is inactive for role '$roleName'")
    public void checkThatCancelButtonIsInactive(String roleName) {
        RolesPage page = openRolePage(roleName);
        assertThat(page.isCancelLinkVisible(), equalTo(false));
        assertThat(page.isCancelLinkInvisible(), equalTo(true));
    }

    @Then("{I |}'$shouldState' see user '$userName' in users list on role '$roleName' page")
    public void checkUserOnRolePage(String shouldState, String userName, String roleName) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        RolesPage page = openRolePage(roleName);
        assertThat(page.isUserPresent(user), is(shouldState.equalsIgnoreCase("should")));
    }

    @Then("I '$condition' see that all permissions check boxes are disabled for role '$roleName'")
    public void checkAllCheckBoxesState(String condition, String roleName) {
        RolesPage page = openRolePage(roleName);
        assertThat(page.isAllPermissionCheckBoxStateDisabled(), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' see empty value in {Organization|Agency} dropdown")
    public void checkAgencyDropdownValueEmpty(String condition) {
        boolean should = condition.equalsIgnoreCase("should");
        GlobalAdminRolesPage globalRolesPage = getGlobalRolesPage();
        String organizationValue = globalRolesPage.getOrganizationDropdownValue();
        assertThat("Organization/Agency dropdown is empty", organizationValue.isEmpty(), is(should));
    }

    @When("I click role '$roleName' on roles list")
    public void clickRole(String roleName) {
        RolesPage page = getSut().getPageCreator().getRolesPage();
        page.clickRoleForAgencyUser(roleName);
        Common.sleep(1000);
    }

    // on / off
    @When("{I |}set show hidden roles checkbox to state '$state' on current role page")
    public void showHiddenRoles(String state) {
        boolean turnOn = state.equalsIgnoreCase("on");
        getSut().getPageCreator().getRolesPage().setShowHidden(turnOn);
        Common.sleep(1000);
    }

    // 14650
    @Then("I '$should' see 'save button enabled in create role section")
    public void saveButtonStatusInCreateNewRoleSection(String shouldState)
    {
        boolean should = shouldState.equals("should");
        assertThat("Element 'Save' button state: ",getSut().getPageCreator().getGlobalRolesPage().isSaveButtonInCreateNewRoleSectionEnabled(), is(should));
    }

    // For NGN-14650
    @Then("{I |}'$shouldState' see element '$fieldName' on roles page")
    public void fieldsOnCreateNewRoleSection(String shouldState, String fieldName) {
        boolean should = shouldState.equals("should");
        boolean actual=false;
        if(fieldName.equalsIgnoreCase("RoleNameTextField"))
           actual = getSut().getPageCreator().getGlobalRolesPage().isRoleNameFieldVisible();
        else if(fieldName.equalsIgnoreCase("SaveButton"))
        actual = getSut().getPageCreator().getGlobalRolesPage().isSaveButtonInCreateNewRoleSectionVisible();
        else if(fieldName.equalsIgnoreCase("CancelButton"))
         actual = getSut().getPageCreator().getGlobalRolesPage().isCancelButtonInCreateNewRoleSectionVisible();
        else if(fieldName.equalsIgnoreCase("Permissions for all business units"))
            actual = getSut().getPageCreator().getGlobalRolesPage().isAgencyRolePermissionHeaderVisible();
        else if(fieldName.equalsIgnoreCase("CopyButton"))
            actual = getSut().getPageCreator().getGlobalRolesPage().isCopyButtonInCreateNewRoleSectionVisible();

        assertThat("Element visibility: " + fieldName, actual, is(should));
    }

    // For NGN-14650
    @Then("I '$shouldState' see box '$elementName' on roles page with following fields: $fieldsTable")
    public void elementsInRoleTypeDropDown(String shouldState, String elementName, ExamplesTable fieldsTable) {
        boolean should = shouldState.equals("should");
        for (Map<String, String> row : fieldsTable.getRows()) {
            assertThat("Is jsElement " + row.get("field") + " visible, locator ",
                    getSut().getPageCreator().getGlobalRolesPage().isRoleTypesVisible(row.get("field")),
                    is(should));
        }

    }

    public String wrapRoleName(String roleName) {
        if (!isDefaultRole(roleName.replace(" ", "."))) roleName = wrapVariableWithTestSession(roleName);
        return roleName;
    }

    public boolean isDefaultRole(String roleName) {
        return getCoreApiAdmin().isDefaultRole(roleName);
    }

    private String[] convertAndWrapRoles(String roles) {
        List<String> converted = new ArrayList<String>();
        for (String role : roles.split(",")) {
            converted.add(wrapRoleName(role.trim()));
        }
        return converted.toArray(new String[converted.size()]);
    }

    private String[] convertRoles(String roles) {
        List<String> converted = new ArrayList<String>();
        for (String role : roles.split(",")) {
            converted.add(role.replace(" ", ".").trim());
// NGN-14650 converted.add(role.trim());
        }
        return converted.toArray(new String[converted.size()]);
    }

    private String checkRolesGroup(String groupName) {
        groupName = groupName.toLowerCase();

        if (!(groupName.equals(Role.GROUP_GLOBAL)
                || groupName.equals(Role.GROUP_LIBRARY)
                || groupName.equals(Role.GROUP_PROJECT)
                || groupName.equals(Role.GROUP_SYSTEM)
                || groupName.equals(Role.GROUP_UNDEFINED)))
            throw new IllegalArgumentException("Unknown role type");
        return groupName;
    }

       // NGN-14650
    private String checkRolesGroup_fill(String groupName) {
        groupName = groupName.toLowerCase();

        if(groupName.equals(Role.GROUP_GLOBAL)
                || groupName.equals(Role.GROUP_LIBRARY)
                || groupName.equals(Role.GROUP_PROJECT))
            return groupName+" role";
        else if(groupName.equals(Role.GROUP_SYSTEM) || groupName.equals(Role.GROUP_UNDEFINED))
            return groupName;
        else
            throw new IllegalArgumentException("Unknown role type: "+groupName);
    }

    private String[] convertPermissions(String permissions) {
        List<String> converted = new ArrayList<String>();
        for (String permission : permissions.split(",")) {
            String perm = permissionsMap.get(permission.toLowerCase());
            converted.add(perm);
        }
        return converted.toArray(new String[converted.size()]);
    }

    private String[] splitPermissions(String[] permissions) {
        ArrayList<String> fixedAllow = new ArrayList<String>();
        for (String item : permissions) {
            if (item == null) continue;
            fixedAllow.addAll(Arrays.asList(item.split(",")));
        }
        return fixedAllow.toArray(new String[fixedAllow.size()]);
    }
}