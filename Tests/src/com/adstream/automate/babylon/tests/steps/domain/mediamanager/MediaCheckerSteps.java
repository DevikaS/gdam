package com.adstream.automate.babylon.tests.steps.domain.mediamanager;

import com.adstream.automate.babylon.JsonObjects.mediamanager.AQAReport;
import com.adstream.automate.babylon.JsonObjects.mediamanager.JobInfo;
import com.adstream.automate.babylon.JsonObjects.mediamanager.StreamInfo;
import com.adstream.automate.babylon.sut.pages.mediamanager.*;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaCheckerEditPage;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaCheckerPage;
import com.adstream.automate.babylon.sut.pages.mediamanager.tablelist.MediaCheckerOrdersList;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Common;
import org.hamcrest.CoreMatchers;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;
import org.hamcrest.core.CombinableMatcher;
import org.hamcrest.core.IsEqual;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.number.OrderingComparison.greaterThan;

/**
 * Created by Saritha.Dhanala on 23/03/2018.
 */
public class MediaCheckerSteps extends BaseStep {

    public MediaCheckerPage getCurrentMediaCheckerPage() {
        return getSut().getPageCreator().getMediaCheckerPage();
    }

    public MediaCheckerAssetInfoPage getCurrentMCAssetInfoPage() {
        return getSut().getPageCreator().getMediaCheckerAssetInfoPage();
    }

    public MediaCheckerAssetEditPage getCurrentMCAssetEditPage() {
        return getSut().getPageCreator().getMediaCheckerAssetEditPage();
    }


    public MediaCheckerEditPage getCurrentMediaCheckerEditPage() {
        return getSut().getPageCreator().getMediaCheckerEditPage();
    }

    public MediaCheckerMezzInfoPage getCurrentMediaCheckerMezzInfoPage() {
        return getSut().getPageCreator().getMediaCheckerMezzInfoPage();
    }

    public MediaCheckerMezzReportPage getCurrentMediaCheckerMezzReportPage() {
        return getSut().getPageCreator().getMediaCheckerMezzReportPage();
    }


    @Given("I am on Media Checker page")
    @When("{I |}go to Media Checker page")
    public void openMediaCheckerPage() {
        getSut().getPageNavigator().getMediaCheckerPage();
        Common.sleep(1000);
     }

    @Given("I am on Media Checker History page")
    @When("{I |}go to Media Checker History page")
    public void openMCHistoryPage() {
        getSut().getPageNavigator().getMediaCheckerHistoryPage();
    }


    @When("{I |}open on tile with clock number '$clockNumber' in Media Checker page")
    public void openMediaFileInMediaChecker(String clockNumber) {
        getCurrentMediaCheckerPage().openRequestTile(clockNumber);

    }

    @When("{I |}click edit button in media checker info page")
    public void clickEditButton(){
        getCurrentMCAssetEditPage().clickEdit();
    }

    @When("{I |}click edit button in media checker Mezz info page")
    public void clickMezzEditButton(){
        getCurrentMediaCheckerMezzInfoPage().clickEdit();
    }

    @Then("{I |}'$condition' see disabled metadata for the matched asset in Media Checker edit page")
    public void checkMetadataDisabled(String condition){
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("MetaData is enabled", getCurrentMCAssetEditPage().isMetaDataDisabled(), is(shouldState));
    }

    @When("{I |}set at playhead for TC in and TC out")
    public void setPlayheadForTC(){
        getCurrentMCAssetEditPage().setPlayahead();
        getCurrentMCAssetEditPage().saveRequest();
    }

    @When("{I |}update meta data in media checker file edit page:$fields")
    public void updateMediaMetaData(ExamplesTable fields){
        MediaCheckerAssetEditPage editDetailsPage = getCurrentMCAssetEditPage();
        Common.sleep(2000);
        Map<String,String> row = parametrizeTabularRow(fields);
        for (Map.Entry<String, String> field : row.entrySet()) {
            if(!field.getKey().isEmpty()) {
                if (field.getKey().contains("TC in") || field.getKey().contains("TC out") || field.getKey().contains("Market") || field.getKey().contains("Duration") || field.getKey().contains("version")) {
                    if (field.getKey().contains("Duration")) {
                        String[] data = field.getValue().split(",");
                        for (int i = 0; i < data.length; i++)
                            editDetailsPage.fillFieldByName(field.getKey(), data[i]);
                    } else editDetailsPage.fillFieldByName(field.getKey(), field.getValue());
                }else  if (field.getKey().contains("agency")) {
                    if(field.getValue().contains("Default"))
                        editDetailsPage.fillFieldByName(field.getKey(), getData().getAgencyByName(field.getValue()).getName());
                    else
                        editDetailsPage.fillFieldByName(field.getKey(), field.getValue());
                }else{
                    editDetailsPage.fillFieldByName(field.getKey(), wrapVariableWithTestSession(field.getValue()));
                }
            }
        }
        Common.sleep(2000);
        editDetailsPage.saveRequest();

    }


