package com.adstream.automate.babylon.tests.steps.domain;


import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.admin.categories.*;
import com.adstream.automate.babylon.sut.pages.admin.people.UsersPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.hamcrest.Matcher;
import org.jbehave.core.annotations.*;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;

import java.util.*;
import java.util.concurrent.TimeUnit;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.is;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10.09.12
 * Time: 17:07
 */
public class CategoriesSteps extends BaseStep {

    @Given("{I am |}on administration area collections page")
    @When("{I |}go to administration area collections page")
    public CategoriesPage openCategoriesPage() {
        return getSut().getPageNavigator().getCategoriesPage("");
    }

    @Given("{I am |}on collection '$categoryName' on administration area collections page")
    @When("{I |}go to collection '$categoryName' on administration area collections page")
    public CategoriesPage openCategoryPage(String categoryName) {
        GenericSteps.refreshPage();
        String categoryId = getCoreApi().getAssetsFilterByName(wrapCollectionName(categoryName), "").getId();
        return getSut().getPageNavigator().getCategoriesPage(categoryId);
    }

    @Given("{I |}created '$names' category")
    @When("{I |}create '$names' category")
    public void createCategory(String names) {
        String tableString = "|Name|";
        for (String name : names.split(",")) tableString += String.format("\n|%s|", name);
        createNewCategories(new ExamplesTable(tableString));
    }

    @Given("{I |}created child category '$subCategoryName' of category '$categoryName'")
    @When("{I |}create child category '$subCategoryName' of category '$categoryName'")
    public void createSubCategory(String subCategoryName, String categoryName) {
        String categoryId = getCoreApi().getAssetsFilterByName(wrapCollectionName(categoryName), "").getId();
        AssetFilterTerms terms = new AssetFilterTerms().addCategory(categoryId);
        getCoreApi().createAssetFilterCategory(wrapCollectionName(subCategoryName), terms.getQuery().toString());
        getCoreApi().getAssetsFilterByName(wrapCollectionName(subCategoryName), "");
    }

    // | Name | MediaType | MediaSubType |
    @Given("{I |}created following categories: $categoriesTable")
    @When("{I |}create following categories: $categoriesTable")
    public void createNewCategories(ExamplesTable categoriesTable) {
        for (int i = 0; i < categoriesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(categoriesTable, i);
            String categoryName = row.get("Name");
            if (getCoreApi().getAssetsFilterByName(wrapCollectionName(categoryName), "asset_filter_category", 0) == null) {
                AssetFilterTerms terms = new AssetFilterTerms();
                if (row.get("MediaType") != null && !row.get("MediaType").isEmpty()) {
                    terms.add("_cm.common.mediaType", row.get("MediaType"));
                    if (row.get("MediaSubType") != null && !row.get("MediaSubType").isEmpty()) {
                        terms.add("_cm.common.mediaSubType", row.get("MediaSubType"));
                    }
                }
                getCoreApi().createAssetFilterCategory(wrapCollectionName(categoryName), terms.getQuery().toString());
                //slow down, be sure that collection available for search
                getCoreApi().getAssetsFilterByName(wrapCollectionName(categoryName), "");
            }
        }
    }


    // | CategoryName | UserName | RoleName | Write |
    @Given("{I |}added next users for following categories: $exampleTable")
    @When("{I |}added next users for following categories: $exampleTable")
    public void sharedUsersForCategories(ExamplesTable examplesTable) {
        for (int i = 0; i < examplesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(examplesTable, i);
            if (row.get("CategoryName") != null && row.get("UserName") != null) {
                String categoryName = wrapCollectionName(row.get("CategoryName"));
                String categoryId = getCoreApi().getAssetsFilterByName(categoryName, "").getId();
                String roleId = getCoreApi().getRoleByName(new RolesSteps().wrapRoleName(row.get("RoleName")),false).getId();
                String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName"))).getId();
                if (!getCoreApi().isAssetFilterSharedToUser(categoryId, userId)) {
                    getCoreApi().shareAssetFilter(categoryId, userId, roleId);
                }
            }
        }
    }

  // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code starts

    @Then("{I |}'$condition' see an access denied message on Categories page")
    public void accessCategories(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String directCategorriesURL = TestsContext.getInstance().applicationUrl + "/admin#/categories/";
        getSut().getWebDriver().navigate().to(directCategorriesURL);
        if( condition.equalsIgnoreCase("should")){
            getSut().getWebDriver().waitUntilElementAppearVisible(By.xpath("//span[text() = 'We are sorry! You do not have permission to access this area.']"));
        }
        boolean actualState = getSut().getWebDriver().isElementVisible(By.xpath("//span[text() = 'We are sorry! You do not have permission to access this area.']"));
        assertThat(shouldState, is(actualState));
    }

    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends

