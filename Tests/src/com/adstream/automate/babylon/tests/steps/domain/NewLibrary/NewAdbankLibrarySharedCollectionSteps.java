package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;


import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;

import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_created;
import com.adstream.automate.babylon.LuceneSearchingParams;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.utils.Common;

import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;


import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibrarySharedCollectionsPage;





public class NewAdbankLibrarySharedCollectionSteps extends NewLibraryAssetsViewSteps {


    @Given("{I am |}on the Shared Collection '$categoryName' from agency '$agencyName' pageNEWLIB")
    @When("{I |}go to the Shared Collection '$categoryName' from agency '$agencyName' pageNEWLIB")
    public NewAdbankLibrarySharedCollectionsPage openSharedCollectionsPageNewLib(String categoryName, String agencyName) {
        String agencyId = getAgencyByName(agencyName).getId();
        String categoryId = getCoreApi().getInboxCategoryByName(agencyId, wrapCollectionName(categoryName)).getId();
        return getSut().getPageNavigator().getNewAdbankLibrarySharedCollectionsPage(agencyId, categoryId);
    }


    @When("{I |}switch to '$typeView' view on shared category pageNEWLIB")
    public void switchToFilesViewOnSharedCategory(String typeView) {
        NewAdbankLibrarySharedCollectionsPage sharedPage = getSut().getPageCreator().getNewAdbankLibrarySharedCollectionsPage();
        if (typeView.equalsIgnoreCase("list")) {
            sharedPage.clickListView();
        } else if (typeView.equalsIgnoreCase("grid")) {
            sharedPage.clickGridView();
        }
    }
    @When("{I }sort files on list view by column '$column' order '$order' on shared category pageNEWLIB")
    public void sortFilesListViewOnSharedCategory(String columnName, String order) {
        NewAdbankLibrarySharedCollectionsPage sharedPage = getSut().getPageCreator().getNewAdbankLibrarySharedCollectionsPage();
        sharedPage.sortListViewByColumn(columnName, order);
    }

    @Then("{I |}should see assets sorting by '$sortingType' for category '$categoryName' for agency '$agencyName' on the shared categories pageNEWLIB")
    public void checkAssetsSortingNEWLIB(String sortingType, String categoryName, String agencyName) {
        String agencyId = getAgencyByName(agencyName).getId();
        String collectionId = getCoreApi().getInboxCategoryByName(agencyId, wrapCollectionName(categoryName)).getId();
        NewAdbankLibrarySharedCollectionsPage page = openSharedCollectionsPageNewLib(categoryName, agencyName);
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
        assertThat(assetsFromPage.size(), equalTo(correctCountOfAsset));
        if ((sortingType.contains("Newest first")) || (sortingType.contains("Oldest first"))
                || (sortingType.contains("Size (Descending)")) || (sortingType.contains("Size (Ascending)"))) {
            for (int i = 0; i < correctCountOfAsset; i++) {
                assertThat(assetsFromPage.get(i), equalTo(page.getAssetsTitleByName(sortedListOfContent.get(i).getName())));
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


    @When("{I |} click shared collection '$collection' on the collection page for Agency '$agencyName'NEWLIB")
    public void clickSharedCollectionNEWLIB(String collection,String agencyName){
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clickSharedCollectionLink(wrapCollectionName(collection),wrapAgencyName(agencyName));
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' on Shared collection pageNEWLIB")
    public void checkAssetsVisibilityOnSharedCollections(String condition, String expectedAssetNames) {
        NewAdbankLibrarySharedCollectionsPage sharedPage = getSut().getPageCreator().getNewAdbankLibrarySharedCollectionsPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = sharedPage.getUploadedElementsText();
        if (expectedAssetNames.isEmpty() && shouldState) {
            assertThat(actualAssetNames.size(), equalTo(0));
        } else {
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }
    }


}
