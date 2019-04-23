package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_modified;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.data.UsageRule;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectsListPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.library.collections.AdbankLibraryPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.library.elements.*;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.lang.StringUtils;
import org.hamcrest.Matcher;
import org.jbehave.core.annotations.*;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import javax.xml.bind.JAXBException;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.*;
import java.util.regex.Pattern;
import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.is;

/**
 * User: ruslan.semerenko
 * Date: 04.09.12 13:00
 */
public class LibrarySteps extends BaseStep {
    private static final int ASSETS_ON_PAGE = 20;

    protected Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    protected Project getTemplateByName(String templateName) {
        return getCoreApi().getTemplateByName(templateName);
    }

    private AdbankLibraryPage getLibraryPage() {
        return getSut().getPageCreator().getLibraryPage();
    }

    @Given("{I am |}on {the|} {L|l}ibrary page")
    @When("{I |}go to {the|} {L|l}ibrary page")
    @Then("{I |}go to {the|} {L|l}ibrary page")
    public AdbankLibraryPage openLibraryPage() {
        //without refresh, at the page doesn't displayed added in scenarios elements
        getSut().getWebDriver().navigate().refresh();
        Common.sleep(5000);
        return getSut().getPageNavigator().getLibraryPage("");
    }
// NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code starts

    @Then("{I } '$condition' see '$tab' tab on Library page")
    public void checkTabVisibilityon(String condition, String tab){
        boolean shouldState=condition.equalsIgnoreCase("should");
        AdbankLibraryPage LibraryFilesListPage = openLibraryPage();
        boolean actualState=LibraryFilesListPage.isTabVisible(tab);
        assertThat(shouldState, equalTo(actualState));
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends

    @Given("{I am |}on {the|} {L|l}ibrary page for collection '$categoriesName'")
    @When("{I |}go to {the|} {L|l}ibrary page for collection '$categoriesName'")
    public AdbankLibraryPage openLibraryPage(String categoriesName) {
        String collectionName = wrapCollectionName(categoriesName);
        getSut().getWebDriver().navigate().refresh();     //without refresh, at the page doesn't displayed added in scenarios elements
        return getSut().getPageNavigator().getLibraryPage(getCategoryId(collectionName));
    }

    @Given("{I am |}on {the|} {L|l}ibrary page via UI")
    @When("{I |}go to {the|} {L|l}ibrary page via UI")
    public void openLibraryPageForClient() {
        getSut().getWebDriver().navigate().refresh();
        getSut().getWebDriver().findElement(By.cssSelector(".link[href=\"/streamlined-library-beta\"]")).click();
        Common.sleep(500);
    }

    // | Name | Advertiser | ParentCategory |
    @Given("{I |}created following collections: $collectionsTable")
    @When("{I |}create following collections: $collectionsTable")
    public void createNewCategories(ExamplesTable collectionsTable) {
        //"query":"{\"and\":[{\"terms\":{\"enums.advertiser.$id\":[\"504e3429e4b01113e363dd14\"]}},{\"terms\":{\"enums.product.$id\":[\"504e7ed6e4b01113e3643885\"]}},{\"terms\":{\"enums.campaign.$id\":[\"504e342ae4b01113e363dd1a\"]}}]}"
        for (int i = 0; i < collectionsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(collectionsTable, i);
            String name = row.get("Name");
            AssetFilter category = getCoreApi().getAssetsFilterByName(wrapVariableWithTestSession(name), "");
            if (category == null || category.getId() == null) {
                String parentCategoryId = getCategoryId(row.get("ParentCategory") == null || row.get("ParentCategory").isEmpty() ? "My Assets" : wrapCollectionName(row.get("ParentCategory")));
                JsonArray and = new JsonArray();
                addTermToCollectionQuery(and, "_cm.common.mediaType", row.get("MediaType"), true);
                addTermToCollectionQuery(and, "_cm.common.mediaSubType", row.get("MediaSubType"), true);
                addTermToCollectionQuery(and, "categories", parentCategoryId, false);

                JsonObject jsonQuery = new JsonObject();
                jsonQuery.add("and", and);

                getCoreApi().createAssetFilterCollection(wrapVariableWithTestSession(name), jsonQuery.toString());
                getCoreApi().getAssetsFilterByName(wrapVariableWithTestSession(name), "");
            }
        }
    }

    @Given("{I |}scrolled down to footer '$times' times on opened Library page")
    @When("{I |}scroll down to footer '$times' times on opened Library page")
    public void scrollDownToFooter(int times) {
        for (int i = 0; i < times; i++) getLibraryPage().scrollDownToFooter();
    }

    private void addTermToCollectionQuery(JsonArray terms, String field, String value, boolean encloseInTerms) {
        if (value != null && !value.isEmpty()) {
            JsonArray arr = new JsonArray();
            arr.add(new JsonPrimitive(value));
            JsonObject term = new JsonObject();
            term.add(field, arr);
            if (encloseInTerms) {
                JsonObject obj = new JsonObject();
                obj.add("terms", term);
                terms.add(obj);
            } else {
                terms.add(term);
            }
        }
    }

    // | Name |
    @When("I delete following collections from library page: $collectionNames")
    public void deleteCollections(ExamplesTable data) {
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.removeCollection(getCategoryId(wrapCollectionName(row.get("Name"))));
            getSut().getWebDriver().navigate().refresh();  // fixed node is null
        }
    }

    // | Advertiser | Category |
    @Given("{I |}created new collection '$collectionName' on the library page with following metadata: $metadataTable")
    @When("{I |}create new collection '$collectionName' on the library page with following metadata: $metadataTable")
    public void createNewCollection(String collectionName, ExamplesTable metadataTable) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        libraryPage.clickAdvancedLink();
        for (int i = 0; i < metadataTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadataTable, i);
            if(row.get("Business Unit") != null) {
                fillMetadataKeyAndValue(libraryPage, "Business Unit", row.get("Business Unit").equalsIgnoreCase("DefaultAgency") ? getAgencyByName("DefaultAgency").getName() : wrapAgencyName(row.get("Business Unit")));
            }
            if (row.get("Advertiser") != null) {
                fillMetadataKeyAndValue(libraryPage, "Advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
            }
            if(row.containsKey("Campaign")) {
                if ((row.get("Campaign") != null) & (!row.get("Campaign").equalsIgnoreCase("DefaultCampaign"))) {
                    fillMetadataKeyAndValue(libraryPage, "Campaign", (row.get("Campaign")));
                }
                else {
                    fillMetadataKeyAndValue(libraryPage, "Campaign", wrapVariableWithTestSession(row.get("Campaign")));
                }
            }
            if (row.get("Category") != null) {
                String categoryName;
                if ((row.get("Category").equalsIgnoreCase("My Assets") || (row.get("Category").equalsIgnoreCase("Everything")))) {
                    categoryName = row.get("Category");
                } else {
                    categoryName = wrapVariableWithTestSession(row.get("Category"));
                }

                if (libraryPage.isMetadataKeyDisabled("Collection")) {
                    libraryPage.clickDeleteMetadataByValue(libraryPage.getDisabledMetaDataValueSelectedLabel("Collection"));
                }

                fillMetadataKeyAndValue(libraryPage, "Collection", categoryName);
            }
        }

