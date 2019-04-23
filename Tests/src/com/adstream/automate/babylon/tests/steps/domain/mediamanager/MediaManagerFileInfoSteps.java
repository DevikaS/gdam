package com.adstream.automate.babylon.tests.steps.domain.mediamanager;


import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerFileInfoPage;
import com.adstream.automate.babylon.JsonObjects.mediamanager.*;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerHistoryPage;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerQCReportPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import com.google.gson.JsonParser;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;
import org.hamcrest.core.IsEqual;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.core.IsEqual.equalTo;

/**
 * Created by Saritha.Dhanala on 08/02/2018.
 */
public class MediaManagerFileInfoSteps extends BaseStep {

    private MediaManagerFileInfoPage getCurrentMediaManagerFileInfoPage() {
        return getSut().getPageCreator().getMediaManagerFileInfoPage();
    }

    @When("{I |}fill meta data in media manager file info page:$fields")
    public void fillMediaMetaData(ExamplesTable fields){
        MediaManagerFileInfoPage viewDetailsPage = getSut().getPageCreator().getMediaManagerFileInfoPage();
        Map<String,String> row = parametrizeTabularRow(fields);
        for (Map.Entry<String, String> field : row.entrySet()) {
            if(!field.getKey().isEmpty()) {
                if (field.getKey().contains("Market") || field.getKey().contains("Duration") || field.getKey().contains("version")) {
                     if (field.getKey().contains("Duration")) {
                        String[] data = field.getValue().split(",");
                        for (int i = 0; i < data.length; i++)
                            viewDetailsPage.fillFieldByName(field.getKey(), data[i]);
                    }
                    else viewDetailsPage.fillFieldByName(field.getKey(), field.getValue());
                }else if (field.getKey().equalsIgnoreCase("AgencyUnique")) {
                    viewDetailsPage.fillFieldByName("agency", wrapVariableWithTestSession(field.getValue()));
                }
                 else if (field.getKey().equalsIgnoreCase("agency")) {
                     if (getData().getAgencyByName(field.getValue())!= null || field.getValue().equals("##"))
                         viewDetailsPage.fillFieldByName("agency", getData().getAgencyByName(field.getValue()).getName());
                     else
                         viewDetailsPage.fillFieldByName("agency", wrapVariableWithTestSession(field.getValue()));
                }else{
                    viewDetailsPage.fillFieldByName(field.getKey(), wrapVariableWithTestSession(field.getValue()));
                }
            }
        }
        Common.sleep(3000);
        viewDetailsPage.saveRequest();

    }


    @Then("{I |}'$should' see the duration error message in info page as '$message'")
    public void checkDurationErrorInInfoPage(String condition, String message){
        String actualMessage=getCurrentMediaManagerFileInfoPage().getDurationError();
        if(condition.equalsIgnoreCase("should"))
        assertThat("Duration message is not matched",actualMessage.equalsIgnoreCase(message));
        else  if(condition.equalsIgnoreCase("should not"))
            assertThat("Duration message is displayed", actualMessage, not(message));
    }

    @Then("{I |}'$condition' see the file upload error message in report page as '$message'")
    public void checkFileUploadMessage(String condition,String message){
        if(condition.equalsIgnoreCase("should"))
          assertThat("File Upload message is not matched", getSut().getPageCreator().getMediaManagerQCReportPage().getFileUploadErrorMessage(), is(message));
        else  if(condition.equalsIgnoreCase("should not"))
          assertThat("File Upload message is displayed", getSut().getPageCreator().getMediaManagerQCReportPage().getFileUploadErrorMessage(), not(message));

    }


    @Then("{I |}'$should' see on media file info page that file is playable")
    public void isPlayableMediaFileExist(String condition){
        boolean shouldState = true;
        boolean actualState = getCurrentMediaManagerFileInfoPage().isMediaFilePlayable();

        assertThat(" Media File is not playable", shouldState ==  actualState);
    }


