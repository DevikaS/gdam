package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.babylon.sut.pages.traffic.element.ApprovePopUp;
import com.adstream.automate.babylon.sut.pages.traffic.element.Comment;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;


/**
 * Created by den4ik on 25-Feb-15.
 */
public class TrafficClockDetailsPage extends BaseTrafficPage {

    private static final By forceReleaseButtonSelector = By.cssSelector("[title='Force Release Master']");
    private static final By restoreMasterButtonSelector = By.cssSelector("[title='Restore Master']");
    private static final By escalateMasterButtonSelector = By.cssSelector("[title='Master Escalate']");
    private static final By rejectMasterButtonSelector = By.cssSelector("[title='Reject Master']");
    private static final By releaseMasterButtonSelector = By.cssSelector("[title='Master Release']");
    private static final By approveProxyButtonSelector = By.cssSelector("[title='Approve Proxy']");
    private static final By rejectProxyButtonSelector = By.cssSelector("[title='Reject Proxy']");
    private static final By escalateProxyButtonSelector = By.cssSelector("[title='Escalate Proxy']");
    private static final By recallMasterButtonSelector = By.cssSelector("[title='Master Recall']");
    private static final By restoreProxyButtonSelector = By.cssSelector("[title='Restore Proxy']");
    private static final String houseNumberButtonSelector = "*//button[contains(text(),\"%s\")]";
  //  private static final By houseNumberECSButtonSelector = By.cssSelector("[btn-radio=\"'ECS'\"]");
  //  private static final By houseNumberCSButtonSelector = By.cssSelector("[btn-radio=\"'CS'\"]");
    private static final By houseNumberIsNotUniqIconSelector = By.cssSelector("[uib-tooltip='House number must be unique!']");
    private static final By backButtonSelector = By.cssSelector("[ng-click=\"$detailsPageCtrl.goBack()\"]");
   // private static final By editAssetButtonSelector = By.cssSelector("#asset_edit_link"); // Pre Refactoring
    private static final By editAssetButtonSelector = By.cssSelector(".ng-show>.btn.btn-info.btn-md"); // Post Refactoring
    private static final By approveHNSaveButtonSelector = By.cssSelector(".btn-success");
    private static final By rightCarouselSelector = By.xpath("//span[@class='glyphicon glyphicon-chevron-right']");
    private static final By editTitlePencilSelector = By.xpath("//editable-field[contains(@schema-definition,'title')]//span[@class='icon-pencil']");
    private static final By editHouseNumberPencilSelector = By.cssSelector("[uib-tooltip='Edit House Number']");
    private static final By editAdvertiserPencilSelector = By.xpath("//span[contains(.,'Advertiser:')]/../following-sibling::*//span[@class='icon-pencil']");
    private static final By editMediaAgencyPencilSelector = By.xpath("//span[contains(.,'Media Agency:')]/../following-sibling::*//span[@class='icon-pencil']");
    private static final By editProductPencilSelector = By.xpath("//span[contains(.,'Product:')]/../following-sibling::*//span[@class='icon-pencil']");
    private static final By fillProductFieldSelector = By.xpath("//span[contains(.,'Product:')]/../following-sibling::*//input[@ng-model='editValue']");
    private static final By flowPlayerStatusSelector = By.cssSelector(".flowplayer");
    private static final By fillTitleFieldSelector = By.xpath("//editable-field[contains(@schema-definition,'title')]//input[@ng-model='editValue']");
    private static final By houseNumberInputSelector = By.cssSelector("[ng-model='$houseNumberEditDefaultCtrl.houseNumber']");
    private static final By houseNumberMenaInputSelector = By.cssSelector("[ng-if='$houseNumberEditCustomCodeCtrl.houseNumber']");
    private static final By fillAdvertiserFieldSelector = By.xpath("//span[contains(.,'Advertiser:')]/../following-sibling::*//input[@ng-model='editValue']");
    private static final By fillMediaAgencyFieldSelector = By.xpath("//span[contains(.,'Media Agency:')]/../following-sibling::*//input[@ng-model='editValue']");
    private static final By saveChangedMetadataSelector = By.xpath("//a[contains(@ng-click,'saveMetadata')]");
    private static final By deliveryStatusSelector = By.cssSelector(".col-sm-2.text-center>span");
    private static final By isLoaded = By.cssSelector("[ng-init='init()']");
    private static final By titleSelector = By.cssSelector("[ng-if='!$metadataDisplay.customTitle']");
    private static final By broadcasterApprovalStatusSelector = By.cssSelector("[status='destination.broadcasterStatus'] span:nth-child(2)");
    private static final By delHouseNumberPencilSelector = By.cssSelector("[ng-click='$houseNumberEditCustomCodeCtrl.clearHouseNumber()']");
    private static final By houseNumberWarningMessageSelector = By.cssSelector(".toast-message");
    private static final By resetApprovalStatus = By.cssSelector("[ng-click=\"resetApprovalStatus(destinationData._id)\"]");
    //private static final String commonSelector =".//*[@name='%s']//preceding-sibling::span";
    private static final String commonSelector ="//div[contains(@class,'active')]//span[contains(.,'%s')]/../following-sibling::*/editable-field";
    private final static long waitforSupportingDocumentsTraffic = 60 * 3000; //3min
    private Button forceReleaseButton;
    private Button rejectMasterButton;
    private Button escalateMasterButton;
    private Button restoreMasterButton;
    private Button releaseMasterButton;
    private Button rejectProxyButton;
    private Button approveProxyButton;
    private Button escalateProxyButton;
    private Button restoreProxyButton;
    private Button recallMasterButton;
    private Button rightCarousel;
    private String title;
    private String advertiser;
    private String product;
    private String agency;


