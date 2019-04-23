package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_created;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.inbox.AdbankSharedCollectionsPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.equalTo;

/**
 * User: lynda-k
 * Date: 20.12.13 10:00
 */
public class SharedCollectionsSteps extends BaseStep {

    @Given("{I am |}on the Shared Collections page")
    @When("{I |}go to the Shared Collections page")
    public AdbankSharedCollectionsPage openSharedCollectionsPage() {
        return getSut().getPageNavigator().getSharedCollectionsPage();
    }

    @Given("{I am |}on the Shared Collection '$categoryName' from agency '$agencyName' page")
    @When("{I |}go to the Shared Collection '$categoryName' from agency '$agencyName' page")
    public AdbankSharedCollectionsPage openSharedCollectionsPage(String categoryName, String agencyName) {
        String agencyId = getAgencyByName(agencyName).getId();
        String categoryId = getCoreApi().getInboxCategoryByName(agencyId, wrapCollectionName(categoryName)).getId();
        return getSut().getPageNavigator().getSharedCollectionsPage(agencyId, categoryId);
    }

    @Given("{I |}accepted all assets on Shared Collection '$categoryName' from agency '$agencyName' page")
    @When("{I |}accept all assets on Shared Collection '$categoryName' from agency '$agencyName' page")
    public void acceptAllAssetsForCollectionFromAgency(String categoryName, String agencyName) {
        AdbankSharedCollectionsPage page = openSharedCollectionsPage(categoryName, agencyName);
        if (page.getAssetsCount() > 0) {
            page.selectSelectAllCheckbox();
            page.clickAcceptButton().clickAction();
        }
    }

    @Given("{I |}rejected all assets on Shared Collection '$categoryName' from agency '$agencyName' page")
    @When("{I |}reject all assets on Shared Collection '$categoryName' from agency '$agencyName' page")
    public void rejectAllAssetsForCollectionFromAgency(String categoryName, String agencyName) {
        AdbankSharedCollectionsPage page = openSharedCollectionsPage(categoryName, agencyName);
        if (page.getAssetsCount() > 0) {
            page.selectSelectAllCheckbox();
            page.clickRejectButton().clickAction();
        }
    }

    @When("{I |}confirm opened accepting popup on Shared Collection page")
    public void confirmAcceptingPopup() {
        new PopUpWindow(getSut().getPageCreator().getBasePage()).clickAction();
    }

    @When("{I |}expand agency '$agencyName' on Shared Collection page")
    public void expandAgencyItem(String agencyName) {
        getSut().getPageNavigator().getSharedCollectionsPage().expandAgencyItemByName(wrapVariableWithTestSession(agencyName));
    }

    @When("{I |}click asset title '$assetName' on Shared Collection '$categoryName' from agency '$agencyName' page")
    public void expandAgencyItem(String assetName, String collectionName, String agencyName) {
        openSharedCollectionsPage(collectionName, agencyName).clickAssetTitleLink(assetName);
    }

    @When("{I }sort files list view in shared collections for collection '$collectionName' page from agency '$agencyName' by column '$column' order '$order'")
    public void sortFilesListView(String collectionName, String agencyName, String columnName, String order) {
        AdbankSharedCollectionsPage page = openSharedCollectionsPage(collectionName, agencyName);
        page.sortListViewByColumn(columnName, order);
    }

    @When("{I |}switch to '$typeView' view in the current shared collections page")
    public void switchToFilesView(String typeView) {
        AdbankSharedCollectionsPage page = getSut().getPageCreator().getSharedCollectionsPage();
        if (typeView.equalsIgnoreCase("tile"))
            page.clickTileView();
        else if (typeView.equalsIgnoreCase("list"))
            page.clickListView();
        else
            throw new IllegalArgumentException("Type of file's view is undefined");
    }


    @Then("{I |}'$condition' see business unit '$agencyName' on opened Shared Collections page")
    public void checkThatAgencyIsPresent(String condition, String agencyName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAgencyNames = getSut().getPageCreator().getSharedCollectionsPage().getAgencyNames();
        String expectedAgencyName = wrapVariableWithTestSession(agencyName);

        assertThat(actualAgencyNames, shouldState ? hasItem(expectedAgencyName) : not(hasItem(expectedAgencyName)));
    }

