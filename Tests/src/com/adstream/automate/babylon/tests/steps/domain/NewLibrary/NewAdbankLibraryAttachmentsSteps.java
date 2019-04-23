package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.CollectionType;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditAttachmentPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveAttachmentPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetAttachmentsPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.core.Is.is;

/**
 * Created by Janaki.Kamat on 22/09/2017.
 */
public class NewAdbankLibraryAttachmentsSteps extends LibraryHelperSteps {

    private NewAdbankLibraryAssetAttachmentsPage openLibraryAssetAttachmentsPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getNewAdbankLibraryAssetAttachmentsPage(collectionId, assetId);
    }

    private NewAdbankLibraryAssetAttachmentsPage getLibraryAssetAttachmentsPage() {
        return getSut().getPageCreator().getNewAdbankLibraryAssetAttachmentsPage();
    }

    @Given("{I am |}on {asset|qc asset} '$assetName' info page in Library for collection '$categoriesName' on attachment assets pageNEWLIB")
    @When("{I |}go to {asset|qc asset} '$assetName' info page in Library for collection '$categoriesName' on attachment assets pageNEWLIB")
    public NewAdbankLibraryAssetAttachmentsPage openAdbankLibraryAssetsAttachmentsPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        return openLibraryAssetAttachmentsPage(getCategoryId(wrapCollectionName(collectionName)), asset.getId());
    }

    @Then("{I |}'$shouldState' see following count '$num' of assets on attachment assets pageNEWLIB")
    public void getCountOfAttachmentAssets(String condition, String actualValue) {

        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualResult = Integer.parseInt(actualValue);
        int expectedResult = getLibraryAssetAttachmentsPage().getAttachmentCount();

        assertThat("Wrong asset number on attachment assets page: ", actualResult, equalTo(expectedResult));
    }


    // | File Name | Size | Description | Uploaded By |
    @Then("{I |}should see following data on asset attachments page for each qc asset '$assetName' clone of order with market '$market' and item clock number '$clockNumber' in collection '$collectionName'NEWLIB: $fieldsTable")
    public void checkQcAssetsCloneAttachments(String assetName, String market, String clockNumber, String collectionName, ExamplesTable fieldsTable) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
         checkAssetAttachments(fieldsTable, openLibraryAssetAttachmentsPage(collectionId, asset.getId()).geListOfAttachments());
    }

    @Then("{I |}'$shouldState' see following attached file{s|} '$attachedFileNamesList' on asset attachments pageNEWLIB")
    public void checkAttachedFileVisibility(String shouldState,String attachedFileNamesList) {
        List<String> visibleAttachedFileNames = getLibraryAssetAttachmentsPage().getAttachmentsList();
            for (String attachedFileName: attachedFileNamesList.split(","))
                assertThat("Check visibility of attached file: " + attachedFileName, visibleAttachedFileNames, shouldState.equals("should")
                        ? hasItem(attachedFileName)
                        : not(hasItem(attachedFileName)));

    }

    @Given("{I |}attached new file '$attachedFile' into collection '$collectionName' for {asset|qc asset} '$assetName' on attachment assets pageNEWLIB")
    @When("{I |}attache new file '$attachedFile' into collection '$collectionName' for {asset|qc asset} '$assetName' on attachment assets pageNEWLIB")
    public void attacheNewFilesToAsset(String attachedFile, AssetFilter collection, String assetName) {
        Content asset = getAsset(collection.getId(), assetName);
        createAttachedFile(attachedFile, collection.getId(), prepareAssetName(assetName),asset.getId());
    }


    @Then("{I |}'$shouldState' see following attached file{s|} '$attachedFileNamesList' on asset attachments page for each qc asset '$assetName' clone in collection '$collectionName'NEWLIB")
    public void checkAttachedFileVisibility(String shouldState, String attachedFileNamesList, String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        List<Content> assetsList = getCoreApi().getAllAssetByName(collectionId, prepareAssetName(assetName));
        if (assetsList.isEmpty()) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        for (Content asset: assetsList) {
            List<String> visibleAttachedFileNames = openLibraryAssetAttachmentsPage(collectionId, asset.getId()).getAttachmentsList();
            for (String attachedFileName: attachedFileNamesList.split(","))
                assertThat("Check visibility of attached file: " + attachedFileName, visibleAttachedFileNames, shouldState.equals("should")
                        ? hasItem(attachedFileName)
                        : not(hasItem(attachedFileName)));
        }
    }


    private void checkAssetAttachments(ExamplesTable fieldsTable, CollectionType.AttachmentsList attachmentsList) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (!row.containsKey("File Name")) throw new NullPointerException("File Name is absent, but it is required field!");
            CollectionType.AttachmentsList.Attachment attachment = attachmentsList.getAttachmentByName(row.get("File Name"));
            assertThat("File Name: ", attachment.getFileName(), equalTo(row.get("File Name")));
            assertThat("Size: ", attachment.getSize(), equalTo(row.get("Size")));
            assertThat("Description: ", attachment.getDescription(), equalTo(row.get("Description")));
       }
    }

    @When("{I |}edit attached file{s|} '$attachedFileName' on asset attachments page:$fieldsTable")
    public void editAttachment(String attachedFileName,ExamplesTable fieldsTable) {
        NewAdbankLibraryAssetAttachmentsPage attachmentPage = getSut().getPageCreator().getNewAdbankLibraryAssetAttachmentsPage();
        Map<String, String> row = parametrizeTabularRow(fieldsTable, 0);
        LibEditAttachmentPopup libEditAttachentPopup=attachmentPage.openMenuPopup(attachedFileName).openEditAttachmentPopup();
        libEditAttachentPopup.enterFileName(row.get("File Name")).enterDescription(row.get("Description")).clickSave();

    }

    @When("{I |}remove attached file{s|} '$attachedFileName' on asset attachments pageNEWLIB")
    public void removeAttachment(String attachedFileName) {
        NewAdbankLibraryAssetAttachmentsPage attachmentPage = getSut().getPageCreator().getNewAdbankLibraryAssetAttachmentsPage();
        LibRemoveAttachmentPopup libremoveAttachentPopup=attachmentPage.openMenuPopup(attachedFileName).openRemoveAttachmentPopup();
        libremoveAttachentPopup.clickRemove();

    }

    @When("{I |}cancel editing of attached file{s|} '$attachedFileName' on asset attachments page:$fieldsTable")
    public void editCancelAttachment(String attachedFileName,ExamplesTable fieldsTable) {
        NewAdbankLibraryAssetAttachmentsPage attachmentPage = getSut().getPageCreator().getNewAdbankLibraryAssetAttachmentsPage();
        Map<String, String> row = parametrizeTabularRow(fieldsTable, 0);
        LibEditAttachmentPopup libEditAttachentPopup=attachmentPage.openMenuPopup(attachedFileName).openEditAttachmentPopup();
        libEditAttachentPopup.enterFileName(row.get("File Name")).enterDescription(row.get("Description")).clickCancel();

    }


    @Then("{I |}should see following data on asset attachments page: $fieldsTable")
    public void checkQcAssetsCloneAttachments(ExamplesTable fieldsTable) {
        checkAssetAttachments(fieldsTable, getLibraryAssetAttachmentsPage().geListOfAttachments());
    }


    @Then("{I |} should see below fields in Attachment Tab:$data")
    public void checkLocalisationFields_AttachmentTab(ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        NewAdbankLibraryAssetAttachmentsPage libraryPage = getSut().getPageCreator().getNewAdbankLibraryAssetAttachmentsPage();
        if (row.containsKey("Asset Attachment Label"))
            assertThat("Attachment Labelis not localised", libraryPage.getAssetAttachmentsLabel().equalsIgnoreCase(row.get("Asset Attachment Label")));
        if (row.containsKey("Upload Attachment"))
            assertThat("Upload Attachment is not localised", libraryPage.getUploadAttachmentsLabel().equalsIgnoreCase(row.get("Upload Attachment")));

    }

    @Then("{I |}'$condition' see usage expired text '$text' on opened asset attachment pageNEWLIB")
    public void checkUsageExpiredLabelPresentOnAssetAttachmentPage(String condition,String text) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState=getSut().getPageCreator().getNewAdbankLibraryAssetAttachmentsPage().isUsageIndicatorLabelExist(text);
        assertThat(actualState, is(expectedState));
    }

}