    @When("{I |} set TCIN as '$tcIN' and TCOUT as '$tcOUT'")
    public void setTimeDuration(String tcIN, String tcOUT){
//        MediaCheckerEditPage editPage =  getCurrentMediaCheckerPage().clickEditButton();
//        editPage.setDuration(tcIN, tcOUT);
    }

    @Then("{I |}'$condition' see the TCIN as '$tcIN' and TCOUT as '$tcOUT' in asset info page of media checker")
    public void checkDurationValues(String condition, String tcIN, String tcOUT){
        boolean shouldState = condition.equalsIgnoreCase("should");
          assertThat("Check TCin value", getCurrentMediaCheckerEditPage().getTCINValue(),  is(tcIN));
          assertThat("Check TCin value", getCurrentMediaCheckerEditPage().getTCOUTValue(), is(tcOUT));
    }

    @When("save changes of current duration")
    public void clickSaveChanges(){
        getCurrentMediaCheckerEditPage().clickSaveChanges();
    }

    @When("{I |}'$actionType' the request tile via media checker Master Info Page")
    public void clickActionType(String actionType) {
        MediaCheckerAssetInfoPage page = getCurrentMCAssetInfoPage();
        page.clickOptionsList();
        if (actionType.equalsIgnoreCase("Delete")) {
            page.deleteRequestTile();
        } else if (actionType.equalsIgnoreCase("Send to AdPro"))
            page.sendToAdproRequestTile();
        else if (actionType.equalsIgnoreCase("Send for subtitling"))
            page.sendForSubtitlingRequestTile();
    }

    @When("{I |}'$actionType' type in media checker")
    public void downloadAssetType(String actionType){
        getCurrentMCAssetInfoPage().downloadOriginalORMezzanine(actionType);

    }

    @When("{I |}send request back to uploader '$email' in media checker")
    public void sendRequestToUploader(String email){
         getCurrentMediaCheckerPage().SendRequestBackToUploader(email);
    }


    @Then("{I |}'$shouldState' see the '$type' button")
    public void checkVisibilityOfButton(String shouldState, String type) {
        boolean should = shouldState.equals("should");
        MediaCheckerAssetInfoPage assetInfoPage = getCurrentMCAssetInfoPage();
        if(type.equalsIgnoreCase("Delete") || type.equalsIgnoreCase("Download original") || type.equalsIgnoreCase("Send request back to uploader") || type.equalsIgnoreCase("Send to AdPro"))
            assetInfoPage.clickOptionsList();
        assertThat("Visibility of button", assetInfoPage.isButtonVisible(type), equalTo(should));
    }


    @When("{I |}search the media file by '$searchType' with '$value' in Media Checker page")
    public void searchMediaCheckerForMediaFile(String searchType, String searchValue) {
        if (searchType.equals("title") || searchType.equals("clock no.") || searchType.equals("Agency"))
            getCurrentMediaCheckerPage().searchTextMedia(wrapVariableWithTestSession(searchValue));
        else
            getCurrentMediaCheckerPage().searchTextMedia(searchValue);

    }

