package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibAcceptAssetSharedCategory;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAssetsInfoPage;
import com.adstream.automate.babylon.tests.steps.domain.NewLibrary.LibraryHelperSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Janaki.Kamat on 19/07/2017.
 */
public class CollectionPageSteps extends LibraryHelperSteps {

    @Given("I am on the collections page")
    @When("I go to the collections page")
    public CollectionPage getCollectionPage() {
        return getSut().getPageNavigator().getCollectionPage();
    }

    @Given("I searched the collection '$collection' on collections page")
    @When("I search the collection '$collection' on collections page")
    public void searchCollections(String collection) {
        CollectionPage page = getSut().getPageNavigator().getCollectionPage();
        page.searchCollection(collection);
    }


    @Given("I clicked the collection '$collection' on collections page")
    @When("I click the collection '$collection' on collections page")
    public void clickCollections(String collection) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        page.clickCollectionName(wrapCollectionName(collection));
    }

    @When("I '$set' the collection '$collection' as home collection on collections page")
    public void setAsHomeCollection(String setHomeCollection, String collection) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        switch (setHomeCollection) {
            case "set":
                page.setAsHomeCollection(wrapCollectionName(collection));
                break;
            case "unset":
                page.removeAsHomeCollection(wrapCollectionName(collection));
                break;
            default:
                throw new IllegalArgumentException("Illegal argument " + setHomeCollection + " for setting home collection");
        }

    }


    @Then("{I |}'$condition' see on the {L|l}ibrary page collections '$collectionName'NEWLIB")
    public void checkCollectionsVisibility(String condition, String collectionName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getListOfCollectionsNames();
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }



    @Then("{I |}should see on the {L|l}ibrary page collections message '$message'")
    public void checkNoMatchFoundMessage(String message) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        assertThat("No match found is not displayed", libraryPage.getMessageNoSearchMatches(), equalToIgnoringCase(message));

    }

    @Then("{I |}'$condition' see on the {L|l}ibrary page sub collections '$collectionName' under agency '$agencyName'NEWLIB")
    public void checkForSubCollectionsVisibility(String condition, String collectionName,String agencyName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        if(agencyName.equalsIgnoreCase("DefaultAgency"))
        { agencyName =getAgencyByName(agencyName).getName();
        }
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getSubCollectionNames(wrapVariableWithTestSession(agencyName));
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }

    //My Collections and My Assets
    @Then("{I |}'$condition' see on the {L|l}ibrary page sub collections '$collectionName' under parent collection '$parentName'NEWLIB")
    public void checkForSubCollectionsUnderParent(String condition, String collectionName,String parentName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getCollectionUnderParentCollections(parentName);
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }

    @When("I '$set' the collection My Assets as home collection on collections page")
    public void setMyAssetsAsHomeCollection(String setHomeCollection) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        switch (setHomeCollection) {
            case "set":
                page.setAsHomeCollectionMyAssets();
                break;
            case "unset":
                page.removeAsHomeCollectionMyAssets();
                break;
            default:
                throw new IllegalArgumentException("Illegal argument " + setHomeCollection + " for setting home collection");
        }

    }

    @Then("{I |}'$condition' see on the {L|l}ibrary page parent collections '$collectionName'NEWLIB")
    public void checkForParentCollectionsVisibility(String condition, String collectionName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getParentCollectionNames();
        for (String collection : collectionName.split(",")) {
            assertThat(collection, shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }



    @Then("{I |}'$condition' see on the collections page '$collectionName' created under Agency '$agencyName'")
    public void checkForSubCollectionsVisibility_UnderAgency(String condition, String collectionName, String agencyName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getCollectionUnderAgency(wrapAgencyName(agencyName));
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }

    @Then("{I |}'$condition' see on the collections page '$collectionName' created under '$parent'")
    public void checkForSubCollectionsVisibility_ParentCollection(String condition, String collectionName, String parent) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getCollectionUnderParent(parent);
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }

    @Then("{I |}'$condition' see on the collections page for '$collection':$data")
    public void checkForPopupOptions(String condition, String collection, ExamplesTable data) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> popupList = libraryPage.getPopupMenuOptions(wrapCollectionName(collection));
        for (Map<String, String> row : parametrizeTableRows(data))
            assertThat(row.get("Menu"), shouldState ? isIn(popupList) : not(isIn(popupList)));

    }

    @Then("{I} '$condition' see the shared collections for Agency '$agency':$data")
    public void checkForSharedCollections(String condition, String agencyName, ExamplesTable data) {
        Boolean should = condition.equalsIgnoreCase("should");
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        List<String> collectionList = collectionPage.getSharedCategory(wrapAgencyName(agencyName));
        for (Map<String, String> row : parametrizeTableRows(data)) {
            assertThat(wrapCollectionName(row.get("collection")), should ? isIn(collectionList) : not(isIn(collectionList)));
        }
    }

    @When("{I} '$subscribe' collection '$collection'")
    public void subscribeCollection(String subscribe, String collection) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        switch (subscribe) {
            case "subscribe":
                page.openMenuPopup_SharedCategory(collection).subscribeToCollection();
                break;
            case "unsubscribe":
                page.openMenuPopup_SharedCategory(collection).unSubscribeToCollection();
                break;
            default:
                throw new IllegalArgumentException("Illegal option " + subscribe);

        }
    }


    @Then("{I |} should see below fields in Collection tree:$data")
    public void checkLocalisationFields_LibraryPage(ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        if (row.containsKey("My Collections"))
            assertThat("My Collections does not show localisation", collectionPage.getMyCollection_Label().equalsIgnoreCase(row.get("My Collection")));
        if (row.containsKey("My Assets"))
            assertThat("My Assets does not show localisation", collectionPage.getMyAsset_Label().equalsIgnoreCase(row.get("My Assets")));

    }

    @When("{I }click library asset Tab on collection page")
    public void clickLibraryAssetTab() {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clickLibraryAssetTab();
        Common.sleep(1000);
    }

    @When("{I }click Collection Tab on collection page")
    public void clickCollectionTab() {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clickCollectionTab();
        Common.sleep(1000);
    }

   /* @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the collection '$collectionName'NEWLIB")
    public void checkAssetsVisibilityOnCollection(String condition, String assetsTitles, String collectionName) {
        getSut().getPageNavigator().getCollectionPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = getSut().getPageCreator().getCollectionPage().getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }*/

    @Then("I '$condition' see collection '$collection' in breadcrum on collections page")
    public void verifyCollectioninBreadCrum(String condition, String collection) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        Object[] collectionsList = page.getBreadCrum().toArray();
        String newString = null;
        StringBuilder actualstrBuilder = new StringBuilder();
        String[] stringArray = Arrays.toString(Arrays.copyOf(collectionsList, collectionsList.length, String[].class)).split("\n\uE90C, ");
        for (int i = 0; i < stringArray.length - 1; i++) {
            actualstrBuilder.append(stringArray[i].replace("[", "").replace("]", "")).append(">");
        }
        actualstrBuilder.append(stringArray[stringArray.length - 1].replace("]", ""));
        StringBuilder expstrBuilder = new StringBuilder();
        String[] expectedCollection = collection.split(">");
        for (int j = 0; j < expectedCollection.length - 1; j++) {
            expstrBuilder.append(expectedCollection[j]).append(">");
        }
        expstrBuilder.append(wrapCollectionName(expectedCollection[expectedCollection.length - 1]));
        assertThat("BreadCrum is not showing up correct hierarchy", expstrBuilder.toString(), equalToIgnoringWhiteSpace(actualstrBuilder.toString()));
    }

    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the collection page")
    public void checkAssetsVisibilityinCollectionPage(String condition, String assetsTitles) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = page.getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }


    @Given("{I am |}on asset '$assetName' page from '$collectionName' in collection page")
    @When("{I |}go to asset '$assetName' page from '$collectionName' in collection page")
    public void openAssetPage(String assetName, String collectionName) {
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), assetName);
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionPage();
        libraryPage.clickAsset(getCategoryId(wrapCollectionName(collectionName)), asset.getId());
    }


    @When("{I |}clear the search criteria in collection page")
    public void clearSearchCriteria() {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clearSearchCollection();
    }


    @When("{I |} click '$buttonName' button for the asset of the shared category on the collection page")
    public void acceptRejectAssetSharedCategory(String buttonName) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        LibAcceptAssetSharedCategory acceptAssetSharedCategory = collectionPage.sharedCategoryButton(buttonName);
    }

    @When("{I |} click shared collection '$collection' on the collection page")
    public void clickSharedCollection(String collection) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clickSharedCollection(wrapCollectionName(collection));
    }

    @When("{I |} click shared collection '$collection' on the collection page for Agency '$agencyName'")
    public void clickSharedCollection(String collection, String agencyName) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clickSharedCollection(wrapCollectionName(collection), wrapAgencyName(agencyName));
    }


    @When("{I |} select asset '$assetName' for collection '$collectionName' in the collections page")
    public void selectAsset(String assetName, String collectionName) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        for (String fileName : assetName.split(",")) collectionPage.selectFileByFileName(fileName);
    }


    @When("{I |} click '$confirm' button in accept reject assets popup")
    public void confirmAcceptRejectAssetSharedCategory(String confirm) {
        LibAcceptAssetSharedCategory acceptAssetSharedCategory = new LibAcceptAssetSharedCategory(getSut().getPageCreator().getCollectionPage());
        switch (confirm.toLowerCase()) {
            case "yes":
                acceptAssetSharedCategory.clickYes();
                break;
            case "cancel":
                acceptAssetSharedCategory.clickCancel();
                break;
            default:
                throw new IllegalArgumentException(String.format("%s is a incorrect option in this context", confirm));
        }
    }

    @When("{I |}click '$collectionName' in collection tree")
    public void clickCollectionInTree(String collectionName) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clickCollectionInTree(wrapCollectionName(collectionName));
    }

    @When("{I |}click '$collectionName' in the tree")
    public void clickParentInTree(String collectionName) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clickParentInTree(wrapCollectionName(collectionName));
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the collection")
    public void checkAssetsVisibility(String condition, String expectedAssetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = getSut().getPageCreator().getCollectionPage().getUploadedElementsText();
        if (expectedAssetNames.isEmpty() && shouldState) {
            assertThat(actualAssetNames.size(), equalTo(0));
        } else {
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }
    }

    @Then("{I} '$condition' see '$button' for the collection")
    public void checkButtonVisibility(String condition, String button) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        for (String btn : button.split(",")) {
            assertThat(collectionPage.checkVisibility(btn), is(expectedState));
        }

    }


    @When("{I |}click asset '$assetName' on the collection page")
    public void clickAsset(String assetName) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        String pattern = "\\.";
        Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(assetName);
        collectionPage.clickAsset(m.find() ? assetName : wrapPathWithTestSession(assetName));
    }

    @When("{I |}click on filter link on Collection page")
    public void clickFilterLink() {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionPage();
        libraryPage.clickAssetFilter();
    }

    @Then("{I |}'$condition' see '$assets' in library Shared Category popup window")
    public void checkAssetsinLibrarySharedCategory(String condition, String assets) {
        Boolean shouldState = "should".equalsIgnoreCase(condition);
        List<String> assetList = new LibAcceptAssetSharedCategory(getSut().getPageCreator().getCollectionPage()).getAssets();
        for (String asset : assets.split(","))
            assertThat(asset, shouldState ? isIn(assetList) : not(isIn(assetList)));

    }

    @When("{I |}wait for message '$message'")
    public void waitforAssetAcceptRejectMessage(String message) {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.waitForMessage(message);
    }

    @Then("{I |}'$condition' see admin icon for collection '$collectionName'")
    public void verifyAdminIconForCollection(String condition, String collectionName) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        boolean expectedState = condition.equals("should");
        assertThat(page.verifyAdminCollectionIcon(collectionName), is(expectedState));
    }

    @Then("{I |}'$condition' see list of collections '$collectionName' on the collection pageNEWLIB")
    public void checkListOfColections(String condition, String collectionName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getCollectionList();
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }

    @Then("I '$condition' see message '$message' on collection page")
    public void verifyUserMessage(String condition, String message) {
        boolean shouldState = condition.equals("should");
        String actualMessage = getSut().getPageCreator().getCollectionPage().IsMessageDisplayed();
        assertThat(actualMessage, shouldState ? equalTo(message) : not(equalTo(message)));
    }

    @Then("{I |} should see '$collection'  list emptyNEWLIB")
    public void checkCollectionsListEmpty(String collection) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean actual = libraryPage.verifyCollectionList(collection);
        assertThat(false, is(actual));

    }

    @Then("{I |}'$condition' see collection '$collectionName' under My Collections on the Library pageNEWLIB")
    public void checkCollectionsVisibilityUnderMyCollectionsNewLib(String condition,String collectionName) {
        CollectionPage libraryPage = getSut().getPageNavigator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        List<String> collectionsList = libraryPage.getMyCollections();
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(collectionsList) : not(isIn(collectionsList)));
        }
    }

    @Then("{I |}'$condition' see only one collection '$collectionName' under My Collections on the Library pageNEWLIB")
    public void checkCollectionsVisibilityWithoutDuplicatesNewLib(String condition,String collectionName) {
        CollectionPage libraryPage = getSut().getPageNavigator().getCollectionPage();
        List<String> collectionsList = libraryPage.getMyCollections();
        int collectionsWithSameNameCount = 0;
        for (String name : libraryPage.getListOfCollectionsNames()) {
            if (name.equalsIgnoreCase(wrapCollectionName(collectionName))) {
                collectionsWithSameNameCount++;
            }
        }
        assertThat(String.format("I should see only one collection '%s'", wrapCollectionName(collectionName)), collectionsWithSameNameCount, equalTo(1));
    }


    @When("I click on the shared category parent sub collections link on collections pageNEWLIB")
    public void clickSharedCategoryParentSubCollectionNewLibrary() {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        libraryPage.clickSharedParentSubCollectionLink();
    }


    @Then("{I |} '$condition' see series of sub collections '$collectionName' under agency '$agencyName'NEWLIB")
    public void verifyAllSharedSubCollectionsNewLibrary(String condition, String collectionName,String agencyName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        if(agencyName.equals("DefaultAgency")){
            agencyName=getAgencyByName(agencyName).getName();}
        List<String> actualSharedCollectionsList = libraryPage.getAllSharedSubCollections(collectionName,wrapVariableWithTestSession(agencyName));
        for (String collection : collectionName.split(",")) {
            assertThat(wrapCollectionName(collection), shouldState ? isIn(actualSharedCollectionsList) : not(isIn(actualSharedCollectionsList)));
        }
    }

    @Then("{I |}'$condition' see that following collections in BU on library pageNEWLIB: $data")
    public void checkThatAgencyContainsCollection(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            List<String> actualChildren = libraryPage.getAllChildItems(wrapVariableWithTestSession(row.get("ParentName")),wrapVariableWithTestSession(row.get("ChildName")));
            for (String expectedChildName : row.get("ChildName").split(",")) {
                expectedChildName = wrapVariableWithTestSession(expectedChildName);
                assertThat(actualChildren, shouldState ? hasItem(expectedChildName) : not(hasItem(expectedChildName)));
            }
        }
    }

    @Then("{I |}'$condition' see business unit '$agencyName' on collection pageNEWLIB")
    public void checkThatAgencyIsPresent(String condition, String agencyName) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAgencyNames = libraryPage.getAllAgencyNames();
        String expectedAgencyName = wrapVariableWithTestSession(agencyName);
        assertThat(actualAgencyNames, shouldState ? hasItem(expectedAgencyName) : not(hasItem(expectedAgencyName)));
    }

    @Then("{I |}'$condition' see trash on collection pageNEWLIB")
    public void checkThatTrashExist(String condition) {
        CollectionPage page = getSut().getPageNavigator().getCollectionPage();
        boolean expectedState = condition.equalsIgnoreCase("should");
        assertThat(page.isTrashExist(), is(expectedState));

    }

    @Then("{I |} should not see shared collection expandableNEWLIB")
    public void checkThatCollectionIsPresentNewLib() {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        assertThat(collectionPage.isSharedWithMeExpandable(), is(false));
    }


    @Then("{I |} '$condition' see collection '$collectionName' from agency '$agencyName' on inbox shared collectionNEWLIB")
    public void checkThatCollectionIsPresentNewlib(String condition, String collectionName,String agencyName ) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        List<String> sharedCollectionsList = collectionPage.getSharedCollections(wrapAgencyName(agencyName));
        String expectedCollectionName = wrapCollectionName(collectionName);
        assertThat(sharedCollectionsList, shouldState ? hasItem(expectedCollectionName) : not(hasItem(expectedCollectionName)));
    }

    @Then("{I |}'$condition' see shared collection link on collection pgeNEWLIB")
    public void checkThatSharedColectionIsPresent(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        assertThat(collectionPage.isSharedWithMeLinkExist(), is(expectedState));
    }


}