    // | ParentName | ChildName |
    @Then("{I |}'$condition' see that following collections in BU on Shared collections page: $data")
    public void checkThatAgencyContainsCollection(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankSharedCollectionsPage page = openSharedCollectionsPage();

        for (Map<String,String> row : parametrizeTableRows(data)) {
            List<String> actualChildren = page.getMenuChildItems(wrapVariableWithTestSession(row.get("ParentName")));
            for (String expectedChildName : row.get("ChildName").split(",")) {
                expectedChildName = wrapVariableWithTestSession(expectedChildName);
                assertThat(actualChildren, shouldState ? hasItem(expectedChildName) : not(hasItem(expectedChildName)));
            }
        }
    }

    @Then("{I |}'$condition' see collection '$collectionName' on opened Shared Collections page")
    public void checkThatCollectionIsPresent(String condition, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualCollectionNames = getSut().getPageCreator().getSharedCollectionsPage().getCollectionNames();
        String expectedCollectionName = wrapCollectionName(collectionName);

        assertThat(actualCollectionNames, shouldState ? hasItem(expectedCollectionName) : not(hasItem(expectedCollectionName)));
    }

    @Then("{I |}'$condition' see {assets|qc asset} '$assetNames' on opened Shared Collections page")
    public void checkThatAssetsIsPresent(String condition, String assetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = getSut().getPageCreator().getSharedCollectionsPage().getAssetNames();

        for (String expectedAssetName : assetNames.split(","))
            assertThat(actualAssetNames, shouldState ? hasItem(getAssetName(expectedAssetName)) : not(hasItem(getAssetName(expectedAssetName))));
    }

    @Then("{I |}'$condition' be on the Shared Collections page")
    public void checkThatOpenedPageIsProjectFilesPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        try {
            getSut().getPageCreator().getSharedCollectionsPage();
            assertThat(true, is(expectedState));
        } catch (Exception e) {
            assertThat(false, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see following categories '$categories' on Shared Collection page")
    public void checkCategoryTrees(String condition, String categories) {
        AdbankSharedCollectionsPage categoriesPage = getSut().getPageCreator().getSharedCollectionsPage();
        boolean state = condition.equals("should");

        for (String category : categories.split(",")) {
            boolean isElementExist = categoriesPage.isCategoryExist(wrapVariableWithTestSession(category));
            assertThat(state, is(isElementExist));
        }
    }

    @Then("{I |}should see assets sorting by '$sortingType' for category '$categoryName' for agency '$agencyName' on the shared categories page")
    public void checkAssetsSorting(String sortingType, String categoryName, String agencyName) {
        String agencyId = getAgencyByName(agencyName).getId();
        String collectionId = getCoreApi().getInboxCategoryByName(agencyId, wrapCollectionName(categoryName)).getId();
        AdbankSharedCollectionsPage page = openSharedCollectionsPage(categoryName, agencyName);
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setResultsOnPage(1000).setSortingField("_created").setSortingOrder("desc");
        SearchResult<Content> assets = getCoreApi().findAssetsInSharedCollection(collectionId, query);
        long startTime = System.currentTimeMillis();
        while (page.getObjectsTitle().size() != assets.getResult().size()) {
            Common.sleep(3000);
            if (System.currentTimeMillis() - startTime > 120000) {
                throw new RuntimeException("Library works very slow");
            }
        }

        List<String> assetsFromPage = page.getObjectsTitle();
        List<String> sortedAssetsFromPage = new ArrayList<>();
        List<Content> sortedListOfContent = new ArrayList<>(assets.getResult());
        sortedAssetsFromPage.addAll(assetsFromPage);
        if (sortingType.contains("Newest first")) {
            Collections.sort(sortedListOfContent, Collections.reverseOrder(new ComparatorContentBy_created()));
        } else if (sortingType.contains("Oldest first")) {
            Collections.sort(sortedListOfContent, new ComparatorContentBy_created());
        } else if (sortingType.contains("Size (Descending)")) {
            Collections.sort(sortedListOfContent, Collections.reverseOrder(new ComparatorContentByFileSize()));
        } else if (sortingType.contains("Size (Ascending)")) {
            Collections.sort(sortedListOfContent, new ComparatorContentByFileSize());
        }
        int correctCountOfAsset = assets.getResult().size();
        assertThat(assetsFromPage.size(), equalTo(correctCountOfAsset));
        if ((sortingType.contains("Newest first")) || (sortingType.contains("Oldest first"))
                || (sortingType.contains("Size (Descending)")) || (sortingType.contains("Size (Ascending)"))) {
            for (int i = 0; i < correctCountOfAsset; i++) {
                assertThat(assetsFromPage.get(i), equalTo(page.getAssetsTitleById(sortedListOfContent.get(i).getId())));
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

}