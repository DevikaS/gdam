package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibDownLoadPopup;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;

/**
 * Created by Janaki.Kamat on 18/07/2017.
 */
public class LibDownLoadPopupSteps extends LibraryHelperSteps {

    @When("{I |}select checkbox '$checkbox' and click download  for collection '$collectionName' on library page download popupNEWLIB")
    public void selectCheckboxesForDownload(String checkbox, String collectionName) {
        LibDownLoadPopup downloadFilePopUpWindow = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).clickDownloadOnLibrary();
        if (checkbox.equalsIgnoreCase("master")) {
            downloadFilePopUpWindow.selectDownloadMaster();
        } else if (checkbox.equalsIgnoreCase("proxy")) {
            downloadFilePopUpWindow.selectDownloadProxy();
        } else if (checkbox.equalsIgnoreCase("master,proxy")) {
            downloadFilePopUpWindow.selectDownloadMaster();
            downloadFilePopUpWindow.selectDownloadProxy();
        } else {
            throw new IllegalArgumentException("Wrong argument exeption: " + checkbox + "Should be only: master,proxy");
        }
        downloadFilePopUpWindow.clickDownloadButton();
    }

    @Given("{I |}clicked Download button for collection '$collectionName' on library pageNEWLIB")
    @When("{I |}click Download button for collection '$collectionName' on library pageNEWLIB")
    public void clickDownloadButton(String collectionName) {
        LibDownLoadPopup downloadFilePopUpWindow = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).clickDownloadOnLibrary();
    }
}
