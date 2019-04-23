package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveCollectionPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionDetailsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;

/**
 * Created by Janaki.Kamat on 16/05/2018.
 */
public class LibRemoveCollectionPopupSteps extends LibraryHelperSteps {
   public CollectionPage openRemoveFromCollection(String collection) {
        CollectionPage libraryPage = getSut().getPageCreator().getCollectionPage();
        return libraryPage.openMenuPopup(collection);
    }


    public CollectionDetailsPage openRemoveFromCollectionDetails() {
        CollectionDetailsPage libraryPage = getSut().getPageCreator().getCollectionDetailsPage();
        return libraryPage.openMenuPopup();
    }

    @Given("{I |}removed the collection in collection details page")
    @When("{I |}remove the collection in collection details page")
    public void removeCurrentCollection_CollectionDetails() {
        LibRemoveCollectionPopup removePopup=openRemoveFromCollectionDetails().removeCollection();
        removePopup.clickRemoveButton();
    }

    @Given("{I |}removed the collection '$collection' in collection page")
    @When("{I |}remove the collection '$collection' in collection page")
    public void removeCollection_CollectionPage(String collection) {
        LibRemoveCollectionPopup removePopup=openRemoveFromCollection(wrapCollectionName(collection)).removeCollection();
        removePopup.clickRemoveButton();
    }

    @Given("{I |}cancelled removing collection '$collection'")
    @When("{I |}cancel removing collection '$collection'")
    public void cancelRemoveCollection(String collection) {
        LibRemoveCollectionPopup removePopup=openRemoveFromCollection(collection).removeCollection();
        removePopup.clickCancelButton();
    }

    @Given("{I |}cancelled removing collection in collection details page")
    @When("{I |}cancel removing collection in collection detils page")
    public void cancelRemoveCollection_CollectionDetails(String collection) {
        LibRemoveCollectionPopup removePopup=openRemoveFromCollectionDetails().removeCollection();
        removePopup.clickCancelButton();
    }
}
