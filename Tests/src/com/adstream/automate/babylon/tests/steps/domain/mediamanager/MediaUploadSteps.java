package com.adstream.automate.babylon.tests.steps.domain.mediamanager;

import com.adstream.automate.babylon.sut.pages.mediamanager.*;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerFileInfoPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.apache.commons.io.FileUtils;
import org.hamcrest.Matchers;
import org.hamcrest.core.Is;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.TimeoutException;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.lessThan;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.number.OrderingComparison.greaterThan;

/**
 * Created by Saritha.Dhanala on 18/12/2017.
 */
public class MediaUploadSteps extends BaseStep {
    protected final long timeOut = 1500; //2 sec
    protected final long globalTimeout = 6 * 60 * 1000; // 6 min

    public MediaManagerUploadPage getCurrentMediaUploadsPage() {
        return getSut().getPageCreator().getMediaUploadPage();
    }


    @Given("I am on A5 Login page")
    @When("I go to A5 Login page")
    public void openA5LoginPage() {
        getSut().getPageCreator().getLoginPage();
    }

    @Given("I am on Media Manager Uploads page")
    @When("{I |}go to Media Manager Uploads page")
    public void openMMUploadsPage() {
        getSut().getPageNavigator().getMMUploadPage();
    }

    @Given("{I |}uploaded media file in to media uploader via UI:$fields")
    @When("{I |}upload media file in to media uploader via UI:$fields")
    public void uploadMediaFile(ExamplesTable fieldsTable) throws IOException {
       for(int i =0; i< fieldsTable.getRowCount(); i++){
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String filePath = getFilePath(row.get("MediaFilePath"));
            getCurrentMediaUploadsPage().uploadMediaFileViaUI(filePath);
        }
    }

    @When("{I |}upload file '$mediaFilePath' to order with '$clockNumber' in uploader page via UI")
    public void uploadFileToOrder(String filePath, String clockNumber){
        getCurrentMediaUploadsPage().uploadMediaFileToOrderViaUI(getFilePath(filePath));
    }

    @When("{I |}upload file '$mediaFilePath' to order with '$clockNumber' in to media '$pageName' page via UI")
    public void uploadFileWithOrderName(String mediaFilePath, String clockNumber, String pageName) throws IOException {
        String[] fileName = mediaFilePath.split("files/");
        String filePath = getFilePath(mediaFilePath);
        String[] splitfile = filePath.split(fileName[1]);
        String newFileName = wrapVariableWithTestSession(splitfile[0]+clockNumber) + ".mov";

        File f = new File(filePath);
        File f1 =new File(newFileName);
        FileUtils.copyFile(f, f1);
        Common.sleep(1000);

        try {
             if(pageName.equalsIgnoreCase("Uploader")) {
                    getCurrentMediaUploadsPage().uploadMediaFileToOrderViaUI(f1.getPath());
//                    getCurrentMediaUploadsPage().waitUntilProgressBarFinishesInUploadPage();
                }else if(pageName.equalsIgnoreCase("Info")) {
                    getSut().getPageCreator().getMediaManagerFileInfoPage().uploadVideoToMediaFileInfoPageViaUI(f1.getPath());
                }
            } finally {
            f1.delete();

        }

    }

    @Then("{I |}'$condition' see error message '$message' in media uploader page")
    public void checkErrorMessage(String condition, String message){
         assertThat(getCurrentMediaUploadsPage().getErrorMessage(), condition.equals("should")?Is.is(message):not(Is.is(message)));
    }


    @Then("{I |}should see warning message '$message' on media manager uploads page")
    public void checkWarningMessage(String message) {
        boolean actualState = getSut().getPageCreator().getMediaUploadPage().isWarningFailedUploadMessageExist(message);
        assertThat(true, Matchers.is(actualState));
    }


    @Given("{I |} uploaded '$fileName' file using MM middle tier api")
    public void uploadFileToMM(String fileName) throws IOException {
        MediaManagerUploadPage m = getSut().getPageNavigator().getMMUploadPage();
        m.clickHoldButton();
        Common.sleep(2000);
        m.clickHistoryButton();
        Common.sleep(2000);
        //  createFileForMM(fileName);
    }

    @When("{I |}click paging list")
    public void clickPagingListMMUploadPage() {
        MediaManagerUploadPage m = getSut().getPageNavigator().getMMUploadPage();
        m.clickPagingList();
    }

