package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderItemPage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderItemsListPage;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import com.sun.jna.*;
import org.apache.tools.ant.taskdefs.condition.Equals;
import org.hamcrest.Matchers;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.core.Is.is;
import org.openqa.selenium.TimeoutException;

/**
 * Created by denysb on 09/03/2016.
 */
public class TrafficOrderItemDetailsPageSteps extends TrafficHelperSteps {

    private String houseNumber_mena = null;
    private final static long previewAvailable = 60 * 2000; //2min

    public TrafficOrderItemPage getTrafficOrderItemPage() {
        return getSut().getPageCreator().getTrafficOrderItemPage();
    }

    @Given("{I |}clicked on '$button' button on order item details page in traffic")
    @When("{I |}click on '$button' button on order item details page in traffic")
    public void clickOnForceReleaseButton(String button) {
        Common.sleep(4000);
        GenericSteps.refreshPageWithoutDelay(); // Scenarios fail very random due to unavilability of buttons on the page. They do appear but at times a page refreshed is required.
        Common.sleep(2000);
        switch (button) {
            case "Force Release Master":
                getTrafficOrderItemPage().clickForceReleaseButtonOnTrafficOrderItemPage();
                break;
            case "Approve Proxy":
                getTrafficOrderItemPage().clickProxyApproveButtonOnTrafficOrderItemPage();
                break;
            case "Reject Proxy":
                getTrafficOrderItemPage().clickRejectProxyButtonOnTrafficOrderItemPage();
                break;
            case "Restore Proxy":
                getTrafficOrderItemPage().clickRestoreProxyButtonOnTrafficOrderItemPage();
                break;
            case "Escalate Proxy":
                getTrafficOrderItemPage().clickEscalateProxyButtonOnTrafficOrderItemPage();
                break;
            case "Release Master":
                getTrafficOrderItemPage().clickReleaseMasterButtonOnTrafficOrderItemPage();
                break;
            case "Reject Master":
                getTrafficOrderItemPage().clickRejectMasterButtonOnTrafficOrderItemPage();
                break;
            case "Escalate Master":
                getTrafficOrderItemPage().clickEscalateMasterButtonOnTrafficOrderItemPage();
                break;
            case "Restore Master":
                getTrafficOrderItemPage().clickRestoreMasterButtonOnTrafficOrderItemPage();
                break;
            case "Back":
                getTrafficOrderItemPage().clickBackButtonButtonOnTrafficOrderItemPage();
                break;
            case "Edit Asset":
                getTrafficOrderItemPage().clickEditAssetButtonOnTrafficOrderItemPage();
                break;
            case "Edit Order":
                getTrafficOrderItemPage().clickEditOrderButtonOnTrafficOrderItemPage();
                break;
        }
    }