    public String getTitle() {
        //return web.findElement(By.xpath(String.format(commonSelector,"title"))).getText();
        return web.findElement(By.cssSelector("[ng-if=\"!$metadataDisplay.customTitle\"] span")).getText();
    }

    public void setTitle(String title) {
        clickEdit(editTitlePencilSelector);
        fillParticularField(fillTitleFieldSelector, title);
        clickSaveMetadataButton();
     }

    public String getAdvertiser() {
        return web.findElement(By.xpath(String.format(commonSelector,"Advertiser"))).getText();
    }

    public String getClockNumber() {
        return web.findElement(By.xpath("//div[contains(@class,'active')]//div[@class='row small metadata-display-container']/div[1]/div[2]/span")).getText();
    }
    public String getAdditionalDetails() {
       // System.out.println("-----------------------"+web.findElement(By.xpath("//additional-details//p")).getText());
        return web.findElement(By.xpath("//div[contains(@class,'active')]//additional-details//p")).getText();
    }

    public boolean verifyCommonButtons(String button) {

        boolean isExist;
        try {
            switch (button) {
                case "Force Release Master":
                    isExist = web.findElement(forceReleaseButtonSelector).isDisplayed();
                    break;
                case "Approve Proxy":
                    isExist = web.findElement(approveProxyButtonSelector).isDisplayed();
                    break;
                case "Escalate Proxy":
                    isExist=web.findElement(escalateProxyButtonSelector).isDisplayed();
                    break;
                case "Reject Proxy":
                    isExist=web.findElement(rejectProxyButtonSelector).isDisplayed();
                    break;
                default:
                    throw new IllegalArgumentException("Unknown button name given");
            }
        }
        catch(Exception e)
        {
            isExist=false;
        }
        return isExist;
    }


    public void setAdvertiser(String advertiser) {
        clickEdit(editAdvertiserPencilSelector);
        fillParticularField(fillAdvertiserFieldSelector, advertiser);
        clickSaveMetadataButton();
    }

    public String getProduct() {
        return web.findElement(By.xpath(String.format(commonSelector,"Product"))).getText();
    }


    public void setProduct(String product) {
        clickEdit(editProductPencilSelector);
        fillParticularField(fillProductFieldSelector, product);
        clickSaveMetadataButton();
    }