    @Then("{I |}should see following details for asset in media checker:$assetsTable")
    public void checkDetails(ExamplesTable assetsTable) {
        Map<String, String> row = parametrizeTabularRow(assetsTable);
        List<String> actual = null;
        if (row.get("Status") != null) {
            actual = getCurrentMediaCheckerPage().getAssetfieldValues("Status");
        }
        int i = 0;

        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(), actual.get(i), equalTo(entry.getValue()));
            i++;
        }

    }

    @When("{I |}wait until the request with clocknumber '$clockNumber' appears in Media Checker")
    public void waitForTheRequest(String clockNumber) {
        getCurrentMediaCheckerPage().waitForRequest(wrapVariableWithTestSession(clockNumber));
    }

    @When("{I |}select market region as '$market' in  Media Checker")
    public void selectMarket(String market){
        getCurrentMediaCheckerPage().selectMarket(market);
    }

    @Then("{I |}should see below '$info' details in media checker page:$field")
    public void checkDetails(String info,ExamplesTable fieldsTable) {
        Common.sleep(1000);
        Map<String,String> orderDetails = new HashMap();
        MediaMangerBasePage page=null;
        getCurrentMediaCheckerPage().clickTab(info);
        if (info.equalsIgnoreCase("MasterInfo")) {
            page=getSut().getPageCreator().getMediaCheckerAssetInfoPage();
        } else if (info.equalsIgnoreCase("MezzInfo")) {
            page=getSut().getPageCreator().getMediaCheckerMezzInfoPage();
        }
        Map<String, String> actualData = page.getRequestDetails();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if(row.get("FieldName").contains("Market")||row.get("FieldName").contains("TC Out")||row.get("FieldName").contains("TC In")
                    || row.get("FieldName").contains("Duration") || row.get("FieldName").contains("Subtitles") || row.get("FieldName").contains("Subtitle Provider")) {
                orderDetails.put(row.get("FieldName"),row.get("Value"));

            } else if (row.get("FieldName").contains("Agency"))
                if(row.get("Value").contains("Default"))
                orderDetails.put(row.get("FieldName"),getAgencyByName(row.get("Value")).getName());
                else
                    orderDetails.put(row.get("FieldName"),row.get("Value"));
            else if (row.get("FieldName").contains("Uploader"))
                orderDetails.put(row.get("FieldName"),getData().getCurrentUser().getEmail());
            else
                orderDetails.put(row.get("FieldName"),wrapVariableWithTestSession(row.get("Value")));
         }
        Matcher<Map<String, String>> matcher = equalTo(orderDetails);
        assertThat("Check the order details in info page ", actualData, matcher);
    }

    @Then("{I |}'$should' see '$type' on top of the asset in Media Checker Mezz Info page")
    public void checkTypeOfProxy(String condition, String type){
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Showing Mezzanine is not displayed", getCurrentMediaCheckerMezzInfoPage().isFileTypeVisible(type), is(shouldState));
    }

    @Then("{I |}'$should' see the '$option' option for asset in Media Checker Mezz info page")
    public void checkItemDisplayed(String condition, String option){
        boolean shouldState = condition.equalsIgnoreCase("should");
        if(option.equalsIgnoreCase("Download Mezzanine"))
           getCurrentMediaCheckerMezzInfoPage().clickOptionsList();
        assertThat("Option is not displayed as "+option, getCurrentMediaCheckerMezzInfoPage().isButtonVisible(option), is(shouldState));
    }


    @Then("{I |}am able to navigate between the pages in media checker")
    public void verifyPagenavigationInMediaChecker(){
        MediaCheckerPage mc = getSut().getPageCreator().getMediaCheckerPage();
        String[] values = mc.clicknavigatorRight();
        assertThat("Pagination right does not happen ", values[0], lessThan(values[1]));
        values = mc.clicknavigatorLeft();
        assertThat("Pagination right does not happen ", values[0], greaterThan(values[1]));
    }

    @Then("{I |}should see the number of results display per '$page' page is '$number'")
    public void verifyResultPerMCPage(String page, String number){
        if(page.equals("Media Checker"))
        assertThat("Number of files displayed ", getCurrentMediaCheckerPage().numberOfResultsInMC(), equalTo(Integer.parseInt(number)));
        else if(page.equals("Media Checker History"))
            assertThat("Number of files displayed ", getSut().getPageCreator().getMCHistoryPage().numberOfResultsInMCHistoryPage(), equalTo(Integer.parseInt(number)));
    }

    @Then("{I |}should see following pagination sizes with default size '$size' in the dropdown in '$page' page:$data")
    public void checkFilesPerPageSizeInMMHistoryPage(String size, String page, ExamplesTable data) {
        List<String> sizes = null;
        if(page.equals("Media Checker"))
           sizes = getCurrentMediaCheckerPage().getPaginationSizesPage(size);
        else if(page.equals("Media Checker History"))
            sizes =getSut().getPageCreator().getMCHistoryPage().getPaginationSizesPage(size);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat(sizes.get(i), containsString(row.get("PaginationSize")));
        }

    }

    @Then("{I |}should see following sort by data with default as '$defaultSort' in the dropdown in MC page:$data")
    public void checkSortingText(String defaultSort, ExamplesTable data){
        List<String> sizes = getCurrentMediaCheckerPage().getSortbyList(defaultSort);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat(sizes.get(i), containsString(row.get("Sort by")));
        }
    }

    @Then("{I |}'$shouldState' see the file in media checker as recent file with value '$text'")
    public void checkRecentFile(String shouldState, String text){
        boolean should = shouldState.equals("should");
        assertThat("Check recent file in MC ", getCurrentMediaCheckerPage().isrecentFileDisplayed(wrapVariableWithTestSession(text)), equalTo(should));
    }

    @When("{I |}select sort by '$sortby' in media checker")
    public void selectSortByInMC(String sortby){
        getSut().getPageNavigator().getMediaCheckerPage().clickSortByInMediaChecker(sortby);
    }

    @Then("{I |}'$condition' see error message:$assetsTable")
    public void checkAssetDeadlineMissedMessage(String condition,ExamplesTable assetsTable) {
        Map<String, String> row = parametrizeTabularRow(assetsTable);
        boolean should = condition.equals("should");
        assertThat("Error message not available", getCurrentMediaCheckerPage().getDeadlineMessage().contains(row.get("Deadline Message")), equalTo(should));
    }

        @Then("{I |}'$condition' see order details in media checker for ClockNumber '$clockNumber':$field")
        public void checkOrderDetails (String condition, String clockNumber, ExamplesTable fieldsTable){
            Common.sleep(1000);
            Map<String, String> orderDetails = new HashMap();
            MediaCheckerOrdersList mediaCheckerOrdersList = getCurrentMediaCheckerPage().getMediaOrderList();
            MediaCheckerOrdersList.AssetOrder assetOrder = mediaCheckerOrdersList.getOrderByClockNumber(wrapPathWithTestSession(clockNumber));

            for (int i = 0; i < fieldsTable.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
                if (row.containsKey("Agency")) {
                    Matcher<String> matcher = condition.equalsIgnoreCase("should") ? equalTo(wrapAgencyName(row.get("Agency"))) : not(wrapAgencyName(row.get("Agency")));
                    assertThat("Agency", assetOrder.getAgency(), matcher);
                }

                if (row.containsKey("Clock Number")) {
                    Matcher<String> matcher = condition.equalsIgnoreCase("should") ? equalTo(wrapAgencyName(wrapVariableWithTestSession(row.get("Clock Number")))) : not(wrapAgencyName(wrapVariableWithTestSession(row.get("Clock Number"))));
                    assertThat("Clock Number", assetOrder.getClockNumber(), matcher);

                }

                if (row.containsKey("Status")) {
                    Matcher<String> matcher = condition.equalsIgnoreCase("should") ? equalTo(row.get("Status")) : not(row.get("Status"));
                    assertThat("Status", assetOrder.getStatus(), matcher);
                }

                if (row.containsKey("Additional Services")) {
                    Matcher<String> matcher = condition.equalsIgnoreCase("should") ? equalTo(row.get("Additional Services")) : not(row.get("Additional Services"));
                    assertThat("Additional Services", assetOrder.getAdditionalServices(), equalTo(row.get("Additional Services")));
                }

            }
        }


        @Then("{I |}'$condition' see following data in Media File Info page of media checker:$field")
        public void checkData (String condition, ExamplesTable fieldsTable){
            Map<String, String> actualData = getCurrentMCAssetInfoPage().getRequestDetails();
            for (int i = 0; i < fieldsTable.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
                Matcher<String> matcher = condition.equalsIgnoreCase("should") ? equalTo(row.get("subtitles")) : not(row.get("subtitles"));
                assertThat(actualData.get("subtitles"),anyOf(equalTo(null),matcher));
            }
        }

        @Then("{I |}'$shouldState' see '$actionType' the request tile in media checker")
        public void clickIfButtonVisible (String shouldState, String actionType){
            boolean should = shouldState.equals("should");
            boolean found = false;
            if (actionType.equalsIgnoreCase("Send for subtitling"))
                found = getCurrentMCAssetInfoPage().isButtonVisible(actionType);
            assertThat(String.format("Button %s %s be visible", actionType, should), found, equalTo(should));
        }


    @Then("{I |}'$condition' see the below '$report' in Media Checker: $fieldsTable")
    public void checkMediaFileDetailsViaUI(String condition, String report,ExamplesTable data){
        MediaCheckerAssetInfoPage assetInfo = getSut().getPageCreator().getMediaCheckerAssetInfoPage();
        MediaMangerBasePage page=null;
        assetInfo.clickTab(report);
        boolean shouldState = condition.equalsIgnoreCase("should");
        if(report.equalsIgnoreCase("MasterReport"))
        {
            page=getSut().getPageCreator().getMediaCheckerQCReportPage();
        }
        else if(report.equalsIgnoreCase("MezzReport")){
            page=getSut().getPageCreator().getMediaCheckerMezzReportPage();
            Common.sleep(2000);
            getSut().getWebDriver().navigate().refresh();
            page.waitUntilQCSpinnerDisappearsInMezzReportPage();
         }
        Map<String,String> actualQCPASSFileInfo = page.getQCPassFileInfo();
            for(Map<String,String> row : parametrizeTableRows(data)){
                if (row.containsKey("audioCodec")) {
                    assertThat("audioCodec", actualQCPASSFileInfo.get("Audio Codec").trim(), CoreMatchers.is(row.get("audioCodec")));
                }
                if (row.containsKey("filetype")) {
                    assertThat("filetype", actualQCPASSFileInfo.get("File Type").trim(), IsEqual.equalTo(row.get("filetype")));
                }
                if (row.containsKey("fileSize")) {
                    assertThat("fileSize", actualQCPASSFileInfo.get("File Size").trim(), IsEqual.equalTo(row.get("fileSize")));
                }
                if (row.containsKey("videoCodec")) {
                    assertThat("videoCodec", actualQCPASSFileInfo.get("Video Codec").trim(), IsEqual.equalTo(row.get("videoCodec")));
                }
                if (row.containsKey("firstFrameTimeCode")) {
                    assertThat("firstFrameTimeCode", actualQCPASSFileInfo.get("First Frame Time Code").trim(), IsEqual.equalTo(row.get("firstFrameTimeCode")));
                }
                if (row.containsKey("Template")) {
                    assertThat("Template", actualQCPASSFileInfo.get("Template").trim(), IsEqual.equalTo(row.get("Template")));
                }
                if (row.containsKey("length")) {
                    assertThat("length", actualQCPASSFileInfo.get("Length").trim(), IsEqual.equalTo(row.get("length")));
                }
            }}


    @Then("{I |}'$condition' see '$tab' tab enabled")
    public void checkForTabVisibility(String condition,String tab) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getCurrentMCAssetInfoPage().istabVisible(tab), is(shouldState));
    }

    @Then("{I |}'$condition' see '$button' button")
    public void checkForButtonVisibilityCheckerInfo(String condition,String button) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getCurrentMCAssetInfoPage().isButtonVisible(button), is(shouldState));
    }

    @When("{I |}click tab '$tabName'")
    public void clickTab(String tabName) {
       getCurrentMCAssetInfoPage().clickTab(tabName);
       Common.sleep(2000);
    }


    @Then("{I |}'$condition' see '$button' button in Mezz Info tab")
    public void checkForButtonVisibilityMezzInfo(String condition,String button) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getCurrentMediaCheckerMezzInfoPage().isButtonVisible(button), is(shouldState));
        }


    @Then("{I |}'$condition' see '$button' button in Mezz Report tab")
    public void checkForButtonVisibilityMezzReport(String condition,String button) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getCurrentMediaCheckerMezzReportPage().isButtonVisible(button), is(shouldState));
    }

    @When("{I |}'$actionType' the request tile via media checker Mezz Info Page")
    public void clickAction(String actionType) {
        MediaCheckerMezzInfoPage page = getCurrentMediaCheckerMezzInfoPage();
        if (actionType.equalsIgnoreCase("Commit"))
            page.commitRequestTile();
    }

    @Then("{I |}'$condition' see '$button' button in Media Checker Info page")
    public void checkForButtonVisibilityInfoPage(String condition,String button) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getCurrentMCAssetInfoPage().isEditButtonVisible(), is(shouldState));
    }

    @Then("{I |}'$condition' see error message in Mezz Report page: $assetsTable")
    public void checkQCErrorMessage(String condition,ExamplesTable assetsTable) {
        Map<String, String> row = parametrizeTabularRow(assetsTable);
        boolean should = condition.equals("should");
        assertThat("Error message not available", getCurrentMediaCheckerMezzReportPage().checkQCErrorMessage(row.get("QC Error Message")), equalTo(should));
    }

}

