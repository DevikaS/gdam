package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_created;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_modified;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.*;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.*;
import com.adstream.automate.babylon.sut.pages.adbank.dashboard.AdbankDashboardPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.library.BaseLibraryPage;
import com.adstream.automate.babylon.sut.pages.library.collections.*;
import com.adstream.automate.babylon.sut.pages.library.elements.*;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import com.google.gson.*;
import com.adstream.automate.babylon.sut.pages.library.BaseLibraryPage;
import com.adstream.automate.page.Page;
import org.apache.tools.ant.filters.TokenFilter;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.By;

import java.awt.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.containsString;

/**
 * Created by Janaki.Kamat on 27/04/2017.
 */
public class NewLibrarySteps extends LibraryHelperSteps {
    private static final int ASSETS_ON_PAGE = 20;
    private static final List<String> filters = asList("Business Unit", "Advertiser", "Originator");
    private int nextPaginationButtonScrollPosition;

    @Given("{I am |}on {the|} {L|l}ibrary page for collection '$categoriesName'NEWLIB")
    @When("{I |}go to {the|} {L|l}ibrary page for collection '$categoriesName'NEWLIB")
    public LibraryAsset openLibraryPage(String categoriesName) {
        String collectionName = wrapCollectionName(categoriesName);
        Common.sleep(3000);
        return (getSut().getPageNavigator().getLibraryPageNEWLIB(collectionName, getCategoryId(wrapCollectionName(collectionName))));
    }

    @Given("{I am |}on {the|} filter page for collection '$categoriesName'NEWLIB")
    @When("{I |}go to {the|} filter page for collection '$categoriesName'NEWLIB")
    public LibraryAsset openCollectionFilterPage(String categoriesName) {
        String collectionName = wrapCollectionName(categoriesName);
        Common.sleep(3000);
        return (getSut().getPageNavigator().getCollectionFilterPage(collectionName, getCategoryId(wrapCollectionName(collectionName))));
    }


    @When("{I |}go to the library page of collection '$categoriesName' for user '$email'NEWLIB")
    public LibraryAsset openLibraryPageForClient(String categoriesName,String email) {
        User user =getCoreApi().getUserByEmail(email);
        String userId = user.getId();
        String collectionName = wrapCollectionName(categoriesName);
        getSut().getWebDriver().navigate().refresh();
        Common.sleep(3000);
        return (getSut().getPageNavigator().getLibraryPageNEWLIB(collectionName, getCategoryIdForClient(wrapCollectionName(collectionName),userId)));
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the collection '$collectionName'NEWLIB")
    public void checkAssetsVisibilityNEWLIB(String condition, String expectedAssetNames, String collectionName) {
        checkAssetsVisibility(condition, expectedAssetNames, openLibraryPageWithoutRefresh(collectionName));
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the list view on collection '$collectionName'NEWLIB")
    public void checkAssetsVisibilityOnListView(String condition, String expectedAssetNames, String collectionName) {
        checkAssetsVisibilityOnListView(condition, expectedAssetNames, openLibraryPageWithoutRefresh(collectionName));
    }

    @Then("{I |}'$condition' see assets with id '$expectedAssetNames' in the collection '$collectionName'NEWLIB")
    public void checkAssetsIdVisibilityNEWLIB(String condition, String expectedAssetNames, String collectionName) {
        checkAssetsIdVisibility(condition, expectedAssetNames, openLibraryPageWithoutRefresh(collectionName));
    }

    @When("{I |}click Send To Delivery from library '$collection' collectionNEWLIB")
    public void clickSendToDeliveryNEWLIB(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        libraryPage.openPopup().clickSendToDelivery();
    }


    @Then("I '$condition' see a message '$message' in library collection '$collectionName'")
    public static void checkWarningMessageNEWLIB(String condition, String message, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean actual = libraryPage.verifyWarningMessage(message);
        assertThat(actual, equalTo(shouldState));
    }

    @Then("I '$condition' see the collection '$collectionName' navigates to '$viewType' by default")
    public static void checkColectionView(String condition,String collectionName,String viewType) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionPage();
        boolean actual = libraryPage.verifyCollectionView(viewType);
        assertThat(actual, equalTo(shouldState));
    }

    @When("{I |}click on collection '$collection' under My Collections")
    public void clickCollectionUnderMyCollection(String collection) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        page.clickCollectionUnderMyCollection(wrapVariableWithTestSession(collection));
    }

    @Then("I should see assets '$assetName' count '$count' in library assets pageNEWLIB")
    public void checkAssetCountNEWLIB(String assetName, int count) {
        LibraryAsset page = getSut().getPageCreator().getNewAdbankLibraryPage();
        assertThat(page.getFilesCount(getAssetName(assetName)), greaterThanOrEqualTo(count));

    }

    @When("I set pagination '$setPagination' in library assets pageNEWLIB")
    public void setPaginationOnLibraryAssetsPage(String setPagination) {
        LibraryAsset page = getSut().getPageCreator().getNewAdbankLibraryPage();
        page.setPagination(Integer.parseInt(setPagination));
    }

    @When("I click '$navigateTo' button in library assets pageNEWLIB")
    public void clickNavigationButtonsOnLibraryAssetsPage(String navigateTo) {
        LibraryAsset page = getSut().getPageCreator().getNewAdbankLibraryPage();
        if(navigateTo.equalsIgnoreCase("Next"))
        {
            page.clickNextPagination();
        }
        else if(navigateTo.equalsIgnoreCase("Previous"))
        {
            page.clickPreviousPagination();
        }
    }

    @When("I save Next pagination button position on collection '$collectionName' page")
    public void clickNextPaginationButtonPosition(String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        this.nextPaginationButtonScrollPosition=libraryPage.getNextPaginationButtonPosition();
    }

    @Then("{I |}'$condition' see Next pagination button on same position on collection '$collectionName' page")
    public void checkNextPaginationButtonPosition(String condition,String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean shouldState = condition.equalsIgnoreCase("should");
        if(shouldState)
        {assertThat(this.nextPaginationButtonScrollPosition, equalTo((libraryPage.getNextPaginationButtonPosition())));}
        else
        {assertThat(this.nextPaginationButtonScrollPosition, not(equalTo((libraryPage.getNextPaginationButtonPosition()))));}

    }


    @When("{I |}switch to '$typeView' view from the collection '$collectionName' pageNEWLIB")
    public void switchToFilesView(String typeView, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        if (typeView.equalsIgnoreCase("list")) {
            libraryPage.clickListView();
        } else if (typeView.equalsIgnoreCase("grid")) {
            libraryPage.clickGridView();
        }
    }


    @Given("{I |}scrolled down to file number '$fileNumber' on library page for collection '$collectionName'NEWLIB")
    @When("{I |}scroll down to file number '$fileNumber' on library page for collection '$collectionName'NEWLIB")
    public void scrollDownToFooterOnListView(int fileNumber, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libraryPage.scrollDownToFileOnListView(fileNumber);

    }