    @When("{I |}select files '$number' in paginglist")
    public void selectFilesPerPage(String number) {
        MediaManagerUploadPage m = getSut().getPageNavigator().getMMUploadPage();
        m.selectFilesDisplayedPerPage(number);
    }

    @Then("{I | }should see following pagination sizes with default size '$size' in the dropdown in MM upload page:$data")
    public void checkFilesPerPageSizeInMMUploadPage(String size, ExamplesTable data) {
        List<String> sizes = getCurrentMediaUploadsPage().getPaginationSizesPage(size);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat(sizes.get(i), containsString(row.get("PaginationSize")));
        }

    }

    @Then("{I |}should see the number of files display per page is '$number'")
    public void checkFilesOnPage(String number) {
        MediaManagerUploadPage m = getSut().getPageNavigator().getMMUploadPage();
        assertThat("Number of files displayed ", m.getNumberOfFilesDisplayed(), equalTo(Integer.parseInt(number)));
    }

    @When("{I |}search the media file by '$searchType'")
    public void searchUploaderFile(String searchValue) {
        getCurrentMediaUploadsPage().searchTextMedia(wrapVariableWithTestSession(searchValue));

    }

    @When("{I |}click element '$pagingButton' on MM upload page")
    public void clickPagingButton(String pagingButton) {
        MediaManagerUploadPage m = getSut().getPageNavigator().getMMUploadPage();
        m.clickMMPagingButton(pagingButton);
    }


    @Then("{I |}should see '$number' media files in uploads page")
    public void checkMediaFile(String number) {
        boolean actualState = false;
        assertThat("Search Value not present ",  getCurrentMediaUploadsPage().getNumberOfFilesDisplayed(), is(Integer.parseInt(number)));

    }

    @When("{I |}click view details of the media file '$fileName'")
    public void viewDetailsOfMediaFile(String fileName) {
        getCurrentMediaUploadsPage().clickViewdetailsButton(fileName);
    }

    @When("{I |}click view details")
    public void viewDetailsInUploadPage() {
        getCurrentMediaUploadsPage().clickViewdetailsButton();

    }

    @Then("{I |}should see Error popup")
    public void errorPopUp(){
        getCurrentMediaUploadsPage().isItInvalidfile();
    }

    @Then("{I |}'$shouldState' see the uploaded video name '$videoName'")
    public void CheckFileName(String shouldState, String videoName) {
        assertThat("Check uploaded video visibility", getCurrentMediaUploadsPage().isMediaFileVisible(wrapVariableWithTestSession(videoName) + ".mov"), Matchers.is(shouldState.equals("should")));
    }

    //check the unique field to remove
    @When("{I }remove the media file")
    public void removeMediaFile() {
        MediaManagerUploadPage m = getSut().getPageNavigator().getMMUploadPage();
        String uploadCountBeforeDeletion = m.getNumberOfUploadfiles();
        String uploadCountAfterDeletion;
        m.clickMediaRemovalButton();
        m.confirmDeletion();
        Common.sleep(2000);
        uploadCountAfterDeletion = m.getNumberOfUploadfiles();
        assertThat("File is not deleted", uploadCountBeforeDeletion, greaterThan(uploadCountAfterDeletion));
    }

    @When("{I |}sort media files by '$type' date in uploads page")
    public void selectByOldDate(String type) {
        getCurrentMediaUploadsPage().clickSortByDateList(type);
    }

    @Then("{I |}'$shouldState' see the file '$fileName' {attached to  request|in first place}")
    public void checkSortedFile(String shouldState, String fileName) {
        MediaManagerUploadPage m = getSut().getPageNavigator().getMMUploadPage();
        boolean fileExists = m.getFirstFileName(fileName);
        boolean should = shouldState.equalsIgnoreCase("should");
        assertThat("File is not available", fileExists, is(should));
    }

    @Then("{I |}'$shouldState' see the tile '$fileName' in Uploads page")
    public void checkTileExists(String shouldState, String fileName) {
        boolean fileExists = getCurrentMediaUploadsPage().isFileExists(wrapVariableWithTestSession(fileName) + ".mov");
        boolean should = shouldState.equalsIgnoreCase("should");
        assertThat("File is available", fileExists, is(should));
    }

    @When("{I |}edit the below details:$fields")
    public void editViewDetails(ExamplesTable fields) {
        MediaManagerFileInfoPage viewDetailsPage = getSut().getPageCreator().getMediaManagerFileInfoPage();
        Map<String, String> row = parametrizeTabularRow(fields);
        for (Map.Entry<String, String> field : row.entrySet()) {
            if (field.getKey().contains("duration") || field.getKey().contains("version")) {
                viewDetailsPage.fillFieldByName(field.getKey(), field.getValue());
            } else {
                viewDetailsPage.fillFieldByName(field.getKey(), wrapVariableWithTestSession(field.getValue()));
            }
        }
        viewDetailsPage.saveRequest();
    }

    @When("waited while order with clock number '$clockNumber' is available in media manager")
    public void waitTillOrderAppears(String clockNumber) {
        long start = System.currentTimeMillis();
       do {
            if (timeOut > 0)
                Common.sleep(timeOut * 3);
            if (getCurrentMediaUploadsPage().isFileExists("N/A") && getCurrentMediaUploadsPage().getClocknumber().trim().equalsIgnoreCase(wrapVariableWithTestSession(clockNumber)))
                break;
        } while (System.currentTimeMillis() - start < globalTimeout);
        if (System.currentTimeMillis() - start > globalTimeout)
            throw new TimeoutException("Timeout:: Check for replication of order in Media manager '" + wrapVariableWithTestSession(clockNumber) + "'");

    }

    @Then("{I |}should see the resolution type as '$type'")
    public void checkResolution(String type){
       assertThat("The resolution is different", getCurrentMediaUploadsPage().getResolutionType(), containsString(type));
    }


    @Then("{I |}should see the following data for media file in upload page: $dataTable")
    public void checkFileMetadata(ExamplesTable dataTable) {
        Map<String, String> data = parametrizeTabularRow(dataTable);
        MediaManagerUploadPage.MediaMetaData actualData = new MediaManagerUploadPage.MediaMetaData(getSut().getWebDriver());
        if ((data.get("Clock no.") != null) && (!data.get("Clock no.").isEmpty())) {
            assertThat(actualData.getClockNumber().trim(), equalTo(wrapVariableWithTestSession(data.get("Clock no."))));
        }
        if ((data.get("Title") != null) && (!data.get("Title").isEmpty())) {
            assertThat(actualData.getTitle().trim(), equalTo(wrapVariableWithTestSession(data.get("Title"))));
        }
        if ((data.get("Market") != null) && (!data.get("Market").isEmpty())) {
            assertThat(actualData.getMarket().trim(), equalTo(data.get("Market")));
        }
        if ((data.get("Advertiser") != null) && (!data.get("Advertiser").isEmpty())) {
            assertThat(actualData.getAdvertiser().trim(), equalTo(wrapVariableWithTestSession(data.get("Advertiser"))));
        }
        if ((data.get("Product") != null) && (!data.get("Product").isEmpty())) {
            assertThat(actualData.getProduct().trim(), equalTo(wrapVariableWithTestSession(data.get("Product"))));
        }
        if ((data.get("QC Message") != null) && (!(data.get("QC Message").isEmpty()))) {
            assertThat(getCurrentMediaUploadsPage().getQCMessage(), equalTo(data.get("QC Message")));
        }
        if (data.get("User") != null) {
            assertThat(getCurrentMediaUploadsPage().getRequestData(), Matchers.containsString(wrapUserEmailWithTestSession(data.get("User"))));
        }
    }

    @When("{I |}submit files with clocknumber '$clockNumber' in upload page")
    @Then("{I |}submit files with clocknumber '$clockNumber' in upload page")
    public void submitMediaFile(String clockNumber) {
        getCurrentMediaUploadsPage().clickSubmitNow();
    }

    @When("{I |}submit unattached files in upload page")
    public void submitMediaFile() {
         getCurrentMediaUploadsPage().clickSubmitNow();
    }


    @Then("{I |}'$shouldState' see  the media file tile with clocknumber '$clockNumber'")
    public void searchMediaFile(String shouldState, String fileName) {

    }

    @When("{I |}close the view details page")
    public void closeViewDetailsPAge() {
        MediaManagerFileInfoPage viewDetailsPage = getSut().getPageCreator().getMediaManagerFileInfoPage();
        viewDetailsPage.closeViewDetails();
    }


    @Then("{I |}'$shouldState' see following media file '$MediaFile' on Uploads page")
    public void checkVisibilityMediaFile(String shouldState, String fileName) {
        MediaManagerUploadPage page = getCurrentMediaUploadsPage();
        assertThat("Check visibility media file: " + fileName, page.isMediaFileVisible(fileName), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see button '$buttonName' present on Uploads page for file '$fileName'")
    public void checkButtonPresence(String shouldState, String buttonName, String fileName) {
        MediaManagerUploadPage page = getCurrentMediaUploadsPage();
        assertThat("Check button enabled: " + buttonName, page.isButtonPresent(fileName,buttonName), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see button '$buttonName' for request with clock '$clock' in Uploads page")
    public void checkButtonPresenceForRequest(String shouldState, String buttonName, String clock) {
        MediaManagerUploadPage page = getCurrentMediaUploadsPage();
        assertThat("Check button enabled: " + buttonName, page.isButtonPresent(wrapVariableWithTestSession(clock)+".mov",buttonName), is(shouldState.equals("should")));
    }

    @When("{I |}fill following fields for registration in media manager: $fieldsTable")
    public void fillMediaManagerRegistrationForm(ExamplesTable fieldsTable) {
        MediaManagerRegistrationForm n = getSut().getPageNavigator().getMMLoginPage().clickRegisterLink();
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        for (Map.Entry<String, String> entry : row.entrySet())
            n.fillRegisterForm(entry.getKey(), entry.getValue());
            n.clickRegisterButton();
    }


    //Then should display the message 'You need to verify your email address to activate your account.An email with instructions to verify your email address has been sent to you.eceived a verification code in your email? Click here to re-send the email.'
    @Then("should display the message '$message'")
    public void VerifyEmailMessage(String message) {
        new MediaManagerRegistrationForm(getSut().getWebDriver()).getEmailMessage();

    }

    @Given("{I |}wait until QC process spinner disappers in '$page' page")
    @When("{I |}wait until QC process spinner disappers in '$page' page")
    public void waitQCProcessCompleted(String page) {
        if (page.equalsIgnoreCase("Uploads")) {
            getCurrentMediaUploadsPage().waitUntilQCSpinnerDisappearsInUploadsPage();
        }
            else if (page.equalsIgnoreCase("Info")) {
                getSut().getPageCreator().getMediaManagerFileInfoPage().waitUntilQCSpinnerDisappearsInInfoPage();
            }
        else if (page.equalsIgnoreCase("MezzReport")) {
            getSut().getPageCreator().getMediaCheckerMezzReportPage().waitUntilQCSpinnerDisappearsInMezzReportPage();
        }
    }

    @Given("{I |}wait until qc error message appears in '$page' page")
    @When("{I |}wait until qc error message appears in '$page' page")
    public void waitQCErrorMessage(String page) {
        if (page.equalsIgnoreCase("MezzReport")) {
            getSut().getPageCreator().getMediaCheckerMezzReportPage().waitUntilQCErrorMessageappearsInMezzReportPage();
        }
    }

    @Then("{I |}am able to navigate between the pages in uploader")
    public void verifyPagenavigationInUploader(){
            Common.sleep(1000);
            String[] values = getSut().getPageCreator().getMMUploadPage().clicknavigatorRight();
            assertThat("Pagination right does not happen ", values[0], lessThan(values[1]));
            values = getSut().getPageCreator().getMMUploadPage().clicknavigatorLeft();
            assertThat("Pagination right does not happen ", values[0], greaterThan(values[1]));
    }

    @When("{I |}'$condition' see the asset tile text as '$assetText'")
    @Then("{I |}'$condition' see the asset tile text as '$assetText'")
    public void VerifyAssetTileText(String condition, String assetText) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("The text is not displayed", getCurrentMediaUploadsPage().isAssetTextDisplayed(assetText), is(shouldState));
    }

    @When("{I |}logout while uploading media file in to media uploader via UI:$fields")
    public void Logout_uploadMediaFile(ExamplesTable fieldsTable) throws IOException {
        for(int i =0; i< fieldsTable.getRowCount(); i++){
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String filePath = getFilePath(row.get("MediaFilePath"));
            getCurrentMediaUploadsPage().Logout_uploadMediaFileViaUI(filePath);
        }
    }

    @When("{I |}click View Details for asset '$asset'")
     public void clickViewDetails(String asset) {
        getCurrentMediaUploadsPage().clickViewdetailsButton_Asset(asset);
    }
}
