package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewLibraryGlobalSearchPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewLibraryGlobalSearchResultsPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class NewLibraryGlobalSearchResultsSteps extends LibraryHelperSteps {




  @Then("{I |}'$condition' see assets '$expectedAssetNames' on the library search results pageNEWLIB")
    public void checkAssetsVisibility(String condition, String expectedAssetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        NewLibraryGlobalSearchResultsPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchResultsPage();
        List<String> actualAssetNames = searchPage.getUploadedElementsText();
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }

     //works with list view
    @Then("{I |}should see the following seccession '$files' on the library search results pageNEWLIB")
    public void checkForSuccessionOnLibraryPage(String files) {
        NewLibraryGlobalSearchResultsPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchResultsPage();
        List<String> actualValues = searchPage.getListResultAssetFromGlobalSearch();
        for (String expectedFile : files.split(",")) assertThat(actualValues, hasItem(expectedFile));
    }


    @When("{I |}select Sort By '$sortingBy' on the library search results pageNEWLIB")
    public void selectSortByValue(String sortingBy) {
        NewLibraryGlobalSearchResultsPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchResultsPage();
        searchPage.setSortBy(sortingBy);
    }


    @When("{I |}switch to '$typeView' view on the library search results pageNEWLIB")
    public void switchToFilesView(String typeView) {
        NewLibraryGlobalSearchResultsPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchResultsPage();
        if (typeView.equalsIgnoreCase("list")) {
            searchPage.clickListView();
        } else if (typeView.equalsIgnoreCase("grid")) {
            searchPage.clickGridView();
        }
    }


    @Then("{I |}'$condition' see asset count '$expectedCount' on the library search results pageNEWLIB")
    public void checkAssetCountOnNewLib(String condition, int expectedCount) {
        NewLibraryGlobalSearchResultsPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchResultsPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualCount = searchPage.getAssetCount();
        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

}

