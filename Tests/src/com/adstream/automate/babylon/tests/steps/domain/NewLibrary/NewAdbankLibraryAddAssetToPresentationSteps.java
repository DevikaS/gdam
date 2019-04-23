package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;


import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_created;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.AddToPresentationPopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.AddToProjectPopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibrarySharedCollectionsPage;
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
import static org.hamcrest.Matchers.hasItem;


public class NewAdbankLibraryAddAssetToPresentationSteps extends NewLibraryAssetsViewSteps {


    @Given("{I |}added asset '$assetNames' into existing presentation '$presentationName' from collection '$collectionName'NEWLIB")
    @When("{I |}add asset '$assetNames' into existing presentation '$presentationName' from collection '$collectionName'NEWLIB")
    public void addAssetToExistingPresentationNewlib(String assetNames, String presentationName,String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        String reelId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        for (String assetName : assetNames.split(",")) {
            Content asset = getAsset(collectionId, assetName);
            if (asset == null)
                asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
            getCoreApi().addAssetToReel(reelId, asset.getId());
        }
    }

    @Given("{I |}clicked Add to Presentation button on '$collection' library pageNEWLIB")
    @When("{I |}click Add to Presentation button on '$collection' library pageNEWLIB")
    public AddToPresentationPopUp openAddToPresentationPopUpNewLib(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickAddToPresentation();
    }

    @Given("{I |}add assets '$assetName' to new presentation '$presentationName' from collection '$collectionName' pageNEWLIB")
    @When("{I |}add assets '$assetName' to new presentation '$presentationName' from collection '$collectionName' pageNEWLIB")
    public void AddAssetToNewPresentation(String assetName, String presentationName, String collectionName) {

        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
        AddToPresentationPopUp addToPresentationPopup = openAddToPresentationPopUpNewLib(collectionName);
        addToPresentationPopup.addTonewPresentation(wrapVariableWithTestSession(presentationName));

    }


    @Given("{I |}add assets '$assetName' to existing presentations '$presentationNames' from collection '$collectionName' pageNEWLIB")
    @When("{I |}add assets '$assetName' to existing presentations '$presentationNames' from collection '$collectionName' pageNEWLIB")
    public void AddAssetToMultiplePresentation(String assetName, String presentationNames, String collectionName) {

        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
        AddToPresentationPopUp addToPresentationPopup = openAddToPresentationPopUpNewLib(collectionName);
        for (String presName : presentationNames.split(",")){
            addToPresentationPopup.addToExistingPresentation(wrapVariableWithTestSession(presName)); }
         Common.sleep(2000);
         addToPresentationPopup.clickAdd();
    }

    @Then("{I |}'$condition' see message '$message' while adding assets to presentation from collection '$collectionName' NEWLIB")
    public void verifyMessageForAddAssetToPresentation(String condition,String message,String collectionName)
    {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actual = libraryPage.verifyToastMessage();
        assertThat(actual, shouldState? containsString(message) : not(containsString(message)));

    }

    @Then("{I |}'$condition' see following presentation search results for text '$textName' while adding asset '$assetName' from collection '$collectionName' pageNEWLIB: $data")
    public void verifySearchForPresentation(String condition, String textName, String assetName, String collectionName, ExamplesTable data )
    {
        List<String> actualResult = new ArrayList();
        List<String> expectedResult = new ArrayList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            expectedResult.add(wrapVariableWithTestSession(row.get("SearchResults"))+" "+row.get("AssetCount"));
        }
        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
        AddToPresentationPopUp addToPresentationPopup = openAddToPresentationPopUpNewLib(collectionName);
        addToPresentationPopup.enterSearchText(textName);
        actualResult=addToPresentationPopup.getAvailableForSearchProjectsListAsText();
        for(String expected:expectedResult) {
            assertThat(actualResult, condition.equalsIgnoreCase("should") ? hasItem(expected) : not(hasItem(expected)));
        }
        addToPresentationPopup.cancelPopup();
    }



    @Then("{I |}'$condition' see presentation pop up for collection '$collection'NEWLIB")
    public void checkAddToPresentationButtonNewLib(String condition, String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        boolean expectedState = condition.equalsIgnoreCase("should");
        AddToPresentationPopUp addToPresentationPopup = openAddToPresentationPopUpNewLib(collection);
        boolean actualState = addToPresentationPopup.isPopUpVisible();
        assertThat(actualState, is(expectedState));
    }
}
