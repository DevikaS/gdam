package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemovePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionDetailsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionFilterPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;

/**
 * Created by Janaki.Kamat on 20/07/2017.
 */
public class LibRemovePopupSteps extends LibraryHelperSteps {

    public LibRemovePopup openRemove(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickRemoveButton();
    }

    @Given("{I |}removed asset in '$collection' library page")
    @When("{I |}remove asset in '$collection' library page")
    public void removeAsset(String collection) {
        LibRemovePopup libRemovePopup = openRemove(collection);
        libRemovePopup.clickRemoveFileButton();
    }

    @Then("{I |}'$condition' asset '$assetName' in remove popup on '$collection' library page")
    public void checkAssetName(String condition,String assetName,String collection) {
        LibRemovePopup libRemovePopup = openRemove(collection);
        assertThat(libRemovePopup.getFileList().contains(assetName), is(condition.equalsIgnoreCase("should")));
    }

    @Given("{I |}removed asset '$assets' from '$collection' collection")
    @When("{I |}remove asset '$assets' from '$collection' collection")
    public void removeAssetFromCurrentCollection(String assets,String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        Common.sleep(2000);
        for (String asset : assets.split(",")) {
            libraryPage.selectFileByFileName(asset);
        }
        libraryPage.openPopup().clickRemoveButton().clickRemoveFileButton();

     }

    @Given("{I |}removed asset '$assets' from filter pageNEWLIB")
    @When("{I |}remove asset '$assets' from filter pageNEWLIB")
    public void removeAssetFromFilterCollection(String assets) {
        CollectionFilterPage page = getSut().getPageCreator().getCollectionFilterPage();

        for (String asset : assets.split(",")) {
            page.selectFileByFileName(asset);
        }
        page.openPopup().clickRemoveButton().clickRemoveFileButton();


    }

    @Then("{I |}'$condition' see remove asset confirmation popup for collection '$collection' on opened library page NEWLIB")
    public void checkThatConfirmationPopupPresentedOnNewLib(String condition,String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
         boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = libraryPage.openPopup().clickRemoveButton().isPopUpVisible();

        assertThat(actualState, is(expectedState));
    }


    @When("{I |}cancel the remove asset confirmation popup from collection '$collection'NEWLIB")
    public void cancelRemoveAssetConfirmPopup(String collection )
    {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        LibRemovePopup popup = new LibRemovePopup(libraryPage);
        popup.close();
    }

    @Then("{I |}'$shouldState' see element '$elementName' for collection '$collection' on opened library page NEWLIB")
    public void checkElementVisibilityOnAssetDropDown(String shouldState, String elementName,String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        boolean expectedState = shouldState.equalsIgnoreCase("should");
        boolean actualState = libraryPage.openPopup().isElementVisibleOnDropdown(elementName);
        assertThat(actualState, is(expectedState));
    }

    @When("{I |}remove all selected assets from filter pageNEWLIB")
    public void removeSelectedAssetFromFilterCollection() {
        CollectionFilterPage page = getSut().getPageCreator().getCollectionFilterPage();
        page.openPopup().clickRemoveFromCollectionButton().clickRemoveButton();
    }

    @When("{I |}click '$buttonName' on remove from collection popupNEWLIB")
    public void cancelAssetFromRemoveFromCollectionPopup(String buttonName) {
        CollectionDetailsPage page = getSut().getPageCreator().getCollectionDetailsPage();
        if(buttonName.equalsIgnoreCase("cancel")){
        page.openPopup().clickRemoveFromCollectionButton().clickCancelButton();}
        else if(buttonName.equalsIgnoreCase("save")){
            page.openPopup().clickRemoveFromCollectionButton().clickRemoveButton();
        }

    }

    @Given("{I |}deleted asset '$assetName' from collection '$collectionName' in new library")
    @When("{I |}delete asset '$assetName' from collection '$collectionName' in new library")
    public void deleteAssetFromLibrary(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        getCoreApi().deleteAsset(asset.getId());
    }

    @Then("{I |}'$condition' see '$popupName' confirmation popup for collection '$collection' on opened library page NEWLIB")
    public void verifyConfirmationPopupPresentedOnNewLib(String condition,String popupName, String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        boolean expectedState = condition.equals("should");
        boolean actualState = false;
        popupName = popupName.toLowerCase();
        switch (popupName) {
            case "remove":
                actualState = libraryPage.openPopup().clickRemoveButton().isPopUpVisible();
                break;
            case "remove from collection":
                actualState = libraryPage.openPopup().clickRemoveFromCollectionButton().isPopUpVisible();
                break;
            default:
                throw new IllegalArgumentException(String.format("Unknown option name '%s'", popupName));
        }

        String message = String.format("Option '%s' is not present on collection page", popupName);
        assertThat(message, actualState, equalTo(expectedState));
    }


    @Then("I '$condition' see a message '$message' while removing the asset from remove from collection popupNEWLIB")
    public static void checkMessageNEWLIB(String condition, String message) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        CollectionDetailsPage page = getSut().getPageCreator().getCollectionDetailsPage();
        boolean actual = page.openPopup().clickRemoveFromCollectionButton().clickRemoveButton_Message(message);
        assertThat(actual, equalTo(shouldState));


    }
}