    @Then("{I |}'$should' see the details in media manager file info page: $fieldsTable")
    public void checkMediaFileMetaData(String condition, ExamplesTable data) {
        MediaManagerFileInfoPage page = getSut().getPageCreator().getMediaManagerFileInfoPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        Map<String, String> actualMetaData = page.getMetaDataDetails();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.containsKey("Market")) {
                assertThat("Market", actualMetaData.get("Market").trim(), is(row.get("Market")));
            }
            if (row.containsKey("Clock Number")) {
                assertThat("Clock Number", actualMetaData.get("Clock Number").trim(),is(wrapVariableWithTestSession(row.get("Clock Number"))));
            }
            if (row.containsKey("Agency")) {
                if(row.get("Agency").contains("DefaultAgency"))
                    assertThat("Agency", actualMetaData.get("Agency").trim(),is(getData().getAgencyByName(row.get("Agency")).getName()));
                else
                assertThat("Agency", actualMetaData.get("Agency").trim(),is(wrapVariableWithTestSession(row.get("Agency"))));
            }
            if (row.containsKey("Advertiser")) {
                assertThat("Advertiser", actualMetaData.get("Advertiser").trim(), is(wrapVariableWithTestSession(row.get("Advertiser"))));
            }
            if (row.containsKey("Product")) {
                assertThat("Product", actualMetaData.get("Product").trim(), is(wrapVariableWithTestSession(row.get("Product"))));
            }

        }

    }


    @When("{I |}close the view details page")
    public void closeViewDetailsPAge() {
        MediaManagerFileInfoPage viewDetailsPage = getSut().getPageCreator().getMediaManagerFileInfoPage();
        viewDetailsPage.closeViewDetails();
    }

    @Then("{I |}'$condition' see the warning messages '$warnings' for mandatory fields")
    public void checkWarningMessage(String condition,String messages){
        boolean shouldState = condition.equalsIgnoreCase("should");
        String[] expectedWarningMessages = messages.split(",");
        List<String> actualWarningMessages = getCurrentMediaManagerFileInfoPage().getWarningMessages();
        for(String message : expectedWarningMessages)
         assertThat(actualWarningMessages, shouldState ? hasItem(message) : not(hasItem(message)));
    }

        @Then("{I |}'$condition' see progress message is displayed as '$assetText'")
    public void VerifyProgressMessagedisplayed(String condition, String assetText) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("The progress message is not displayed", getCurrentMediaManagerFileInfoPage().isProgressMessageDisplayed(assetText), is(shouldState));
    }
    @Then("{I |}'$condition' see the QC status message '$message'")
    public void checkStatusMessageInQCReport(String condition, String message){
        MediaManagerQCReportPage page = getSut().getPageCreator().getMediaManagerQCReportPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("QC report message ", page.getQCStatusMessage(), equalToIgnoringCase(message));
    }

    @Then("{I |}'$condition' see the below media file details on QC Report in UI: $fieldsTable")
    public void checkMediaFileDetailsViaUI(String condition, ExamplesTable data){
        MediaManagerQCReportPage page = getSut().getPageCreator().getMediaManagerQCReportPage();
        String actualStatus = page.getQCStatusMessage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        if(actualStatus.contains("Passed")) {
            Map<String,String> actualQCPASSFileInfo = page.getQCPassFileInfo();
                for(Map<String,String> row : parametrizeTableRows(data)){
                if (row.containsKey("audioCodec")) {
                    assertThat("audioCodec", actualQCPASSFileInfo.get("Audio Codec").trim(), is(row.get("audioCodec")));
                }
                if (row.containsKey("filetype")) {
                    assertThat("filetype", actualQCPASSFileInfo.get("File Type").trim(), equalTo(row.get("filetype")));
                }
                if (row.containsKey("fileSize")) {
                    assertThat("fileSize", actualQCPASSFileInfo.get("File Size").trim(), equalTo(row.get("fileSize")));
                }
                if (row.containsKey("videoCodec")) {
                    assertThat("videoCodec", actualQCPASSFileInfo.get("Video Codec").trim(), equalTo(row.get("videoCodec")));
                }
                if (row.containsKey("firstFrameTimeCode")) {
                    assertThat("firstFrameTimeCode", actualQCPASSFileInfo.get("First Frame Time Code").trim(), equalTo(row.get("firstFrameTimeCode")));
                }
                if (row.containsKey("Template")) {
                        assertThat("Template", actualQCPASSFileInfo.get("Template").trim(), equalTo(row.get("Template")));
                    }
                if (row.containsKey("length")) {
                    assertThat("length", actualQCPASSFileInfo.get("Length").trim(), equalTo(row.get("length")));
                }
        }}
        if(actualStatus.contains("errors"))
        {

            List<String> actualQCFAILFileInfo = page.getQCFailErrorMessages();
            List<String> expectedFAILFileInfo = new ArrayList<>();
            for (Map<String, String> row : parametrizeTableRows(data)) {
                expectedFAILFileInfo.add(row.get("Errors"));
            }

            for (String expected : expectedFAILFileInfo) {
                assertThat(expected, isIn(actualQCFAILFileInfo));
            }
        }
   }

    @When("{I |}click '$buttonORLink' in media manger file info page")
    public void clickButtonORLink(String buttonORLink) {
        getSut().getPageCreator().getMediaManagerFileInfoPage().clickButtonLink(buttonORLink);

    }

    @Then("{I |}should see '$number' assets in the Select an asset popup")
    public void checkNumberOfAssets(String number){
        assertThat("The number of assets are not matched ", getCurrentMediaManagerFileInfoPage().getNumberOfAssets(), is(Integer.parseInt(number)));
    }

    @When("{I |}select asset '$number' in the Select an asset popup")
    public void selectAsset(String number) {
        getCurrentMediaManagerFileInfoPage().selectAsset(number);
    }


    @When("{I |}click Download QC Report button")
    public void clickDownloadQCReportButton() {
        getSut().getPageCreator().getMediaManagerQCReportPage().clickDownloadQAReportButton();
    }

    @When("{I |}click file info button")
    public void clickFileInfoButton() {
        getSut().getPageCreator().getMediaManagerQCReportPage().clickFileInfoButton();
    }

    @When("{I |}click QC Report button in media manager file info page")
    public void clickQCReportButton(){
        getCurrentMediaManagerFileInfoPage().clickQCReportButton();
    }
    @When("{I |}attach asset")
    public void clickAttachAsset(){
        getCurrentMediaManagerFileInfoPage().attachAsset();
    }

    @When("{I |}upload video '$mediaFilePath' in to Media File Info page via UI")
    public void uploadFileInMediaFileInfoPage(String mediaFilePath) {
        MediaManagerFileInfoPage page = getSut().getPageCreator().getMediaManagerFileInfoPage();
        String filepath = getFilePath(mediaFilePath);
        File f = new File(filepath);
        String[] splitfile = filepath.split(".mov");
        String newFileName = wrapVariableWithTestSession(splitfile[0]) + ".mov";
        try {
            f.renameTo(new File(newFileName));
            page.uploadVideoToMediaFileInfoPageViaUI(newFileName);
        } finally {
            new File(newFileName).renameTo(new File(splitfile[0] + ".mov"));

        }
    }


    @Then("{I |}'$shouldState' see order details data form in Media File Info page:$fields")
    public void checkOrderDetails(String shouldState, ExamplesTable fieldsTable) {
        Map<String,String> expectedData = new HashMap();
        String fieldName = null;
        MediaManagerFileInfoPage page = getSut().getPageCreator().getMediaManagerFileInfoPage();
        Map<String, String> actualData = page.getRequestDetails();
        for(int i =0 ;i< fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            fieldName = row.get("FieldName").substring(0,1).toUpperCase()+row.get("FieldName").substring(1);
            if (fieldName.contains("Market") || fieldName.contains("Duration"))
                expectedData.put(fieldName, row.get("Value"));
            else if (fieldName.contains("Agency"))
                expectedData.put(row.get("FieldName"),getAgencyByName(row.get("Value")).getName());
            else if (fieldName.contains("Uploader"))
                expectedData.put(fieldName, getData().getCurrentUser().getEmail());
            else
                expectedData.put(fieldName, wrapVariableWithTestSession(row.get("Value")));
        }
        assertThat("Check the order details is enabled ",actualData, Matchers.equalTo(expectedData));
    }

    @When("{I |}click '$buttonName' in file report page")
    public void clickButtonInReportPage(String buttonName){
        MediaManagerQCReportPage page = getSut().getPageCreator().getMediaManagerQCReportPage();
        page.clickActionReportButton(buttonName);
        Common.sleep(2000);
        page.clickOnPopup(buttonName);

    }


    @Then("{I |}'$condition' see the below media file details on QC Report download via API: $fieldsTable")
    public void checkMediaFileDetailsViaAPI(String condition, ExamplesTable data){
        boolean shouldState = condition.equalsIgnoreCase("should");
        MediaManagerQCReportPage qcReportPage = getSut().getPageCreator().getMediaManagerQCReportPage();
        String fileId = qcReportPage.getFileId();

        AQAReport rep  =  getCoreApi().getQCReportData(fileId);
        StreamInfo s = rep.getDocument().getObjects()[0].getJsonReports()[0].getStreamInfo();
        JobInfo ji = rep.getDocument().getObjects()[0].getJsonReports()[0].getJobInfo();
        Map<String, String> row = parametrizeTabularRow(data);
        if (row.get("audioCodec") != null)
           assertThat("Check AudioCodec: ", s.getAudioCodec(), Matchers.equalTo(row.get("audioCodec")));
        if (row.get("fileType") != null)
            assertThat("Check FileType: ", s.getFileType(), Matchers.equalTo(row.get("fileType")));
        if (row.get("fileSize") != null)
            assertThat("Check fileSize: ", s.getFileSize(), Matchers.equalTo(row.get("fileSize")));
        if (row.get("videoCodec") != null)
            assertThat("Check videoCodec: ", s.getVideoCodec(), Matchers.equalTo(row.get("videoCodec")));
        if (row.get("firstFrameTimeCode") != null)
            assertThat("Check firstFrameTimeCode: ", s.getFirstFrameTimeCode(), Matchers.equalTo(row.get("firstFrameTimeCode")));
        if (row.get("length") != null)
            assertThat("Check length: ", s.getLength(), Matchers.equalTo(row.get("length")));
        if (row.get("Status") != null)
            assertThat("Check Status: ", ji.getStatus(), Matchers.equalTo(row.get("Status")));
        if (row.get("Errors") != null)
            assertThat("Check Errors: ", ji.getTotalErrors(), Matchers.equalTo(row.get("Errors")));

    }

    @When("{I |} click Safe Tile check box")
    public void clickSafeTile(){
        getCurrentMediaManagerFileInfoPage().clickSafeTile();
    }


    @Then("{I |}should see the safe tile is '$status'")
    public void checkSafeTileStatus(String status) {
        boolean expectedState = false;
        if (status.equalsIgnoreCase("off")) {
            expectedState = true;
        }
        boolean expectedStatus = status.equalsIgnoreCase("should");
        assertThat("Check Safe Tile", getCurrentMediaManagerFileInfoPage().isSafeTileNotSelected(), is(expectedState));
    }

    @Then("the safe frames should be '$status'")
    public void checkVisbibilityOfSafeFrames(String status) {
        assertThat("Check Safe frames", getCurrentMediaManagerFileInfoPage().isSafeFramesVisible(),containsString(status));
    }

    @Then("{I |}should see safe title dotted outline from the border of the video as: $fieldsTable")
    public void CheckSafeTileOutlines(ExamplesTable data){
        String[] actualOutline = getCurrentMediaManagerFileInfoPage().getSafeFrameOutlineDetails();
        for(int i =0;i<data.getRowCount();i++){
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat("Check Safe tile Outlines", actualOutline[i],equalTo(row.get("Outlines")));
        }

    }

    @Then("{I |}should see the error messages:$fields")
    public void checkErrorMessages(ExamplesTable table) {
        List<String> expectedData = new ArrayList<String>();
                List<String> actualErrros = getCurrentMediaManagerFileInfoPage().getErrorMessages();
        for (int i = 0; i < table.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(table, i);
             expectedData.add(row.get("Error messages"));
        }
        assertThat("The error maessages are different", actualErrros, equalTo(expectedData));
    }

    @Then("{I|}'$condition' see '$buttonName' button")
    public void checkReuploadButton(String condition,String buttonName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = false;
        switch (buttonName) {
            case "reupload":
                actualState = getSut().getPageCreator().getMediaManagerQCReportPage().checkForReuploadButton();
                break;
            default:
                throw new IllegalArgumentException(String.format("%s button is not available on this page", buttonName));
        }

    }

    @Given("{I |}reuploaded media file in to media uploader via UI:$fields")
    @When("{I |}reupload media file in to media uploader via UI:$fields")
    public void reUploadMediaFile(ExamplesTable fieldsTable) throws IOException {
        for(int i =0; i< fieldsTable.getRowCount(); i++){
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String filePath = getFilePath(row.get("MediaFilePath"));
            getSut().getPageCreator().getMediaManagerQCReportPage().reUploadMediaFileViaUI(filePath);
        }
    }


    @Then("{I |}should see Media Metadata:$fields")
    public void checkMediaMetaData(ExamplesTable fields){
        MediaManagerFileInfoPage viewDetailsPage = getSut().getPageCreator().getMediaManagerFileInfoPage();
        Map<String,String> row = parametrizeTabularRow(fields);
        Map<String, String> actualData = new HashMap<String,String>();
        for (Map.Entry<String, String> field : row.entrySet()) {
            if (field.getKey().contains("agency"))
                if(field.getValue().contains("Default"))
                    row.put(field.getKey(),getAgencyByName(field.getValue()).getName());
            if (field.getKey().contains("advertiser") || field.getKey().contains("product") || field.getKey().contains("title") || field.getKey().contains("clockNumber"))
                row.put(field.getKey(),wrapPathWithTestSession(field.getValue()));
            if (!field.getKey().isEmpty()) {
                if (field.getKey().contains("Market") || field.getKey().contains("Duration") || field.getKey().contains("version")) {
                    if (field.getKey().contains("Duration")) {
                        String[] data = field.getValue().split(",");
                        for (int i = 0; i < data.length; i++)
                            actualData.put(field.getKey(), viewDetailsPage.getFieldValueByName(field.getKey()));
                    } else actualData.put(field.getKey(),viewDetailsPage.getFieldValueByName(field.getKey()));
                } else
                    actualData.put(field.getKey(), viewDetailsPage.getFieldValueByName(field.getKey()));
            }
        }
        assertThat("Check the order details in info page ", actualData, Matchers.equalTo(row));

    }

    @Then("{I |}should see the duration error message in report page as '$message'")
    public void checkDurationErrorInReportPage(String message){
        assertThat("Duration message is not matched", getSut().getPageCreator().getMediaManagerQCReportPage().getDurationError(), is(message));

    }

}
