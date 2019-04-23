package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibDeleteAssetsAttachmentPopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetAttachmentsPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.When;

/**
 * Created by Janaki.Kamat on 25/09/2017.
 */
public class LibDeleteAssetsAttachmentPopUpSteps extends NewLibraryAssetsViewSteps {
    public LibDeleteAssetsAttachmentPopUp openDeleteAssetsAttachmentPopUp(String fileName) {
        NewAdbankLibraryAssetAttachmentsPage attachmentsPage = getSut().getPageCreator().getNewAdbankLibraryAssetAttachmentsPage();
        return attachmentsPage.geListOfAttachments().getAttachmentByName(fileName).openDeleteAttachmentPopUp();
    }

    @When("{I |}delete following attached file '$attachedFileName' on asset attachments pageNEWLIB")
    public void copyToCollection(String attachedFileName) {
        LibDeleteAssetsAttachmentPopUp libDeleteAssetsAttachmentPopUp = openDeleteAssetsAttachmentPopUp(attachedFileName);
        Common.sleep(1000);
        libDeleteAssetsAttachmentPopUp.clickRemoveButton();
    }
}