        CreateNewCollectionPopUp newCollectionPopUp = libraryPage.clickSaveAsACollection();
        newCollectionPopUp.setCollectionName(wrapVariableWithTestSession(collectionName)).action.click();
    }

    @Given("{I |}created new collection '$collectionName' on the library page")
    @When("{I |}create new collection '$collectionName' on the library page")
    public void createNewCollection(String collectionName) {
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        Common.sleep(3000);
        page.clickAdvancedLink();
        CreateNewCollectionPopUp popup = page.clickSaveAsACollection();
        popup.setCollectionName(wrapVariableWithTestSession(collectionName)).action.click();
    }

    @Given("{I |}typed collection name '$collectionName' on opened Add to collection popup")
    @When("{I |}type collection name '$collectionName' on opened Add to collection popup")
    public void typeCollectionName(String collectionName) {
        new AddToCollectionPopUp(getLibraryPage()).typeCollectionName(wrapVariableWithTestSession(collectionName));
    }

    @Given("{I |}saved changes for current collection")
    @When("{I |}save changes for current collection")
    public void saveCollection() {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        libraryPage.clickAdvancedLink();
        libraryPage.clickSaveButton();
    }

    @When("{I |}save new collection '$collectionName' on the library page")
    public void saveNewCollection(String collectionName) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        CreateNewCollectionPopUp newCollectionPopUp = libraryPage.clickSaveAsACollection();
        newCollectionPopUp.setCollectionName(wrapVariableWithTestSession(collectionName)).action.click();
    }

    // | FilterName | FilterValue |
    @Given("{I |}filled following metadata on opened library collection page: $data")
    @When("{I |}fill following metadata on opened library collection page: $data")
    public void fillCollectionFiltersForm(ExamplesTable data) {
        clickAdvancedLink();

        for (MetadataItem row : wrapMetadataFields(data, "FilterName", "FilterValue")) {
            for (String value : row.getValue().split(","))
                getLibraryPage().addFilter(row.getKey(), value);
        }
    }

    @Then("{I |}'$shouldState' see that filter '$filterName' has value '$filterValue' on opened library collection page")
    public void checkFilterValue(String shouldState, String filterName, String filterValue) {
        boolean state = shouldState.equalsIgnoreCase("Should");
        String value = filterName.equalsIgnoreCase("Business Unit")?wrapAgencyName(filterValue):wrapVariableWithTestSession(filterValue);
        assertThat(getLibraryPage().isAddedFilterValuePresent(filterName, value), equalTo(state));
    }

    // | FilterName | FilterValue |
    @Given("{I |}added into collection '$collectionName' following metadata with switched on mediatype '$mediaTypes': $data")
    @When("{I |}add into collection '$collectionName' following metadata with switched on mediatype '$mediaTypes': $data")
    public void addMetadataIntoCategoryWithMediaType(String collectionName, String mediaTypes, ExamplesTable data) {
        openLibraryPage(collectionName);
        clickMediaTypeFilter("on", mediaTypes);
        fillCollectionFiltersForm(data);
        saveCollection();
    }

    // | FilterName | FilterValue |
    @Given("{I |}created collection '$collectionName' from '$categoryName' with following metadata and switched on mediatype '$mediaTypes': $data")
    @When("{I |}create collection '$collectionName' from '$categoryName' with following metadata and switched on mediatype '$mediaTypes': $data")
    public void createCollectionFromCategoryWithMetadataAndMediaFilter(String collectionName, String categoryName, String mediaTypes, ExamplesTable data) {
        openLibraryPage(categoryName);
        clickMediaTypeFilter("on", mediaTypes);
        fillCollectionFiltersForm(data);
        saveNewCollection(collectionName);
    }

    // | FilterName | FilterValue |
    @Given("{I |}created collection '$collectionName' from '$categoryName' with following metadata on library page: $data")
    @When("{I |}create collection '$collectionName' from '$categoryName' with following metadata on library page: $data")
    public void createCollectionFromCategoryWithMetadata(String collectionName, String categoryName, ExamplesTable data) {
        openLibraryPage(categoryName);
        fillCollectionFiltersForm(data);
        saveNewCollection(collectionName);
    }

    @Given("{I |}switched '$state' media type filter '$filterName' on the page {L|l}ibrary")
    @When("{I |}switch '$state' media type filter '$filterName' on the page Library")
    public void clickMediaTypeFilter(String state, String filterName) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        String[] arrayFilterName = filterName.split(",");
        for (String fN : arrayFilterName) {
            if (fN.isEmpty()) continue;
            libraryPage.switchFilterInNeedState(fN, state);
            Common.sleep(3000);
        }
    }

    @Given("{I |}selected mediaSubType '$value' on the library page")
    @When("{I |}select mediaSubType '$value' on the library page")
    public void selectMediaSubType(String value) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        if (value.contains("'"))
            value = value.substring(0, value.indexOf("'") - 1);
        libraryPage.selectMediaSubType(value);
        Common.sleep(3000);
    }


    // enabledFilters comma separated
    // possible values: IMAGE, AUDIO, VIDEO, PRINT, DIGITAL
    @When("{I |}select media type filters '$enabledFilters' on the library page")
    public void selectLibraryMediaFilters(String enabledFilters) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        List<AdbankFilesPage.MediaType> enabledTypes = new ArrayList<>();
        for (String enabledFilter : enabledFilters.split(",")) {
            if (enabledFilter.isEmpty()) {
                continue;
            }
            enabledTypes.add(AdbankFilesPage.MediaType.valueOf(enabledFilter.trim().toUpperCase()));
        }
        for (AdbankFilesPage.MediaType mediaType : AdbankFilesPage.MediaType.values()) {
            libraryPage.setMediaTypeFilterEnabled(mediaType, enabledTypes.contains(mediaType));
        }
    }

    @When("{I |}remove metadata with key '$key' from library page")
    public void testRemoveMetadataFromCurrentCollection(String key) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        int num = libraryPage.getNumOfMetadataRow(key);
        libraryPage.clickDeleteMetadataByNum(num);
    }

    @When("{I |}select collection '$collectionName' on the library page")
    public void selectCollection(String collection) {
        getSut().getPageNavigator().getLibraryPage().selectCollection(wrapCollectionName(collection));
    }

    @When("{I |}select collection '$collectionName' on the library page via UI")
    public void selectCollectionUI(String collection) {
        getSut().getPageNavigator().getLibraryPage().selectCollectionUI(wrapCollectionName(collection));
    }

    @When("I click save metadata button for current collection on the library page")
    public void clickSaveButton() {
        getSut().getPageNavigator().getLibraryPage().clickSaveButton();
    }

    @Given("{I |}selected all assets on the library page")
    @When("{I |}select all assets on the library page")
    public void clickSelectAll() {
        getSut().getPageCreator().getLibraryPage().clickSelectAll();
    }

    @Given("{I |}clicked advanced link on the library page")
    @When("{I |}click advanced link on the library page")
    public void clickAdvancedLink() {
        getSut().getPageNavigator().getLibraryPage().clickAdvancedLink();
    }

    @When("I select metadata key '$key' on the library page")
    public void selectMetadataKey(String key) {
        getSut().getPageNavigator().getLibraryPage().setMetaDataKey(key);
    }

    @When("I click close button on the library page")
    public void clickCloseButton() {
        getSut().getPageNavigator().getLibraryPage().clickCloseButton();
    }

    @When("{I |}click add to existing presentation button on library page")
    public void clickAddToExistingPresentation() {
        getSut().getPageNavigator().getLibraryPage().clickAddToExistingPresentation();
    }

    @When("{I |}select '$count' assets on library page")
    public void selectSomeFiles(String count) {
        getSut().getPageNavigator().getLibraryPage().selectSomeFiles(Integer.parseInt(count));
    }

    @Given("{I |}selected asset '$assetName' in the current library page")
    @When("{I |}select asset '$assetName' in the current library page")
    public void selectAssets(String assetName) {
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage();
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
    }

    @Given("{I |}clicked Add to Work Request button on opened library page")
    @When("{I |}click Add to Work Request button on opened library page")
    public void clickAddToWorkRequestButton() {
        getSut().getPageCreator().getLibraryPage().clickAddToWorkRequestButton();
    }

    @Given("{I |}selected last uploaded by user '$userName' assets '$fileNames' on library page for category '$categoryName'")
    @When("{I |}select last uploaded by user '$userName' assets '$fileNames' on library page for category '$categoryName'")
    public void selectUserAssets(String userName, String fileNames, String categoryName) {
        String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage(collectionId);

        for (String fileName : fileNames.split(",")) {
            Content asset = getLastUploadedUserAsset(collectionId, userId, fileName);
            if (asset == null)
                asset = getLastUploadedUserAsset(collectionId, userId, wrapVariableWithTestSession(fileName));
            page.selectFileByFileId(asset.getId());
        }
    }

    @Given("{I |}added following assets '$assets' to collection '$toCollection' from collection '$fromCollection'")
    @When("{I |}add following assets '$assets' to collection '$toCollection' from collection '$fromCollection'")
    public void addAssetsToCollection(String assetName, String toCollection, String fromCollection) {
        AdbankLibraryPage page = openLibraryPage(fromCollection);
        selectAssets(assetName);
        AddToCollectionPopUp popup = page.clickAddToCollection();
        popup.setCollectionName(wrapVariableWithTestSession(toCollection)).action.click();

    }

    @Given("{I |}added asset '$assetName' into new presentation '$presentationName' with description '$descriptionName'")
    @When("{I |}add asset '$assetName' into new presentation '$presentationName' with description '$descriptionName'")
    public void addAssetToNewPresentation(String assetName, String presentationName, String descriptionName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        for (String fileName : assetName.split(","))
            libraryPage.selectFileByFileName(fileName);
        libraryPage.clickAddToPresentationButton();
        AddNewPresentationPopUpWindow newPresentationPopUpWindow = libraryPage.clickAddToNewPresentation();
        newPresentationPopUpWindow.setName(wrapVariableWithTestSession(presentationName));
        newPresentationPopUpWindow.setDescription(descriptionName);
        newPresentationPopUpWindow.save();
        Common.sleep(3000);
        getSut().getWebDriver().navigate().refresh(); // workaround for ORD-448
    }


    @Then("{I |}on selecting '$assetName' Add to new presentation is '$enabledState'")
    public void checkaddAssetToNewPresentationEnabled(String assetName,String enabledState)
    {
        boolean isEnabled = enabledState.equalsIgnoreCase("enabled");
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        for (String fileName : assetName.split(","))
            libraryPage.selectFileByFileName(fileName);
        assertThat("Add to Presentation", libraryPage.checkAddToPresentationButtonEnabled(), not(equalTo(isEnabled)));

    }

    @Given("{I |}clicked Download button on library page")
    @When("{I |}click Download button on library page")
    public void clickDownloadButton() {
        getSut().getPageNavigator().getLibraryPage().clickDownloadOnLibrary();
    }

    @When("{I |}select checkbox '$checkbox' and click download on library page download popup")
    public void selectCheckboxesForDownload(String checkbox) {
        DownloadFilePopUpWindow downloadFilePopUpWindow = new DownloadFilePopUpWindow(getSut().getPageNavigator().getLibraryPage());
        if (checkbox.equalsIgnoreCase("master")) {
            downloadFilePopUpWindow.selectDownloadMaster();
        } else if (checkbox.equalsIgnoreCase("proxy")) {
            downloadFilePopUpWindow.selectDownloadProxy();
        } else if (checkbox.equalsIgnoreCase("master,proxy")) {
            downloadFilePopUpWindow.selectDownloadMaster();
            downloadFilePopUpWindow.selectDownloadProxy();
        } else {
            throw new IllegalArgumentException("Wrong argument exeption: " + checkbox + "Should be only: master,proxy");
        }
        downloadFilePopUpWindow.clickDownloadButton();
    }

    @Then("{I |}'$condition' see pop-up '$button' for file '$fileName' on library page")
    public void checkAddToPresentationButton(String condition, String button, String fileName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = false;
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        libraryPage.selectFileByFileName(fileName);
        libraryPage.clickAddToPresentationButton();

        if (button.equalsIgnoreCase("Add to new presentation")) {
            actualState = libraryPage.clickAddToNewPresentation().isPopUpVisible();
        }
        else if (button.equalsIgnoreCase("Add to exist presentation")) {
            actualState = libraryPage.clickAddToExistingPresentation().isPopUpVisible();
        }

        assertThat("Button state must be %b" + shouldState, shouldState == actualState);
    }

    @Given("{I |}added last uploaded by user '$user' asset '$files' into new presentation '$presentation' on library page for collection '$category'")
    @When("{I |}add last uploaded by user '$user' asset '$files' into new presentation '$presentation' on library page for collection '$category'")
    @Alias("{I |}add accepted by user '$user' asset '$files' into new presentation '$presentation' on library page for collection '$category'")
    public void addUserAssetToNewPresentation(String user, String files, String presentation, String category) {
        selectUserAssets(user, files, category);

        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        page.clickAddToPresentationButton();

        AddNewPresentationPopUpWindow popup = page.clickAddToNewPresentation();
        popup.setName(wrapVariableWithTestSession(presentation));
        popup.action.click();
        Common.sleep(1000);
    }

    @Given("I created new presentation with name '$presentationName' and description '$description'")
    @When("I create new presentation with name '$presentationName' and description '$description'")
    public void createNewPresentation(String presentationName, String descriptionName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        libraryPage.clickAddToPresentationButton();
        AddNewPresentationPopUpWindow newPresentationPopUpWindow = libraryPage.clickAddToNewPresentation();
        newPresentationPopUpWindow.setName(wrapVariableWithTestSession(presentationName));
        newPresentationPopUpWindow.setDescription(descriptionName);
        newPresentationPopUpWindow.action.click();
        Common.sleep(1000);
    }

    @Given("I '$action' add new presentation with name '$presentationName' and description '$description'")
    @When("I '$action' add presentation with name '$presentationName' and description '$description'")
    public void crossCancelCreateNewPresentation(String action, String presentationName, String descriptionName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        libraryPage.clickAddToPresentationButton();
        AddNewPresentationPopUpWindow newPresentationPopUpWindow = libraryPage.clickAddToNewPresentation();
        newPresentationPopUpWindow.setName(wrapVariableWithTestSession(presentationName));
        newPresentationPopUpWindow.setDescription(descriptionName);
        if (action.equalsIgnoreCase("Cross")) newPresentationPopUpWindow.close.click();
        else if (action.equalsIgnoreCase("Cancel")) newPresentationPopUpWindow.cancel.click();
        else Assert.fail("Please verify example parametrs!");
        Common.sleep(1000);
    }

    @Given("I '$action' add into existing presentation with name '$presentationName'")
    @When("I '$action' add into existing presentation with name '$presentationName'")
    public void crossCancelCreateExistingPresentation(String action, String presentationName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        libraryPage.clickAddToPresentationButton();
        AddExistingPresentationPopUpWindow existingPresentationPopUpWindow = libraryPage.clickAddToExistingPresentation();
        existingPresentationPopUpWindow.clickPresentation(getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId());
        if (action.equalsIgnoreCase("Cross")) existingPresentationPopUpWindow.close.click();
        else if (action.equalsIgnoreCase("Cancel")) existingPresentationPopUpWindow.cancel.click();
        else Assert.fail("Please verify example parametrs!");
        Common.sleep(1000);

    }

    @Given("{I |}added asset '$assetName' into existing presentation '$presentationName'")
    @When("{I |}add asset '$assetName' into existing presentation '$presentationName'")
    public void addAssetToExistingPresentation(String assetNames, String presentationNames) {
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage();
        for (String assetName : assetNames.split(",")) page.selectFileByFileName(assetName);
        page.clickAddToPresentationButton();
        AddExistingPresentationPopUpWindow popup = page.clickAddToExistingPresentation();

        for (String presentationName : presentationNames.split(","))
            popup.clickPresentation(getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId());
        popup.action.click();
        Common.sleep(2000);
    }

    @Given("{I |}added last uploaded by user '$user' asset '$files' into existing presentation '$presentations' on library page for collection '$category'")
    @When("{I |}add last uploaded by user '$user' asset '$files' into existing presentation '$presentations' on library page for collection '$category'")
    public void addUserAssetToExistingPresentation(String user, String files, String presentations, String category) {
        selectUserAssets(user, files, category);

        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        page.clickAddToPresentationButton();

        AddExistingPresentationPopUpWindow popup = page.clickAddToExistingPresentation();

        for (String presentation : presentations.split(","))
            popup.clickPresentation(getCoreApi().getReelByName(wrapVariableWithTestSession(presentation)).getId());

        popup.action.click();
        Common.sleep(1000);
    }

    // | Asset | Presentation |
    @Given("{I |}added following assets into following existing presentations: $dateTable")
    @When("{I |}add following assets into following existing presentations: $dateTable")
    public void addAssetToExistingPresentation(ExamplesTable dateTable) {
        for (int i = 0; i < dateTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(dateTable, i);
            if (!getSut().getWebDriver().getCurrentUrl().contains("library#collections")) openLibraryPage();
            addAssetToExistingPresentation(row.get("Asset"), row.get("Presentation"));
        }
    }

    @When("{I |}search by text '$text' in library")
    public void searchText(String text) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        libraryPage.searchObject(text);
    }

    @When("{I |}click More button on library page for collection '$collection'")
    public void clickMoreButton(String collection) {
        openLibraryPage(collection).clickMoreButton();
    }

    @When("{I |}click More button on opened library page")
    public void clickMoreButton() {
        getSut().getPageCreator().getLibraryPage().clickMoreButton();
    }

    @Given("{I |}clicked Edit Usage Rights button from More drop down")
    @When("{I |} click Edit Usage Rights button from More drop down")
    public AdbankBatchUsageRightEditPopUp openEditUsageRightsPopUp(){
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        page.clickMoreButton();
        page.clickEditUsageRightsButtonFromMoreDropDown();
        return new AdbankBatchUsageRightEditPopUp(page);
    }

    @Given("{I |}added Batch Usage Right '$usageRule' with following fields on opened Edit Usage Rights pop-up from library page: $data")
    @When("{I |}add Batch Usage Right '$usageRule' with following fields on opened Edit Usage Rights pop-up from library page: $data")
    public void addUsageRightOnOpenedAssetUsageRightsPage(String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        AdbankBatchUsageRightEditPopUp popup = openEditUsageRightsPopUp();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            popup.openTabOnAdbankBatchUsageRightEditPopUp(usageRule);
            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty())
                row.put("StartDate", parseDateTime(row.get("StartDate")).toString(dateTimeFormatter));

            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty())
                row.put("ExpirationDate", parseDateTime(row.get("ExpirationDate")).toString(dateTimeFormatter));

            switch (usageRule) {
                case UsageRule.GENERAL:
                    popup.fillGeneralFields(row);
                    break;
                case UsageRule.COUNTRIES:
                    popup.fillCountriesFields(row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    popup.fillMediaTypesFields(row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    popup.fillVisualTalentFields(row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    popup.fillVoiceOverArtistFields(row);
                    break;
                case UsageRule.MUSIC:
                    popup.fillMusicFields(row);
                    break;
                case UsageRule.OTHER_USAGE:
                    popup.fillOtherUsageFields(row);
                    break;
            }

            if (row.get("NotifyIfExpired") != null && row.get("NotifyIfExpired").equals("true")) {
                popup.checkNotifyIfExpiredCheckbox(usageRule);
                popup.fillDaysFromExpireField(usageRule, row.get("DaysFromExpire"));

                if (row.get("IncludeTeam") != null && row.get("IncludeTeam").equals("true")) {
                    popup.checkIncludeTeamCheckbox(usageRule);
                }
            }

            popup.action.click();
            Common.sleep(2000);
        }
    }

    @When("{I |}click Remove button on opened library page")
    public void clickRemoveButton() {
        getSut().getPageCreator().getLibraryPage().clickRemoveButton();
    }

    @Given("{I |}removed asset '$assets' from library collection '$collection'")
    @When("{I |}remove asset '$assets' from library collection '$collection'")
    public void removeAssetFromCollection(String assets, String collection) {
        AdbankLibraryPage libraryPage = openLibraryPage(collection);

        for (String asset : assets.split(",")) {
            libraryPage.selectFileByFileName(asset);
        }

        libraryPage.clickMoreButton();
        libraryPage.clickRemoveButton().action.click();
        Common.sleep(2000);
    }

    @When("{I |}click Send to Delivery for assets '$assetsList' from library collection '$collection'")
    public void clickSendToDeliveryForAssets(String assetsList, String collection) {
        AdbankLibraryPage libraryPage = openLibraryPage(collection);
        for (String asset : assetsList.split(","))
            libraryPage.selectFileByFileName(getAssetName(asset));
        libraryPage.clickMoreButton();
        libraryPage.clickSendToDelivery();
    }

    @When("{I |}send following assets '$assetsList' from library collection '$collection' to Delivery")
    public void sendAssetsToDelivery(String assetsList, String collection) {
        AdbankLibraryPage libraryPage = openLibraryPage(collection);
        for (String asset : assetsList.split(","))
            libraryPage.selectFileByFileName(getAssetName(asset));
        libraryPage.clickMoreButton();
        libraryPage.sendToDelivery();
    }
    @When("{I |}send following assets '$assetsList' from library collection '$collection' to Delivery for '$locale' locale users")
    public void sendAssetsToDeliveryForlocale(String assetsList, String collection,String locale) {
        AdbankLibraryPage libraryPage = openLibraryPage(collection);
        for (String asset : assetsList.split(","))
            libraryPage.selectFileByFileName(getAssetName(asset));
        libraryPage.clickMoreButtonforOtherLocale();
        libraryPage.sendToDeliveryForOtherLocale(locale);
    }
    @Given("{I |}removed pinned asset '$assets' from collection '$collection'")
    @When("{I |}remove pinned asset '$assets' from collection '$collection'")
    public void removePinnedAssetFromCollection(String assets, String collection) {
        AdbankLibraryPage libraryPage = openLibraryPage(collection);

        for (String asset : assets.split(",")) {
            libraryPage.selectFileByFileName(asset);
        }

        libraryPage.clickMoreButton();
        libraryPage.clickRemoveFromCollectionButton().action.click();
        Common.sleep(2000);
    }

    @Given("{I |}remove selected assets from collection on opened library page")
    @When("{I |}remove selected assets from collection on opened library page")
    public void clickRemoveFromCollection() {
        getLibraryPage().clickMoreButton();
        getLibraryPage().clickRemoveFromCollectionButton().action.click();
    }

    @Given("{I |}removed last uploaded by user '$userName' asset '$assets' from library collection '$collection'")
    @When("{I |}remove last uploaded by user '$userName' asset '$assets' from library collection '$collection'")
    public void removeUserAssetFromCollection(String userName, String assets, String collection) {
        openLibraryPage(collection);
        removeUserAssetFromOpenedCollection(userName, assets, collection);
    }

    @Given("{I |}removed last uploaded by user '$userName' asset '$assets' from opened library collection '$collection'")
    @When("{I |}remove last uploaded by user '$userName' asset '$assets' from opened library collection '$collection'")
    public void removeUserAssetFromOpenedCollection(String userName, String assets, String collection) {
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        selectUserAssets(userName, assets, collection);
        page.clickMoreButton();
        page.clickRemoveButton().action.click();
        Common.sleep(2000);
    }

    @Given("{I |}removed last uploaded by user '$userName' asset '$assets' from library collection '$collection' with action '$action'")
    @When("{I |}remove last uploaded by user '$userName' asset '$assets' from library collection '$collection' with action '$action'")
    public void removeUserAssetWithConfirmationAction(String userName, String assets, String collection, String action) {
        AdbankLibraryPage page = openLibraryPage(collection);
        selectUserAssets(userName, assets, collection);
        page.clickMoreButton();
        PopUpWindow popup = page.clickRemoveButton();

        if (action.equalsIgnoreCase("remove")) {
            popup.action.click();
        } else if (action.equalsIgnoreCase("cancel")) {
            popup.cancel.click();
        } else if (action.equalsIgnoreCase("close")) {
            popup.close.click();
        }

        Common.sleep(2000);
    }

    @Given("{I |}removed selected assets from opened library page")
    @When("{I |}remove selected assets from opened library page")
    public void removeAssetFromCollectionFromOpenedLibraryPage() {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        libraryPage.clickMoreButton();
        libraryPage.clickRemoveButton().action.click();
        Common.sleep(2000);
    }

    @Given("{I |}removed asset '$assets' from current library collection")
    @When("{I |}remove asset '$assets' from current library collection")
    public void removeAssetFromCurrentCollection(String assets) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();

        for (String asset : assets.split(",")) {
            libraryPage.selectFileByFileName(asset);
        }

        libraryPage.clickMoreButton();
        libraryPage.clickRemoveButton().action.click();
    }

    @Given("{I |}removed asset '$assets' with '$action' confirmation action from current library collection")
    @When("{I |}remove asset '$assets' with '$action' confirmation action from current library collection")
    public void removeAssetWithConfirmationActionFromCurrentCollection(String assets, String action) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();

        for (String asset : assets.split(",")) libraryPage.selectFileByFileName(asset);
        libraryPage.clickMoreButton();
        PopUpWindow popup = libraryPage.clickRemoveButton();

        if (action.equalsIgnoreCase("ok")) {
            popup.action.click();
        } else if (action.equalsIgnoreCase("cancel")) {
            popup.cancel.click();
        } else if (action.equalsIgnoreCase("close")) {
            popup.close.click();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for confirmation popup", action));
        }
        Common.sleep(1000);
    }

    @When("{I |}rename library collection '$collectionName' to '$newCollectionName'")
    public void renameLibraryCategory(String collectionName, String newCollectionName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        libraryPage.renameCollection(collectionId, wrapCollectionName(newCollectionName));
        getSut().getWebDriver().navigate().refresh();
    }


    @Given("{I |}uploaded file '$fileName' into library")
    @Alias("{I |}uploaded asset '$assetName' into library")
    @When("{I |}upload file '$fileName' into library")
    @Then("{I |}upload file '$fileName' into library")
    public void uploadFileIntoLibrary(String fileNames) {
        String tableString = "| Name |";
        for (String fileName : fileNames.split(",")) {
            tableString += String.format("\n| %s |", fileName);
        }
        uploadAssets(ASSETS_ON_PAGE, new ExamplesTable(tableString));
    }

    @Given("{I |}appended file '$fileName' to library for collection '$collectionName' while file count less than '$expectedAssetsCount'")
    @When("{I |}append file '$fileName' to library for collection '$collectionName' while file count less than '$expectedAssetsCount'")
    public void appendFileIntoLibrary(String fileName, String collectionName, int expectedAssetsCount) {
        int actualAssetsCount = getCoreApi().getAssetCountForCollection(getCategoryId(wrapCollectionName(collectionName)));
        if (expectedAssetsCount > actualAssetsCount)
            uploadSimilarFilesIntoLibrary(fileName, expectedAssetsCount - actualAssetsCount);
    }

    @Given("{I |}uploaded file '$fileName' '$assetCount' times to library")
    @When("{I |}upload file '$fileName' '$assetCount' times to library")
    public void uploadSimilarFilesIntoLibrary(String fileName, int assetCount) {
        for (int i = 0; i < assetCount; i++) {
            createAsset(fileName);
        }
    }

    @Given("{I |}uploaded file '$fileName' into my library")
    @When("{I |}upload file '$fileName' into my library")
    public void uploadAssetIntoMyLibrary(String fileName) {
        uploadSimilarFilesIntoLibrary(fileName, 1);
    }

    @Given("{I |}uploaded following files into my library: $data")
    @When("{I |}upload following files into my library: $data")
    public void uploadAssetsIntoMyLibrary(ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            uploadAssetIntoMyLibrary(row.get("Name"));
        }
    }

    // | Name | AgencyName |
    @Given("{I |}uploaded following assets into following agencies: $data")
    @When("{I |}upload following assets into following agencies: $data")
    public void uploadAssetsIntoDifferentAgencies(ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            String agencyId = getCoreApiAdmin().getAgencyByName(wrapAgencyName(row.get("AgencyName"))).getId();
            createAsset(row.get("Name"), agencyId);
        }
    }


    @Given("{I |}deleted asset '$assetName' from collection '$collectionName' in Library")
    @When("{I |}delete asset '$assetName' from collection '$collectionName' in Library")
    public void deleteAssetFromLibrary(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        getCoreApi().deleteAsset(asset.getId());
    }

    @Given("{I |}deleted uploaded by user '$userName' asset '$assetName' from collection '$collectionName' in Library")
    @When("{I |}delete uploaded by user '$userName' asset '$assetName' from collection '$collectionName' in Library")
    public void deleteUserAssetFromLibrary(String userName, String assetName, String collectionName) {
        String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        getCoreApi().deleteAsset(getLastUploadedUserAsset(collectionId, userId, assetName).getId());
    }

    // | Name |
    @Given("{I |}uploaded following assets: $assetName")
    @When("{I |}upload following assets: $assetName")
    public void uploadAssets(ExamplesTable assetName) {
        uploadAssets(ASSETS_ON_PAGE, assetName);
    }

    @Given("{I |}uploaded following assets with find existing among '$count' assets: $assetName")
    @When("{I |}upload following assets with find existing among '$count' assets: $assetName")
    public void uploadAssets(int count, ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("Name") != null) {
                createAssetIfNotVisibleOnFirstPage(getCategoryId("My Assets"), row.get("Name"), count);
            }
        }
    }

    @Given("{I |}waited while transcoding is finished in collection '$collectionName'")
    @When("{I |}wait while transcoding is finished in collection '$collectionName'")
    public void waitWhileTranscodingIsFinished(String collectionName) {
        waitForSpecOrPreview(collectionName, null, false);
    }

    @Given("{I |}waiting while transcoding is finished in collection '$collectionName' for asset '$assetName'")
    public void waitUntilTranscodingFinishedForAsset(String collectionName, String assetName) {
        waitForSpecOrPreview(collectionName, assetName, false);
    }

    @Given("{I |}waited while preview is available in collection '$collectionName'")
    @When("{I |}wait while preview is available in collection '$collectionName'")
    public void waitWhilePreviewAvailableIsFinished(String collectionName) {
        waitForSpecOrPreview(collectionName, null, true);
    }

    private void waitForSpecOrPreview(String collectionName, final String assetName, boolean waitForPreview) {
        final String collectionId = getCategoryId(wrapCollectionName(collectionName));
        getSut().getPageNavigator().getLibraryPage(collectionId);
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                if (assetName == null) {
                    return getLastAssets(collectionId, ASSETS_ON_PAGE);
                } else {
                    return asList(getCoreApi().getAssetByName(collectionId, assetName));
                }
            }

            @Override
            public void doActionWhileWaiting() {
                getSut().getPageCreator().getLibraryPage();
            }
        }.process(waitForPreview);

        getSut().getWebDriver().navigate().refresh();
        getSut().getPageNavigator().getLibraryPage(collectionId);
    }

    @Given("{I |}waited while preview is visible on library page for collection '$collectionName' for asset '$assetName'")
    @When("{I |}wait while preview is visible on library page for collection '$collectionName' for asset '$assetName'")
    public void waitWhilePreviewIsVisible(String collectionName, String assetName) {
        waitForSpecOrPreview(collectionName, assetName, true);
    }

    @Given("{I |}waited while previews are visible on library page for collection '$collectionName' for asset '$assetName'")
    @When("{I |}wait while previews are visible on library page for collection '$collectionName' for asset '$assetName'")
    public void waitWhilePreviewsIsVisible(String collectionName, String assetName) {
        String[] fileArray = assetName.split(",");
        for (String file : fileArray) {
            waitForSpecOrPreview(collectionName, file, true);
        }
    }

    @Given("{I |}clicked following activity '$activity' on opened Library page")
    @When("{I |}click following activity '$activity' on opened Library page")
    public void clickOnActivity(String activity) {
        getLibraryPage().openAsset(activity);
        Common.sleep(1000);
    }

    @Given("{I |}waited while preview is visible on library collection '$collectionName' for asset id '$assetId'")
    @When("{I |}wait while preview is visible on library collection '$collectionName' for asset id '$assetId'")
    public void waitWhilePreviewIsVisibleForAssetId(String collectionName, String assetId) {
        waitWhilePreviewIsVisible(collectionName, wrapVariableWithTestSession(assetId));
    }

    @Given("{I |}waited while preview is visible on library page for collection '$collectionName' for assets '$assetNames'")
    @When("{I |}wait while preview is visible on library page for collection '$collectionName' for assets '$assetNames'")
    public void waitWhilePreviewIsVisibleForAssets(String collectionName, String assetNames) {
        for (String assetName : assetNames.split(",")) {
            waitWhilePreviewIsVisible(collectionName, assetName);
        }
    }

    // Name
    @When("{I |}wait while previews is visible on library page for collection '$collectionName' for the following assets: $assetTable")
    public void waitWhilePreviewsIsVisible(String collectionName, ExamplesTable assetTable) {
        for (Map<String, String> row : assetTable.getRows()) {
            waitWhilePreviewIsVisible(collectionName, row.get("Name"));
        }
    }

    @Given("{I |}waited while preview is visible on library page for collection '$collectionName' for assets: $assetName")
    @When("{I |}wait while preview is visible on library page for collection '$collectionName' for assets: $assetName")
    public void waitWhilePreviewIsVisible(String collectionName, ExamplesTable assetsTable) {
        for (int i = 0; i < assetsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(assetsTable, i);
            waitWhilePreviewIsVisible(collectionName, row.get("Name"));
        }
    }

    @When("{I |}select Sort By '$sortingBy' on the current library page")
    public void selectSortByValue(String sortingBy) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        libraryPage.setSortBy(sortingBy);
    }

    @When("{I |}changing title of asset '$assetName' to following title '$assetTitleNew' on library page for collection '$collectionName'")
    public void changeAssetTitle(String assetName, String assetTitleNew, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        asset.setName(assetTitleNew);
        getCoreApi().updateAsset(asset);
    }

    // | Name | SubType | Screen | AccountDirector | AgencyTVProducer | ArtDirector | Copywriter | CreativeDirector | Director | ExecutiveProducer | HeadOfTV | ProductionCompany | PrintMedia | PrintStatus |
    @Given("{I |}set following file info for next assets from collection '$collectionName': $assetsTable")
    @When("{I |}set following file info for next assets from collection '$collectionName': $assetsTable")
    public void setFileInfoForAssets(String collectionName, ExamplesTable assetsTable) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        for (int i = 0; i < assetsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(assetsTable, i);
            Content asset = getAsset(collectionId, row.get("Name"));

            if (row.get("SubType") != null && !row.get("SubType").isEmpty())
                asset.setMediaSubType(row.get("SubType"));
            if (asset.getMediaType().equals("video")) {
                if (row.get("Country") != null && !row.get("Country").isEmpty())
                    asset.setMetadataField("video", "country", row.get("Country"));
                if (row.get("Screen") != null && !row.get("Screen").isEmpty())
                    asset.setMetadataField("video", "screen", asList(row.get("Screen")));
                if (row.get("ClockNumber") != null && !row.get("ClockNumber").isEmpty())
                    asset.setMetadataField("video", "clockNumber", wrapVariableWithTestSession(row.get("ClockNumber")));
                if (row.get("AccountDirector") != null && !row.get("AccountDirector").isEmpty())
                    asset.setMetadataField("video", "accountDirector", row.get("AccountDirector"));
                if (row.get("AgencyTVProducer") != null && !row.get("AgencyTVProducer").isEmpty())
                    asset.setMetadataField("video", "agencyTVProducer", row.get("AgencyTVProducer"));
                if (row.get("ArtDirector") != null && !row.get("ArtDirector").isEmpty())
                    asset.setMetadataField("video", "artDirector", row.get("ArtDirector"));
                if (row.get("Copywriter") != null && !row.get("Copywriter").isEmpty())
                    asset.setMetadataField("video", "copywriter", row.get("Copywriter"));
                if (row.get("CreativeDirector") != null && !row.get("CreativeDirector").isEmpty())
                    asset.setMetadataField("video", "creativeDirector", row.get("CreativeDirector"));
                if (row.get("Director") != null && !row.get("Director").isEmpty())
                    asset.setMetadataField("video", "director", row.get("Director"));
                if (row.get("ExecutiveProducer") != null && !row.get("ExecutiveProducer").isEmpty())
                    asset.setMetadataField("video", "executiveProducer", row.get("ExecutiveProducer"));
                if (row.get("HeadOfTV") != null && !row.get("HeadOfTV").isEmpty())
                    asset.setMetadataField("video", "headOfTV", row.get("HeadOfTV"));
                if (row.get("ProductionCompany") != null && !row.get("ProductionCompany").isEmpty())
                    asset.setMetadataField("video", "productionCompany", row.get("ProductionCompany"));
            } else if (asset.getMediaType().equals("print")) {
                if (row.get("PrintMedia") != null && !row.get("PrintMedia").isEmpty())
                    asset.setMetadataField("print", "printMedia", asList(row.get("PrintMedia")));
                if (row.get("PrintStatus") != null && !row.get("PrintStatus").isEmpty())
                    asset.setMetadataField("print", "printStatus", asList(row.get("PrintStatus")));
            }

            getCoreApi().updateAsset(asset);
        }
    }

    @Given("{I |}patched following file info for next assets from collection '$collectionName': $assetsTable")
    @When("{I |}patch following file info for next assets from collection '$collectionName': $assetsTable")
    public void patchFileInfoForAssets(String collectionName, ExamplesTable assetsTable) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        for (int i = 0; i < assetsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(assetsTable, i);
            getCoreApi().patchAsset(getAsset(collectionId, row.get("Name")).getId(),row.get("Campaign"));
        }
    }

    // | UsageRight | FilterKey | FilterValue |
    @Given("{I |}created collection '$collectionName' based on category '$category' with following usage rights metadata: $data")
    @When("{I |}create collection '$collectionName' based on category '$category' with following usage rights metadata: $data")
    public void createSubCategoryWithMetadata(String collectionName, AssetFilter category, ExamplesTable data) {
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage(category.getId());
        createAssetFilter(data, page);
        page.clickSaveAsACollection().setCollectionName(wrapCollectionName(collectionName)).clickAction();
    }

    @When("{I |}created filter based on category '$category' with following usage rights metadata: $data")
    public void createAssetFilter(AssetFilter category, ExamplesTable data) {
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage(category.getId());
        createAssetFilter(data, page);
    }

    public void createAssetFilter(ExamplesTable data, AdbankLibraryPage page) {
        page.clickAdvancedLink();
        for (Map<String,String> row : parametrizeTableRows(data)) {
            if (row.get("FilterKey").equals("Start Date") || row.get("FilterKey").equals("Expire Date")) {
                row.put("FilterValue", parseDateTime(row.get("FilterValue")).toString(DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat())));
            }
            page.addUsageRightsFilter(row.get("UsageRight"), row.get("FilterKey"), row.get("FilterValue"));
        }
    }

    @Given("{I |}created collection '$collectionName' based on category '$categoryName' on library page")
    @When("{I |}create collection '$collectionName' based on category '$categoryName' on library page")
    public void createCollectionFromCategory(String collectionName, String categoryName) {
        collectionName = wrapVariableWithTestSession(collectionName);
        categoryName = wrapCollectionName(categoryName);
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage(getCategoryId(categoryName));
        page.clickAdvancedLink();
        page.clickSaveAsACollection().setCollectionName(collectionName).action.click();
    }

    @When("{I |}click add to collection on opened library page")
    public void clickAddToCollection() {
        getSut().getPageNavigator().getLibraryPage().clickAddToCollection();
    }

    @When("{I |}'$action' public url for asset '$fileName' in collection '$collectionName'")
    public void doActionWithPublicUrlForFile(String action, String fileName, String collectionName) {
        AdbankLibraryPage page = openLibraryPage(collectionName);
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectPublicShareTab();

        if (action.equalsIgnoreCase("Activate")) {
            popup.activatePublicLink();
        } else if (action.equalsIgnoreCase("Deactivate")) {
            popup.deactivatePublicLink();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action: '%s' for public url", action));
        }
    }

    // | Message | UserEmails | ExpireDate | DownloadProxy |
    // DownloadProxy and DownloadOriginal are not required properties and may be set as true or false
    @When("{I |}send public link of asset '$fileName' from collection '$collectionName' to following users: $data")
    public void sendPublicUrlOfFile(String fileName, String collectionName, ExamplesTable data) {
        AdbankLibraryPage page = openLibraryPage(collectionName);
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectPublicShareTab();
        Common.sleep(2000);
        popup.activatePublicLink();
        fillSharePopup(parametrizeTabularRow(data), false);
        popup.clickOKButton();
    }

    // | Message | UserEmails | ExpireDate | DownloadProxy | DownloadOriginal |
    // DownloadProxy and DownloadOriginal are not required properties and may be set as true or false
    @Given("{I |}added secure share for asset '$fileName' from collection '$collectionName' to following users: $data")
    @When("{I |}added secure share for asset '$fileName' from collection '$collectionName' to following users: $data")
    public void addSecureShareOfFileOverCore(String fileName, AssetFilter collection, ExamplesTable data) {
        Map<String, String> fields = parametrizeTabularRow(data);
        DateTime expirationDate = parseDateTime(fields.get("ExpireDate"));
        boolean downloadProxy = Boolean.parseBoolean(fields.get("DownloadProxy"));
        boolean downloadOriginal = Boolean.parseBoolean(fields.get("DownloadOriginal"));
        Content asset = getAsset(collection.getId(), fileName);
        List<String> users = new ArrayList<>();
        for (String email : fields.get("UserEmails").split(",")) {
            users.add(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(email)).getId());
        }
        getCoreApi().shareAsset(Arrays.asList(asset.getId()), users, expirationDate, fields.get("Message"), downloadProxy, downloadOriginal);
    }

    // | Message | UserEmails | ExpireDate | DownloadProxy | DownloadOriginal |
    // DownloadProxy and DownloadOriginal are not required properties and may be set as true or false
    @When("{I |}add secure share for asset '$fileName' from collection '$collectionName' to following users: $data")
    public void addSecureShareOfFile(String fileName, String collectionName, ExamplesTable data) {
        AdbankLibraryPage page = openLibraryPage(collectionName);
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectStareTab();
        fillSharePopup(parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }

    @When("{I |}add secure share for asset without download permission '$fileName' from collection '$collectionName' to following users: $data")
    public void addSecureShareOfFileWithoutDownloadpermission(String fileName, String collectionName, ExamplesTable data) {
        AdbankLibraryPage page = openLibraryPage(collectionName);
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectStareTab();
        fillSharePopupNoDownloadPermission(parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }

    @When("{I |}add secure share for all assets from collection '$collectionName' to following users: $data")
    public void addSecureShareOfFiles(String collectionName, ExamplesTable data) {
        AdbankLibraryPage page = openLibraryPage(collectionName);
        getSut().getPageCreator().getLibraryPage().clickSelectAll();
        ShareFilesPopup popup = page.clickShareFilesButton().selectStareTab();
        fillSharePopup(parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }

    @When("{I |}remove secure share for asset '$fileName' of user '$userName' from collection '$collectionName'")
    public void removeSecureShareOfFile(String fileName, String userName,String collectionName) {
        String userDetails;
        AdbankLibraryPage page = openLibraryPage(collectionName);
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectSecureSharesTab();
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        if (user == null) {
            throw new NullPointerException("User was not found by following email " + wrapUserEmailWithTestSession(userName));
        }
        if (user.getSubtype().equals("user")) {
            userDetails = user.getFullName();
        } else {
            userDetails = user.getEmail();
        }
        popup.removeUserFromShare(userDetails);
    }

    @Then("{I |} should see following count '$count' of total assets in collection")
    public void checkCountOfTotalFiles(int count) {
        int actualState = getSut().getPageCreator().getLibraryPage().getCountOfTotalAssets();
        assertThat(String.format("Wrong number of asset in collection: %d, but should be %d", actualState, count), count == actualState);
    }

    @Then("{I |} '$condition' see open edit usage right pop up in library")
    public void isEditUsageRightPopUpAvailableInLibrary(String condition){
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = page.isEditUsageRightPopUpAvaiable();
        page.clickMoreButton();
        page.clickEditUsageRightsButtonFromMoreDropDown();
        assertThat(actualState,is(shouldState));
    }

    @Then("{I |}'$condition' see assets '$assetNames' on opened remove asset confirmation popup")
    public void checkUrlLibraryPage(String condition, String assetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualNames = new RemoveAssetsConfirmationPopup(getLibraryPage()).getAssetNames();

        for (String expectedName : assetNames.split(",")) {
            assertThat(actualNames, shouldState ? hasItem(expectedName) : not(hasItem(expectedName)));
        }
    }

    @Then("{I |}'$condition' see Add to Work Request button on library page")
    public void checkAddToWorkRequestButton(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryPage().isAddToWorkRequestButton();
        assertThat(shouldState, is(actualState));
    }
    //NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code starts
    @Then("{I |}'$condition' see Add to Project button on library page")
    public void checkAddToProjectButton(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryPage().isAddAssetToProjectButtonVisible();
        assertThat(shouldState, is(actualState));
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends

    @Then("{I |}'$condition' see existing collection '$collectionName' in opened dropdown on Add to collection popup")
    public void checkThatCollectionPresentInAddToCollectionDropdown(String condition, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualNames = new AddToCollectionPopUp(getLibraryPage()).getCollectionNames();
        String expectedName = wrapVariableWithTestSession(collectionName);
        assertThat(actualNames, shouldState ? hasItem(expectedName) : not(hasItem(expectedName)));
    }

    @Then("I should see library page")
    public void checkUrlLibraryPage() {
        assertThat(getSut().getWebDriver().getCurrentUrl(), containsString("library#collections"));
    }

    @Then("{I |}'$condition' be on Library Page")
    public void checkLibraryPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            getSut().getPageCreator().getLibraryPage();
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see search object '$objects' in library")
    public void checkSearchObject(String condition, String objects) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualObjectList = getSut().getPageCreator().getLibraryPage().getDropdownListOfLinks();

        for (String expectedObject : objects.split(","))
            assertThat(actualObjectList, shouldState ? hasItem(expectedObject) : not(hasItem(expectedObject)));
    }

    @Then("{I |}'$condition' see show all results link on quick search menu in library")
    public void checkShowAllResultsLinkVisibility(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getSut().getPageCreator().getLibraryPage().isShowAllResultsLinkVisible(), equalTo(shouldState));
    }


    @Then("{I |}'$condition' see trash folder on library page")
    public void checkThatTrashFolderPresent(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryPage().isTrashFolderPresent();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see opened confirmation popup on opened library page")
    public void checkThatConfirmationPopupPresented(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryPage().isConfirmationPopupPresented();
        assertThat(actualState, is(expectedState));
    }

    @Then("I '$condition' not see add new/existing presentation popup window")
    public void checkConditionNewExistingPresentationPopupWindow(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AddExistingPresentationPopUpWindow existingPresentationPopUpWindow = new AddExistingPresentationPopUpWindow(getSut().getPageCreator().getLibraryPage());
        assertThat(existingPresentationPopUpWindow.isPopUpVisible(), equalTo(shouldState));
    }

    @Then("{I |}'$state' see add new/existing presentation menu")
    public void checkIsAddToPresentationMenuVisible(String state) {
        boolean shouldState = state.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryPage().isAddToExistingMenuVisible();
        assertThat(shouldState, is(actualState));
    }

    @Then("I should see '$count' selected note in files counter")
    public void checkSelectedCounter(String count) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        assertThat(count, equalTo(libraryPage.getLabelsValueAboutCountSelectedFiles()));
    }

    @Then("I should see that all assets are selected on the library page")
    public void checkThatAllAssetsAreSelected() {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        assertThat(libraryPage.getAllAssetsCount(), equalTo(libraryPage.getAllSelectedAssetsCount()));
    }

    @Then("{I |}'$condition' see asset '$assetNames' in library")
    public void checkAsset(String condition, String assetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage();

        for (String assetName : assetNames.split(","))
            assertThat(page.isFilePresent(getAssetName(assetName)), is(shouldState));
    }

    // method works with non wrapped asset titles (not wrap asses title if one doesn't have dot symbol)
    // | AssetTitle |
    @Then("{I |}'$condition' see asset with following titles on opened Library page: $data")
    public void checkAsset(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            assertThat(page.isFilePresent(row.get("AssetTitle")), equalTo(shouldState));
        }
    }


    @Then("{I |}'$condition' see asset '$assetNames' in library for all collections with filter '$filters'")
    public void checkAssetInCollections(String condition, String assetNames, String filters) {
        openLibraryPage();
        for (AssetFilter collection : getCoreApi().getAssetFilters().getFilters()) {
            getSut().getPageNavigator().getLibraryPage(collection.getId());
            clickMediaTypeFilter("on", filters);
            checkAsset(condition, assetNames);
        }
    }

    @Then("{I |}'$condition' see asset '$assetNames' in library for all collections")
    public void checkAssetInAllAvailableCollections(String condition, String assetNames) {
        openLibraryPage();
        for (String collectionName : getSut().getPageNavigator().getLibraryPage().getListOfCollectionsNames()) {
            openLibraryPage(collectionName);
            checkAsset(condition, assetNames);
        }
    }

    @Then("I should see asset '$assetName' in library collection '$collectionName' with title ends with '...'")
    public void checkLongAssetName(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        String actualName = openLibraryPage(collectionName).getAssetTitleTextByAssetId(asset.getId());
        if (actualName.endsWith("...")) actualName = actualName.substring(0, actualName.length() - 3);
        assertThat(assetName, startsWith(actualName));
    }

    // assetName in library without extention only name
    @Then("I should see assets '$assetName' count '$count' in library")
    public void checkAsset(String assetName, int count) {
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage();
        assertThat(page.getFilesCount(getAssetName(assetName)), greaterThanOrEqualTo(count));
    }

    @Then("{I |}'$condition' see asset count '$expectedCount' on opened Library page")
    public void checkAssetCount(String condition, int expectedCount) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualCount = getSut().getPageCreator().getLibraryPage().getAssetsCount();
        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

    // | Name | Count |
    // Count is optional
    @Then("I should see following assets in library: $assetsTable")
    public void checkAssets(ExamplesTable assetTable) {
        for (int i = 0; i < assetTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(assetTable, i);
            String assetName = row.get("Name");
            String count = row.get("Count");
            if (count == null) {
                checkAsset("should", assetName);
            } else {
                checkAsset(assetName, Integer.parseInt(count));
            }
        }
    }

    @Then("{I |}should see following number '$number' of related files on library page")
    public void countOfRelatedFiles(int shouldState) {
        int actualState = getSut().getPageCreator().getLibraryPage().getCountOfRelatedAssets();
        assertThat(String.format("Wrong number of related assets %d", actualState), actualState,is(shouldState));
    }

    // | Name | State |
    @Then("I should see on the {L|l}ibrary page collections according to next conditions: $stateTable")
    public void checkCollectionsVisibility(ExamplesTable stateTable) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        List<String> actualCollectionsList = libraryPage.getListOfCollectionsNames();
        for (int i = 0; i < stateTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(stateTable, i);
            if (row.get("Name") != null) {
                boolean shouldState = row.get("State") != null && row.get("State").equalsIgnoreCase("should");
                assertThat(wrapCollectionName(row.get("Name")), shouldState ? isIn(actualCollectionsList) : not(isIn(actualCollectionsList)));
            }
        }
    }

    @Then("{I |}'$condition' see on the {L|l}ibrary page collections '$collectionName'")
    public void checkCollectionsVisibility(String condition, String collectionName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        boolean shouldState = condition.equals("should");
        for (String collection : collectionName.split(",")) {
            List<String> collectionsList = libraryPage.getListOfCollectionsNames();
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }

    @Then("{I |}'$condition' see following collections '$categories' on Library page")
    public void checkCollectionTrees(String condition, String categories) {
        boolean should = condition.equalsIgnoreCase("should");
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        List<String> actualCollections = page.getListOfCollectionsNames();
        for (String category : categories.split(",")) {
            assertThat(actualCollections, should ? hasItem(wrapCollectionName(category)) : not(hasItem(wrapCollectionName(category))));
        }
    }

    @Then("{I |}should see only one collection '$collectionName' on the Library page")
    public void checkCollectionsVisibilityWithoutDuplicates(String collectionName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        int collectionsWithSameNameCount = 0;
        for (String name : libraryPage.getListOfCollectionsNames()) {
            if (name.equalsIgnoreCase(wrapCollectionName(collectionName))) collectionsWithSameNameCount++;
        }

        assertThat(String.format("I should see only one collection '%s'", wrapCollectionName(collectionName)), collectionsWithSameNameCount, equalTo(1));
    }

    @Then("{I |}should see assets '$value' on the library page")
    public void checkAssetsCount(String value) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        assertThat(libraryPage.getLabelsValueAboutCountFiles(), equalTo(value));
        assertThat(libraryPage.getAssetsCount(), equalTo(Integer.parseInt(value)));
    }

    @Then("{I |}should see '$value' Items per page")
    public void checkItemsPerPage(String value) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        assertThat(value, equalTo(libraryPage.getItemsPerPageValue()));
    }

    @Then("{I |}'$condition' see count '$expectedAssetsCount' on existing presentations popup")
    public void checkAssetsCountOnExistingPresentationsPopup(String condition, String expectedAssetsCount) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AddExistingPresentationPopUpWindow addExistingPresentationPopUpWindow = new AddExistingPresentationPopUpWindow(getSut().getPageCreator().getLibraryPage());
        String regexp = "Add (\\d) files to a presentation";
        java.util.regex.Matcher mather = Pattern.compile(regexp, Pattern.CASE_INSENSITIVE).matcher(addExistingPresentationPopUpWindow.getTitle());
        String actualAssetsCount = mather.find() ? mather.group(1) : "";

        assertThat(actualAssetsCount, shouldState ? equalTo(expectedAssetsCount) : not(equalTo(expectedAssetsCount)));
    }

    @Then("{I |}'$condition' see names '$expectedAssetNames' on existing presentations popup")
    public void checkAssetNamesOnExistingPresentationsPopup(String condition, String expectedAssetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AddExistingPresentationPopUpWindow addExistingPresentationPopUpWindow = new AddExistingPresentationPopUpWindow(getSut().getPageCreator().getLibraryPage());
        String actualAssetNames = addExistingPresentationPopUpWindow.getFileNames().replaceAll(",\\s*", ",");

        assertThat(actualAssetNames, shouldState ? equalTo(expectedAssetNames) : not(equalTo(expectedAssetNames)));
    }

    @Then("{I |}'$condition' see all available presentation is displayed in add to existing popup")
    public void checkThatAllAvailablePresentationIsDisplayed(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        AddExistingPresentationPopUpWindow addExistingPresentationPopUpWindow = new AddExistingPresentationPopUpWindow(getSut().getPageCreator().getLibraryPage());
        List<String> actualPresentationsList = addExistingPresentationPopUpWindow.getPresentationList();
        List<String> expectedPresentationsList = new ArrayList<>();

        for (Reel reel : getCoreApi().getReels(new LuceneSearchingParams(), 10000)) {
            expectedPresentationsList.add(reel.getName());
        }

        Collections.sort(actualPresentationsList, String.CASE_INSENSITIVE_ORDER);
        Collections.sort(expectedPresentationsList, String.CASE_INSENSITIVE_ORDER);

        assertThat(actualPresentationsList, shouldState ? equalTo(expectedPresentationsList) : not(equalTo(expectedPresentationsList)));
    }

    @Then("{I |}should see available preview for asset '$assetName' in collection '$collectionName'")
    public void checkAvailabilityAssetsPreview(String assetName, String collectionName) {
        AdbankLibraryPage libraryPage = openLibraryPage(collectionName);
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        assertThat(libraryPage.isPreviewVisible(asset.getId()), equalTo(true));
    }

    @Then("I '$condition' see metadata with key '$key' in drop-down menu for other fields on library page")
    public void checkVisibilityOfKeyInTheMetadata(String condition, String expectedKey) {
        boolean shouldState = condition.equals("should");
        List<String> actualKeys = getSut().getPageNavigator().getLibraryPage().getMetaDataKey();

        assertThat(actualKeys, shouldState ? hasItem(expectedKey) : not(hasItem(expectedKey)));
    }

    @Then("I should see current collection only with metadata key '$key' and value '$value'")
    public void checkMetadataKeyAndValue(String key, String value) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        if (key.equalsIgnoreCase("Advertiser")) value = getData().getAgencyByName(value).getName();
        else value = wrapCollectionName(value);
        assertThat(libraryPage.getDisabledMetaDataKeySelectedLabel(1), equalTo(key));
        assertThat(libraryPage.getDisabledMetaDataValueSelectedLabel(key), equalTo(value));
    }

    @Then("I should see that metadata with key '$key' has value '$value'")
    public void checkMetadataValueForKey(String key, String value) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        assertThat(libraryPage.getMetadataTextValue(key), equalTo(value));
    }

    @Then("I '$condition' see advanced search panel on the library page")
    public void checkAdvancedSearchPanelVisibility(String condition) {
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        if (page.isAdvancedLinkVisible()) page.clickAdvancedLink();

        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = page.isAdvancedFilterBlockVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("I '$condition' see media filters panel on the library page")
    public void checkFiltersPanelVisibility(String condition) {
        boolean actualState = getSut().getPageNavigator().getLibraryPage().isMediaFiltersPanelVisible();
        boolean expectedState = condition.equalsIgnoreCase("should");

        assertThat(actualState, is(expectedState));
    }

    @Then("I '$condition' see metadata key '$keys' in the dropdown on the library page")
    public void checkMetadataKey(String condition, String keys) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String key : keys.split(",")) {
            assertThat(key, shouldState ? isIn(libraryPage.getMetaDataKey()) : not(isIn(libraryPage.getMetaDataKey())));
        }
    }

    @Then("There are count of metadata key must be '$condition' than '$count'")
    public void checkCountOfMetadataKey(String condition, String count) {
        Matcher matcher = null;
        if (condition.equalsIgnoreCase("less or equal")) matcher = lessThanOrEqualTo(Integer.parseInt(count));
        else if (condition.equalsIgnoreCase("less")) matcher = lessThan(Integer.parseInt(count));
        else if (condition.equalsIgnoreCase("greater or equal"))
            matcher = greaterThanOrEqualTo(Integer.parseInt(count));
        else if (condition.equalsIgnoreCase("greater")) matcher = greaterThan(Integer.parseInt(count));
        else if (condition.equalsIgnoreCase("equal")) matcher = equalTo(Integer.parseInt(count));
        else Assert.fail("Condition is incorrect");
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        assertThat(libraryPage.getCountOfKeyMetadataFields(), matcher);
    }

    // | Key | Value |
    @Then("I should see following metadata on the library page: $metadataTable")
    public void checkMetadata(ExamplesTable metadataTable) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        for (int i = 0; i < metadataTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadataTable, i);
            if ((row.get("Key") != null) && (row.get("Value") != null)) {
                checkMetadaKeyAndValue(libraryPage, row.get("Key"), row.get("Value"), i);
            }
        }
    }

    @Then("I should see that mediaSubType value is '$value' on the current collection")
    public void checkMediaSubTypeValue(String value) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        Matcher matcher;
        if (value.equalsIgnoreCase("Generic Master") || value.equalsIgnoreCase("Titled Master")) {
            matcher = containsString(value);
        } else {
            matcher = equalTo(value);
        }
        assertThat(libraryPage.getMediaSubTypeSelectedValue(), matcher);
    }

    // | Filter | State |
    @Then("I should see following filter state for current collection: $filterTable")
    public void checkFilterState(ExamplesTable filterTable) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        for (int i = 0; i < filterTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filterTable, i);
            if ((row.get("Filter") != null) || (row.get("State") != null)) {
                boolean state = row.get("State").equalsIgnoreCase("on");
                assertThat(libraryPage.getFiltersState(row.get("Filter")), equalTo(state));
            }
        }
    }

    @Then("I '$condition' see filters '$filters' in state '$state' for current collection")
    public void checkFilterState(String condition, String filters, String state) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean filterState = state.equalsIgnoreCase("on");

        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();

        for (String filter : filters.split(",")) {
            String message = String.format("Filter '%s' should %sbe in state '%s'", filter, shouldState ? "" : "not ", state);
            assertThat(message, libraryPage.getFiltersState(filter), shouldState ? is(filterState) : not(is(filterState)));
        }
    }


    // possible values for thumbnail: GenericMasterIcon, TitledMasterIcon
    @Then("{I |}should see thumbnail '$thumbnailElement' for all assets on current library page")
    public void checkThumbnailForEachFile(String thumbnailElement) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        int assetsCount = libraryPage.getAllAssetsCount();
        By locator = getSut().getUIMap().getByPageName("FilesPage", thumbnailElement);
        int thumbnailsCount = getSut().getWebDriver().findElements(locator).size();
        assertThat("Each asset should have thumbnail " + thumbnailElement, thumbnailsCount, equalTo(assetsCount));
    }


    @Then("I '$condition' see metadata values '$values' for key '$key'")
    public void checkMetadataValuesAccordingToKey(String condition, String values, String key) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        libraryPage.setMetaDataKey(key);
        List<String> valuesFromPage = libraryPage.getMetaDataValue();
        Matcher<String> matcher = condition.equalsIgnoreCase("should") ? isIn(valuesFromPage) : not(isIn(valuesFromPage));
        for (String value : values.split(",")) {
            if (key.equalsIgnoreCase("advertiser")) {
                value = getData().getAgencyByName(value).getName();
            } else if (key.equalsIgnoreCase("category")) {
                value = wrapCollectionName(value);
            } else if(key.equalsIgnoreCase("originator")) {
                value = wrapAgencyName(values);
            }
            assertThat(value, matcher);
        }
    }

    @Then("I '$condition' see metadata values '$values' for Collection key")
    public void checkMetadataValuesForCollectionKey(String condition, String values) {
        String[] valuesArray = values.split(",");
        for (int i = 0; i < valuesArray.length; i++) valuesArray[i] = wrapCollectionName(valuesArray[i]);
        checkMetadataValuesAccordingToKey(condition, StringUtils.join(valuesArray, ","), "Collection");
    }

    //| Collection | AssetInclude | AssetExclude |
    @Then("I should see following assets in the collections: $visibilityTable")
    public void checkAssetsVisibility(ExamplesTable visibilityTable) {
        for (int i = 0; i < visibilityTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(visibilityTable, i);
            if (row.get("Collection") != null) {
                String categoryId = getCategoryId(wrapCollectionName(row.get("Collection")));
                AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage(categoryId);
                List<String> listOfAssetsFileNames = libraryPage.getUploadedElementsText();
                if ((row.get("AssetInclude") != null) && (!row.get("AssetInclude").isEmpty())) {
                    for (String assetI : row.get("AssetInclude").split(",")) {
                        assertThat(assetI, isIn(listOfAssetsFileNames));
                    }
                }
                if ((row.get("AssetExclude") != null) && (!row.get("AssetExclude").isEmpty())) {
                    for (String assetE : row.get("AssetExclude").split(",")) {
                        assertThat(assetE, not(isIn(listOfAssetsFileNames)));
                    }
                }
            }
        }
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the current collection")
    public void checkAssetsVisibility(String condition, String expectedAssetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        List<String> actualAssetNames = page.getUploadedElementsText();

        if (expectedAssetNames.isEmpty() && shouldState) {
            assertThat(actualAssetNames.size(), equalTo(0));
        } else {
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + " is present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the collection '$collectionName'")
    public void checkAssetsVisibility(String condition, String expectedAssetNames, String collectionName) {
        openLibraryPageWithoutRefresh(collectionName);
        checkAssetsVisibility(condition, expectedAssetNames);
    }

    @Then("{I |}'$condition' see assets via UI '$expectedAssetNames' in the collection")
    public void checkAssetsVisibilityForClient(String condition, String expectedAssetNames) {
        checkAssetsVisibility(condition, expectedAssetNames);
    }
    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the collection '$collectionName'")
    public void checkAssetsVisibilityOnCollection(String condition, String assetsTitles, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = openLibraryPage(collectionName).getPresentedAssetsTitles();

        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }

    @Then("{I |}'$condition' see uploaded by user '$userName' assets '$fileNames' in the collection '$categoryName'")
    @Alias("{I |}'$condition' see accepted by user '$userName' assets '$fileNames' in the collection '$categoryName'")
    public void checkAssetsVisibilityOnCollection(String condition, String userName, String fileNames, String categoryName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage(collectionId);

        for (String fileName : fileNames.split(",")) {
            Content asset = getLastUploadedUserAsset(collectionId, userId, fileName);
            if (asset == null)
                asset = getLastUploadedUserAsset(collectionId, userId, wrapVariableWithTestSession(fileName));

            if (shouldState) {
                assertThat(page.isAssetPresentsByFileId(asset.getId()), is(true));
            } else {
                assertThat(asset, nullValue());
            }
        }
    }

    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the current collection")
    public void checkAssetsVisibilityOnCurrentCollection(String condition, String assetsTitles) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = getSut().getPageCreator().getLibraryPage().getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }

    @Then("I should see on the library page that element sort by has value '$value'")
    public void checkSortBySelectedLabel(String value) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        assertThat(libraryPage.getSortByValue(), equalTo(value));
    }

    @Then("{I |}should see assets sorting by '$sortingType' for collection '$collectionName' on the library page")
    public void checkAssetsSorting(String sortingType, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage(collectionId);
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setResultsOnPage(1000).setSortingField("_created").setSortingOrder("desc");
        SearchResult<Content> assets = getCoreApi().findAssets(collectionId, query);
        long startTime = System.currentTimeMillis();
        while (libraryPage.getObjectsTitle().size() != assets.getResult().size()) {
            Common.sleep(3000);
            if (System.currentTimeMillis() - startTime > 120000)
                Assert.fail("Library works very slow");
        }

        List<String> assetsFromPage = libraryPage.getObjectsTitle();
        List<String> sortedAssetsFromPage = new ArrayList<>();
        List<Content> sortedListOfContent = new ArrayList<>(assets.getResult());
        sortedAssetsFromPage.addAll(assetsFromPage);
        if (sortingType.contains("Last Uploaded First")) {
            Collections.sort(sortedListOfContent, Collections.reverseOrder(new ComparatorContentBy_modified()));
        } else if (sortingType.contains("Last Uploaded Last")) {
            Collections.sort(sortedListOfContent, new ComparatorContentBy_modified());
        } else if (sortingType.contains("Size (Descending)")) {
            Collections.sort(sortedListOfContent, Collections.reverseOrder(new ComparatorContentByFileSize()));
        } else if (sortingType.contains("Size (Ascending)")) {
            Collections.sort(sortedListOfContent, new ComparatorContentByFileSize());
        }
        int correctCountOfAsset = assets.getResult().size();
        assertThat(assetsFromPage.size(), equalTo(correctCountOfAsset));
        if ((sortingType.contains("Last Uploaded First")) || (sortingType.contains("Last Uploaded Last"))
                || (sortingType.contains("Size (Descending)")) || (sortingType.contains("Size (Ascending)"))) {
            for (int i = 0; i < correctCountOfAsset; i++) {
                assertThat(assetsFromPage.get(i), equalTo(libraryPage.getAssetsTitleById(sortedListOfContent.get(i).getId())));
            }
        }
        if (sortingType.contains("Title (A to Z)")) {
            Collections.sort(sortedAssetsFromPage, String.CASE_INSENSITIVE_ORDER);
            assertThat(assetsFromPage, equalTo(sortedAssetsFromPage));
        } else if (sortingType.contains("Title (Z to A)")) {
            Collections.sort(sortedAssetsFromPage, Collections.reverseOrder(String.CASE_INSENSITIVE_ORDER));
            assertThat(assetsFromPage, equalTo(sortedAssetsFromPage));
        }
    }

    @Then("I '$condition' see disabled save button on add to presentation popup without selected presentation")
    public void checkThatSaveButtonIsDisabled(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AddExistingPresentationPopUpWindow existingPresentationPopUpWindow = new AddExistingPresentationPopUpWindow(getSut().getPageCreator().getLibraryPage());
        assertThat(existingPresentationPopUpWindow.isSaveButtonDisabled(), equalTo(shouldState));
    }

    @Then("{I |}'$shouldState' see Upload button on collection '$collectionName' in Library")
    public void checkVisibilityUploadButton(String shouldState, String collectionName) {
        AdbankLibraryPage libraryPage = openLibraryPage(collectionName);
        boolean should = shouldState.equals("should");
        assertThat(libraryPage.isUploadButtonVisible(), equalTo(should));
    }

    // | FileName | Duration | Size | AspectRatio | Type |
    @Then("{I |}should see for collection '$collectionName' in Library following files metadata : $metadata")
    public void checkFilesMetadata(String collectionName, ExamplesTable metadata) {
        AdbankLibraryPage libraryPage = openLibraryPage(collectionName);
        for (int i = 0; i < metadata.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadata, i);
            AdbankLibraryPage.FileMetadata fileMetadata = libraryPage.getFileMetadata(row.get("FileName"));
            assertThat("Title", fileMetadata.getName(), equalTo(row.get("FileName")));
            if (row.get("ShortId") != null) assertThat("ShortId", fileMetadata.getShortId(), equalTo(row.get("ShortId")));
            if (row.get("Type") != null) assertThat("Type", fileMetadata.getType(), equalTo(row.get("Type")));
        }
    }

    @Then("I '$condition' see add to presentation drop-down menu on library page")
    public void checkDropDownMenuVisibility(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        assertThat(libraryPage.isAddToExistingPresentationButtonVisible(), equalTo(shouldState));
        assertThat(libraryPage.isAddToNewPresentationButtonVisible(), equalTo(shouldState));
    }

    @Then("I '$condition' see add to presentation drop-down menu buttons disabled on library page")
    public void checkDropDownMenuButtonsEnabled(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        assertThat(libraryPage.isAddToExistingPresentationButtonEnabled(), equalTo(shouldState));
        assertThat(libraryPage.isAddToNewPresentationButtonEnabled(), equalTo(shouldState));
    }

    // | Name | ShouldState |
    @Then("I should see following metadata keys in the drop-down menu for current collection: $data")
    public void checkVisibilityOfKeyInTheMetadata(ExamplesTable data) {
        List<String> actualKeys = getSut().getPageNavigator().getLibraryPage().getMetaDataKey();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("ShouldState") != null && row.get("ShouldState").equalsIgnoreCase("should");
            assertThat(actualKeys, shouldState ? hasItem(row.get("Name")) : not(hasItem(row.get("Name"))));
        }
    }

    @Then("I '$condition' see that collection '$collectionName' is selected")
    public void checkSelectedCollection(String condition, String collectionName) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        collectionName = wrapCollectionName(collectionName);
        assertThat(libraryPage.isCollectionSelected(collectionName), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("I should see that asset '$assetName' has not got specification in the current collection")
    public void checkThatAssetsSystemInfoIsUndefine(String assetName) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        assertThat(libraryPage.getSystemInfoByFileName(assetName), containsString("undefine"));
    }

    @Then("I '$condition' see preview for asset '$assetName' for current collection")
    public void checkPreviewForAsset(String condition, String assetName) {
        AdbankLibraryPage libraryPage = getSut().getPageCreator().getLibraryPage();
        if (!assetName.contains("."))
            assetName = wrapVariableWithTestSession(assetName);
        assertThat(libraryPage.isPreviewForFileAvailable(assetName), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("I '$condition' see asset '$assetName' with wrapped name in collection '$collectionName'")
    public void checkThatAssetTitleIsWrapped(String condition, String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageNavigator().getLibraryPage(collectionId).isAssetNameWrapped(assetName);

        assertThat(actualState, is(expectedState));
    }

    @Then("I should see collection '$collectionName' contain the following assets '$assetName'")
    public void checkCollectionOnAsset(String collectionName, String assetName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        openLibraryPage(collectionName);
        for (String fileName : assetName.split(","))
            libraryPage.selectFileByFileName(fileName);
    }

    @Then("{I |}'$shouldState' see collection '$collectionName' in collection list on library page")
    public void checkCollectionDelete(String should, String collectionName) {
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage();
        boolean shouldState = should.equalsIgnoreCase("should not");
        boolean actualState = libraryPage.isCollectionRemove(collectionName);
        assertThat(actualState, equalTo(shouldState));
    }

    @Then("{I |}'$shouldState' see following options '$optionsList' in More drop down menu on library page")
    public void checkMoreMenuOptionsExist(String shouldState, String optionsList) {
        getLibraryPage().clickMoreButton();
        for (String option : optionsList.split(","))
            assertThat("Check is option " + option + " exist: ", getLibraryPage().isMoreMenuOptionVisible(option), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see active options '$optionsList' in More drop down menu on library page")
    public void checkMoreMenuOptionsState(String shouldState, String optionsList) {
      //  getLibraryPage().clickMoreButton();  // 5.7 Regression fix
        for (String option : optionsList.split(","))
            assertThat("Check is option " + option + " active: ", getLibraryPage().isActiveMoreMenuOption(option), is(shouldState.equals("should")));
    }

    // | UserName | DownloadMaster | DownloadProxy |
    // DownloadProxy and DownloadMaster are not required properties and may be set as true or false
    @Then("{I |}'$condition' see following users on Secure Shares tab in Share files popup for asset '$fileName' on opened Library page: $data")
    public void checkThatUserPresentOnSecureSharesTab(String condition, String fileName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        getSut().getWebDriver().navigate().refresh();
        AdbankLibraryPage page = getLibraryPage();
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectSecureSharesTab();
        List<Map<String,String>> actualUsers = popup.getUsersList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            Map<String,String> expectedUser = new HashMap<>();
            expectedUser.put("UserName", getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName"))).getFullName());
            expectedUser.put("DownloadMaster", Boolean.toString(Boolean.parseBoolean(row.get("DownloadMaster"))));
            expectedUser.put("DownloadProxy", Boolean.toString(Boolean.parseBoolean(row.get("DownloadProxy"))));

            assertThat(actualUsers, shouldState ? hasItem(expectedUser) : not(hasItem(expectedUser)));
        }
    }

    @Then("{I |}should see the following seccession '$files' on library page")
    public void checkForSuccessionOnLibraryPage(String files) {
        List<String> actualValues = getLibraryPage().getListResultAssetFromGlobalSearch();
        for (String expectedFile : files.split(",")) assertThat(actualValues, hasItem(expectedFile));
    }

    @Then("{I |}'$condition' see business unit '$agencyName' on library page")
    public void checkThatAgencyIsPresent(String condition, String agencyName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAgencyNames = openLibraryPage().getAgencyNames();
        String expectedAgencyName = wrapVariableWithTestSession(agencyName);

        assertThat(actualAgencyNames, shouldState ? hasItem(expectedAgencyName) : not(hasItem(expectedAgencyName)));
    }

    // | ParentName | ChildName |
    @Then("{I |}'$condition' see that following collections in BU on library page: $data")
    public void checkThatAgencyContainsCollection(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage page = openLibraryPage();

        for (Map<String,String> row : parametrizeTableRows(data)) {
            List<String> actualChildren = page.getMenuChildItems(wrapVariableWithTestSession(row.get("ParentName")));
            for (String expectedChildName : row.get("ChildName").split(",")) {
                expectedChildName = wrapVariableWithTestSession(expectedChildName);
                assertThat(actualChildren, shouldState ? hasItem(expectedChildName) : not(hasItem(expectedChildName)));
            }
        }
    }

    @When("{I |}switch to '$typeView' view in the current library page")
    public void switchToFilesView(String typeView) {
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        if (typeView.equalsIgnoreCase("tile"))
            page.clickTileView();
        else if (typeView.equalsIgnoreCase("list"))
            page.clickListView();
        else
            throw new IllegalArgumentException("Type of file's view is undefined");
    }

    @Then("{I |}should see assets in the '$typeView' view for current library page")
    public void checkFilesViewState(String typeView) {
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        switch (typeView.toLowerCase()) {
            case "list":
                assertThat(page.isViewOfFilesIsList(), is(true));
                break;
            case "tile":
                assertThat(page.isViewOfFilesIsTile(), is(true));
                break;
            default:
                throw new IllegalArgumentException("Unknown type of view: " + typeView);
        }
    }

    @When("{I }sort files list view in library for collection '$collectionName' by column '$column' order '$order'")
    public void sortFilesListView(String collectionName, String columnName, String order) {
        AdbankLibraryPage page = openLibraryPage(collectionName);
        switchToFilesView("list");
        page.sortListViewByColumn(columnName, order);
    }

    @Given("{I |}scrolled down to number of file is '$number' on library page for collection '$collectionName'")
    @When("{I |}scroll down to number of file is '$number' on library page for collection '$collectionName'")
    public void scrollDownToFooter(int number, String collectionName) {
        AdbankLibraryPage page = openLibraryPage(collectionName);
        page.scrollDownToFooter(number);

    }

    @Then("{I |}'$condition' see the add to a project button on library page")
    public void addToProjectButtonVisible(String condition) {
        AdbankLibraryPage page = openLibraryPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = page.isAddAssetToProjectButtonVisible();
        assertThat(shouldState, is(actualState));
    }

    @Then("{I |}'$condition' see an access denied message on library page")
    public void checkAccessDeniedOnLibraryPage(String condition) {
        String directLibraryURL = TestsContext.getInstance().applicationUrl + "/library#collections/";
        getSut().getWebDriver().navigate().to(directLibraryURL);
        getSut().getWebDriver().waitUntilElementAppear(By.xpath("//div[@id='app-main']"));
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getWebDriver().isElementVisible(By.xpath("//span[text() = 'We are sorry! You do not have permission to access this area.']"));
        assertThat(shouldState, is(actualState));
    }

    private void fillShareAssetPopup(ShareFilesPopup popup,Map<String,String> fields,boolean isSecureShare){
        if (fields.get("ExpireDate") == null || fields.get("ExpireDate").isEmpty()) {
            if (isSecureShare) {
                popup.checkNeverExpiresCheckbox();
            } else {
                popup.checkNeverPublicExpiresCheckbox();
            }
        } else {
            if (isSecureShare) {
                popup.uncheckNeverExpiresCheckbox();
            } else {
                popup.uncheckNeverPublicExpiresCheckbox();
            }

            popup.setExpirationDate(parseDateTime(fields.get("ExpireDate")).toString("dd/MM/yyyy"));
        }

        for (String userEmail : fields.get("UserEmails").split(",")) popup.typeUserEmails(wrapUserEmailWithTestSession(userEmail));
        popup.typeMessage(fields.get("Message"));

        if (Boolean.parseBoolean(fields.get("DownloadProxy"))) {
            popup.checkDownloadProxyCheckbox();
        } else {
            popup.uncheckDownloadProxyCheckbox();
        }

        if (isSecureShare) {
            if (Boolean.parseBoolean(fields.get("DownloadOriginal"))) {
                popup.checkDownloadOriginalCheckbox();
            } else {
                popup.uncheckDownloadOriginalCheckbox();
            }
        }
    }
    private void fillSharePopup(Map<String,String> fields, boolean isSecureShare) {
        ShareFilesPopup popup = new ShareFilesPopup(getLibraryPage());
        fillShareAssetPopup(popup,fields,isSecureShare);
    }


    private void fillSharePopupNoDownloadPermission(Map<String,String> fields, boolean isSecureShare) {
        ShareFilesPopup popup = new ShareFilesPopup(getLibraryPage());
        if (fields.get("ExpireDate") == null || fields.get("ExpireDate").isEmpty()) {
            if (isSecureShare) {
                popup.checkNeverExpiresCheckbox();
            } else {
                popup.checkNeverPublicExpiresCheckbox();
            }
        } else {
            if (isSecureShare) {
                popup.uncheckNeverExpiresCheckbox();
            } else {
                popup.uncheckNeverPublicExpiresCheckbox();
            }

            popup.setExpirationDate(parseDateTime(fields.get("ExpireDate")).toString("dd/MM/yyyy"));
        }

        for (String userEmail : fields.get("UserEmails").split(",")) popup.typeUserEmails(wrapUserEmailWithTestSession(userEmail));
        popup.typeMessage(fields.get("Message"));

    }

    public AdbankLibraryPage openLibraryPageWithoutRefresh(String categoriesName) {
        String collectionName = wrapCollectionName(categoriesName);
        return getSut().getPageNavigator().getLibraryPage(getCategoryId(wrapCollectionName(collectionName)));
    }

    protected Content getAsset(String collectionId, String assetId) {
        long timeout = System.currentTimeMillis() + 10 * 1000; // 10 seconds
        do {
            Content asset = getCoreApi().getAssetByName(collectionId, prepareAssetName(assetId));
            if (asset == null) {
                Common.sleep(1000);
            } else {
                return asset;
            }
        } while (System.currentTimeMillis() < timeout);
        return null;
    }

    protected String prepareAssetName(String assetName) {
        // asset which directly uploaded to library is not wrapped and have some extension
        return assetName.contains(".") ? assetName : wrapVariableWithTestSession(assetName);
    }

    protected Content getLastUploadedUserAsset(String collectionId, String userId, String assetId) {
        // asset which directly uploaded to library is not wrapped and have some extension
        if (!assetId.contains("."))
            assetId = wrapVariableWithTestSession(assetId);
        return getCoreApi().getLastUploadedUserAssetById(collectionId, userId, assetId);
    }

    protected List<Content> getLastAssets(String collectionId, int assetsOnPage) {
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setResultsOnPage(assetsOnPage).setSortingField("_created").setSortingOrder("desc");
        return getCoreApi().findAssets(collectionId, query).getResult();
    }

    protected Content getAssetFromFirstPage(String collectionId, String assetId, int assetsOnPage) {
        List<Content> assets = getLastAssets(collectionId, assetsOnPage);
        for (Content asset : assets) {
            if (asset.getName().equals(assetId)) {
                return asset;
            }
        }
        return null;
    }

    protected Content getAssetFromFirstPage(String collectionId, String assetId, int assetsOnPage, long timeout) {
        long deadline = System.currentTimeMillis() + timeout;
        Content asset;
        while ((asset = getAssetFromFirstPage(collectionId, assetId, assetsOnPage)) == null) {
            Common.sleep(1000);
            if (System.currentTimeMillis() > deadline) {
                break;
            }
        }
        return asset;
    }

    protected void createAsset(String fileName) {
        File file = new File(RelativePathConverter.getFullPath(fileName));
        getCoreApi().uploadAsset(file);
    }

    protected void createAsset(String fileName, String agencyId) {
        File file = new File(RelativePathConverter.getFullPath(fileName));
        getCoreApi().uploadAsset(file, null, agencyId);
    }

    protected void createAssetIfNotVisibleOnFirstPage(String collectionId, String fileName, int assetsOnPage) {
        String filePath = RelativePathConverter.getFullPath(fileName);
        File file = new File(filePath);
        Content asset = getAssetFromFirstPage(collectionId, file.getName(), assetsOnPage);
        if (asset == null) {
            getCoreApi().uploadAsset(file);
            getAssetFromFirstPage(collectionId, file.getName(), assetsOnPage, 10 * 1000);
        } else {
            Common.sleep(200);
        }
    }

    protected Content createFolderOverCoreApi(String path, String objectName) {
        path = normalizePath(path);
        if (path.isEmpty()) return null;
        path = wrapPathWithTestSession(path);
        Project project = getObjectByName(wrapVariableWithTestSession(objectName));
        return getCoreApi().createFolderRecursive(path, project.getId(), project.getId());
    }

    protected Content createFolderTemplateOverCoreApi(String path, String objectName) {
        path = normalizePath(path);
        if (path.isEmpty()) return null;
        path = wrapPathWithTestSession(path);
        Project project = getTemplateByName(wrapVariableWithTestSession(objectName));
        return getCoreApi().createFolderRecursive(path, project.getId(), project.getId());
    }

    protected DateTime parseDateTime(String date) {
        return parseDateTime(date, TestsContext.getInstance().storiesDateTimeFormat);
    }

    private void fillMetadataKeyAndValue(AdbankLibraryPage libraryPage, String key, String value) {
        libraryPage.setMetaDataKey(key);
        Common.sleep(1000);
        if(key.equals("Campaign")){
            libraryPage.setMetaDataValueOnFly(value);
        }else{
        libraryPage.setMetaDataValue(value);
        }
        Common.sleep(1000);
        libraryPage.clickAddMetadata();
    }

    private void checkMetadaKeyAndValue(AdbankLibraryPage libraryPage, String key, String value, int num) {
        assertThat(libraryPage.getDisabledMetaDataKeySelectedLabel(num), equalTo(key));
        if (key.equalsIgnoreCase("advertiser")) value = getData().getAgencyByName(value).getName();
        else value = wrapCollectionName(value);
        assertThat(libraryPage.getDisabledMetaDataValueSelectedLabel(num), equalTo(value));
    }

    protected String getCategoryId(String categoryName) {
        AssetFilter category = getCoreApi().getAssetsFilterByName(categoryName, "");
        if (category != null) {
            return category.getId();
        }
        throw new RuntimeException(String.format("Could not find category '%s'", categoryName));
    }

    protected String getCategoryIdForClient(String categoryName,String userId) {
        AssetFilter category = getCoreApi().getAssetsFilterByNameForClient(categoryName, "", userId);
        if (category != null) {
            return category.getId();
        }
        throw new RuntimeException(String.format("Could not find category '%s'", categoryName));
    }

    /**
     *
     * @param attachedFile - is file which will be attached
     * @param assetName - to this file, will be attached new file - fileName
     * @param collectionName - project name
     */
    protected void createAttachedFile(String attachedFile, String collectionName, String assetName, String assetId) {
        Common.sleep(1000); // waiting for indexing and appearing asset in library
        String filePath = getFilePath(attachedFile);
        Content masterFile = getCoreApi().getAssetByName(collectionName, assetName);
        getCoreApi().uploadAttachedFile(new File(filePath), masterFile, assetId, "asset");
        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
        } while (getCoreApi().getAssetByName(collectionName, assetName).getAttachedFiles().length == masterFile.getAttachedFiles().length
                && System.currentTimeMillis() - start < 10000);
    }

    private AdbankLibraryAssetsInfoPage getLibraryAssetsInfoPage() {
        return getSut().getPageCreator().getLibraryAssetsInfoPage();
    }

    protected void uploadattachmentToAssetViaSendplus(String fileName,String assetId) throws IOException {

            String filePath = getFilePath(fileName);
            User user = getData().getCurrentUser();
            getNVergeApi().uploadAttachToAssetViaSendplus(new File(filePath), user.getEmail(), user.getPassword(),assetId);


    }

    @When("{I |} share asset '$fileName' from collection '$collectionName' to following users: $data")
    public void addShareOfFile(String fileName, String collectionName, ExamplesTable data) {
        ShareFilesPopup popup = getLibraryAssetsInfoPage().clickShareFilesButton().selectStareTab();
        fillShareAssetPopup(popup,parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }

    @Then("{I |}'$condition' see '$message'")
    public void verifyNewLibraryMessage(String condition, String message) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage libraryPage = getSut().getPageNavigator().getLibraryPage("");
        assertThat(shouldState, equalTo(libraryPage.getNewLibraryAccess(message)));
    }

    @Then("{I |}'$condition' be directed to new library page")
    public void clickOnNewLibraryUrl(String condition) {
       boolean expectedState = condition.equalsIgnoreCase("should");
       boolean actualState = true;
       try {
            getSut().getPageCreator().getLibraryPage().clickNewLibraryUrl();
            LibraryAsset libraryPage=getSut().getPageCreator().getNewAdbankLibraryPage();
        }catch (Exception e) {
            actualState = false;
        } finally {
            assertThat(actualState, is(expectedState));
        }
    }

    @When("{I |}'$button' the clock")
    public void clickReIngestReTranscodeButton(String button) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage= getLibraryAssetsInfoPage();
        if("reingest".equalsIgnoreCase(button))
            libraryAssetsInfoPage.clickReingestButton();
        if("retranscode".equalsIgnoreCase(button))
            libraryAssetsInfoPage.clickRetranscodeButton();
    }

    @When("{I |}verify '$button' message")
    public void verifyMessage(String button){
        getLibraryAssetsInfoPage().verifyMessage(button);
    }

    @Then("{I |}verify that '$button' button '$condition' be enabled")
    public void verifyPresenceOfButton(String button,String condition) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage= getLibraryAssetsInfoPage();
        Boolean cond="should".equalsIgnoreCase(condition);
        assertThat(button + "button is enabled",cond.equals(libraryAssetsInfoPage.presenceOfButton(button)));
    }

    @Given("{I |}clicked Edit all selected button from More drop down")
    @When("{I |}click Edit all selected button from More drop down")
    public AdbankBatchEditFilePopUp openEditAssetPopUp(){
        AdbankLibraryPage page = getSut().getPageCreator().getLibraryPage();
        page.clickMoreButton();
        page.clickEditAllSelectedButtonFromMoreDropdown();
        return new AdbankBatchEditFilePopUp(page);
    }

    @When("{I |}click on '$assetType' on Edit asset popup")
    public void clickTabOnEditAssetPopup(String assetType) {
        AdbankBatchEditFilePopUp  adbankBatchEditFilePopUp = new AdbankBatchEditFilePopUp(getLibraryPage());
        adbankBatchEditFilePopUp.openTabOnAdbankBatchEditFilePopUp(assetType);
    }

    @Then("{I |}'$condition' see following '$fieldType' fields with values on opened Edit all selected asset popup: $data")
    public void checkDropdownFieldsValues(String condition, String fieldType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankBatchEditFilePopUp  popup = new AdbankBatchEditFilePopUp(getLibraryPage());

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            List<String> actualValues;

            if (fieldType.equalsIgnoreCase("dropdown")) {
                actualValues = popup.getAvailableComboBoxValues(row.getKey(), row.getSection());
                //NGN-16223-QAA: User can see Collections based on Market code changes starts
            } else if (fieldType.equalsIgnoreCase("autoSuggest")) {
                actualValues = popup.getAvailableAutoSuggestBoxValues(row.getKey(), row.getSection());
            }//NGN-16223-QAA: User can see Collections based on Market code changes Ends
            else if (fieldType.equalsIgnoreCase("radio buttons")) {
                actualValues = popup.getAvailableRadioButtonsValues(row.getKey(), row.getSection());
            }
            else {
                throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldType));
            }
            for (String expectedValue : row.getValue().split(","))
                assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
        }
    }

    @Then ("{I |} '$condition' see following '$fieldType' fields with expected values on opened Edit all selected asset popup: $data")
    public void checkDropdownFieldsValuesWithSizeCheck(String condition, String fieldType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankBatchEditFilePopUp  popup = new AdbankBatchEditFilePopUp(getLibraryPage());
        List<String> actualValues;
        List<String> expectedValues = new ArrayList<String>();
        int counter = 0;

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (fieldType.equalsIgnoreCase("dropdown")) {
                actualValues = popup.getAvailableComboBoxValues(row.getKey(), row.getSection());
                if(actualValues.get(0).isEmpty())
                    actualValues.remove(0);
                //NGN-16223-QAA: User can see Collections based on Market code changes starts
            } else {
                throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldType));
            }

            assertThat("Expected values list doesn't match the size of the Actual values list",actualValues.size()== row.getValue().split(",").length);
            for (String expectedValue : row.getValue().split(","))
                assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
        }
    }

    @When("{I fill |}'$action' asset info with the following fields on Edit all selected popup: $data")
    public void editAssetInfoFields(String action, ExamplesTable data) {
        AdbankBatchEditFilePopUp  popup = new AdbankBatchEditFilePopUp(getLibraryPage());
        popup.openTabOnAdbankBatchEditFilePopUp(action);
        popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
    }


    @When("{I |}'$action' after all the details are entered on the Edit all selected popup")
    public void popupAction(String action) {
        AdbankBatchEditFilePopUp  popup = new AdbankBatchEditFilePopUp(getLibraryPage());
        action = action.toLowerCase();

        if (action.matches("save|saved")) {
            popup.save();
        } else if (action.matches("cancel|canceled")) {
            popup.cancel();
        } else if (action.matches("close|closed")) {
            popup.close();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for edit file popup", action));
        }
    }


    @Then("{I |}'$condition' see asset '$file'")
    public void checkForAsset(String condition,String file) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPage LibraryFilesListPage = openLibraryPage();
        boolean actualState = LibraryFilesListPage.isAssetAvailable(prepareAssetName(file));
        assertThat(shouldState, equalTo(actualState));
    }

  }