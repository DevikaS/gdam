package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankDeleteAssetsAttachmentPopUp;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetAttachmentsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.library.elements.LibraryAttachmentsList;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.By;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/*
 * Created by sobolev-a on 23.07.2014.
 */
public class AdbankLibraryAttachmentsSteps extends LibrarySteps {

    private AdbankLibraryAssetAttachmentsPage openLibraryAssetAttachmentsPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getAdbankLibraryAssetAttachmentsPage(collectionId, assetId);
    }

    private AdbankLibraryAssetAttachmentsPage getLibraryAssetAttachmentsPage() {
        return getSut().getPageCreator().getAdbankLibraryAssetAttachmentsPage();
    }

    private LibraryAttachmentsList getLibraryAttachmentList() {
        return getLibraryAssetAttachmentsPage().getLibraryAttachmentsList();
    }

    private void checkQcAssetAttachments(ExamplesTable fieldsTable, LibraryAttachmentsList attachmentsList, String market, String clockNumber) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (!row.containsKey("File Name")) throw new NullPointerException("File Name is absent, but it is required field!");
            LibraryAttachmentsList.Attachment attachment = attachmentsList.getAttachmentByName(row.get("File Name"));
            assertThat("File Name: ", attachment.getFileName(), equalTo(row.get("File Name")));
            assertThat("Size: ", attachment.getSize(), equalTo(row.get("Size")));
            assertThat("Description: ", attachment.getDescription(), equalTo(row.get("Description")));
            if (row.containsKey("Uploaded By") && !row.get("Uploaded By").isEmpty()) {
                Order order = getCoreApi().getOrderByMarketAndItemClockNumber(market, wrapVariableWithTestSession(clockNumber));
                OrderItem orderItem = getCoreApi().getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
                String uploadedByUser = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("Uploaded By"))).getFullName();
                String uploadDateTime = DateTimeUtils.formatDate(new DateTime(orderItem.getUploadedFiles()[0].getUploadedTimestamp()), getCurrentUserDateTimeFormat());
                assertThat("Uploaded By: ", attachment.getUploadedBy(), equalTo(String.format("%s %s", uploadedByUser, uploadDateTime)));
            }
        }
    }

    @Given("{I am |}on {asset|qc asset} '$assetName' info page in Library for collection '$categoriesName' on attachment assets page")
    @When("{I |}go to {asset|qc asset} '$assetName' info page in Library for collection '$categoriesName' on attachment assets page")
    public AdbankLibraryAssetsInfoPage openAdbankLibraryAssetsAttachmentsPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        return openLibraryAssetAttachmentsPage(collectionId, asset.getId());
    }


    @When("{I |}upload an attachment '$attachment' to asset '$assetName' for collection '$collectionName' using sendplus middletier api")
    public void uploadAssetAttachmentViaSendplus(String attachment,String assetName,String collectionName ) throws IOException {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        uploadattachmentToAssetViaSendplus(attachment, asset.getId());
    }

    @Given("{I |}attached new file '$attachedFile' into collection '$collectionName' for {asset|qc asset} '$assetName' on attachment assets page")
    @When("{I |}attache new file '$attachedFile' into collection '$collectionName' for {asset|qc asset} '$assetName' on attachment assets page")
    public void attacheNewFilesToAsset(String attachedFile, AssetFilter collection, String assetName) {
        Content asset = getAsset(collection.getId(), assetName);
        createAttachedFile(attachedFile, collection.getId(), prepareAssetName(assetName), asset.getId());
    }

    @Given("{I |}deleted attached asset '$filename' on info page in tab attachments files")
    @When("{I |}delete attached asset '$filename' on info page in tab attachments files")
    public void deleteAttachedFile(String fileName) {
        AdbankDeleteAssetsAttachmentPopUp deleteAttachedFile = getLibraryAssetAttachmentsPage().clickByDeletetButton(fileName);
        deleteAttachedFile.clickOkBtn();
    }


    @When("{I |}delete all attached files in tab attachments files")
    public void deleteAllAttachedFiles() {
        int rowCount=getSut().getWebDriver().findElements(By.xpath("//div[@class='itemsList enlargerHeight mvs']/div[2]/div[@ng-repeat='attachment in attachedFiles | orderBy:sortFunction:sortParams.sortReverse']")).size();

        for (int row = 1; row <= rowCount; row++) {
            getSut().getWebDriver().findElement(By.xpath("//div[@class='itemsList enlargerHeight mvs']/div[2]/div[1]//span[@ng-click='removeAttachment(attachment)']")).click();
            Common.sleep(1000);
            AdbankDeleteAssetsAttachmentPopUp deleteAttachedFile = getLibraryAssetAttachmentsPage().clickByDeletetAllAttachment();
            deleteAttachedFile.clickOkBtn();
            Common.sleep(1000);
        }

    }



    @When("{I |}delete following attached file '$attachedFileName' on asset attachments page")
    public void deleteAttach(String attachedFileName) {
        getLibraryAttachmentList().getAttachmentByName(attachedFileName).getDeleteAttachmentPopUp().clickOkBtn();
    }

    // | Name | Description |
    @When("{I |}fill following fields on Edit attached file '$attachedFileName' popup on asset attachments page: $fieldsTable")
    public void fillEditAttachedFilePopUp(String attachedFileName, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        getLibraryAttachmentList().getAttachmentByName(attachedFileName).getEditAttachmentPopUp().fill(row.get("Name"), row.get("Description"));
    }

    @When("{I |}save editing of attached file '$attachedFileName' on asset attachments page")
    public void saveFillingOfEditAttachedFilePopUp(String attachedFileName) {
        getLibraryAttachmentList().getAttachmentByName(attachedFileName).getEditAttachmentPopUp().save();
    }

    @Then("{I |}'$shouldState' see following count '$num' of assets on attachment assets page")
    public void getCountOfAttachmentAssets(String condition, String actualValue) {

        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualResult = Integer.parseInt(actualValue);
        int expectedResult = getLibraryAssetAttachmentsPage().getCountOfAttachmentFiles();

        assertThat("Wrong asset number on attachment assets page: ", actualResult, equalTo(expectedResult));
    }

    // | File Name | Size | Description | Uploaded By |
    @Then("{I |}should see following data on asset attachments page for qc asset of order with market '$market' and item clock number '$clockNumber': $fieldsTable")
    public void checkQcAssetsAttachments(String market, String clockNumber, ExamplesTable fieldsTable) {
        checkQcAssetAttachments(fieldsTable, getLibraryAttachmentList(), market, clockNumber);
    }

    // | File Name | Size | Description | Uploaded By |
    @Then("{I |}should see following data on asset attachments page for each qc asset '$assetName' clone of order with market '$market' and item clock number '$clockNumber' in collection '$collectionName': $fieldsTable")
    public void checkQcAssetsCloneAttachments(String assetName, String market, String clockNumber, String collectionName, ExamplesTable fieldsTable) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        List<Content> assetsList = getCoreApi().getAllAssetByName(collectionId, prepareAssetName(assetName));
        if (assetsList.isEmpty()) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        for (Content asset: assetsList)
            checkQcAssetAttachments(fieldsTable, openLibraryAssetAttachmentsPage(collectionId, asset.getId()).getLibraryAttachmentsList(), market, clockNumber);
    }

    @Then("{I |}'$shouldState' see following attached file{s|} '$attachedFileNamesList' on asset attachments page for each qc asset '$assetName' clone in collection '$collectionName'")
    public void checkAttachedFileVisibility(String shouldState, String attachedFileNamesList, String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        List<Content> assetsList = getCoreApi().getAllAssetByName(collectionId, prepareAssetName(assetName));
        if (assetsList.isEmpty()) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        for (Content asset: assetsList) {
            List<String> visibleAttachedFileNames = openLibraryAssetAttachmentsPage(collectionId, asset.getId()).getLibraryAttachmentsList().getVisibleAttachmentNames();
            for (String attachedFileName: attachedFileNamesList.split(","))
                assertThat("Check visibility of attached file: " + attachedFileName, visibleAttachedFileNames, shouldState.equals("should")
                                                                                                               ? hasItem(attachedFileName)
                                                                                                               : not(hasItem(attachedFileName)));
        }
    }
}