    @When("I set pagination '$setPagination' in collection '$collectionName' pageNEWLIB")
    public void setPaginationOnCollectionPage(String setPagination,String collectionName ) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libraryPage.setPagination(Integer.parseInt(setPagination));
    }


    @When("I open Add Usage Rights Popup from collection '$collectionName' pageNEWLIB")
    public void setPaginationOnCollectionPage(String collectionName ) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        LibAddUsageRightsPopup libAddUsageRightsPopup = libraryPage.openPopup().clickUsageRightsButton();
    }

    @When("{I |} navigate to collection '$collectionName' filter pageNEWLIB")
    public void navigateToCollectionFilterPage(String collectionName)
    {
        String categoryId = getCategoryId(wrapCollectionName(collectionName));
        LibraryAsset libraryPage = getSut().getPageNavigator().getCollectionFilterPage(collectionName, categoryId);
        Common.sleep(1000);
    }

    @When("I click '$navigateTo' button on collection '$collectionName' pageNEWLIB")
    public void clickNavigationButtonsOnCollectionPage(String navigateTo, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        if(navigateTo.equalsIgnoreCase("Next"))
        {
            libraryPage.clickNextPagination();
        }
        else if(navigateTo.equalsIgnoreCase("Previous"))
        {
            libraryPage.clickPreviousPagination();
        }
    }



    @Then("{I |}should see assets in the '$typeView' view in the collection '$collectionName' pageNEWLIB")
    public void checkFilesViewState(String typeView, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        switch (typeView.toLowerCase()) {
            case "list":
                assertThat(libraryPage.isViewOfFilesIsList(), is(true));
                break;
            case "grid":
                assertThat(libraryPage.isViewOfFilesIsGrid(), is(true));
                break;
            default:
                throw new IllegalArgumentException("Unknown type of view: " + typeView);
        }
    }

    @When("{I }sort files list view in library for collection '$collectionName' by column '$column' order '$order'NEWLIB")
    public void sortFilesListView(String collectionName, String columnName, String order) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libraryPage.sortListViewByColumn(columnName, order);
    }

    //sorting for list view
    @Then("{I |}should see assets sorting by '$sortingType' for collection '$collectionName' on the library pageNEWLIB")
    public void checkAssetsSorting(String sortingType, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setResultsOnPage(1000).setSortingField("_created").setSortingOrder("desc");
        SearchResult<Content> assets = getCoreApi().findAssets(collectionId, query);
        List<String> assetsFromPage = libraryPage.getObjectsTitle();
        List<String> sortedAssetsFromPage = new ArrayList<>();
        List<Content> sortedListOfContent = new ArrayList<>(assets.getResult());
        sortedAssetsFromPage.addAll(assetsFromPage);
        if (sortingType.contains("Last Uploaded First")) {
            Collections.sort(sortedListOfContent, Collections.reverseOrder(new ComparatorContentBy_created()));
        } else if (sortingType.contains("Last Uploaded Last")) {
            Collections.sort(sortedListOfContent, new ComparatorContentBy_created());
        } else if (sortingType.contains("Size (Descending)")) {
            Collections.sort(sortedListOfContent, Collections.reverseOrder(new ComparatorContentByFileSize()));
        } else if (sortingType.contains("Size (Ascending)")) {
            Collections.sort(sortedListOfContent, new ComparatorContentByFileSize());
        }
        int correctCountOfAsset = assets.getResult().size();
        if ((sortingType.contains("Last Uploaded First")) || (sortingType.contains("Last Uploaded Last"))
                || (sortingType.contains("Size (Descending)")) || (sortingType.contains("Size (Ascending)"))) {
            for (int i = 0; i < correctCountOfAsset; i++) {
                String data1 = new Gson().toJson(assets);
                assertThat(assetsFromPage.get(i), equalTo(libraryPage.getAssetsTitleByName(sortedListOfContent.get(i).getName())));
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


    @Then("I should see assets '$assetName' count '$count' in collection '$collectionName'NEWLIB")
    public void checkAssetCountInCollection(String assetName, int count, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        assertThat(libraryPage.getFilesCount(getAssetName(wrapVariableWithTestSession(assetName))), greaterThanOrEqualTo(count));

    }

    @Then("I '$condition' see total asset count '$count' in collection '$collectionName'NEWLIB")
    public void checkTotalAssetCountInCollectionNEWLIB(String condition, int count, String collectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean actual = libraryPage.getTotalAssetCount(count);
        assertThat(actual, is(expectedState));
    }



    @Then("I '$condition' see following metadata in tiles for asset '$assetName' in collection '$collectionName'NEWLIB:$data")
    public void verifyTilesForAsset(String condition,String assetName, String collectionName, ExamplesTable data) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        for (Map<String,String> field : parametrizeTableRows(data)) {
            String actualResult = libraryPage.verifyTilesMetaData(assetName, field.get("FieldName"), field.get("FieldValue"));
            assertThat(actualResult, containsString(field.get("FieldValue")));

        }
    }

    @Then("I '$condition' see usage rights indicator type '$type' for asset '$assetName' in collection '$collectionName'NEWLIB")
    public void verifyUsageRightsIndicator(String condition,String type, String assetName, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));

       assertThat(libraryPage.verifyUsageRightsTooltip(type,assetName), equalTo(shouldState));
   }

    @Then("I '$condition' see preview for asset '$assetName' in collection '$collectionName'NEWLIB")
    public void checkAssetPreviewNEWLIB(String condition, String assetName, String collectionName) {


        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (collectionName.equalsIgnoreCase("Everything")) {
            LibraryAsset page = getSut().getPageCreator().getNewAdbankLibraryPage();
            assertThat(page.isPreviewForFileAvailable(asset.getId()), equalTo(condition.equalsIgnoreCase("should")));
        } else {
            CollectionDetailsPage collection = getSut().getPageCreator().getCollectionDetailsPage();
            assertThat(collection.isPreviewForFileAvailable(asset.getId()), equalTo(condition.equalsIgnoreCase("should")));

        }

    }
    @Then("I '$condition' see usage rights indicator type '$type' for asset '$assetName' in collection '$collectionName' on list viewNEWLIB")
    public void verifyUsageRightsIndicatorOnListView(String condition,String type, String assetName, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));

        assertThat(libraryPage.verifyUsageRightsIndicatorOnListView(type,assetName), equalTo(shouldState));
    }

    @Given("{I |} '$check' the field '$fieldname' in section '$sectionName' of Collection '$collection' NEWLIB")
    @When("{I |} '$check' the field '$fieldname' in section '$sectionName' of Collection '$collection' NEWLIB")
    public void selectOption(String check, String fieldName, String sectionName, String collection) {
        for (String splitData : fieldName.split(","))
            getSut().getPageCreator().getLibraryPageNEWLIB(collection).selectField(check, splitData, sectionName);
    }

    @When("{I |}switch on media type filter '$filterName' from collection '$collectionName'NEWLIB")
    public void SwitchOnMediaTypeFilter(String filterName,String collectionName) {
        filterName=filterName.toLowerCase();
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
        libraryPage.clickAssetFilter();
        libraryPage.switchOnFilters(filterName);
    }

    //| Collection | AssetInclude | AssetExclude |
    @Then("I should see following assets in the collectionsNEWLIB: $visibilityTable")
    public void checkAssetsVisibility(ExamplesTable visibilityTable) {
        for (int i = 0; i < visibilityTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(visibilityTable, i);
            if (row.get("Collection") != null) {
                String categoryId = getCategoryId(wrapCollectionName(row.get("Collection")));
                LibraryAsset libraryPage = getSut().getPageNavigator().getCollectionFilterPage(row.get("Collection"), categoryId);
                Common.sleep(2000);
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

    @Then("I should see following filter state for collection '$collection' NEWLIB: $filterTable")
    public void checkFilterStateNewLibrary(String collection, ExamplesTable filterTable) {
        CollectionFilterPage filter = getSut().getPageCreator().getCollectionFilterPage();
        for (int i = 0; i < filterTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filterTable, i);
            if ((row.get("Filter") != null) || (row.get("State") != null)) {
                boolean state = row.get("State").equalsIgnoreCase("on");
                assertThat(filter.getFiltersState(row.get("Filter")), equalTo(state));
            }
        }

    }


    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the current collectionNEWLIB")
    public void checkAssetsVisibility(String condition, String expectedAssetNames, LibraryAsset page) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = page.getUploadedElementsText();
        if (expectedAssetNames.isEmpty() && shouldState) {
            assertThat(actualAssetNames.size(), equalTo(0));
        } else {
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' in list view on current collectionNEWLIB")
    public void checkAssetsVisibilityOnListView(String condition, String expectedAssetNames, LibraryAsset page) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = page.getUploadedElementsTextOnListView();
        if (expectedAssetNames.isEmpty() && shouldState) {
            assertThat(actualAssetNames.size(), equalTo(0));
        } else {
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }
    }


    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the filter pageNEWLIB")
    public void checkAssetsVisibilityInFilterPage(String condition, String expectedAssetNames) {
        CollectionFilterPage page = getSut().getPageCreator().getCollectionFilterPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = page.getUploadedElementsText();
        if (expectedAssetNames.isEmpty() && shouldState) {
            assertThat(actualAssetNames.size(), equalTo(0));
        } else {
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }
    }


    @Then("{I |}'$condition' see assets with id '$expectedAssetNames' in the current collectionNEWLIB")
    public void checkAssetsIdVisibility(String condition, String expectedAssetNames, LibraryAsset page) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = page.getUploadedElementsText();
        if (expectedAssetNames.isEmpty() && shouldState) {
            assertThat(actualAssetNames.size(), equalTo(0));
        } else {
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(wrapVariableWithTestSession(expectedAssetName)), is(shouldState));
            }
        }
    }

    @Given("{I |}uploaded file '$fileName' into my libraryNEWLIB")
    @When("{I |}upload file '$fileName' into my libraryNEWLIB")
    public void uploadAssetIntoMyLibrary(String fileName) {
        uploadSimilarFilesIntoLibrary(fileName, 1);
    }

    @Given("{I |}uploaded following files into my libraryNEWLIB: $data")
    @When("{I |}upload following files into my libraryNEWLIB: $data")
    public void uploadAssetsIntoMyLibrary(ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            uploadAssetIntoMyLibrary(row.get("Name"));
        }
    }

    @Given("{I |}uploaded file '$fileName' '$assetCount' times to libraryNEWLIB")
    @When("{I |}upload file '$fileName' '$assetCount' times to libraryNEWLIB")
    public void uploadSimilarFilesIntoLibrary(String fileName, int assetCount) {
        for (int i = 0; i < assetCount; i++) {
            createAsset(fileName);
        }
    }

    @Given("{I |}waited while transcoding is finished in collection '$collectionName'NEWLIB")
    @When("{I |}wait while transcoding is finished in collection '$collectionName'NEWLIB")
    public void

    waitWhileTranscodingIsFinished(String collectionName) {
        waitForSpecOrPreview(collectionName, null, false);
    }


    @Given("{I |}waited while previews are visible on library page for collection '$collectionName' for asset '$assetName'NEWLIB")
    @When("{I |}wait while previews are visible on library page for collection '$collectionName' for asset '$assetName'NEWLIB")
    public void waitWhilePreviewsIsVisible(String collectionName, String assetName) {
        String[] fileArray = assetName.split(",");
        for (String file : fileArray) {
            waitForSpecOrPreview(collectionName, file, true);
        }
    }

    @Given("{I |}waiting while transcoding is finished in collection '$collectionName' for asset '$assetName'NEWLIB")
    @When("{I |}wait while transcoding is finished in collection '$collectionName' for asset '$assetName'NEWLIB")
    public void waitUntilTranscodingFinishedForAsset(String collectionName, String assetName) {
        waitForSpecOrPreview(collectionName, assetName, false);
    }

    private void waitForSpecOrPreview(final String collectionName, final String assetName, boolean waitForPreview) {
        final String collectionId = getCategoryId(wrapCollectionName(collectionName));
        getSut().getPageNavigator().getLibraryPageNEWLIB(collectionName, collectionId);
        Common.sleep(2000);
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
                getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
            }
        }.process(waitForPreview);

        getSut().getWebDriver().navigate().refresh();
        getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
    }


    @Given("{I |}selected asset '$assetName' in the '$collectionName' library pageNEWLIB")
    @When("{I |}select asset '$assetName' in the '$collectionName'  library pageNEWLIB")
    public void selectAssets(String assetName, String collectionName) {
        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));
        Common.sleep(4000);
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
    }



    @Then("{I |}'$condition' see '$option' option in menu for collection '$collectionName'NEWLIB")
    public void checkVisibilityOfOptionsinMenu(String condition, String option,String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean expectedState = condition.equals("should");
        boolean actualState = false;
        option = option.toLowerCase();
        switch (option) {
            case "remove":
                actualState = page.openPopup().isRemoveOptionVisible();
                break;
            case "remove from collection":
                actualState = page.openPopup().isRemoveFromCollectionOptionVisible();
                break;
            case "add to work request":
                actualState = page.openPopup().isAddToWorkRequestOptionVisible();
                break;
            case "send to delivery":
                actualState = page.openPopup().isSendToDeliveryOptionVisible();
                break;

            case "add usage rights":
                actualState = page.openPopup().isUsageRightsOptionVisible();
                break;

            default:
                throw new IllegalArgumentException(String.format("Unknown option name '%s'", option));
        }

        String message = String.format("Option '%s' is not present on collection page", option);
        assertThat(message, actualState, equalTo(expectedState));

    }


    @Then("{I |}'$condition' see menu on collection '$collectionName'NEWLIB")
    public void checkVisibilityOfMenu(String condition, String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean expectedState = condition.equals("should");
        boolean actualState = page.isMenuExist();
        assertThat(actualState, equalTo(expectedState));

    }
    @Given("{I |}selected asset '$assetName' from filter pageNEWLIB")
    @When("{I |}select asset '$assetName' from filter pageNEWLIB")
    public void selectAssetsFromFilterPage(String assetName) {
        CollectionFilterPage page = getSut().getPageCreator().getCollectionFilterPage();
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
    }

    private LibraryAsset getLibraryPageNEW() {
        return getSut().getPageCreator().getLibraryPageNEWLIB("");
    }


    // As per old library if Parent Category is not provided the collection sits in My Assets, As of collection sits in the Primary BU
    @Given("{I |}created following collectionsNEWLIB: $collectionsTable")
    @When("{I |}create following collectionsNEWLIB: $collectionsTable")
    public void createNewCategories(ExamplesTable collectionsTable) {
        for (int i = 0; i < collectionsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(collectionsTable, i);
            String name = row.get("Name");
            AssetFilter category = getCoreApi().getAssetsFilterByName(wrapVariableWithTestSession(name), "");
            if (category == null || category.getId() == null) {
                JsonArray and = new JsonArray();
                addTermToCollectionQuery(and, "_cm.common.mediaType", row.get("MediaType"), true);
                addTermToCollectionQuery(and, "_cm.common.mediaSubType", row.get("MediaSubType"), true);
                if (row.get("ParentCategory") != null && !row.get("ParentCategory").isEmpty()) {
                    addTermToCollectionQuery(and, "categories", getCategoryId(wrapCollectionName(row.get("ParentCategory"))), false);
                }
                JsonObject jsonQuery = new JsonObject();
                jsonQuery.add("and", and);
                if (row.get("AssetName") != null && !row.get("AssetName").isEmpty()) {
                    AssetFilter assetFilter = getCoreApi().createAssetFilterNEWLIB(wrapVariableWithTestSession(name), jsonQuery.toString(), null);
                    for (String asset : row.get("AssetName").split(","))
                        getCoreApi().addAssetToCollection(name, jsonQuery.toString(), assetFilter.getId(), getAsset(getCategoryId("My Assets"), asset).getId());
                } else {
                    AssetFilter assetFilter = getCoreApi().createAssetFilterNEWLIB(wrapVariableWithTestSession(name), jsonQuery.toString(), null);
                }

                /* Middle tier changed for new library
              if(row.get("AssetName") != null && !row.get("AssetName").isEmpty()){
                   StringBuilder temp= new StringBuilder();
                   for (String asset : row.get("AssetName").split(",")){
                       temp.append(getAsset(getCategoryId("My Assets"), asset).getId()).append("\",\"");
                   }
                    AssetFilter assetFilter=getMtApi().createAssetFilterNEWLIB(wrapVariableWithTestSession(name), jsonQuery.toString(),temp.toString().substring(0,temp.toString().length()-3));
                }
                else{
                    AssetFilter assetFilter=getMtApi().createAssetFilterNEWLIB(wrapVariableWithTestSession(name), jsonQuery.toString(),null);
                }*/

                getCoreApi().getAssetsFilterByName(wrapVariableWithTestSession(name), "");
            }
        }
    }


    @Given("{I am |}on {the|} {L|l}ibrary pageNEWLIB")
    @When("{I |}go to {the|} {L|l}ibrary pageNEWLIB")
    @Then("{I |}go to {the|} {L|l}ibrary pageNEWLIB")
    public LibraryAsset openLibraryPage() {
        getSut().getWebDriver().navigate().refresh();
        Common.sleep(1000);
        return getSut().getPageNavigator().getLibraryPageNEWLIB("Everything", getCategoryId(wrapCollectionName("Everything")));
    }

    @When("I am on the library assets page")
    public NewAdbankLibraryAssetsPage getNewAdbankLibraryAssetsPage() {
        return getSut().getPageNavigator().getNewAdbankLibraryAssetsPage();

    }

    @Then("I '$condition' see asset '$assetName' with wrapped name in collection '$collectionName'NEWLIB")
    public void checkThatAssetTitleIsWrappedNewLib(String condition, String assetName, String collectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
         assertThat(libraryPage.isAssetNameWrapped(), is(expectedState));
    }

    @Then("I '$condition' see message '$message' on library assets page")
    public void verifyUserMessage(String condition,String message )
    {
        boolean shouldState = condition.equals("should");
        String actualMessage =  getSut().getPageCreator().getNewAdbankLibraryAssetsPage().IsMessageDisplayed();
        assertThat(actualMessage, shouldState ? equalTo(message) : not(equalTo(message)));
    }

    @When("I click on '$menuName' on top menu")
    public void clickLibraryOnTopMenu(String menuName) {
        getSut().getPageCreator().getNewAdbankLibraryAssetsPage().clickTopMenu(menuName);

    }

    @Then("{I |}'$condition' see '$menuName' on top menu")
    public void checkModuleExistOnTopMenu(String condition,String menuName)
    {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getNewAdbankLibraryAssetsPage().isMenuExist(menuName);
        assertThat("Verify modules on Top Menu", actualState, equalTo(expectedState));
    }

  @Then("{I |}'$condition' be on '$pageName' PageNEWLIB")
    public void checkLibraryPageOpenedNEWLIB(String condition,String pageName ) {

        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            if(pageName.equalsIgnoreCase("New Library")){
            getSut().getPageCreator().getNewAdbankLibraryAssetsPage();}
            else if(pageName.equalsIgnoreCase("Presentations")){
                getSut().getPageCreator().getLibraryAllPresentationsPage();
            }
            else if(pageName.equalsIgnoreCase("Collection Info")){
                getSut().getPageCreator().getCollectionDetailsPage();
            }
        } catch (Exception e) {
            actualState = false;
        }
        getSut().getPageCreator().getLibraryAllPresentationsPage();
        assertThat(actualState, is(expectedState));


    }

    @Then("{I |}'$condition' see the page navigated to '$pageUrl'")
    public void verifyPageNav(String condition,String pageUrl )
    {
        boolean expectedState = condition.equalsIgnoreCase("should");
        String actualNavUrl = getSut().getWebDriver().getCurrentUrl();
        assertThat(actualNavUrl, expectedState? containsString(pageUrl) : not(containsString(pageUrl)));
    }

    @Given("{I |}switched '$state' media type filter '$filterName' for collection '$collectionName' on the page {L|l}ibraryNEWLIB")
    @When("{I |}switch '$state' media type filter '$filterName' for collection '$collectionName' on the page LibraryNEWLIB")
    public void clickMediaTypeFilter(String state, String filterName, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
        Common.sleep(2000);
        libraryPage.clickAssetFilter();
        String[] arrayFilterName = filterName.split(",");
        for (String fN : arrayFilterName) {
            if (fN.isEmpty()) continue;
            libraryPage.switchFilterInNeedState(fN, state);
            Common.sleep(5000);
        }
    }

    @When("I click on Save Changes button on the collection filter page")
    public void clickButton() {
        getSut().getPageCreator().getCollectionFilterPage().clickSaveChanges();

    }

    @Given("{I |}switched '$state' media type filter '$filterName' on filter page")
    @When("{I |}switch '$state' media type filter '$filterName' on filter page")
    public void clickMediaTypeFilter_Collection(String state, String filterName) {
        filterName=filterName.toLowerCase();
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
        for (String filter : filterName.split(",")) {
        libraryPage.switchOnFilters(filter); }
    }

    @Given("{I |}uploaded following assetsNEWLIB: $assetName")
    @When("{I |}upload following assetsNEWLIB: $assetName")
    public void uploadAssets(ExamplesTable assetName) {
        uploadAssets(ASSETS_ON_PAGE, assetName);
    }

    @Then("I '$condition' see filters '$filters' in state '$state' for '$collectionName' collectionNEWLIB")
    public void checkFilterState(String condition, String filters, String state, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean filterState = state.equalsIgnoreCase("on");
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
         for (String filter : filters.split(",")) {
            String message = String.format("Filter '%s' should %sbe in state '%s'", filter, shouldState ? "" : "not ", state);
            assertThat(message, libraryPage.getFiltersState(LibraryAsset.MediaFilter.findByType(filter)), shouldState ? is(filterState) : not(is(filterState)));
        }
    }


    @Then("I should see following '$section' filter state for '$collectionName' collectionNEWLIB: $filterTable")
    public void checkFilterState(String section, String collectionName, ExamplesTable filterTable) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryFilterPage(wrapCollectionName(collectionName));
        boolean state = false;
        for (int i = 0; i < filterTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filterTable, i);
            switch (section) {
                case "MediaType":
                    if ((row.get("Filter") != null) && (row.get("State") != null)) {
                        state = row.get("State").equalsIgnoreCase("on");
                        assertThat(libraryPage.getFiltersState(LibraryAsset.MediaFilter.findByType(row.get("Filter"))), equalTo(state));
                    }
                    if ((row.get("Filter") != null) && (row.get("disabled") != null)) {
                        state = row.get("disabled").equalsIgnoreCase("yes");
                        assertThat(libraryPage.verifyFilterEnabled(LibraryAsset.MediaFilter.findByType(row.get("Filter"))), equalTo(state));
                    }
                    break;
                case "MediaSubType":
                    if ((row.get("Filter") != null) && (row.get("State") != null)) {
                        state = row.get("State").equalsIgnoreCase("on");
                        assertThat(libraryPage.getSubMediaState(LibraryAsset.MediaSubType.findByType(row.get("Filter"))), equalTo(state));
                    }
                case "Business Unit":
                case "Originator":
                case "Market":
                case "Advertiser":
                    if ((row.get("State") != null)) {
                        state = row.get("State").equalsIgnoreCase("on");
                        assertThat(libraryPage.isChecked(section, filters.contains(section) ? wrapVariableWithTestSession(row.get("Filter")) : row.get("Filter")), equalTo(state));
                    }
                    break;
                case "Campaign":
                    assertThat(libraryPage.getCampaignValue(), equalTo(row.get("Filter").trim().isEmpty() ? "" : wrapVariableWithTestSession(row.get("Filter"))));
                    break;

            }
        }
    }

    @Given("{I |}uploaded following assets with find existing among '$count' assetsNEWLIB: $assetName")
    @When("{I |}upload following assets with find existing among '$count' assetsNEWLIB: $assetName")
    public void uploadAssets(int count, ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("Name") != null) {
                createAssetIfNotVisibleOnFirstPage(getCategoryId("My Assets"), row.get("Name"), count);
            }
        }
    }



    @Given("{I |}scrolled down to footer '$times' times on opened Library pageNEWLIB")
    @When("{I |}scroll down to footer '$times' times on opened Library pageNEWLIB")
    public void scrollDownToFooterNEWLIB(int times) {
        LibraryAsset page = getSut().getPageCreator().getNewAdbankLibraryPage();
        for (int i = 0; i < times; i++) {
            page.scrollDownToFooter();
        }
        page.clickTopLabel(); //to get the focus
    }

    @Given("{I |}clicked following activity '$activity' on opened Library pageNEWLIB")
    @When("{I |}click following activity '$activity' on opened Library pageNEWLIB")
    public void clickOnActivityNEWLIB(String activity) {
        LibraryAsset page = getSut().getPageCreator().getNewAdbankLibraryPage();
        page.openAsset(activity);
        Common.sleep(1000);
    }

    @Given("{I |}selected all assets for collection '$collection' on the library pageNEWLIB")
    @When("{I |}select all assets for collection '$collection' on the library pageNEWLIB")
    public void clickSelectAll(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        libraryPage.clickSelectAll();
    }

    @Given("{I |}deselected all assets for collection '$collection' on the library pageNEWLIB")
    @When("{I |}deselect all assets for collection '$collection' on the library pageNEWLIB")
    public void clickDeselectAll(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        libraryPage.clickunSelectAll();
    }

    @When("{I |}select checkbox '$checkbox' and click download  for collection '$collectionName' on library page download popupNEWLIB")
    public void selectCheckboxesForDownload(String checkbox, String collectionName) {
        LibDownLoadPopup downloadFilePopUpWindow = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).clickDownloadOnLibrary();
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

    @Given("{I |}scrolled down to footer '$times' times on collection details pageNEWLIB")
    @When("{I |}scroll down to footer '$times' times on collection details pageNEWLIB")
    public void scrollDownToFooterOnCollectionDetailsPage(int times) {
        CollectionDetailsPage page = getSut().getPageCreator().getCollectionDetailsPage();
        for (int i = 0; i < times; i++) {
            page.scrollDownToFooterOnCollectionDetailsPage();
        }

    }

    @Given("{I |}waited while preview is visible on library page for collection '$collectionName' for assetsNEWLIB: $assetName")
    @When("{I |}wait while preview is visible on library page for collection '$collectionName' for assetsNEWLIB: $assetName")
    public void waitWhilePreviewIsVisible(String collectionName, ExamplesTable assetsTable) {
        for (int i = 0; i < assetsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(assetsTable, i);
            waitWhilePreviewIsVisible(collectionName, row.get("Name"));
        }
    }

    @When("{I |}wait while previews is visible on library page for collection '$collectionName' for the following assetsNEWLIB: $assetTable")
    public void waitWhilePreviewsIsVisible(String collectionName, ExamplesTable assetTable) {
        for (Map<String, String> row : assetTable.getRows()) {
            waitWhilePreviewIsVisible(collectionName, row.get("Name"));
        }
    }

    @Given("{I |}waited while preview is visible on library page for collection '$collectionName' for asset '$assetName'NEWLIB")
    @When("{I |}wait while preview is visible on library page for collection '$collectionName' for asset '$assetName'NEWLIB")
    public void waitWhilePreviewIsVisible(String collectionName, String assetName) {
        waitForSpecOrPreview(collectionName, assetName, true);
    }

    @Given("{I |}waited while preview is visible on library page for collection '$collectionName' for assets '$assetNames'NEWLIB")
    @When("{I |}wait while preview is visible on library page for collection '$collectionName' for assets '$assetNames'NEWLIB")
    public void waitWhilePreviewIsVisibleForAssets(String collectionName, String assetNames) {
        for (String assetName : assetNames.split(",")) {
            waitWhilePreviewIsVisible(collectionName, assetName);
        }
    }

    @Given("{I |}uploaded file '$assetName' into libraryNEWLIB")
    public void uploadAsset(String assetName) {
        String tableName = "| Name |";
        for (String fileName : assetName.split(",")) {
            tableName = tableName + String.format("\n | %s |", fileName);
        }
        uploadAssets(ASSETS_ON_PAGE, new ExamplesTable(tableName));
    }

    @Given("{I |}waited while preview is available in collection '$collectionName'NEWLIB")
    @When("{I |}wait while preview is available in collection '$collectionName'NEWLIB")
    public void waitWhilePreviewAvailableIsFinished(String collectionName) {
        waitForSpecOrPreview(collectionName, null, true);
    }




    @Given("{I |}select mediaSubType '$MediaSubType' of '$filter' for collection '$collectionName' on the page LibraryNEWLIB")
    @When("{I |}select mediaSubType '$MediaSubType' of '$filter' for collection '$collectionName' on the page LibraryNEWLIB")
    public void clickMediaSubTypeFilter(String MediaSubType, String filter, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
        if (!MediaSubType.isEmpty()) {
                    for (String subType : MediaSubType.split(",")) {
                        libraryPage.selectMediaSubType(subType);
                        Common.sleep(2000);
                    }
                }
   }


    @When("{I |}select '$section' with value '$field' in the collection '$collectionName'NEWLIB")
    public void selectFilterInLibrary(String section, String field, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
        for (String value : field.split(","))
            libraryPage.selectField("on", filters.contains(section) ? wrapPathWithTestSession(value) : value, section);
    }

    @Then("{I |}'$condition' see that filter '$filterName' has value '$filterValue' in the collection '$collectionName'NEWLIB")
    public void checkFilterValueNewLib(String condition, String filterName, String filterValue,String collectionName) {
        boolean shouldState = condition.equals("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryFilterPage(collectionName);
        List<String> businessUnitList=libraryPage.getValuesFromFilter(filterName);
        for (String filter : filterValue.split(",")) {
            assertThat(wrapVariableWithTestSession(filter), shouldState ? isIn(businessUnitList) : not(isIn(businessUnitList)));
        }

            }

    @When("{I |}select '$section' with value '$field' as filter collection '$collectionName'NEWLIB")
    public void selectFilterForSubCollections(String section, String field, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryFilterPage(collectionName);
        for (String value : field.split(","))
            libraryPage.selectField("on", filters.contains(section) ? wrapPathWithTestSession(value) : value, section);
    }

    @When("{I |}select usage rights date '$section' with value '$field' as filter collection '$collectionName'NEWLIB")
    public void selectUsageRightsDateFilter(String section, String field, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryFilterPage(collectionName);
        libraryPage.enterUsageRightsDate(section,field);

    }

    @When("{I |}enter value '$value' for campaign in the collection '$collectionName'NEWLIB")
    public void enterValueForCampaign(String value, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
        libraryPage.enterCampaignValue(value);
    }

    @When("{I |}enter value '$value' for campaign in Filter for Collection '$collectionName'")
    public void enterValueForCampaign_FilterPage(String value, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryFilterPage(collectionName);
        libraryPage.enterCampaignValue(value);
    }

    @Then("{I }'$condition' see assets '$assetList' selected in '$collectionName'")
    public void thenIshouldSeeAssetsInCollection(String condition, String assetList, String collectionName) {
        Boolean should = condition.equalsIgnoreCase("should");
        LibraryAsset libraryAsset = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
        for (String asset : assetList.split(",")) {
            assertThat(libraryAsset.isAssetSelected(asset), equalTo(should));
        }
    }

    @Then("{I |}'$shouldState' see Upload button on collection '$collectionName' in LibraryNEWLIB")
    public void checkVisibilityUploadButton(String shouldState, String collectionName) {
        LibraryAsset libraryPage = openLibraryPage(collectionName);
        boolean should = shouldState.equals("should");
        assertThat(libraryPage.isUploadButtonVisible(), equalTo(should));
    }

    @Then("{I |}should see for collection '$collectionName' in Library following files metadataNEWLIB : $metadata")
    public void checkFilesMetadata(String collectionName, ExamplesTable metadata) {
        LibraryAsset libraryPage = openLibraryPage(collectionName);
        for (int i = 0; i < metadata.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadata, i);
            LibraryAsset.LibraryFileMetadata fileMetadata = libraryPage.getFileLibraryMetadata(row.get("FileName"));
            assertThat("Title", fileMetadata.getName(), equalTo(row.get("FileName")));
            if (row.get("ShortId") != null)
                assertThat("ShortId", fileMetadata.getBusinessUnit(), equalTo(wrapVariableWithTestSession(row.get("ShortId"))));
            if (row.get("Type") != null) assertThat("Type", fileMetadata.getType(), equalTo(row.get("Type")));
        }
    }


    @Given("{I |}uploaded file '$fileName' into libraryNEWLIB")
    @Alias("{I |}uploaded asset '$assetName' into libraryNEWLIB")
    @When("{I |}upload file '$fileName' into libraryNEWLIB")
    @Then("{I |}upload file '$fileName' into libraryNEWLIB")
    public void uploadFileIntoLibrary(String fileNames) {
        String tableString = "| Name |";
        for (String fileName : fileNames.split(",")) {
            tableString += String.format("\n| %s |", fileName);
        }
        uploadAssets(ASSETS_ON_PAGE, new ExamplesTable(tableString));
    }

    @Given("{I |}uploaded following assets into following agenciesNEWLIB: $data")
    @When("{I |}upload following assets into following agenciesNEWLIB: $data")
    public void uploadAssetsIntoDifferentAgencies(ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            String agencyId = getCoreApiAdmin().getAgencyByName(wrapAgencyName(row.get("AgencyName"))).getId();
            createAsset(row.get("Name"), agencyId);
        }
    }

    @Given("{I }cleared the filter '$filterName' with value '$filterValue' on '$collection' page")
    @When("{I }clear the filter '$filterName' with value '$filterValue' on '$collection' page")
    public void clearFilter(String filterName, String filterValue, String collection) {
        LibraryAsset libAsset = openLibraryPageWithoutRefresh(wrapCollectionName(collection));
        if (filterValue != null && !filterValue.trim().isEmpty()) {
            for (String value : filterValue.split(","))
                libAsset.clearFilter(filterName, filters.contains(filterName) ? wrapVariableWithTestSession(value) : value);
        }
    }


    @Given("{I |}clicked element '$elementName' on collection '$collectionName'NEWLIB")
    @When("{I |}click element '$elementName' on collection '$collectionName'NEWLIB")
    public void clickComboBox(String elementName, String collectionName) {
        LibraryAsset libAsset = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libAsset.clickSortCombo();
    }

    @Then("{I |}'$condition' see following elements on collection '$collectionName'NEWLIB:$sortingTable")
    public void verifySortOption(String condition, String collectionName, ExamplesTable sortingTable) {
        boolean should = condition.equalsIgnoreCase("should");
        LibraryAsset libAsset = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libAsset.clickSortCombo();
        for (int i = 0; i < sortingTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(sortingTable, i);
            assertThat("Sorting list should have value " + row.get("element"), libAsset.getSortingOptionsList().contains(row.get("element")));
        }

    }


    @Then("I should see on the library page for '$collectionName' that element sort by has value '$value'NEWLIB")
    public void checkSortByLabel(String collectionName, String value) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
        assertThat(libraryPage.getSortByValue(), equalTo(value));
    }


    @When("{I |}select Sort By '$sortingBy' in collection '$collectionName'NEWLIB")
    public void selectSortByValue(String sortingBy, String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(collectionName);
        libraryPage.setSortBy(sortingBy);
    }

    @Given("{I |}accepted all assets on Shared Collection '$categoryName' from agency '$agencyName' pageNEWLIB")
    @When("{I |}accept all assets on Shared Collection '$categoryName' from agency '$agencyName' pageNEWLIB")
    public void acceptAllAssetsForCollectionFromAgency(String categoryName, String agencyName) {
        String categoryId = getCoreApi().getInboxCategoryByName(getAgencyIdByName(wrapAgencyName(agencyName)), wrapCollectionName(categoryName)).getId();
        getCoreApi().acceptAssetsFromCollection(categoryId, getAssets(categoryId));
    }



   @When("I click on filter link for collection '$collection'")
    public void clickFilterLinkCollectionDetails(String collection) {
        LibraryAsset libraryAsset = getSut().getPageCreator().getLibraryPageNEWLIB(collection);
        libraryAsset.clickAssetFilter();
    }

    @Then("{I |}'$condition' see common filters field with expander on filter page")
    public void checkPresenceOfExpanderForCommonFilters(String condition) {
        boolean should = condition.equals("should");
        LibraryAsset libraryAsset = getSut().getPageCreator().getCollectionFilterPage();
        assertThat(libraryAsset.verifyPresenceOfExpanderForCommonFilters(), is(should));

    }

    @Then("{I |}'$condition' see business unit field appears at top under common filters on filter page")
    public void checkPositionOfBUFieldUnderCommonFilters(String condition) {
        boolean should = condition.equals("should");
        LibraryAsset libraryAsset = getSut().getPageCreator().getCollectionFilterPage();
        assertThat(libraryAsset.isBusinessUnitAppearsAtTopUnderCommonFilters(), is(should));

    }

    @Then("{I |}'$condition' see asset type changed to '$assetType' for asset '$assetName' on '$collection' page")
    public void changeMedia(String condition, String assetType, String assetName, String collection) {
        boolean should = condition.equals("should");
        LibraryAsset libraryAsset = getSut().getPageNavigator().getLibraryPageNEWLIB(collection, getCategoryId(collection));
        assertThat(libraryAsset.getAssetTypeInfo(assetType, assetName), is(should));

    }


    @Then("I should see assets '$assetName' count '$count' in '$collection' libraryNEWLIB")
    public void checkAssetCount(String assetName, int count, String collection) {
        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        assertThat(page.getCount(getAssetName(assetName)), greaterThanOrEqualTo(count));
    }

    @Then("{I |}'$condition' see asset count '$expectedCount' in '$collection' NEWLIB")
    public void checkAssetCountOnNewLib(String condition, int expectedCount, String collection) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualCount = page.getAssetCount();
        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

    @Then("{I |}'$condition' see asset count '$expectedCount' in collection filter pageNEWLIB")
    public void checkAssetCountOnFilterPage(String condition, int expectedCount) {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualCount = page.getAssetCount();
        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));

    }
    @Then("{I |}'$condition' see asset count greater than '$expectedCount' in collection filter pageNEWLIB")
    public void checkAssetCountOnFilterPageForGreaterCondition(String condition, int expectedCount) {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualCount = page.getAssetCount();
        assertThat(actualCount, shouldState ? greaterThanOrEqualTo(expectedCount) : not(greaterThanOrEqualTo(actualCount)));

    }

    @Then("{I |}'$condition' see the following metadata editable in collection filter pageNEWLIB: $metadata")
    public void checkMetadataOnFilterPage(String condition,ExamplesTable metadata) {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (int i = 0; i < metadata.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(metadata, i);

            assertThat("message", page.isMetadataEditable(row.get("MetaData")), equalTo(shouldState));

        }

    }

    @Then("{I |}'$condition' see the keyword '$keyword' accepted")
    public void searchKeyword(String condition,String keyword)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        for (String key : keyword.split(",")) {
            assertThat(page.isKeywordAccepted(key), shouldState ? equalTo(true) : equalTo(false));
        }
    }


    @Then("{I |}'$condition' see asset with following titles on opened '$collection' Library pageNEWLIB: $data")
    public void checkAsset(String condition, String collection, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(collection, getCategoryId(wrapCollectionName(collection)));
        for (Map<String, String> row : parametrizeTableRows(data)) {
            assertThat(Integer.valueOf(page.getCount(row.get("AssetTitle"))).intValue() > 0, equalTo(shouldState));
        }
    }


    @Then("{I |}should see available preview for asset '$assetNames' in collection '$collectionName'NEWLIB")
    public void checkAvailabilityAssetsPreview(String assetNames, String collectionName) {
        LibraryAsset libraryPage = openLibraryPage(collectionName);
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        String[] assetArray = assetNames.split(",");
        for (String assetName : assetArray) {
        Content asset = getAsset(collectionId, assetName);
        assertThat(libraryPage.isPreviewVisible(asset.getId()), equalTo(true)); }
    }


    @When("{I |}changing title of asset '$assetName' to following title '$assetTitleNew' on library page for collection '$collectionName'NEWLIB")
    public void changeAssetTitle(String assetName, String assetTitleNew, String collectionName) {
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), assetName);
        asset.setName(assetTitleNew);
        getCoreApi().updateAsset(asset);
    }


    @Given("{I |}appended file '$fileName' to library for collection '$collectionName' while file count less than '$expectedAssetsCount'NEWLIB")
    @When("{I |}append file '$fileName' to library for collection '$collectionName' while file count less than '$expectedAssetsCount'NEWLIB")
    public void appendFileIntoLibrary(String fileName, String collectionName, int expectedAssetsCount) {
        uploadSimilarFilesIntoLibrary(fileName, expectedAssetsCount - getCoreApi().getAssetCountForCollection(getCategoryId(wrapCollectionName(collectionName))));
    }


    @When("{I |}select '$count' assets on '$collection' pageNEWLIB")
    public void selectSomeFiles(String count, String collection) {
        getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection)).selectAssets(count);
    }

    @Then("I should see '$count' selected note in files counter in '$collection'NEWLIB")
    public void checkFileCount(String count, String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        assertThat("(" + count + " selected)", equalTo(libraryPage.getLabelsValueAboutCountSelectedFiles()));
    }

    @When("I click on filter link on Collection details for collection '$collection'NEWLIB")
    public void clickFilterLink(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionDetailsPage();
        libraryPage.clickAssetFilter();

    }

    @When("{I |}search by keyword '$text' on the current filter pageNEWLIB")
    public void searchTextNewLibrary(String text)  {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
            page.enterSearchKeyword(text);

    }

    @When("{I |}click on asset '$assetName' on the current filter pageNEWLIB")
    public void clickAssetFromFilterPage(String assetName)  {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        page.clickAssetFromFilterPage(assetName);

    }

    @When("{I |}'$option' Match All Keywords on the current filter pageNEWLIB")
    public void checkMatchAllWords(String option) {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        page.checkMatchAllWords(option);
    }

    @Then("{I |}'$condition' see Match All Keywords checked by default on current filter pageNEWLIB")
    public void isMatchAllWordsChecked(String condition) {
        Boolean should = condition.equalsIgnoreCase("should");
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        assertThat(page.isMatchAllWordsChecked(), equalTo(should));
    }

    @When("{I |}clear the filter on library filter page")
    public void clearFilter()
    {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        page.clearAllFilters();
    }

    @Then("I should see media sub type '$subType' on current collection filter pageNEWLIB")
    public void verifyMediaSubType(String subType)
    {
        CollectionFilterPage page=getSut().getPageCreator().getCollectionFilterPage();
        assertThat(page.verifyMediaSubtypeOnFilterPanel(), equalTo(subType));

    }
    @Given("{I am |}on asset '$assetName' page in Library for collection '$categoriesName'NEWLIB")
    @When("{I |}go to asset '$assetName' page in Library for collection '$categoriesName'NEWLIB")
    public void openAssetPage(String assetName, String collectionName) {
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), assetName);
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libraryPage.clickAsset(getCategoryId(wrapCollectionName(collectionName)), asset.getId());
    }


    @Given("I am on Dashboard page from new library collection '$collectionName'")
    @When("{I |}go to Dashboard page from new library collection '$collectionName'")
    public void openDashboardPagefromNewLibrary(String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libraryPage.clickDashboardLink();
    }


    @Given("{I |}clicked on save changes on collection '$collectionName' page")
    @When("{I |}click on save changes on collection '$collectionName' page")
    public void clickSaveChanges(String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryFilterPage(wrapCollectionName(collectionName));
        libraryPage.clickSaveChanges();

    }

    @Given("{I |}clicked on cancel button in save changes popup warning on collection '$collectionName' page")
    @When("{I |}click on cancel button in save changes popup warning on collection '$collectionName' page")
    public void clickCancelChanges(String collectionName) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryFilterPage(wrapCollectionName(collectionName));
        libraryPage.clickCancelChanges();

    }

    @Given("{I |}selected asset '$assetName' in the '$collectionName'NEWLIB")
    @When("{I |}select asset '$assetName' in the '$collectionName'NEWLIB")
    public void selectAssetsInCollectionDetails(String assetName, String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
    }

    @Then("{I }'$condition' see create '$collectionType' button on '$collectionName' page")
    public void checkforButtonvisibilityForCreatingCollection(String condition, String collectionType, String collectionName) {
        Boolean should = condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        assertThat(collectionType + "button " + condition + " be visible", page.checkPresenceOfNewCollectionButton(collectionType), should ? is(true) : not(is(true)));
    }

    @Then("{I }'$condition' see option '$selectionType' button on '$collectionName' page")
    public void checkforButtonvisibilityOfSelectionType(String condition, String selectionType, String collectionName) {
        Boolean should = condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        assertThat(selectionType + "button " + condition + " be visible", page.checkPresenceOfSelectionTypeOptions(selectionType), should ? is(true) : not(is(true)));
    }



    @Then("{I |}'$condition' see '$option' option in Copy To menu for collection '$collectionName'NEWLIB")
    public void checkVisibilityOfOptionsinCopyToMenu(String condition, String option,String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean expectedState = condition.equals("should");
        boolean actualState = false;
        option = option.toLowerCase();
        switch (option) {
            case "project":
                actualState = page.openPopup().isAddToProjectVisible();
                break;
            case "presentation":
                actualState = page.openPopup().isAddToPresentationVisible();
                break;
            default:
                throw new IllegalArgumentException(String.format("Unknown option name '%s'", option));
        }

        String message = String.format("Option '%s' is not present under Copy To menu", option);
        assertThat(message, actualState, equalTo(expectedState));

    }





    @Given("{I |}deleted asset '$assetName' from collection '$collectionName' in LibraryNEWLIB")
    @When("{I |}delete asset '$assetName' from collection '$collectionName' in LibraryNEWLIB")
    public void deleteAssetFromLibrary(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        getCoreApi().deleteAsset(asset.getId());
    }




    @When("{I }'$action' column '$column' in the list view on '$collectionName' page")
    public void selectColumnInListView(String action, String column, String collectionName) {
       LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
       page.selectListViewColumn(action,column);
    }


    @When("{I }click reset to default in the list view on '$collectionName' page")
    public void clickResetToDefault(String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        page.clickResetToDefault();
    }


    @When("{I }click on list view Icon on '$collectionName' page")
    public void clickListViewIcon(String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        page.clickListViewIcon();
    }

    @Then("{I }'$condition' see the list columns in '$collectionName' page: $listTitlesTable")
    public void verifyColumnTitles(String condition,String collectionName,ExamplesTable listTitlesTable) {
        boolean should=condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        List<String> titleNames=page.getColumnTitles();
        for(Map<String,String> columnTitle:parametrizeTableRows(listTitlesTable)){
            String title=columnTitle.get("Title");
            assertThat(titleNames,should ? hasItem(title) : not(hasItem(title)));
        }
    }

    @Then("{I }'$condition' see the list columns selected in '$collectionName' page:$listTitlesTable")
    public void verifyColumnTitlesSelected(String condition,String collectionName,ExamplesTable listTitlesTable) {
        boolean should=condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        List<String> titleNames=page.getSelectedColumns();
        for(Map<String,String> columnTitle:parametrizeTableRows(listTitlesTable)){
            String title=columnTitle.get("Title");
            assertThat(titleNames,should ? hasItem(title) : not(hasItem(title)));
        }
    }


    @Then("{I |}should see the following fields for '$assetName' in list view of '$collectionName' page:$listTitlesTable")
    public void verifyDataForOrderItem(String assetName,String collectionName,ExamplesTable data) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        LibraryAsset.AssetInListView assetInListView = page.getAssetInListView(assetName);
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.containsKey("Title")) {
                assertThat("Title", assetInListView.getTitle(), equalTo(row.get("Title")));
            }
            if (row.containsKey("File Size")) {
                assertThat("File Size", assetInListView.getFileSize(), equalTo(row.get("File Size")));
            }
            if (row.containsKey("File Type")) {
                 assertThat("File Type", assetInListView.getFileType(), equalTo(row.get("File Type")));
            }
            if (row.containsKey("Originator")) {
                row.put("Originator", row.get("Originator"));
                assertThat("Originator", assetInListView.getOriginator().contains(row.get("Originator")));
            }
        }
    }

    @Then("{I }'$condition' see save changes button")
    public void checkForVisiilityofSaveChanges(String condition) {
        Boolean should = condition.equalsIgnoreCase("should");
        LibraryAsset libraryAsset = getSut().getPageCreator().getCollectionFilterPage();
        assertThat(libraryAsset.isSaveChangesButtonVisible(), equalTo(should));
        }


    @When("{I }close the popup menu on '$collectionName' page")
    public void closePopupMenu(String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        page.clickClosePopup();
    }


    @When("{I |}add additional filter as filter collection: $visibilityTable")
    public void selectAdditionalFilter(ExamplesTable visibilityTable) {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
        for (int i = 0; i < visibilityTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(visibilityTable, i);
            libraryPage.selectAdditionalField(row.get("value"),row.get("Additional Field"));
        }
    }

    @Then("I '$condition' see following metadata keys in the '$fieldName' drop-down menu for filter '$filterName' from current collection filter pageNEWLIB:$data")
    public void checkVisibilityOfKeyInTheMetadata(String condition,String fieldName,String filterName,ExamplesTable data) {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualValues=new ArrayList<>();
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (row.getKey().equalsIgnoreCase("Add more fields")) {
                actualValues = libraryPage.checkMetaDataValueInDropDown(filterName);
            } else {
                throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldName));
            }
            for (String expectedValue : row.getValue().split(",")){
                assertThat(actualValues, shouldState ? hasItem(expectedValue.trim()) : not(hasItem(expectedValue.trim())));}

        }
    }

    @When("{I |}add media subtype as filter collection: $visibilityTable")
    public void selectMediaSubType(ExamplesTable visibilityTable) {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
        for (int i = 0; i < visibilityTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(visibilityTable, i);
            if(row.get("value")!=null && !row.get("value").isEmpty())
            libraryPage.selectMediaSubType_1(row.get("value"));
        }
    }

    @When("{I |}click expand for '$mediaType'")
    public void clickExpand(String mediaType) {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
        for(String type:mediaType.split(","))
        libraryPage.clickExpandFilter(LibraryAsset.MediaFilter.findByType(type));
    }

    @When("{I |}click expand Usage rights on current filter page")
    public void clickExpandUsageRights() {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionFilterPage();
        libraryPage.expandUsageRights();
    }
}