    public String getAgency() {
        return web.findElement(By.xpath(String.format(commonSelector,"Media Agency"))).getText();
    }

    public void setAgency(String agency) {
        clickEdit(editMediaAgencyPencilSelector);
        fillParticularField(fillMediaAgencyFieldSelector, agency);
        clickSaveMetadataButton();
    }

    public TrafficClockDetailsPage(ExtendedWebDriver web) {
        super(web);
        forceReleaseButton = new Button(this, forceReleaseButtonSelector);
        rejectMasterButton = new Button(this,rejectMasterButtonSelector);
        escalateMasterButton = new Button(this, escalateMasterButtonSelector);
        restoreMasterButton = new Button(this, restoreMasterButtonSelector);
        releaseMasterButton = new Button(this, releaseMasterButtonSelector);
        rejectProxyButton = new Button(this, rejectProxyButtonSelector);
        approveProxyButton = new Button(this, approveProxyButtonSelector);
        escalateProxyButton = new Button(this, escalateProxyButtonSelector);
        restoreProxyButton = new Button(this, restoreProxyButtonSelector);
        recallMasterButton = new Button(this, recallMasterButtonSelector);
        rightCarousel = new Button(this, rightCarouselSelector);
    }

    public void isLoaded(){
        web.isElementVisible(isLoaded);
    }

    public void clickForceReleaseButtonOnTrafficOrderItemPage(){
        forceReleaseButton.click();
    }

    public void clickRejectMasterButtonOnTrafficOrderItemPage(){
        rejectMasterButton.click();
    }

    public void clickEscalateMasterButtonOnTrafficOrderItemPage(){
        escalateMasterButton.click();
    }

    public void clickRestoreMasterButtonOnTrafficOrderItemPage(){
        restoreMasterButton.click();
    }

    public void clickRecallMasterButtonOnTrafficOrderItemPage(){
        recallMasterButton.click();
    }

    public void clickReleaseMasterButtonOnTrafficOrderItemPage(){
        releaseMasterButton.click();
    }

    public void clickRejectProxyButtonOnTrafficOrderItemPage(){
        rejectProxyButton.click();
    }

    public void clickProxyApproveButtonOnTrafficOrderItemPage(){
        approveProxyButton.click();
    }

    public void clickEscalateProxyButtonOnTrafficOrderItemPage(){
        escalateProxyButton.click();
    }

    public void clickRightCarousel(){
        rightCarousel.click();
    }

    public void clickRestoreProxyButtonOnTrafficOrderItemPage(){
        restoreProxyButton.click();
    }


    public void clickEditAssetButtonOnTrafficOrderItemPage(){
        web.findElement(editAssetButtonSelector).click();
    }

    public void clickBackButtonButtonOnTrafficOrderItemPage(){
        web.findElement(backButtonSelector).click();
    }

    public void clickEdit(By selector){
        web.findElement(selector).click();
    }

    public void clickSaveMetadataButton(){
        List<WebElement> list = web.findElements(saveChangedMetadataSelector);
        for (WebElement element : list) {
            if(element.isDisplayed()){
                element.click();
            }
        }

    }


    public List<String> verifySupportDocs() {
        List<String> actualSupportDocs = new ArrayList<>();
        int cnt = web.findElements(By.xpath("//supporting-docs//table/tbody/tr[@ng-repeat='doc in $supportingDocsCtrl.documents']")).size();
        for (int docs = 1; docs <= cnt; docs++) {
            String actualDocs = web.findElement(By.xpath("//supporting-docs//table/tbody/tr[" + docs + "]/td[1]")).getText();
            actualSupportDocs.add(actualDocs.trim());
        }
        return actualSupportDocs;
    }

