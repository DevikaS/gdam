package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveFromCollectionPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;

/**
 * Created by Janaki.Kamat on 19/08/2017.
 */
public class LibRemoveFromCollectionPopupSteps extends LibraryHelperSteps {

    public LibRemoveFromCollectionPopup openRemoveFromCollection(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickRemoveFromCollectionButton();
    }

    @Given("{I |}removed asset from '$collection' library page")
    @When("{I |}remove asset from '$collection' library page")
    public void removeAsset(String collection) {
        LibRemoveFromCollectionPopup libRemovePopup = openRemoveFromCollection(collection);
        libRemovePopup.clickRemoveButton();
    }

    @Given("{I |}removed asset '$assets' within '$collection' collection")
    @When("{I |}remove asset '$assets' within '$collection' collection")
    public void removeAssetFromCurrentCollection(String assets,String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        for (String asset : assets.split(",")) {
            libraryPage.selectFileByFileName(asset);
        }
        libraryPage.openPopup().clickRemoveFromCollectionButton().clickRemoveButton();
    }


    @Given("{I |}cancelled asset from '$collection' library page")
    @When("{I |}cancel asset from '$collection' library page")
    public void cancelRemoveAsset(String collection) {
        LibRemoveFromCollectionPopup libRemovePopup = openRemoveFromCollection(collection);
        libRemovePopup.clickCancelButton();
    }
}