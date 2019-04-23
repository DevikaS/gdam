package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.NewLibrary.NewLibraryAssetUsageRightsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.AddToProjectPopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.RestorePopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionDetailsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewLibraryTrashPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class NewLibraryTrashSteps extends LibraryHelperSteps {


    @Given("{I am |}on library trash pageNEWLIB")
    @When("{I |}go to library trash pageNEWLIB")
    public NewLibraryTrashPage openNewLibraryTrashPage() {
        return getSut().getPageNavigator().getNewLibraryTrashPage();
    }

    @Given("{I |}selected asset '$assetName' in the library trash pageNEWLIB")
    @When("{I |}select asset '$assetName' in the library trash pageNEWLIB")
    public void selectAssetsFromTrashPage(String assetName) {
        LibraryAsset page =  getSut().getPageNavigator().getNewLibraryTrashPage();
        Common.sleep(4000);
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
    }

    @When("{I |}click restore button in the library trash pageNEWLIB")
    public RestorePopUp clickRestoreButtonNewlib() {
        NewLibraryTrashPage page=getSut().getPageCreator().getNewLibraryTrashPage();
        return page.clickRestore();
    }

    @When("{I |}click restore on restore popup")
    public void acceptRestore()
    {
        NewLibraryTrashPage page=getSut().getPageCreator().getNewLibraryTrashPage();
        RestorePopUp popup = new  RestorePopUp(page);
        popup.clickAction();

    }

    @When("{I |}click asset '$assetName' on library trash pageNEWLIB")
    public void openAssetDetailsNewLib(String assetName) {
        getSut().getPageCreator().getNewLibraryTrashPage().navigateToAssetInfoPage(assetName);
    }



    @Given("{I |}restored assets '$assets' from library trash pageNEWLIB")
    @When("{I |}restore assets '$assets' from library trash pageNEWLIB")
    public void restoreAssetFromTrashNewLib(String assets) {
        LibraryAsset page = openNewLibraryTrashPage();
        NewLibraryTrashPage trashpage=getSut().getPageCreator().getNewLibraryTrashPage();
        for (String asset : assets.split(",")) {
            page.selectFileByFileName(asset);
        }
        trashpage.clickRestore().action.click();

    }

    @When("{I |}switch to '$typeView' view on library trash pageNEWLIB")
    public void switchToFilesViewOnTrashPage(String typeView) {
        NewLibraryTrashPage trashpage=getSut().getPageCreator().getNewLibraryTrashPage();
        if (typeView.equalsIgnoreCase("list")) {
            trashpage.clickListView();
        } else if (typeView.equalsIgnoreCase("grid")) {
            trashpage.clickGridView();
        }
    }

    @Then("{I |}should see for library trash page files in the '$typeView' viewNEWLIB")
    public void checkFilesViewStateOnTrash(String typeView) {
        boolean shouldState = typeView.equalsIgnoreCase("list");
        NewLibraryTrashPage trashpage=getSut().getPageCreator().getNewLibraryTrashPage();
        assertThat(trashpage.isViewOfFilesIsList(), equalTo(shouldState));
    }

    @Then("{I |}'$condition' see message '$message' while restoring assets from library trash pageNEWLIB")
    public void verifyMessageForRestoreAssets(String condition,String message)
    {
        NewLibraryTrashPage trashpage=getSut().getPageCreator().getNewLibraryTrashPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actual = trashpage.verifyToastMessage();
        assertThat(actual, shouldState? containsString(message) : not(containsString(message)));

    }



    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the library trash pageNEWLIB")
    public void checkAssetsVisibilityOnCollection(String condition, String assetsTitles) {
        NewLibraryTrashPage trashpage=getSut().getPageCreator().getNewLibraryTrashPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = trashpage.getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }

    }


    @Then("{I |}'$condition' see asset count '$expectedCount' in the library trash pageNEWLIB")
    public void checkAssetCountOnNewLib(String condition, int expectedCount) {
        NewLibraryTrashPage trashpage=getSut().getPageCreator().getNewLibraryTrashPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualCount = trashpage.getAssetCount();
        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }



}