   /* public String verifyClockMetaData(String key)
    {
        key=key+":";
        String getFieldValue="";
        int rowCount= web.findElements(By.xpath("//div[@class='row small metadata-display-container']/div[@ng-switch='definition.name']")).size();
        List <String> columnTitles = new ArrayList<String>();
        for(int row = 1; row <= rowCount; row++) {
            String title = web.findElement(By.xpath("//div[@class='row small metadata-display-container']/div[" + row + "]/div[1]/span")).getText();
            columnTitles.add(title.trim());
        }

            for (int i = 0; i < columnTitles.size(); i++) {
                if (key.equalsIgnoreCase(columnTitles.get(i))) {
                    switch (columnTitles.get(i)) {
                        case "Advertiser:":
                            getFieldValue = cells;
                            break;

                        default:
                            throw new IllegalArgumentException("Unknown field type given");
                    }
                    break;
                }
                System.out.println("--------------break");



        }
        return getFieldValue;
    }
*/



    public String verifyHouseNumberGroupingOnOrderDetailsPage(String getdestination) {
        String getHouseNumber=null;
        Common.sleep(5000);
        //int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']/div[@class='panel-default ng-scope ng-isolate-scope panel']")).size();
        int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']//div[@class='panel-default panel']")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span/div[1]/div[1]")).getText();
            if (destinationList.contains(getdestination.trim())) {
                getHouseNumber = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//input")).getAttribute("value");
                break;
            }
        }
        return getHouseNumber;
    }

    public void clickResetApprovalStatus(){
        web.findElement(By.cssSelector(".pull-right.glyphicon.glyphicon-chevron-right")).click();
        web.findElement(resetApprovalStatus).click();
        web.findElement(By.cssSelector(".btn.btn-success")).click();

    }

    public void fillParticularField(By locator, String data){
        web.findElement(locator).clear();
        web.findElement(locator).sendKeys(data);
    }

    public String getBroadcasterApprovalStatus() {
        web.sleep(10000);
        return web.findElement(broadcasterApprovalStatusSelector).getText();
    }

    public String getDeliveryStatus() {
        web.sleep(5000);
        return web.findElement(deliveryStatusSelector).getText();
    }

    public void addExistingHouseNumber(String getdestination,String houseNumber) {
        Common.sleep(3000);
        //int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']/div[@class='panel panel-default']")).size();
        int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']//div[@class='panel-default panel']")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span/div[1]/div[1]")).getText();
            if (destinationList.contains(getdestination.trim())) {
                web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//form//a")).click();
                web.findElement(By.xpath(String.format("//Button[contains(text(),'%s')]",houseNumber))).click();
                break;
            }
        }
    }


    public String verifyHouseNumberGroupingNotExist(String getdestination) {
        String getHouseNumber=null;

        Common.sleep(3000);
       // int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']/div[@class='panel-default ng-scope ng-isolate-scope panel']")).size();
        int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']//div[@class='panel-default panel']")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span/div[1]/div[1]")).getText();
            if (destinationList.contains(getdestination.trim())) {
                getHouseNumber = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//form//span/span[1]")).getText();
                break;
            }
        }
        return getHouseNumber;
    }

    public void enterHouseNumber(String value) {
        if (value.equalsIgnoreCase("NCS")) {
            web.findElement(editHouseNumberPencilSelector).click();
            web.findElement(By.xpath(String.format(houseNumberButtonSelector,"NCS"))).click();
        }else if (value.equalsIgnoreCase("ECS")) {
            web.findElement(editHouseNumberPencilSelector).click();
            web.findElement(By.xpath(String.format(houseNumberButtonSelector,"ECS"))).click();
        }else if (value.equalsIgnoreCase("CS")){
            web.findElement(editHouseNumberPencilSelector).click();
            web.findElement(By.xpath(String.format(houseNumberButtonSelector,"CS"))).click();
        }else {
            web.findElement(houseNumberInputSelector).sendKeys(value);
            //web.findElement(By.cssSelector("[name='houseNumberForm']")).click();//strange workaround for HN saving
          //  web.findElement(By.cssSelector(".btn.btn-info.btn-sm.ng-scope")).click();
            web.findElement(By.xpath("//button[contains(@ng-click,'updateHouseNumber')][contains(.,'Save')]")).click();

        }
        web.sleep(4000);
    }



    public void enterHouseNumberwithoutdelay(String value) {
        if (value.equalsIgnoreCase("NCS")) {
            web.findElement(editHouseNumberPencilSelector).click();
            web.findElement(By.xpath(String.format(houseNumberButtonSelector,"NCS"))).click();
        }else if (value.equalsIgnoreCase("ECS")) {
            web.findElement(editHouseNumberPencilSelector).click();
            web.findElement(By.xpath(String.format(houseNumberButtonSelector,"ECS"))).click();
        }else if (value.equalsIgnoreCase("CS")){
            web.findElement(editHouseNumberPencilSelector).click();
            web.findElement(By.xpath(String.format(houseNumberButtonSelector,"CS"))).click();
        }else {
            web.findElement(houseNumberInputSelector).sendKeys(value);
            web.findElement(By.xpath("//button[contains(@ng-click,'updateHouseNumber')][contains(.,'Save')]")).click();

        }
    }
    public String getHouseNumber(String houseNumber){
    //    Common.sleep(5000);
        if(houseNumber.equalsIgnoreCase("NCS")||houseNumber.equalsIgnoreCase("ECS")||houseNumber.equalsIgnoreCase("CS")){
            return web.findElement(houseNumberMenaInputSelector).getText();
        }else{
            return web.findElement(houseNumberInputSelector).getAttribute("value");
        }
    }

    public String getComment(String lastComment){
        List<WebElement> commentWeb= web.findElements(commentsSelector);
        for(WebElement comment : commentWeb){
           if(comment.getText().equalsIgnoreCase(lastComment))
                return comment.getText() ;
        }
        return null;
    }

    public void fillMetadata(String key,String value){
        switch(key){
            case "Title":
                setTitle(value);
                break;
            case "Advertiser":
                setAdvertiser(value);
                break;
            case "Product":
                setProduct(value);
                break;
            case "Media Agency":
                setAgency(value);
                break;
        }

    }

    public boolean isApprovalButtonVisible(String button){
        switch(button){
            case "Force Release Master":
                return web.isElementVisible(forceReleaseButtonSelector);
            case "Approve Proxy":
                return web.isElementVisible(approveProxyButtonSelector);
            case "Reject Proxy":
                return web.isElementVisible(rejectProxyButtonSelector);
            case "Restore Proxy":
                return web.isElementVisible(restoreProxyButtonSelector);
            case "Escalate Proxy":
                return web.isElementVisible(escalateProxyButtonSelector);
            case "Release Master":
                return web.isElementVisible(releaseMasterButtonSelector);
            case "Reject Master":
                return web.isElementVisible(rejectMasterButtonSelector);
            case "Escalate Master":
                return web.isElementVisible(escalateMasterButtonSelector);
            case "Restore Master":
                return web.isElementVisible(restoreMasterButtonSelector);
            case "Edit Title":
                return web.isElementVisible(editTitlePencilSelector);
            case "Edit Metadata":
                boolean editAdvertiserelementVisible = web.isElementVisible(editAdvertiserPencilSelector);
                boolean editProductElementVisible = web.isElementVisible(editProductPencilSelector);
                boolean editMediaAgencyElementVisible = web.isElementVisible(editMediaAgencyPencilSelector);
                return editAdvertiserelementVisible && editProductElementVisible
                        && editMediaAgencyElementVisible;

            default:
                throw new RuntimeException("Button " + button + " not suitable in this case ");
        }

    }

    public void clickCommentButton(String destination){
        List<WebElement> dest= web.findElements(By.cssSelector("[ng-repeat*='destination in $destinationsListCtrl.destinations']"));
        for(WebElement wb:dest){
            if(wb.findElement(By.cssSelector(".col-sm-3 > strong")).getText().equals(destination))
                wb.findElement(By.cssSelector(".glyphicon.glyphicon-comment")).click();
        }
    }

    public ApprovePopUp getApprovePopUpPage(){
        return new ApprovePopUp(this);
    }

    public boolean isHouseNumberUniq(){
        return !web.findElement(houseNumberIsNotUniqIconSelector).isDisplayed();
    }

    public boolean isHouseNumberEditFieldAvailable(){
        return web.isElementPresent(houseNumberInputSelector);
    }

    public boolean isPreviewAvailable(){
        Common.sleep(12000);
        return web.isElementVisible(By.cssSelector(".is-ready.is-paused"));
    }

    public boolean isProxyAvailableForDownload(){
     //   return web.isElementVisible(By.xpath(".//*[@id='video-controls']/fieldset/a/span")); // Pre refactoring
        return web.isElementVisible(By.cssSelector(".glyphicon.font-18.icon-Download")); // Post refactoring
    }

    public String getOrderItemStatus(){
        return web.findElement(getcommonSelector("Order Item Status")).getText();
    }

    public TrafficOrderItem getOrderItem(){
        return new TrafficOrderItem(web);
    }

    public class  TrafficOrderItem {

        private String orderReference;
        private String clockNumber;
        private String advertiser;
        private String product;
        private String firstAirDate;
        private String title;
        private String orderItemStatus;


        public TrafficOrderItem(ExtendedWebDriver web) {
            ExtendedWebDriver webDriver = web;
            initOrderItem();
        }

        private void initOrderItem() {
            if (web.isElementPresent(getcommonSelector("Order Reference")))
                setOrderReference(web.findElement(getcommonSelector("Order Reference")).getText());
            if (web.isElementPresent(getcommonSelector("Clock #")))
                setClockNumber(web.findElement(getcommonSelector("Clock #")).getText());
            if (web.isElementPresent(getcommonSelector("Advertiser")))
                setAdvertiser(web.findElement(getcommonSelector("Advertiser")).getText());
            if (web.isElementPresent(getcommonSelector("Product")))
                setProduct(web.findElement(getcommonSelector("Product")).getText());
            if (web.isElementPresent(getcommonSelector("First Air Date")))
                setFirstAirDate(web.findElement(getcommonSelector("First Air Date")).getText());
            if (web.isElementPresent(titleSelector))
                title = web.findElement(titleSelector).getText();
             if (web.isElementPresent(getcommonSelector("Order Item Status")))
                setOrderItemStatus(web.findElement(getcommonSelector("Order Item Status")).getText());
        }

        public String getOrderItemStatus() {
            return orderItemStatus;
        }

        public void setOrderItemStatus(String orderItemStatus) {
            this.orderItemStatus = orderItemStatus;
        }

        public String getOrderReference() {
            return orderReference;
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getProduct() {
            return product;
        }

        public String getFirstAirDate() {
            return firstAirDate;
        }

        public String getTitle() {
            return title;
        }
        public void setOrderReference(String orderReference) {
            this.orderReference = orderReference;
        }

        public void setClockNumber(String clockNumber) {
            this.clockNumber = clockNumber;
        }

        public void setAdvertiser(String advertiser) {
            this.advertiser = advertiser;
        }

        public void setProduct(String product) {
            this.product = product;
        }

        public void setFirstAirDate(String firstAirDate) {
            this.firstAirDate = firstAirDate;
        }
    }
        public void deleteHouseNumber() {
            web.findElement(editHouseNumberPencilSelector).click();
            web.findElement(delHouseNumberPencilSelector).click();
        }

    public boolean checkButtonStatus(){
        return web.isElementVisible(By.xpath(".//button[@disabled=\"disabled\"]"));
    }

    public String getHouseNumberWarningMessage(){
        return web.findElement(houseNumberWarningMessageSelector).getText();
    }

    public void checkInputBox()
    {
       // web.findElement(By.xpath("//thead[@type='destination']//input")).click();
        web.findElement(By.xpath("//input[contains(@ng-click,'selectAllCtrl')]")).click();
    }

    public String verifyClkNumberDisplayedASFirstItem()
    {

        String clkNumber = web.findElement(By.xpath("//tbody[1]//td[@name-row='clockNumber']//span")).getText();
        return clkNumber;

    }

    public Comment clickAddCommentOnOrderItemDetailsPage()

    {
       // List<WebElement> comment = getDriver().findElements(By.xpath("//button[@id='add_comment']"));
        List<WebElement> comment = getDriver().findElements(By.xpath("//button[contains(.,'Add Comment')]"));
        for (WebElement we : comment) {
            if (we.getText().equalsIgnoreCase("Add Comment")) {
                we.click();
            }
        }
        return new Comment(this);
    }

    public void clickCommentIcon(String getdestination) {

        Common.sleep(3000);
        int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']//div[@class='panel-default panel']")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span/div[1]/div[1]")).getText();
            if (destinationList.contains(getdestination.trim())) {
                web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span/div[1]/div[7]/span/i")).click();
                break;
            }
        }

    }

    public boolean verifyPresenceOfCommentButton()
    {
        boolean isExist=true;
        try
        {
            isExist=web.findElement(By.xpath("//button[@id='add_comment']")).isDisplayed();
        }
        catch(Exception e)
        {
            isExist=false;
        }
        return isExist;
    }

    public String getHeaders(String key){
        String value=null;
        By locator= By.xpath("//div[@class='row small metadata-display-container']/div/div[1]");
        List<WebElement> list=web.findElements(locator);
        switch(key){
            case "Advertiser" :
                value=list.get(1).getText();
                break;
            case "Product"  :
                value=list.get(2).getText();
                break;
            case "Agency"  :
                value=list.get(3).getText();
                break;
            case "Language"  :
                value=list.get(6).getText();
                break;
            case "Media Agency"  :
                value=list.get(5).getText();
                break;
            case "Additional Details" :
                value=web.findElement(By.xpath("//additional-details/common-header/h4")).getText();
                break;
            case "Supporting Documents" :
                value=web.findElement(By.xpath("//supporting-docs/div/div/common-header/h4")).getText();
                break;
            case "Technical Specifications" :
                value=web.findElement(By.xpath("//technical-spec/div/div/common-header/h4")).getText();
                break;
        }
        return value;
    }

   public By getcommonSelector(String fieldName){
        return By.xpath("//div[contains(@class,'detail-item')]/span[contains(text(),'"+fieldName+":')]/../following-sibling::div");
    }

   public boolean getSupportingDocument(String fileName)    {
        boolean fileavailable = false;
        waitForSupportingDocumentinTraffic(fileName);
        List<String> SupportingDocument = new ArrayList<String>();
        List<WebElement> SuppDocs = web.findElements(SuppDocSelector);
        for (WebElement SuppDoc : SuppDocs) {
            SupportingDocument.add(SuppDoc.getText()); }
        for (String doc : SupportingDocument) {
            if (doc.contains(fileName)) {
                fileavailable = doc.contains(fileName);
                break;           }
        }
        return fileavailable;
    }

    protected void waitForSupportingDocumentinTraffic(String fileName)    {
        long start = System.currentTimeMillis();
        do {
            List<WebElement> SuppliedDocs = web.findElements(SuppDocSelector);
            for (WebElement SuppliedDoc : SuppliedDocs)
            {  if (SuppliedDoc.getText().contains(fileName))
                return;
            }
            Common.sleep(waitforSupportingDocumentsTraffic/4);
            web.navigate().refresh();
        }while(System.currentTimeMillis() - start < waitforSupportingDocumentsTraffic);
    }


    public String getSupportingDocumentdownloadUrl(String fileName){
        List<String> downloadUrls = new ArrayList<String>();
        String SuppDocDownloadUrl = "";
        try {
            List<WebElement> SuppDocsDownloadUrls = web.findElements(By.cssSelector(".table-cell>a"));
            for (WebElement downloadUrl : SuppDocsDownloadUrls) {
                downloadUrls.add(downloadUrl.getAttribute("href"));
            }
            for (String downloadUrl : downloadUrls) {
                if (downloadUrl.contains(fileName)) {
                    SuppDocDownloadUrl = downloadUrl;
                }
            }
        }
        catch (NoSuchElementException e){
            e.printStackTrace();
        }
        return SuppDocDownloadUrl ;
    }



}