    //|Title|Product|Advertiser|Media Agency|
    @When("{I |}fill the following fields on order item traffic page:$data")
    public void fillApprovalDataForOrderItem(ExamplesTable data) {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            for (Map.Entry<String, String> map : row.entrySet()) {
                page.fillMetadata(map.getKey(), wrapVariableWithTestSession(map.getValue()));
            }
        }
    }

    @Given("{I |}waited till order item page will be loaded in Traffic")
    @When("{I |}wait till order item page will be loaded in Traffic")
    public void waitTillOrderListWillBeLoaded(){
        getTrafficOrderItemPage().waitUntilPageWillBeLoaded(2000);
    }

    @When("{I |}{edit|fill} house number field with value '$houseNumber' on order details page in traffic")
    public void fillHouseNumber(String houseNumber) {
        if (houseNumber.equalsIgnoreCase("NCS") || houseNumber.equalsIgnoreCase("ECS") || houseNumber.equalsIgnoreCase("CS")) {
            getTrafficOrderItemPage().enterHouseNumber(houseNumber);
        } else {
            getTrafficOrderItemPage().enterHouseNumber(wrapVariableWithTestSession(houseNumber));
        }
        if(this.houseNumber_mena==null)
            this.houseNumber_mena=getTrafficOrderItemPage().getHouseNumber(houseNumber);
    }

    @When("{I |}{edit|fill} house number field with value '$houseNumber' on order details page in traffic without delay")
    public void fillHouseNumberwithoutDelay(String houseNumber) {
        if (houseNumber.equalsIgnoreCase("NCS") || houseNumber.equalsIgnoreCase("ECS") || houseNumber.equalsIgnoreCase("CS")) {
            getTrafficOrderItemPage().enterHouseNumberwithoutdelay(houseNumber);
        } else {
            getTrafficOrderItemPage().enterHouseNumberwithoutdelay(wrapVariableWithTestSession(houseNumber));
        }
        if(this.houseNumber_mena==null)
            this.houseNumber_mena=getTrafficOrderItemPage().getHouseNumber(houseNumber);

    }

    @Given("{I |}verify house number is not set in order item details page for Mena Market in traffic")
    @When("{I |}verify house number is not set in order item details page for Mena Market in traffic")
    public void resetHouseNumberForMenaMarket(){
        if(this.houseNumber_mena!=null)
            this.houseNumber_mena=null;
    }

    @When("{I |}click on comment icon for '$destination'")
    public void clickCommentIcon(String destination)
    {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        page.clickCommentIcon(destination);
    }

    @Then("{I |}should not see an option to comment at clock level")
    public void verifyCommentIcon()
    {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        assertThat(false, is(page.verifyPresenceOfCommentButton()));
    }

    @Then("{I |}'$condition' see '$status' Broadcaster Approval Status on on order item details page in traffic")
    public void checkBroadcasterApprovalStatusOnOrderItemPage(String condition, String status) {
        String actualStatus = getTrafficOrderItemPage().getBroadcasterApprovalStatus();
        assertThat(actualStatus, is(status));
    }

    @When("{I |}click on Recall Master on order item details page in traffic")
    public void clickRecallMaster()
    {
        getTrafficOrderItemPage().clickRecallMasterButtonOnTrafficOrderItemPage();
    }

    @When("{I |}reset Approval Status for '$clock' clock on traffic order details page")
    public void resetApprovalStatusParticularClock(String clock){
        getTrafficOrderItemPage().clickResetApprovalStatus();
    }

    @Then("{I |}'$condition' see reset approval button disabled on order item details page in traffic")
    public void verifyStateOfResetApprovalButton(String condition) {
        boolean actualState = getTrafficOrderItemPage().verifyStateOfResetApprovalStatus();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(actualState, shouldState ? is(true) : is(false));


    }

    @Then("{I |}'$condition' see '$status' Delivery Status on on order item details page in traffic")
    public void checkDeliveryStatusOnOrderItemPage(String condition, String status) {
        String actualStatus = getTrafficOrderItemPage().getDeliveryStatus();
        assertThat(actualStatus, is(status));
    }

    @Then("{I |}should see '$status' delivery status in a4 for order with clocknumber '$clocknumber'")
    public void checkDeliveryStatusinA4(String status, String clockNumber) {
        String orderReference = getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getOrderReference().toString();
        getCoreApi().getOrderItemDeliveryStatusfromA4(orderReference);
    }



    //Buttons: |Force Release Master|Approve Proxy|Reject Proxy|Restore Proxy|Escalate Proxy|Release Master|Reject Master|Escalate Master|Restore Master|Edit Metadata|
    @Then("{I |}'$condition' see '$button' button on order item details page in traffic")
    public void checkThatButtonIsVisibleOnOrderItemDetailsInTraffic(String condition, String button) {
        boolean isButtonVisible = false;
        try{
            isButtonVisible= getTrafficOrderItemPage().isApprovalButtonVisible(button);
        }
        catch(Exception e){
            isButtonVisible=false;
        }
        Boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(shouldState, is(isButtonVisible));
    }

    @When("I click comment button for destination '$destination' in order item details page")
    @Given("I click comment button for destination '$destination' in order item details page")
    public void clickCommentButton(String destination){
        getTrafficOrderItemPage().clickCommentButton(destination);
    }


    @When("{I |}delete house number field for the following destination:$fields")
    public void deleteHNForSpecificDestination(ExamplesTable fields)
    {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            getTrafficOrderItemPage().deleteHNForSpecificDestination(row.get("Destination"));
            Common.sleep(3000);
        }
    }

    @Then("{I |}see the house number for the following destination:$fields")
    public void verifyHNForSpecificDestination(ExamplesTable fields)
    {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            String text = getTrafficOrderItemPage().verifyHNForSpecificDestination(row.get("Destination"));
            if(row.get("House Number").isEmpty()){
                assertThat("Verify House Number", getTrafficOrderItemPage().verifyHNForSpecificDestination(row.get("Destination")), equalTo((row.get("House Number"))));}
            else {
                assertThat("Verify House Number", getTrafficOrderItemPage().verifyHNForSpecificDestination(row.get("Destination")), equalTo(wrapVariableWithTestSession(row.get("House Number"))));}
        }
    }



    @Then("{I |}'$condition' see the house number unique validation message on order details page")
    public void verifyHNUniqueValidationMessage(String condition)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean isExist = getTrafficOrderItemPage().isHNUniqueValidationMessage();
        assertThat(shouldState, is(isExist));
    }

    @When("{I |}{edit|fill} house number field for the following destination:$fields")
    public void fillHNForSpecificDestination(ExamplesTable fields)
    {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            getTrafficOrderItemPage().fillHNForSpecificDestination(row.get("Destination"), wrapVariableWithTestSession(row.get("House Number")));
        }
    }






    //Buttons: |Force Release Master|Approve Proxy|Reject Proxy|Restore Proxy|Escalate Proxy|Release Master|Reject Master|Escalate Master|Restore Master|Edit Metadata|
    @Then("{I |}'$condition' see '$button' button disabled on order item details page in traffic")
    public void checkThatButtonStatusOnOrderItemDetailsInTraffic(String condition, String button) {
        boolean buttonStatus = getTrafficOrderItemPage().checkButtonStatus();
        Boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(buttonStatus, is(shouldState));
    }

    @Then("{I |}'$should' see playable preview on order item details page in traffic")
    public void checkVideoPlayablePreview(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getTrafficOrderItemPage().isPreviewAvailable();
        assertThat("Playable preview is not available", shouldState == actualState);
    }

    @Then("{I |}'$should' see playable preview available for download on order item details page in traffic")
    public void checkProxyDownload(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getTrafficOrderItemPage().isProxyAvailableForDownload();
        assertThat("Playable preview is not available", shouldState == actualState);
    }

    @Then("{I |}'$should' see orderItem status as '$orderItemStatus' in order item details page in Traffic")
    public void checkordserItemStatus(String condition,String orderItemStatus) {
        String actualStatus = getTrafficOrderItemPage().getOrderItemStatus();
        assertThat("Order item status did not match",orderItemStatus.equalsIgnoreCase(actualStatus.trim()),is(condition.equals("should"))) ;
    }


    @Then("{I |}'$should' see house number '$houseNumber' on order details page in traffic")
    public void getHouseNumber(String should,String houseNumber) {
        String actualHN = getTrafficOrderItemPage().getHouseNumber(houseNumber);
        String expectedHN = "";
        if (houseNumber.equalsIgnoreCase("NCS") || houseNumber.equalsIgnoreCase("ECS") || houseNumber.equalsIgnoreCase("CS")) {
            expectedHN = houseNumber;
            assertThat("Incorrect House Number value", actualHN.startsWith(expectedHN + "-00"), is(should.equals("should")));
        } else {
            expectedHN = wrapVariableWithTestSession(houseNumber);
            assertThat("Incorrect House Number value", actualHN.equals(expectedHN), is(should.equals("should")));
        }
    }

    @Then("{I |}'$should' see house number '$houseNumber' on order details page in traffic for Clock '$ClockNumber' for destination '$destinationName'")
    public void getHouseNumberBasedUponDestination(String should,String houseNumber,String ClockNumber,String destinationName) {
        TrafficOrderItemPage trafficOrderItemPage = getSut().getPageCreator().getTrafficOrderItemPage();
        TrafficOrderItemPage.DeliveryItem deliveryItem = trafficOrderItemPage.getDeliveryItemByReference(wrapVariableWithTestSession(ClockNumber),destinationName);
        String actualHN = deliveryItem.getHouseNumber();
        String expectedHN = "";
        if (houseNumber.equalsIgnoreCase("NCS") || houseNumber.equalsIgnoreCase("ECS") || houseNumber.equalsIgnoreCase("CS")) {
            expectedHN = houseNumber;
            assertThat("Incorrect House Number value", actualHN.startsWith(expectedHN + "-00"), is(should.equals("should")));
        } else {
            expectedHN = wrapVariableWithTestSession(houseNumber);
            assertThat("Incorrect House Number value", actualHN.equals(expectedHN), is(should.equals("should")));
        }
    }

    @Then("{I |}should see icon that house number is not uniq on order details page in traffic")
    public void isHouseNumberUniq() {
        boolean actualResult = getTrafficOrderItemPage().isHouseNumberUniq();
        assertThat("House Number is Uniq",actualResult==true);
    }

    @Then("{I |}'$should' see edit house number field on order details page in traffic")
    public void isHouseNumberUniq(String should) {
        boolean actualResult = getTrafficOrderItemPage().isHouseNumberEditFieldAvailable();
        boolean condition = should.equals("should");
        assertThat("House Number edit field is present",condition==actualResult);
    }

    @When("{I |}'$should' see house number suffix '$suffix' on order details page in traffic")
    @Then("{I |}'$should' see house number suffix '$suffix' on order details page in traffic")
    public void getHouseNumberSuffix(String condition, String expectedHNsuffix){
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState =  getTrafficOrderItemPage().isHouseNumberSuffixAvailable();
        assertThat(actualState, is(expectedState));
        if(expectedState) {
            String actualHNSuffix = getTrafficOrderItemPage().getHouseNumberSuffix();
            assertThat("Incorrect House Number Suffix ", actualHNSuffix.equals(expectedHNsuffix));
        }

    }


    @Then("{I |}should see house number grouped on order details page in traffic:$groupHouseNumber")
    public void verifyHouseNumberGroupingOnOrederDetailsPage(ExamplesTable groupHouseNumber)
    {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        for (int i = 0; i < groupHouseNumber.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(groupHouseNumber, i);
            if(row.get("House Number").isEmpty())
            {
                Common.sleep(3000);
                String actualHouseNumber=page.verifyHouseNumberGroupingOnOrderDetailsPage(row.get("Destination"));
                assertThat("Check House Number Grouping", "", equalTo(actualHouseNumber));
            }
            String actualHouseNumber = page.verifyHouseNumberGroupingOnOrderDetailsPage(row.get("Destination"));
            assertThat("Check House Number Grouping", actualHouseNumber, equalTo(wrapVariableWithTestSession(row.get("House Number"))));
        }
    }

    @Then("{I |}should see house number suffixed on order details page in traffic:$groupHouseNumber")
    public void verifyHouseNumberSuffixOnOrederDetailsPage(ExamplesTable groupHouseNumber)
    {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        for (int i = 0; i < groupHouseNumber.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(groupHouseNumber, i);
            if(row.get("House Number Suffix")!=null && !row.get("House Number Suffix").isEmpty()){
                if(page.isHouseNumberSuffixAvailable()) {
                    String actualHouseNumberSuffix = page.verifyHouseNumberSuffixGroupingOnOrderDetailsPage(row.get("Destination"));
                    assertThat("Check House Number Suffix not available", actualHouseNumberSuffix, equalTo(row.get("House Number Suffix")));
                }
            }else{
                assertThat("Check House Number Suffix available", getTrafficOrderItemPage().isHouseNumberSuffixAvailable(), is(false));

            }

        }
    }

    @Then("{I |}should not see house number grouped on order details page in traffic:$groupHouseNumber")
    public void verifyHouseNumberGroupingNotExist(ExamplesTable groupHouseNumber)
    {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        for (int i = 0; i < groupHouseNumber.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(groupHouseNumber, i);
            String actualHouseNumber=page.verifyHouseNumberGroupingNotExist(row.get("Destination"));
            if(row.get("House Number").equals("N/A")){
                assertThat("Check House Number is not Grouped", "N/A", equalTo(actualHouseNumber));
            }
        }
    }

    //Order reference, Clock Number, Advertiser, Product, First Air Date
    @Then("{I |}should see following metadata on order details page in traffic:$data")
    public void validateMetadataOnOrderDetailsPageInTraffic(ExamplesTable table) {
        TrafficOrderItemPage.TrafficOrderItem orderItem = getTrafficOrderItemPage().getOrderItem();

        for (int i = 0; i < table.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(table, i);
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Order Reference":
                        String orderReference = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(row.get("Clock Number"))).getOrderReference().toString();
                        assertThat("Order Reference", orderItem.getOrderReference(), equalTo(orderReference));
                        break;
                    case "Clock Number":
                        row.put("Clock Number", wrapVariableWithTestSession(row.get("Clock Number")));
                        assertThat("Clock Number", orderItem.getClockNumber(), equalTo(row.get("Clock Number")));
                        break;
                    case "Advertiser":
                        row.put("Advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
                        assertThat("Advertiser", orderItem.getAdvertiser(), equalTo(row.get("Advertiser")));
                        break;
                    case "Product":
                        row.put("Product", wrapVariableWithTestSession(row.get("Product")));
                        assertThat("Product", orderItem.getProduct(), equalTo(row.get("Product")));
                        break;
                    case "First Air Date":
                        assertThat("First Air Date", orderItem.getFirstAirDate(), equalTo(row.get("First Air Date")));
                        break;
                    case "Title":
                        row.put("Title", wrapVariableWithTestSession(row.get("Title")));
                        assertThat("Title", orderItem.getTitle(), equalTo(row.get("Title")));
                        break;
                    case "Order Item Status":
                        assertThat("Order Item Status", orderItem.getOrderItemStatus(), equalTo(row.get("Order Item Status")));
                        break;
                    case "Cloned":
                        assertThat("Cloned", orderItem.getCloned(), equalTo(row.get("Cloned")));
                        break;
                    case "Format":
                        assertThat("Format", orderItem.getFormat(), equalTo(row.get("Format")));
                        break;
                    default :
                        throw new NullPointerException("No Field with name '"+rowEntry.getKey()+"' on Traffic Order Item Details Page");
                }
            }

            /*if (row.containsKey("Clock Number")) {
                row.put("Clock Number", wrapVariableWithTestSession(row.get("Clock Number")));
                assertThat("Clock Number", orderItem.getClockNumber(), equalTo(row.get("Clock Number")));
            }
            if (row.containsKey("Order Reference")) {
                String orderReference = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(row.get("Clock Number"))).getOrderReference().toString();
                assertThat("Order Reference", orderItem.getOrderReference(), equalTo(orderReference));
            }
            if (row.containsKey("Advertiser")) {
                row.put("Advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
                assertThat("Advertiser", orderItem.getAdvertiser(), equalTo(row.get("Advertiser")));
            }
            if (row.containsKey("Product")) {
                row.put("Product", wrapVariableWithTestSession(row.get("Product")));
                assertThat("Product", orderItem.getProduct(), equalTo(row.get("Product")));
            }
            if (row.containsKey("First Air Date")) {
                assertThat("First Air Date", orderItem.getFirstAirDate(), equalTo(row.get("First Air Date")));
            }
            if (row.containsKey("Title")) {
                row.put("Title", wrapVariableWithTestSession(row.get("Title")));
                assertThat("Title", orderItem.getTitle(), equalTo(row.get("Title")));
            }*/
        }
    }

    @Given("{I |}select existing house number for the destination on order details page:$groupHouseNumber")
    public void addExistingHouseNumber(ExamplesTable groupHouseNumber)
    {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        for (int i = 0; i < groupHouseNumber.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(groupHouseNumber, i);
            page.addExistingHouseNumber(row.get("Destination"), row.get("House Number"));
        }
    }

    @Given("{I |}delete house number field on order details page")
    @When("{I |}delete house number field on order details page")
    public void deleteHouseNumber() {
        getTrafficOrderItemPage().deleteHouseNumber();
    }

    @Then("{I |} should see House Number restored after ReEditing of '$houseNumber'")
    public void restoreHouseNumber_onDeletion(String houseNumber) {
        assertThat("House Number value restore historic value",this.houseNumber_mena, equalToIgnoringCase(getTrafficOrderItemPage().getHouseNumber(houseNumber)));
        this.houseNumber_mena=null;
    }

    @Then("{I |} should see House Number restored is sequential of '$houseNumber'")
    public void isHouseNumber_Sequential(String houseNumber) {
        String prevHouseNumber[] ;
        String currentHouseNumber[] ;
        prevHouseNumber = this.houseNumber_mena.split("-");
        currentHouseNumber = getTrafficOrderItemPage().getHouseNumber(houseNumber).split("-");
        assertThat("House Number value restored is sequential value", Integer.parseInt(prevHouseNumber[1]) + 1, equalTo(Integer.parseInt(currentHouseNumber[1])));
    }

    @Then("I should see comment '$lastComment' in order item details page")
    public void checkComment(String lastComment){
        assertThat("Last Comment not updated in order item details page",lastComment.equalsIgnoreCase(getTrafficOrderItemPage().getComment(lastComment)));
    }

    @Then("{I |}'$condition' see warning message '$message' for clockNumber '$clockNumber' on traffic order item details page")
    public void checkWarningMessage(String condition, String message,String clockNumber ) {
        String actualMessage = getTrafficOrderItemPage().checkWarningMessage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(actualMessage, condition.equalsIgnoreCase("should") ? containsString(message.trim()) : not(containsString(message.trim())));


    }

    @Then("{I |}'$should' see a warning message '$message' for house number")
    public void checkMessage(String condition,String expectedMessage){
        Common.sleep(1000);
        boolean shouldState= condition.equalsIgnoreCase("should");
        String actual =getTrafficOrderItemPage().getHouseNumberWarningMessage();
        assertThat("Check warning message for house number: ",actual.contains(expectedMessage)?shouldState:!shouldState);
    }


    @Then("{I |}should see the following fields on order item traffic page:$data")
    public void verifyDataForOrderItem(ExamplesTable data) {
        TrafficOrderItemPage page = getTrafficOrderItemPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.containsKey("Title")) {
                row.put("Title", wrapVariableWithTestSession(row.get("Title")));
                assertThat("Title", page.getTitle(), equalTo(row.get("Title")));
            }
            if (row.containsKey("Advertiser")) {
                row.put("Advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
                assertThat("Advertiser", page.getAdvertiser(), equalTo(row.get("Advertiser")));
            }
            if (row.containsKey("Product")) {
                row.put("Product", wrapVariableWithTestSession(row.get("Product")));
                assertThat("Product", page.getProduct(), equalTo(row.get("Product")));
            }
            if (row.containsKey("Media Agency")) {
                row.put("Media Agency", wrapVariableWithTestSession(row.get("Media Agency")));
                assertThat("Media Agency", page.getAgency(), equalTo(row.get("Media Agency")));
            }
        }
    }
    @Then("{I |}should see order item with following headers:$data")
    public void getHeaderDetails(ExamplesTable data){
        Map<String, String> row = parametrizeTabularRow(data);
        if (row.containsKey("Advertiser"))
            assertThat("Advertiser", getTrafficOrderItemPage().getLocalMetadata(row.get("Advertiser")), equalTo(row.get("Advertiser").concat(":")));
        if (row.containsKey("Product"))
            assertThat("Product", getTrafficOrderItemPage().getLocalMetadata(row.get("Product")), equalTo(row.get("Product").concat(":")));
        if (row.containsKey("Agency"))
            assertThat("Agency", getTrafficOrderItemPage().getLocalMetadata(row.get("Agency")), equalTo(row.get("Agency").concat(":")));
        if (row.containsKey("Media Agency"))
            assertThat("Media Agency", getTrafficOrderItemPage().getLocalMetadata(row.get("Media Agency")), equalTo(row.get("Media Agency").concat(":")));
        if (row.containsKey("Additional Details"))
            assertThat("Additional Details", getTrafficOrderItemPage().getHeaders("Additional Details"), equalTo(row.get("Additional Details")));
        if (row.containsKey("Technical Specifications"))
            assertThat("Technical Specifications", getTrafficOrderItemPage().getHeaders("Technical Specifications"), equalTo(row.get("Technical Specifications")));
        if (row.containsKey("Supporting Documents"))
            assertThat("Supporting Documents", getTrafficOrderItemPage().getHeaders("Supporting Documents"), equalTo(row.get("Supporting Documents")));

    }

    @Then("{I |}'$condition' see button Approve Proxy enabled")
    public void verifyButtonDisabbled(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actual = getTrafficOrderItemPage().verifyPresenceOfApproveProxyButton();
        assertThat("Approve Proxy button should be disabled", actual ? shouldState : !shouldState);    }
}