    // | CategoryName | TeamName | RoleName |
    @Given("{I |}added following library teams for following categories: $data")
    @When("{I |}add following library teams for following categories: $data")
    public void sharedLibraryTeamForCategories(ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("CategoryName") != null && row.get("TeamName") != null) {
                String categoryName = wrapCollectionName(row.get("CategoryName"));
                String categoryId = getCoreApi().getAssetsFilterByName(categoryName, "").getId();
                String teamId = new UserGroupSteps().wrapNameAndGetGroup(row.get("TeamName")).getId();
                String roleId = getCoreApi().getRoleByName(new RolesSteps().wrapRoleName(row.get("RoleName")),false).getId();
                if (!getCoreApi().isAssetFilterSharedToUser(categoryId, teamId)) {
                    getCoreApi().shareAssetFilter(categoryId, teamId, roleId);
                }
            }
        }
    }

    // | CategoryName | AgencyName |
    @Given("{I |}shared next agencies for following categories: $exampleTable")
    @When("{I |}shared next agencies for following categories: $exampleTable")
    public void sharedAgenciesForCategories(ExamplesTable examplesTable) {
        for (int i = 0; i < examplesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(examplesTable, i);
            if (row.get("CategoryName") != null && row.get("AgencyName") != null) {
                String categoryName = wrapCollectionName(row.get("CategoryName"));
                String categoryId = getCoreApi().getAssetsFilterByName(categoryName, "").getId();
                String agencyId = getAgencyIdByName(row.get("AgencyName"));
                if (!getCoreApi().isAssetFilterSharedToAgency(categoryId, agencyId)) {
                    getCoreApi().shareAssetFilterToAgency(categoryId, agencyId);
                }
            }
        }
    }

    @Given("{I |}{selected|clicked by} category '$categoryName'")
    @When("{I |}{select|click by} category '$categoryName'")
    public void clickByCategoryName(String categoryName) {
        selectCategory(categoryName);
    }

    @When("I remove metadata with key '$key' from current catogories page")
    public void removeMetadataByKey(String key) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        categoriesPage.clickDeleteMetadataByKey(key);
    }

    @When("{I |}click save button for metadata of current category")
    public void clickSaveButton() {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        categoriesPage.clickSaveButton();
    }

    @Given("{I |}switched '$state' media type filter '$filterName' on administration area collections page")
    @When("{I |}switch '$state' media type filter '$filterName' on administration area collections page")
    public void clickMediaTypeFilter(String state, String filterName) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        String[] arrayFilterName = filterName.split(",");
        for (String fN: arrayFilterName) {
            categoriesPage.switchFilterInNeedState(fN, state);
        }
        Common.sleep(2000);
    }

    @Then("I should see media type filter '$mediaType' is in state '$state' on administration area collection page")
    public void checkMediaTypeState(String mediaType, String state) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean expected = state.equals("on") || state.equals("true") || state.equals("enabled");
        assertThat("Media type filter '" + mediaType + "' in state '" + state + "'",
                categoriesPage.getFiltersState(mediaType), is(expected));
    }

    @Then("I should see collection '$subCollectionName' is child of collection '$collectionName' on administration area collections page")
    public void checkCollectionIsChild(String subCollectionName, String collectionName) {
        CategoriesPage page = selectCategory(subCollectionName);
        List<String> children = page.getCollectionChildren(wrapCollectionName(collectionName));
        assertThat(children, hasItem(wrapCollectionName(subCollectionName)));
    }

    @When("{I |}select media subtype '$subType' for current category")
    public void selectMediaSubType(String subType) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        if (subType.contains("'"))
            subType = subType.substring(0, subType.indexOf("'")-1);
        categoriesPage.selectMediaSubType(subType);
    }

    @When("{I |}create category '$categoryName'")
    public void createNewCategory(String categoryName) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        Common.sleep(500);
        categoriesPage.waitUntilPopUpNotificationMessageDisappeared();
        CreateNewCategoryPopUp createNewCategoryPopUp = categoriesPage.clickNewCategory();
        createNewCategoryPopUp.setCategoryName(wrapCollectionName(categoryName)).action.click();
    }

    @When("{I |}create category '$categoryName' via UI")
    public void createNewCategoryUI(String categoryName) {
        BasePage page = getSut().getPageCreator().getBasePage();
        page.expandAccountMenu();
        page.selectAccountMenuItemByName("Admin");
        Common.sleep(500);
        UsersPage adminPage = getSut().getPageCreator().getUsersPage();
        adminPage.clickCollectionsTab();
        CategoriesPage categoriesPage  = new CategoriesPage(getSut().getWebDriver());
        CreateNewCategoryPopUp createNewCategoryPopUp = categoriesPage.clickNewCategory();
        createNewCategoryPopUp.setCategoryName(wrapCollectionName(categoryName)).action.click();
    }



    @When("{I |}set to collection '$collection' following metadata: $metadata")
    public void setMetadataToCollection(String collectionName, ExamplesTable metadata) {
        CategoriesPage page = selectCategory(collectionName);
        for (int i = 0; i < metadata.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadata, i);
            addMetadataItemIntoCategory(collectionName, row.get("key"), row.get("value"));
        }
        page.clickSaveButton();
        Common.sleep(1000);
    }

    // | key | value |
    @When("{I |}create collection '$subCollectionName' based on collection '$collectionName' on administration area with following metadata: $metadata")
    public void createSubCollection(String subCollectionName, String collectionName, ExamplesTable metadata) {
        CategoriesPage page = selectCategory(collectionName);
        for (int i = 0; i < metadata.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadata, i);
            addMetadataItemIntoCategory(collectionName, row.get("key"), row.get("value"));
        }
        page.clickSaveAsACollection().setCollectionName(wrapVariableWithTestSession(subCollectionName)).action.click();
        Common.sleep(1000);
    }

    @Given("{I |}added into category '$categoryName' metadata with key '$key' and value '$value'")
    @When("{I |}add into category '$categoryName' metadata with key '$key' and value '$value'")
    public void addMetadataItemIntoCategory(String categoryName, String key, String value) {
        CategoriesPage categoriesPage = selectCategory(categoryName);
        categoriesPage.setMetaDataKey(key);
        Common.sleep(1000);
        categoriesPage.setMetaDataValue(wrapVariableWithTestSession(value));
        Common.sleep(1000);
        categoriesPage.clickAddMetaData();
    }

    // | Key | Value |
    @Given("{I |}added into category '$categoryName' following arbitary metadata: $mdTable")
    @When("{I |}add into category '$categoryName' following arbitary metadata: $mdTable")
    public void addMetadataItemIntoCategoryForVideoFilter(String categoryName, ExamplesTable mdTable) {
        CategoriesPage categoriesPage = selectCategory(categoryName);
        for (int i = 0; i < mdTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(mdTable, i);
            if (row.get("Key")==null || row.get("Key").isEmpty() || row.get("Value")==null || row.get("Value").isEmpty())
                continue;
            categoriesPage.setMetaDataKey(row.get("Key"));
            if (categoriesPage.isMetadataTextValueWithItsKeyExist(row.get("Key"))) {
                categoriesPage.typeMetadataTextValueByKey(row.get("Key"), row.get("Value"));
            } else {
                categoriesPage.setMetadataValueByKey(row.get("Key"), row.get("Value"));
            }

            Common.sleep(1000);
            categoriesPage.clickAddMetaData();
        }
    }

    // | UsageRight | FilterKey | FilterValue |
    @Given("{I |}added following usage rights filters into category '$categoryName': $data")
    @When("{I |}add following usage rights filters into category '$categoryName': $data")
    public void createSubCategoryWithMetadata(String categoryName, ExamplesTable data) {
        CategoriesPage page = openCategoryPage(categoryName);

        for (Map<String,String> row : parametrizeTableRows(data)) {
            page.addUsageRightsFilter(row.get("UsageRight"), row.get("FilterKey"), row.get("FilterValue"));
        }

        page.clickSaveButton();
    }

    @Given("I selected for current category metadata with key '$key'")
    @When("I select for current category metadata with key '$key'")
    public void selectMetadataByKey(String key) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        categoriesPage.setMetaDataKey(key);
    }

    @Given("{I |}added users '$userNames' for category '$categoryName' with role '$roleName'")
    @When("{I |}add users '$userNames' for category '$categoryName' with role '$roleName'")
    public void addUserIntoCategory(String userNames, String categoryName, String roleName) {
        CategoriesPage page1 = openCategoryPage(categoryName); // For NGN-14650
        getSut().getWebDriver().findElement(By.xpath("//a[@href='#roles']")).click(); // For NGN-14650
        CategoriesPage page = openCategoryPage(categoryName);
        List<String> usersToAdd = new ArrayList<String>();
        for (String userName : userNames.split(",")) {
            String email = wrapUserEmailWithTestSession(userName);
            User user = getCoreApiAdmin().getUserByEmail(email);
            if (!page.isUserPresentOnThePage(user.getId())) {
                usersToAdd.add(email);
            }
        }
        if (!usersToAdd.isEmpty()) {
            ManagePermissionsPopUp managePermissionsPopUp = page.openManageUsersPopup();
            for (String userName : usersToAdd) {
                managePermissionsPopUp.selectUser(wrapUserEmailWithTestSession(userName));
                Common.sleep(1000);
            }

            managePermissionsPopUp.selectRole(new RolesSteps().wrapRoleName(roleName));
            Common.sleep(1000);
            managePermissionsPopUp.add();
        }
    }

    @Given("{I |}added users '$userNames' to category '$categoryName' with role '$roleName' by users details")
    @When("{I |}add users '$userNames' to category '$categoryName' with role '$roleName' by users details")
    public void addUserIntoCategoryByUserNameAndEmail(String userNames, String categoryName, String roleName) {
        CategoriesPage page1 = openCategoryPage(categoryName); // For NGN-14650
        getSut().getWebDriver().findElement(By.xpath("//a[@href='#roles']")).click(); // For NGN-14650
        CategoriesPage page = openCategoryPage(categoryName);
        List<Map<String,String>> usersToAdd = new ArrayList<>();

        for (String userName : userNames.split(",")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));

            if (!page.isUserPresentOnThePage(user.getId())) {
                Map<String,String> userFields = new HashMap<>();
                userFields.put("Name", user.getFullName());
                userFields.put("Email", user.getEmail());
                usersToAdd.add(userFields);
            }
        }

        if (!usersToAdd.isEmpty()) {
            ManagePermissionsPopUp popup = page.openManageUsersPopup();

            for (Map<String,String> userFields : usersToAdd) {
                popup.selectUser(userFields.get("Email"));
            }
            Common.sleep(3000);
            popup.selectRole(new RolesSteps().isDefaultRole(roleName) ? roleName : wrapVariableWithTestSession(roleName));
            popup.add();
        }
    }
    @Given("{I |}added users via UI '$userNames' to category '$categoryName' with role '$roleName' by users details")
    @When("{I |}add users via UI '$userNames' to category '$categoryName' with role '$roleName' by users details")
    public void addUserIntoCategoryByUserNameAndEmailUI(String userNames, String categoryName, String roleName) {
        CategoriesPage page = new CategoriesPage(getSut().getWebDriver());
        List<Map<String,String>> usersToAdd = new ArrayList<>();
        for (String userName : userNames.split(",")) {
            User user = getCoreApiAdmin().getUserByEmail(userName);
            if (!page.isUserPresentOnThePage(user.getId())) {
                Map<String,String> userFields = new HashMap<>();
                userFields.put("Name", user.getFullName());
                userFields.put("Email", user.getEmail());
                usersToAdd.add(userFields);
            }
        }

        if (!usersToAdd.isEmpty()) {
            ManagePermissionsPopUp popup = page.openManageUsersPopup();

            for (Map<String,String> userFields : usersToAdd) {
                popup.selectUser(userFields.get("Email"));
            }

            popup.selectRole(roleName);
            popup.add();
        }
    }
    @When("{I |}fill users field with text '$text' on Add Users popup on on Categories and Permissions page")
    public void fillTextIntoUsersFieldOnAddUsersPopup(String text) {
        new ManagePermissionsPopUp(getSut().getPageCreator().getCategoriesPage()).selectUser(text);
        Common.sleep(1000);
    }

    @When("{I |}add following business unit '$unit' with category '$category'")
    public void addBusinessUnitWithCategory(String unit, String category) {
        CategoriesPage page = getSut().getPageCreator().getCategoriesPage();
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(page);
        page.selectCategoriesByName(wrapVariableWithTestSession(category));
        page.clickAddAgency();
        addAgencyPopUp.selectAgency(wrapVariableWithTestSession(unit));
        addAgencyPopUp.clickAddButton();
        Common.sleep(1000);
    }

    @When("{I |}click library team '$teamName' for category '$categoryName' on Categories and Permissions page")
    public void clickLibraryTeamOnAdminCategoryPage(String teamName, String categoryName) {
        openCategoryPage(categoryName).clickLibraryTeam(wrapVariableWithTestSession(teamName));
        Common.sleep(1000);
    }

    @When("{I |}click user '$userName' for category '$categoryName' on Categories and Permissions page")
    public void clickUserOnAdminCategoryPage(String userName, String categoryName) {
        openCategoryPage(categoryName).clickUserLinkById(getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId());
        Common.sleep(1000);
    }

    @Given("{I |}changed role for users '$userNames' in category '$categoryName' with role '$roleName'")
    @When("{I |}change role for users '$userNames' in category '$categoryName' with role '$roleName'")
    public void changeUserRoleIntoCategory(String userNames, String categoryName, String roleName) {
        CategoriesPage categoriesPage = selectCategory(categoryName);
        for (String userName: userNames.split(",")) {
            String userId = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
            ManageUsersCategoriesPopUp manageUsersCategoriesPopUp = categoriesPage.openManageUsersCategory(userId);
            manageUsersCategoriesPopUp.selectRole(wrapVariableWithTestSession(roleName));
            Common.sleep(1000);
            manageUsersCategoriesPopUp.save();
        }
    }

    @Given("{I |}added library teams '$libraryTeams' for category '$categoryName' with role '$libraryRole'")
    @When("{I |}add library teams '$libraryTeams' for category '$categoryName' with role '$libraryRole'")
    public void addLibraryTeamToCategory(String libraryTeams, String categoryName, String libraryRole) {
        CategoriesPage page1 = openCategoryPage(categoryName); // For NGN-14650
        getSut().getWebDriver().findElement(By.xpath("//a[@href='#roles']")).click(); // For NGN-14650
        AddLibraryTeamPopup popup = openCategoryPage(categoryName).clickAddLibraryTeam();
        for (String team : libraryTeams.split(",")) popup.selectLibraryTeam(wrapVariableWithTestSession(team));
        popup.selectRole(new RolesSteps().wrapRoleName(libraryRole));
        popup.save();
    }

    @Given("{I |}removed library teams '$teamNames' from category '$categoryName'")
    @When("{I |}remove library teams '$teamNames' from category '$categoryName'")
    public void removeLibraryTeamFromCategory(String teamNames, String categoryName) {
        String teamId = getCoreApi().getLibraryTeamByName(wrapVariableWithTestSession(teamNames)).getId();
        openCategoryPage(categoryName).clickRemoveLibraryTeam(teamId).clickAction();
    }

    @Given("{I |}selected media type '$mediaType' and sub media type '$subMediaType' for category '$categoryName'")
    @When("{I |}select media type '$mediaType' and sub media type '$subMediaType' for category '$categoryName'")
    public void changeCategoryMediaType(String mediaType, String subMediaType, String categoryName) {
        categoryName = wrapVariableWithTestSession(categoryName);
        AssetFilter category = getCoreApi().getAssetsFilterByName(categoryName, "");

        JsonObject typeTerms = new JsonObject();
        //typeTerms.add("mediaType.untouched", new Gson().toJsonTree(new String[] {mediaType}));
        typeTerms.add("_cm.common.mediaType", new Gson().toJsonTree(new String[] {mediaType}));
        JsonObject subTypeTerms = new JsonObject();
        //String key = String.format("properties.customInfo.%s.subType.untouched", mediaType);
        //String key = String.format("_cm.common.%s", mediaType);
        subTypeTerms.add("_cm.common.mediaSubType", new Gson().toJsonTree(new String[] {subMediaType}));

        JsonObject andFirst = new JsonObject();
        andFirst.add("terms", typeTerms);
        JsonObject andSecond = new JsonObject();
        andSecond.add("terms", subTypeTerms);

        JsonArray and = new JsonArray();
        and.add(andFirst);
        and.add(andSecond);

        JsonObject query = new JsonObject();
        query.add("and", and);

        getCoreApi().getWrappedService().updateAssetFilter(category.getId(), categoryName, query.toString());
    }

    @When("{I |}put data '$data' into 'Limit User' popup for category '$categoryName'")
    public void putDataIntoUserLimitPopup(String data, String categoryName) {
        openCategoryPage(categoryName).openManageUsersPopup().setUser(data);
        Common.sleep(1000);
    }

    @When("{I |}select user by name '$userName' and email '$userEmail' on 'Limit User' popup")
    public void selectUsersByNameAndEmail(String userName, String userEmail) {
        if (!userName.isEmpty() && !userEmail.isEmpty()) {
            ManagePermissionsPopUp popup = new ManagePermissionsPopUp(getSut().getPageCreator().getCategoriesPage());
            popup.selectUser(wrapUserEmailWithTestSession(userEmail));
            Common.sleep(1000);
        }
    }

    @When("{I |}try to add user '$userEmail' for category '$categoryName'")
    public void tryToAddUsersIntoCategory(String userEmail, String categoryName) {
        openCategoryPage(categoryName).openManageUsersPopup().setUser(wrapUserEmailWithTestSession(userEmail));
        Common.sleep(1000);
    }

    @Given("{I |}removed users '$usersNames' for category '$categoryName'")
    @When("{I |}remove users '$usersNames' for category '$categoryName'")
    public void removeUsersFromCategory(String usersNames, String categoryName) {
        CategoriesPage page = openCategoryPage(categoryName);
        for (String userName : usersNames.split(","))
            page.clickRemoveUser(getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId()).action.click();
    }

    @When("{I |}click remove button on agency '$agencyName' for category '$categoryName'")
    public void clickRemoveButtonForAgency(String agencyName, String categoryName){
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        selectCategory(categoryName);
        categoriesPage.clickRemoveAgency(getAgencyIdByName(agencyName));
    }

    @When("{I |}remove agency '$agencyName' for category '$categoryName'")
    public void removeAgencyFromCategory(String agencyName, String categoryName) {
        CategoriesPage categoriesPage = openCategoryPage(categoryName);
        String agencyId;
        if (getData().getAgencyByName(agencyName)!= null)
            agencyId = getData().getAgencyByName(agencyName).getId();
        else
            agencyId = getCoreApi().getAgencyByName(wrapVariableWithTestSession(agencyName)).getId();

        PopUpWindow popUpWindow = categoriesPage.clickRemoveAgency(agencyId);
        popUpWindow.action.click();
        Common.sleep(1000);
    }

    // | Name |
    @When("{I |}delete following categories from {A|a}sset {C|c}ategories and {P|p}ermissions page: $categoriesName")
    public void deleteCategoty(ExamplesTable categoriesName) {
        for (int i = 0; i < categoriesName.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(categoriesName, i);
            if (row.get("Name")!=null) {
                CategoriesPage categoriesPage = selectCategory(row.get("Name"));
                PopUpWindow popUpWindow = categoriesPage.clickDeleteButton();
                popUpWindow.action.click();
                Common.sleep(1000);
            }
        }
    }

    @When("{I |}'$action' deleting popup for category '$categoryName'")
    public void cancelDeletingPresentations(String action, String categoryName) {
        CategoriesPage categoriesPage = selectCategory(categoryName);
        selectCategory(categoryName);
        PopUpWindow popUpWindow = categoriesPage.clickDeleteButton();

        if (action.equalsIgnoreCase("cancel")) {
            popUpWindow.cancel.click();
        } else if (action.equalsIgnoreCase("close")) {
            popUpWindow.close.click();
        }
    }

    @Given("{I |}removed category '$categoryName' from Collection page in admin area")
    @When("{I |}remove category '$categoryName' from Collection page in admin area")
    public void removeCategories(String categoryName) {
        openCategoryPage(categoryName).clickDeleteButton().action.click();
    }

    @When("I click Add Agencies button for category '$categoryName'")
    public void clickAddAgenciesButtonForCategory(String categoryName) {
        CategoriesPage categoriesPage = openCategoryPage(categoryName);
        categoriesPage.clickAddAgency();
    }

    @Given("{I |}added agency '$agencyNames' to category '$categoryName' on Asset Categories and Permissions page")
    @When("{I |}add agency '$agencyNames' to category '$categoryName' on Asset Categories and Permissions page")
    public void addAgencyToCategory(String agencyNames, String categoryName) {
        for (String agencyName : agencyNames.split(",")) {
            new AgencySteps().addPartnerAgency(agencyName, getCoreApi().getCurrentAgency().getName());
        }
        CategoriesPage page = openCategoryPage(categoryName);
        List<String> agencyNamesToAdd = new ArrayList<String>();
        for (String agencyName : agencyNames.split(",")) {
            Agency agency = getData().getAgencyByName(agencyName);
            agencyName = agency == null ? wrapVariableWithTestSession(agencyName) : agency.getName();

            if (!page.isAgencyExistInAgenciesList(agencyName)) {
                agencyNamesToAdd.add(agencyName);
            }
        }
        if (!agencyNamesToAdd.isEmpty()) {
            AddAgencyPopUp popup = page.clickAddAgency();
            for (String agencyName : agencyNamesToAdd) {
                popup.selectAgency(agencyName);
                Common.sleep(500);
            }
            popup.action.click();
            Common.sleep(1000);
        }
    }

    @Given("{I |}specified agency name '$agencyName' on Add Agencies popup")
    @When("{I |}specify agency name '$agencyName' on Add Agencies popup")
    public void specifyAgencyNameOnAgenciesPopup(String agencyName) {
        String agency;
        for (String agencyLocal: agencyName.split(",")) {
            if (getData().getAgencyByName(agencyName)!= null) agency = getData().getAgencyByName(agencyLocal).getName();
            else agency = wrapVariableWithTestSession(agencyLocal);
            AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
            addAgencyPopUp.selectAgency(agency);
            Common.sleep(1000);
        }
    }

    @When("{I |}delete '$number' agency from Add Agencies popup")
    public void deleteAgencyByNum(int number) {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        addAgencyPopUp.clickDeleteButton(number);
    }

    @When("{I |}start type agency name '$agencyName' on Add Agencies popup")
    public void startTypeAgencyNameOnAgenciesPopup(String agencyName) {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        addAgencyPopUp.setAgencyName(agencyName);
    }

    @When("{I |}select agency according to text '$text' on Add Agencies popup")
    public void selectAgencyAccordingToText(String text) {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        addAgencyPopUp.selectAgency(text);
    }

    @When("I cancel Add Agencies on the Add Agencies popup")
    public void cancelAddAgencies() {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        addAgencyPopUp.cancel.click();
    }

    @When("I close Add Agencies on the Add Agencies popup")
    public void closeAddAgencies() {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        addAgencyPopUp.close.click();
    }

    @When("{I |}cancel Remove Agencies on the Remove Agencies popup")
    public void cancelRemoveAgencies() {
        PopUpWindow popUpWindow = new PopUpWindow(getSut().getPageCreator().getCategoriesPage());
        popUpWindow.cancel.click();
    }

    @When("{I |}close Remove Agencies on the Remove Agencies popup")
    public void closeRemoveAgencies() {
        PopUpWindow popUpWindow = new PopUpWindow(getSut().getPageCreator().getCategoriesPage());
        popUpWindow.close.click();
    }

    @When("{I |}save Add Agencies on the Add Agencies popup")
    public void saveAddAgencies() {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        addAgencyPopUp.action.click();
    }

    @Then("{I |}'$condition' see agencies in the dropdown list according to text '$text'")
    public void checkAgenciesDropdownList(String condition, String text) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAgencies = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage()).getAgenciesDropdownList();

        for (String agency : actualAgencies) assertThat(agency, shouldState ? startsWith(text) : not(startsWith(text)));
    }

    @Then("I should see selected agencies '$agenciesNames' on the Add Agencies popup")
    public void checkSelectedAgencies(String agenciesNames) {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        List<String> agenciesList = addAgencyPopUp.getSelectedAgenciesList();
        if (agenciesNames.isEmpty()) {
            assertThat("", agenciesList.size(), equalTo(0));
            return;
        }
        for (String agency: agenciesList) {
            assertThat("", agency.substring(2).startsWith(agenciesNames), equalTo(true));
        }
    }

    @Then("I should see selected agencies '$agenciesNames' on the Add Agencies popup and count of selected agencies must be '$count'")
    public void checkSelectedAgencies(String agenciesNames, String count) {
        AddAgencyPopUp addAgencyPopUp = new AddAgencyPopUp(getSut().getPageCreator().getCategoriesPage());
        List<String> agenciesList = addAgencyPopUp.getSelectedAgenciesList();
        assertThat("", agenciesList.size(), equalTo(Integer.parseInt(count)));
        for (String agency: agenciesList) {
            assertThat("", agency.substring(2).startsWith(agenciesNames), equalTo(true));
        }

    }

    @Then("I '$condition' Add Agencies popup on the category page")
    public void checkAAPopUpVisible(String condition) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Add Agencies popup: User is waiting that this popup is: " + shouldState + " but now it's " + !shouldState,
                categoriesPage.isAddAgencyPopupVisible(), equalTo(shouldState));
    }

    @Then("I '$condition' see Add users button on the category page")
    public void checkAddUserVisible(String condition) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Add User Button: User is waiting that the button is: " + shouldState + " but now it's " + !shouldState,
                categoriesPage.isAddUsersButtonVisible(), equalTo(shouldState));
    }

    @Then("I '$condition' see Add Business Unit button on the category page")
    public void checkAddBUVisible(String condition) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Add BU Button: User is waiting that the button is: " + shouldState + " but now it's " + !shouldState,
                categoriesPage.isAddBusinessUnitButtonVisible(), equalTo(shouldState));
    }

    @Then("I '$condition' see Add Library Team button on the category page")
    public void checkAddLibraryTeamVisible(String condition) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Add Library Team Button: User is waiting that the button is: " + shouldState + " but now it's " + !shouldState,
                categoriesPage.isAddLibraryTeamButtonVisible(), equalTo(shouldState));
    }

    @Then("{I |}should see '$text' text on Remove Agencies popup")
    public void checkTextOnRAPopUp(String text){
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        assertThat(categoriesPage.getRemoveAgencyPopupText(), equalTo(text));
    }

    @Then("I '$condition' Remove Agencies popup on the category page")
    public void checkRAPopUpVisible(String condition) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Remove Agencies popup: User is waiting that this popup is: " + shouldState + " but now it's " + !shouldState,
                categoriesPage.isRemoveAgencyPopupVisible(), equalTo(shouldState));
    }

    @Then("{I |}'$condition' see agency '$agencyName' in the agencies list for current category")
    public void checkAgencyInTheAgenciesList(String condition, String agencyName) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        String agency;
        for (String agencyLocal: agencyName.split(",")) {
            if (getData().getAgencyByName(agencyName)!= null) {
                agency = getData().getAgencyByName(agencyLocal).getName();
            } else {
                agency = wrapVariableWithTestSession(agencyLocal);
            }
            assertThat("Agency present in agencies list: " + agency,
                    categoriesPage.isAgencyExistInAgenciesList(agency), equalTo(shouldState));
        }
    }

    @Then("I should see that count of agencies in the list is '$count' for current category")
    public void checkCountOfAgenciesInTheList(String count) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        int countOnThePage = categoriesPage.getCountOfAgencies();
        assertThat("I am waiting that count of agencies for current category is " + count + " but count is " + countOnThePage,
                countOnThePage, equalTo(Integer.parseInt(count)));
    }

    @Then("I should see that count of users in the list is '$count' for current category")
    public void checkCountOfUsersInTheList(String count) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        int countOnThePage = categoriesPage.getCountOfUsers();
        assertThat("I am waiting that count of users for current category is " + count + " but count is " + countOnThePage,
                countOnThePage, equalTo(Integer.parseInt(count)));
    }

    // | Name | ShouldState |
    @Then("I should see following metadata keys on the current categories page: $metadataKeys")
    public void checkMetadataKeys(ExamplesTable metadataKeys) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        List<String> allMetadataKeys = categoriesPage.getAllMetadatasKeys();
        for (int i = 0; i < metadataKeys.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadataKeys, i);
            boolean shouldState = row.get("ShouldState") != null && row.get("ShouldState").equalsIgnoreCase("should");
            assertThat(row.get("Name"), shouldState ? isIn(allMetadataKeys) : not(isIn(allMetadataKeys)));
        }
    }

    // | Name | Advertiser |
    @Then("I '$condition' see following metadata for category: $metadataTable")
    public void checkMetadataOnThePage(String condition, ExamplesTable metadataTable) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (int i = 0; i < metadataTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadataTable, i);
            String value;
            if (row.get("Name")!= null && !row.get("Name").isEmpty()) {
                String categoryId = getCoreApi().getAssetsFilterByName(wrapCollectionName(row.get("Name")), "").getId();
                categoriesPage = getSut().getPageNavigator().getCategoriesPage(categoryId);
            }
            if (row.get("Advertiser")!= null && !row.get("Advertiser").isEmpty()) {
                assertThat("", "Advertiser", isIn(categoriesPage.getAllMetadataKeys()));
                if (getData().getAgencyByName(row.get("Advertiser"))!=null) value = getData().getAgencyByName(row.get("Advertiser")).getName();
                else value = getData().getAgencyByName(wrapVariableWithTestSession(row.get("Advertiser"))).getName();
                assertThat("", value, shouldState ? isIn(categoriesPage.getAllMetadataValues()) : not(isIn(categoriesPage.getAllMetadataValues())));
            }
            if (row.get("Other")!= null && !row.get("Other").isEmpty()) {
                List<String> actualValues = new ArrayList<String>();
                actualValues.addAll(categoriesPage.getMetadataTextValueByKey());
                actualValues.addAll(categoriesPage.getAllMetadataValues());
                Collections.sort(actualValues);

                List<String> expectedValues = new ArrayList<String>();
                Collections.addAll(expectedValues, row.get("Other").split(","));
                Collections.sort(expectedValues);

                assertThat(actualValues, shouldState ? equalTo(expectedValues) : not(equalTo(expectedValues)));
            }
        }
    }

    @Then("I '$condition' see media subtype '$mediaSubType' for current category")
    public void checkMediaSubType(String condition, String mediaSubType) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        assertThat(categoriesPage.getMediaSubType().trim(), condition.equalsIgnoreCase("should") ? equalTo(mediaSubType) : not(equalTo(mediaSubType)));
    }

    // | Name |
    @Then("{I |}'$condition' see on the {A|a}sset {C|c}ategories and {P|p}ermissions page next categories: $listOfCategories")
    public void checkListOfCategories(String condition, ExamplesTable listOfCategories) {
        boolean shouldState = condition.equals("should");
        List<String> actualCategoriesList = getSut().getPageCreator().getCategoriesPage().getListOfCategoriesNames();

        for (Map<String,String> row : parametrizeTableRows(listOfCategories)) {
            if (row.get("Name") != null && !row.get("Name").isEmpty()) {
                String expectedCategory = wrapCollectionName(row.get("Name"));
                assertThat(actualCategoriesList, shouldState ? hasItem(expectedCategory) : not(hasItem(expectedCategory)));
            }
        }
    }

    @Then("{I |}'$condition' see selected '$categoryName' at LHS on {A|a}sset {C|c}ategories and {P|p}ermissions page")
    public void checkSelectedCategoryName(String condition, String categoryName) {
        boolean shouldState = condition.equals("should");
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        assertThat(categoriesPage.getActiveCategoryName().equals(wrapVariableWithTestSession(categoryName)), equalTo(shouldState));
    }

    @Then("{I |}'$condition' see only one category with name '$categoryName' on 'Categories Available' menu")
    public void checkThatOnlyOneCategoryPresentedOnMenu(String condition, String categoryName) {
        boolean shouldState = condition.equals("should");

        int actualCount = getSut().getPageCreator().getCategoriesPage().getCategoriesCountByName(wrapCollectionName(categoryName));
        int expectedCount = 1;

        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

    @Then("{I |}'$condition' see filters '$filterNames' on {A|a}sset {C|c}ategories and {P|p}ermissions page in the state on")
    public void checkFiltersState(String condition, String filterNames) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        boolean shouldState = condition.equals("should");
        String[] filterNamesArray = filterNames.split(",");
        for (String filterName: filterNamesArray) {
            assertThat(categoriesPage.getFiltersState(filterName), equalTo(shouldState));
        }
    }

    @Then("I '$condition' see metadata with key '$key' in drop-down menu for other fields on {A|a}sset {C|c}ategories and {P|p}ermissions page")
    public void checkVisibilityOfKeyInTheMetadata(String condition, String expectedKey) {
        boolean shouldState = condition.equals("should");
        List<String> actualKeys = getSut().getPageCreator().getCategoriesPage().getMetaDataKey();

        assertThat(actualKeys, shouldState ? hasItem(expectedKey) : not(hasItem(expectedKey)));
    }

    // | Name | ShouldState |
    @Then("I should see following metadata keys in the drop-down menu for current category: $keysTable")
    public void checkVisibilityOfKeyInTheMetadata(ExamplesTable keysTable) {
        List<String> actualKeys = getSut().getPageCreator().getCategoriesPage().getMetaDataKey();

        for (Map<String, String> row : parametrizeTableRows(keysTable)) {
            boolean shouldState = row.get("ShouldState") != null && row.get("ShouldState").equalsIgnoreCase("should");
            assertThat(actualKeys, shouldState ? hasItem(row.get("Name")) : not(hasItem(row.get("Name"))));
        }
    }

    @Then("I should see category '$categoryName' without metadata")
    public void checkThatCategoryHasNotMetadata(String categoryName) {
        CategoriesPage categoriesPage = selectCategory(categoryName);
        assertThat(categoriesPage.getCountOfDeleteMetadataButtons(), equalTo(0));
        assertThat(categoriesPage.getCountOfKeyMetadataFields(), equalTo(0));
    }

    @Then("{I |}'$condition' see users '$usersNames' on {A|a}sset {C|c}ategories and {P|p}ermissions page")
    public void checkUserNamesOnAssetCategoriesAndPermissionsPage(String condition, String usersNames) {
        boolean shouldState = condition.equals("should");
        List<String> actualUsersList = getSut().getPageCreator().getCategoriesPage().getUsersList();

        for (String userName : usersNames.split(",")) {
            String email = wrapUserEmailWithTestSession(userName);
            User user = getCoreApi().getUserByEmail(email);
            String expectedUser = user == null ? email : user.getFullName();

            assertThat(actualUsersList, shouldState ? hasItem(expectedUser) : not(hasItem(expectedUser)));
        }
    }

    @Then("{I |}'$condition' see selected role '$roleName' on Categories and Permissions page")
    public void checkAssignedRoleForUser(String condition, String roleName) {
        boolean shouldState = condition.equals("should");
        ManageUsersCategoriesPopUp popup = new ManageUsersCategoriesPopUp(getSut().getPageCreator().getCategoriesPage());
        String actualRoleName = popup.getSelectedRole();
        String expectedRoleName = new RolesSteps().isDefaultRole(roleName) ? roleName : wrapVariableWithTestSession(roleName);
        assertThat(actualRoleName, shouldState ? equalTo(expectedRoleName) : not(equalTo(expectedRoleName)));
    }

    @Then("{I |}'$condition' see roles select box on Manage Users Categories popup")
    public void checkThatRolesSelectBoxPresentsOnManageUsersPopup(String condition) {
        boolean expectedState = condition.equals("should");
        boolean actualState = new ManageUsersCategoriesPopUp(getSut().getPageCreator().getCategoriesPage()).isRoleVisible();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see following user names '$usersNames' on Manage Users Categories popup")
    public void checkThatLibraryTeamContainsUsers(String condition, String usersNames) {
        boolean shouldState = condition.equals("should");
        CategoriesPage page = getSut().getPageCreator().getCategoriesPage();
        List<String> actualUsersList = new ManageUsersCategoriesPopUp(page).getUsersList();
        for (String expectedUserName : usersNames.split(",")) {
            String email = wrapUserEmailWithTestSession(expectedUserName);
            User user = getCoreApi().getUserByEmail(email);
            String expectedUser = user == null ? email : user.getFullName();
            assertThat(actualUsersList, shouldState ? hasItem(expectedUser) : not(hasItem(expectedUser)));
        }
    }

    @Then("{I |}'$condition' see Library Teams '$teams' for category '$categoryName' on Asset Categories and Permissions page")
    public void checkLibraryTeamsPresentsOnAssetCategoriesAndPermissionsPage(String condition, String teams, String categoryName) {
        boolean shouldState = condition.equals("should");
        List<String> actualTeamsList = openCategoryPage(categoryName).getLibraryTeamsList();
        for (String expectedTeam : teams.split(",")) {
            expectedTeam = wrapVariableWithTestSession(expectedTeam);
            assertThat(actualTeamsList, shouldState ? hasItem(expectedTeam) : not(hasItem(expectedTeam)));
        }
    }

    @Then("{I |}'$condition' see Users '$usersNames' for category '$categoryName' on on Asset Categories and Permissions page")
    public void checkUsersPresentsOnAssetCategoriesAndPermissionsPage(String condition, String usersNames, String categoryName) {
        openCategoryPage(categoryName);
        checkUserNamesOnAssetCategoriesAndPermissionsPage(condition, usersNames);
    }

    @Then("{I |}'$condition' see $itemType '$itemsNames' in drop down on Add Users popup on Categories and Permissions page")
    public void checkThatItemPresentInDropDownOnAddUsersPopup(String condition, String itemType, String itemsNames) {
        boolean shouldState = condition.equals("should");
        List<String> actualItemsList = new ManagePermissionsPopUp(getSut().getPageCreator().getCategoriesPage()).getUsersDropDownListItems();

        if (itemType.equalsIgnoreCase("users")) {
            List<Map<String,String>> actualUsers = new ArrayList<Map<String, String>>();
            List<Map<String,String>> expectedUsers = new ArrayList<Map<String, String>>();

            for (String item : actualItemsList) {
                Map<String,String> userItems = new HashMap<String, String>();
                userItems.put("Name", item.split("\n")[0].trim());
                userItems.put("Email", item.split("\n")[1].trim());
                actualUsers.add(userItems);
            }

            for (String item : itemsNames.split(",")) {
                User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(item));
                Map<String,String> userItems = new HashMap<String, String>();
                userItems.put("Name", user.getFullName());
                userItems.put("Email", user.getEmail());
                expectedUsers.add(userItems);
            }

            for (Map<String,String> expectedUser : expectedUsers) assertThat(actualUsers, shouldState ? hasItem(expectedUser) : not(hasItem(expectedUser)));
        } else if (itemType.equalsIgnoreCase("library teams")) {
            List<String> actualTeams = new ArrayList<String>();
            for (String item : actualItemsList) actualTeams.add(item.split("\n")[0].trim());

            for (String expectedTeam : itemsNames.split(",")) {
                expectedTeam = wrapVariableWithTestSession(expectedTeam);
                assertThat(actualTeams, shouldState ? hasItem(expectedTeam) : not(hasItem(expectedTeam)));
            }
        } else {
            throw new IllegalArgumentException(String.format("Unknown item type: '%s'", itemType));
        }
    }

    // | CategoryName | Should |
    @Then("I should see following collections on administration area collections page: $categoriesState")
    public void checkVisibilityOfCategories(ExamplesTable categoriesState) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        List<String> actualCategoriesList = categoriesPage.getListOfCategoriesNames();

        for (Map<String, String> row : parametrizeTableRows(categoriesState)) {
            if (row.get("CategoryName") !=  null) {
                boolean shouldState = row.get("Should") != null && row.get("Should").equalsIgnoreCase("should");
                String expectedCategory = wrapVariableWithTestSession(row.get("CategoryName"));
                assertThat(actualCategoriesList, shouldState ? hasItem(expectedCategory) : not(hasItem(expectedCategory)));
            }
        }
    }

    // | Advertiser |
    @Then("{I |}'$condition' see '$categoryName' category with the following metadata: $metadata")
    public void checkThatMetadataDisplayed(String condition, String categoryName, ExamplesTable metadata) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();

        List<String> expectedMetadata = new ArrayList<String>();
        List<String> actualMetadata = new ArrayList<String>();

        for (String key : metadata.getHeaders()) actualMetadata.addAll(categoriesPage.getMetadataValueByItemName(key));

        for (Map<String, String> row : metadata.getRows()) {
            if (row.containsKey("Advertiser")) {
                Agency agency = getData().getAgencyByName(row.get("Advertiser"));
                expectedMetadata.add(agency == null ? wrapVariableWithTestSession(row.get("Advertiser")) : agency.getName());
            }
        }

        Collections.sort(actualMetadata);
        Collections.sort(expectedMetadata);

        assertThat(actualMetadata, shouldState ? equalTo(expectedMetadata) : not(equalTo(expectedMetadata)));
    }

    @Then("I '$condition' see empty drop down user list on 'Limit User' popup")
    public void checkThatPopupEmpty(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        ManagePermissionsPopUp managePermissionsPopUp = new ManagePermissionsPopUp(getSut().getPageCreator().getCategoriesPage());
        assertThat(managePermissionsPopUp.emptyDropDownUserList.isVisible(), is(shouldState));
    }



    @Then("I '$condition' see drop down user list with '$userNames' and '$userEmails' on 'Limit User' popup")
    public void checkThatPopupEmpty(String condition, String userNames, String userEmails) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String[] userNamesArray = userNames.split(",");
        String[] userEmailsArray = userEmails.split(",");

        if (userNamesArray.length == userEmailsArray.length) {
            List<String> usersList = new ManagePermissionsPopUp(getSut().getPageCreator().getCategoriesPage()).getUsersDropDownListItems();
            List<Map<String, String>> actualUsersList = new ArrayList<Map<String, String>>();

            Map<String, String> userData = new HashMap<String, String>();

            if (usersList.isEmpty()) {
                userData.put("Name", "");
                userData.put("Email", "");
                actualUsersList.add(userData);
            } else {
                for(String userItem : usersList) {
                    userData.put("Name", userItem.split("\n")[0]);
                    userData.put("Email", wrapUserEmailWithTestSession(userItem.split("\n")[1]));
                    actualUsersList.add(userData);
                }
            }

            for (int i = 0; i < userNamesArray.length; i++) {
                userData.put("Name", userNamesArray[i]);
                userData.put("Email", userEmailsArray[i].isEmpty() ? "" : wrapUserEmailWithTestSession(userEmailsArray[i]));
                assertThat(actualUsersList, shouldState ? hasItem(userData) : not(hasItem(userData)));
            }
        } else {
            throw new IllegalArgumentException(String.format("Arguments 'userNames', 'userEmails' should have equal length\n" +
                    "Actual: userNames='%s'\n" +
                    "        userEmails='%s'", userNames, userEmails));
        }
    }

    @Then("I '$condition' see selected user with name '$userNames' and email '$userEmails' in add user on 'Limit User' popup")
    public void checkThatUserSelected(String condition, String userName, String userEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> usersList = new ManagePermissionsPopUp(getSut().getPageCreator().getCategoriesPage()).getSelectedUsersList();
        List<String> actualUsersList = new ArrayList<String>();
        for (String user : usersList) actualUsersList.add(user.split("\n")[1]);
        if (userName.isEmpty() && userEmail.isEmpty()) {
            assertThat(actualUsersList.isEmpty(), is(shouldState));
        } else {
            String expectedUserName = String.format("%s %s", userName, wrapUserEmailWithTestSession(userEmail));
            assertThat(actualUsersList, shouldState ? hasItem(expectedUserName) : not(hasItem(expectedUserName)));
        }
    }

    @Then("{I |}'$condition' see the following roles for category '$categoryName' in dropdown box of 'Limit User' popup: $rolesTable")
    public void checkThatCategoryContainsRoles(String condition, String categoryName, ExamplesTable rolesTable) {
        getSut().getWebDriver().findElement(By.xpath("//a[@href='#roles']")).click(); // For NGN-14650
        CategoriesPage page1 = openCategoryPage(categoryName); // For NGN-14650
        boolean shouldState = condition.equalsIgnoreCase("should");
        selectCategory(categoryName);
        List<String> rolesList = getSut().getPageCreator().getCategoriesPage().openManageUsersPopup().getRolesList();

        for(Map<String, String> row : rolesTable.getRows()) {
            String roleName = wrapVariableWithTestSession(row.get("RoleName"));
            assertThat(rolesList, shouldState ? hasItem(roleName) : not(hasItem(roleName)));
        }
    }

    @Then("{I |}'$condition' see available item '$productName' on '$metadataKey' metadata drop down")
    public void checkThatProductAvailableForCategory(String condition, String productName, String metadataKey) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        productName = wrapVariableWithTestSession(productName);
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        categoriesPage.setMetaDataKey(metadataKey);
        Common.sleep(1000);
        List<String> availableProductsList = categoriesPage.getActiveMetadataValues();

        assertThat(availableProductsList, shouldState ? hasItem(productName) : not(hasItem(productName)));
    }

    // | Name | ShouldState |
    @Then("I should see for current category following values for metadata with key '$key': $valuesTable")
    public void checkListOfMetadataValues(String key, ExamplesTable valuesTable) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        List<String> listOfValues = categoriesPage.getMetadataValuesByKeyName(key);
        for(Map<String, String> row : valuesTable.getRows()) {
            boolean shouldState = row.get("ShouldState") != null && row.get("ShouldState").equalsIgnoreCase("should");
            assertThat(wrapVariableWithTestSession(row.get("Name")), shouldState ? isIn(listOfValues) : not(isIn(listOfValues)));
        }
    }

    @Then("{I |}'$condition' see user '$userName' on category '$categoryName' on category page pop-up")
    public void checkIfUserExist(String condition, String userName, String categoryName) {
        CategoriesPage page = openCategoryPage(categoryName);
        ManagePermissionsPopUp managePermissionsPopUp = page.openManageUsersPopup();
        userName = wrapUserEmailWithTestSession(userName);
        managePermissionsPopUp.setUser(wrapUserEmailWithTestSession(userName));
        List<String> userList = managePermissionsPopUp.getUsersDropDownListItems();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState;
        String userEmail;

        for (String anUserList : userList) {
            userEmail = anUserList.replaceAll("/.*", "").replaceAll(".*\n", "");
            actualState = userName.equalsIgnoreCase(userEmail);
            assertThat(shouldState, is(actualState));
        }
    }

    private CategoriesPage selectCategory(String categoryName) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        categoryName = categoryName.equalsIgnoreCase("Everything") || categoryName.equalsIgnoreCase("My Assets")
                ? categoryName
                : wrapVariableWithTestSession(categoryName);
        if (!categoriesPage.getActiveCategoryName().equalsIgnoreCase(categoryName))
            categoriesPage.selectCategoriesByName(categoryName);
        return categoriesPage;
    }

    protected static User wrapNameAndGetUser(String userName) {
        return getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
    }

    @When("{I |}select metadata filter name '$filterName' on opened administration area collections page")
    public void selectFilterName(String filterName) {
        getSut().getPageCreator().getCategoriesPage().setMetaDataKey(filterName);
        Common.sleep(1000);
    }

    @Then("{I |}'$condition' see metadata filter values '$filterValue' for filter name '$filterName' on opened administration area collections page")
    public void checkFilterValueAvailability(String condition, String expectedFilterValue, String filterName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        selectFilterName(filterName);
        List<String> actualFilterValues = getSut().getPageCreator().getCategoriesPage().getMetaDataValues();
        assertThat(actualFilterValues, shouldState ? hasItem(expectedFilterValue) : not(hasItem(expectedFilterValue)));
    }


    // | FilterName | FilterValue |
    @Given("{I |}added into category '$categoryName' following metadata with switched on mediatype '$mediaTypes': $data")
    @When("{I |}add into category '$categoryName' following metadata with switched on mediatype '$mediaTypes': $data")
    public void addMetadataIntoCategoryWithMediaType(String categoryName, String mediaTypes, ExamplesTable data) {
        openCategoryPage(categoryName);
        clickMediaTypeFilter("on", mediaTypes);
        addMetadataIntoOpenedCategory(data);
    }

    // | FilterName | FilterValue |
    @Given("{I |}added into category '$categoryName' following metadata: $data")
    @When("{I |}add into category '$categoryName' following metadata: $data")
    public void addMetadataIntoCategory(String categoryName, ExamplesTable data) {
        openCategoryPage(categoryName);
        addMetadataIntoOpenedCategory(data);
    }

    // | FilterName | FilterValue |
    @Given("{I |}added following metadata on opened category page: $data")
    @When("{I |}add following metadata on opened category page: $data")
    public void addMetadataIntoOpenedCategory(ExamplesTable data) {
        CategoriesPage page = getSut().getPageCreator().getCategoriesPage();

        for (MetadataItem row : wrapMetadataFields(data, "FilterName", "FilterValue")) {
            for (String value : row.getValue().split(","))
                page.addFilter(row.getKey(), value);
        }

        page.clickSaveButton();
    }

    @Then("{I |}'$shouldState' see that filter '$filterName' has value '$filterValue' on opened category page")
    public void checkFilterValue(String shouldState, String filterName, String filterValue) {
        CategoriesPage page = getSut().getPageCreator().getCategoriesPage();
        boolean state = shouldState.equalsIgnoreCase("Should");
        String value = filterName.equalsIgnoreCase("Business Unit")?wrapAgencyName(filterValue):wrapVariableWithTestSession(filterValue);
        assertThat(page.isAddedFilterValuePresent(filterName, value), equalTo(state));
    }


    // | FilterName | FilterValue |
    @Then("{I |}'$condition' see following metadata for category '$categoryName' on Categories and Permissions page: $data")
    public void checkCategoryMetadata(String condition, String categoryName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> actualFiltersList = openCategoryPage(categoryName).getAddedFilters();

        for (MetadataItem expectedFilter : wrapMetadataFields(data, "FilterName", "FilterValue"))
            assertThat(actualFiltersList, shouldState ? hasItem(expectedFilter) : not(hasItem(expectedFilter)));
    }

    // | FilterName |
    @Then("{I |}'$condition' see following available metadata filters on opened category page: $data")
    public void checkAvailableFilterNamesForSearch(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFilterNames = getSut().getPageCreator().getCategoriesPage().getAvailableFiltersList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            assertThat(actualFilterNames, shouldState ? hasItem(row.get("FilterName")) : not(hasItem(row.get("FilterName"))));
        }
    }

    // | Name |
    @Then("{I |}'$condition' see collections sorted in following order on opened Categories and Permissions page: $data")
    public void checkCollectionsSorting(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> expectedCollections = new ArrayList<>();
        for (Map<String,String> row : parametrizeTableRows(data)) {
            if (!row.get("Name").equalsIgnoreCase("My Assets") && !row.get("Name").equalsIgnoreCase("Everything")) {
                expectedCollections.add(wrapVariableWithTestSession(row.get("Name")));
            } else {
                expectedCollections.add(row.get("Name"));
            }
        }

        List<String> actualCollections = getSut().getPageCreator().getCategoriesPage().getListOfCategoriesNames();

        for (int i = 0; i < expectedCollections.size(); i++) {
            assertThat(actualCollections.get(i), shouldState ? equalTo(expectedCollections.get(i)) : not(equalTo(expectedCollections.get(i))));
        }
    }

    @Then("{I |}'$condition' see parameter in Usage Rights in category '$categoryName': $data")
    public void checkParameterExist(String condition, String categoryName, ExamplesTable data) {
        CategoriesPage page = openCategoryPage(categoryName);
        boolean state = condition.equals("should");
        boolean isElementExist = false;
        for (Map<String,String> row : parametrizeTableRows(data)) {
            isElementExist = page.isElementExist(row.get("UsageRight"), row.get("FilterKey"));
        }
        assertThat(state, is(isElementExist));
    }

    @Then("{I |}'$condition' see following categories '$categories' on Categories admin area page")
    public void checkCategoryTrees(String condition, String categories) {
        boolean actualState = condition.equalsIgnoreCase("should");
        boolean expectedState;
        CategoriesPage page = getSut().getPageCreator().getCategoriesPage();

        for (String category : categories.split(",")) {
            expectedState = page.isCategoryExist(wrapVariableWithTestSession(category));
            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see following metadata fields for asset type '$assetType' on Categories admin area page:$data")
    public void checkDropdownForAssetSpecificMetadataFields(String condition, String assetType, ExamplesTable data) {
        CategoriesPage categoriesPage = getSut().getPageCreator().getCategoriesPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            List<String> expectedMetadataFields = new ArrayList<>();
            List<String> actualMetadataFields = categoriesPage.getMetadataFields(assetType.toLowerCase());
            for(String expected: row.get("Metadata Fields").split(";")) {
                expectedMetadataFields.add(expected);
            }
            String[] valuesArray = row.get("Metadata Fields").split(";");

    assertThat(categoriesPage.verifyAssetTypeMetaDataFieldPresent(assetType),is(condition.equalsIgnoreCase("should")));
    assertThat(actualMetadataFields,condition.equalsIgnoreCase("should")?hasItems(valuesArray):not(hasItems(valuesArray)));
        }
    }
}