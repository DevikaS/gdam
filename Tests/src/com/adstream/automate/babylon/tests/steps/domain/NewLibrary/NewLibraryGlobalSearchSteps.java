package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_created;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.RestorePopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibrarySharedCollectionsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewLibraryGlobalSearchPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewLibraryTrashPage;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
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

public class NewLibraryGlobalSearchSteps extends LibraryHelperSteps {


    @Given("{I am |}on global search pageNEWLIB")
    @When("{I |}go to global search pageNEWLIB")
    public NewLibraryGlobalSearchPage openNewLibraryGlobalSearchPage() {
        return getSut().getPageNavigator().getNewLibraryGlobalSearchPage();
    }

    @When("{I |}enter input '$searchCriteria' on global search pageNEWLIB")
    public void enterSearchCriteria(String searchCriteria) {
        LibraryAsset page = openNewLibraryGlobalSearchPage();
        NewLibraryGlobalSearchPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchPage();
        searchPage.enterSearchCriteria(searchCriteria);
    }

    @When("{I |}enter input '$searchCriteria' with following options on global search pageNEWLIB:$data")
    public void enterSearchCriteria(String searchCriteria,ExamplesTable data) {
        LibraryAsset page = openNewLibraryGlobalSearchPage();
        NewLibraryGlobalSearchPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Global Options")) {
                if(row.get("Global Options").equalsIgnoreCase("Clock number") ||row.get("Global Options").equalsIgnoreCase("Advertiser") ){
                    searchCriteria=wrapVariableWithTestSession(searchCriteria) ;
                }
                searchPage.selectMenuOption(row.get("Global Options"));
            }
            if (row.containsKey("Match All Words")) {
                searchPage.checkMatchAllWords(row.get("Match All Words"));
            }
            searchPage.enterSearchCriteria(searchCriteria);
        }
    }

    @Then("{I |}'$condition' see assets '$expectedAssetNames' in the global search pageNEWLIB")
    public void checkAssetsVisibility(String condition, String expectedAssetNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        NewLibraryGlobalSearchPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchPage();
        List<String> actualAssetNames = searchPage.getListOfAssets();
            for (String expectedAssetName : expectedAssetNames.split(",")) {
                assertThat("Asset " + expectedAssetName + condition + "be present on page",
                        actualAssetNames.contains(expectedAssetName), is(shouldState));
            }
        }

    @When("{I |}click on view all in library link on global search pageNEWLIB")
    public void clickViewAllInLibrary()
    {
        NewLibraryGlobalSearchPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchPage();
        searchPage.clickViewAll();
    }

    @When("{I |}click on back button on global search pageNEWLIB")
    public void clickBackButton()
    {
        NewLibraryGlobalSearchPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchPage();
        searchPage.clickBackButton();
    }

    @Then("{I |}should see asset count '$expectedCount' on global search pageNEWLIB")
    public void checkAssetCountOnNewLib(String expectedCount) {
        NewLibraryGlobalSearchPage searchPage=getSut().getPageCreator().getNewLibraryGlobalSearchPage();
        String actualText = searchPage.getTotalAssetsFound();
        assertThat("",actualText.contains(expectedCount) );
    }



}

