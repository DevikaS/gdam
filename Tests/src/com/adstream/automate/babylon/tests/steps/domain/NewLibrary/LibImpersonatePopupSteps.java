package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibImpersonatePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;

/**
 * Created by Janaki.Kamat on 28/07/2017.
 */
public class LibImpersonatePopupSteps extends LibraryHelperSteps {


    @Given("{I |}impersonated as user '$userName' on '$collectionName' page")
    @When("{I |}impersonated as  user '$userName' on '$collectionName' page")
    public void impersonateAsUser(String userName,String collectionName) {
        LibraryAsset page=getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        LibImpersonatePopup popup=page.clickImpersonateButton();
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        popup.typeUserEmails(user.getFullName());
        popup.clickImpersonate();
    }
}
