package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.babylon.sut.pages.traffic.element.ApprovePopUp;
import com.adstream.automate.babylon.sut.pages.traffic.element.Comment;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.InvalidSelectorException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;


/**
 * Created by den4ik on 25-Feb-15.
 */
public class TrafficOrderItemPage extends BaseTrafficPage {

    private static final By forceReleaseButtonSelector = By.cssSelector("[title='Force Release Master']");
    private static final By restoreMasterButtonSelector = By.cssSelector("[title='Restore Master']");
    private static final By escalateMasterButtonSelector = By.cssSelector("[title='Master Escalate']");
    private static final By rejectMasterButtonSelector = By.cssSelector("[title='Reject Master']");
    private static final By releaseMasterButtonSelector = By.cssSelector("[title='Master Release']");
    private static final By approveProxyButtonSelector = By.cssSelector("[title='Approve Proxy']");
    private static final By rejectProxyButtonSelector = By.cssSelector("[title='Reject Proxy']");
    private static final By escalateProxyButtonSelector = By.cssSelector("[title='Escalate Proxy']");
    //Once NIR-1057 is fixed change it to correct spelling
    private static final By recallMasterButtonSelector = By.cssSelector("[title='Master Recall']");
    private static final By restoreProxyButtonSelector = By.cssSelector("[title='Restore Proxy']");
    private static final String houseNumberButtonSelector = "*//button[contains(text(),\"%s\")]";
    //  private static final By houseNumberECSButtonSelector = By.cssSelector("[btn-radio=\"'ECS'\"]");
    //  private static final By houseNumberCSButtonSelector = By.cssSelector("[btn-radio=\"'CS'\"]");
    private static final By houseNumberIsNotUniqIconSelector = By.cssSelector("[aria-label='House number must be unique!']");
    private static final By backButtonSelector = By.cssSelector("[ng-click=\"$detailsPageCtrl.goBack()\"]");
    // private static final By editAssetButtonSelector = By.cssSelector("#asset_edit_link"); // Pre Refactoring
    private static final By editAssetButtonSelector = By.cssSelector(".ng-show>.btn.btn-info.btn-md"); // Post Refactoring
    private static final By approveHNSaveButtonSelector = By.cssSelector(".btn-success");
    private static final By editOrderButtonSelector = By.xpath("//button[@title='Edit Order']");
    private static final By editTitlePencilSelector = By.xpath("//editable-field[contains(@schema-definition,'title')]//span[@class='icon-pencil']");
    private static final By editHouseNumberPencilSelector = By.cssSelector("[uib-tooltip='Edit House Number']");
    private static final By editAdvertiserPencilSelector = By.xpath("//span[contains(.,'Advertiser:')]/../following-sibling::*//span[@class='icon-pencil']");
    private static final By editMediaAgencyPencilSelector = By.xpath("//span[contains(.,'Media Agency:')]/../following-sibling::*//span[@class='icon-pencil']");
    private static final By editProductPencilSelector = By.xpath("//span[contains(.,'Product:')]/../following-sibling::*//span[@class='icon-pencil']");
    private static final By fillProductFieldSelector = By.xpath("//span[contains(.,'Product:')]/../following-sibling::*//input[@ng-model='$editableFieldCtrl.editValue']");
    private static final By flowPlayerStatusSelector = By.cssSelector(".flowplayer");
    private static final By fillTitleFieldSelector = By.xpath("//editable-field[contains(@schema-definition,'title')]//input[@ng-model='$editableFieldCtrl.editValue']");
    private static final By houseNumberInputSelector = By.cssSelector("[ng-model='$houseNumberEditDefaultCtrl.editValue']");
    private static final By houseNumberEditIconSelector = By.cssSelector("i[ng-click=\"$houseNumberEditDefaultCtrl.openEditForm()\"]");
    private static final By houseNumberSuffixlocator = By.cssSelector("span[ng-if=\"$houseNumberEditDefaultCtrl.houseNumberSuffix\"]");
    private static final By houseNumberMenaInputSelector = By.cssSelector("[ng-if='$houseNumberEditCustomCodeCtrl.houseNumber']");
    private static final By fillAdvertiserFieldSelector = By.xpath("//span[contains(.,'Advertiser:')]/../following-sibling::*//input[@ng-model='$editableFieldCtrl.editValue']");
    private static final By fillMediaAgencyFieldSelector = By.xpath("//span[contains(.,'Media Agency:')]/../following-sibling::*//input[@ng-model='$editableFieldCtrl.editValue']");
    private static final By saveChangedMetadataSelector = By.xpath("*//button[@type='submit']");
    private static final By deliveryStatusSelector = By.cssSelector(".col-sm-2.text-center>span");
    private static final By deliveryStatusSelector_new = By.xpath("//h4[@class='panel-title']//div[4]");
    private static final By isLoaded = By.cssSelector("[ng-init='init()']");
    private static final By titleSelector = By.cssSelector("[ng-if='!$metadataDisplay.customTitle']");
    private static final By broadcasterApprovalStatusSelector = By.cssSelector("[status='destination.broadcasterStatus'] span:nth-child(2)");
    private static final By delHouseNumberPencilSelector = By.cssSelector("[ng-click='$houseNumberEditCustomCodeCtrl.clearHouseNumber()']");
    private static final By houseNumberWarningMessageSelector = By.cssSelector(".toast-message");
    private static final By resetApprovalStatus = By.cssSelector("[ng-click=\"destination.resetApprovalStatus()\"]");
    //private static final String commonSelector =".//*[@name='%s']//preceding-sibling::span";
    private static final String commonSelector ="//span[contains(.,'%s')]/../following-sibling::*";
    private final static long waitforSupportingDocumentsTraffic = 60 * 3000; //3min
    private static final String destinationRowsSelector = "//*[@ng-repeat=\"destination in $destinationsListCtrl.destinations\"][.//div[contains(@ng-class,\"$destinationsListCtrl.UserModel.isTrafficManager()\")]/*[contains(text(),\"%s\")]]";
    private static final By cellsSelector = By.cssSelector("[class^='col-sm-']");
    private static final By columnTitlesSelector = By.xpath("//div[@class=\"panel-heading row font-14\"]//*[contains(@class,'col-sm-2') or contains(@class,'col-sm-1')]");
    private static final By formatSelector = By.xpath("//div[@ng-switch-when='format']//format-icon/i");
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

    public TrafficOrderItemPage(ExtendedWebDriver web) {
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
    }

    public void isLoaded(){
        web.isElementVisible(isLoaded);
    }

    public void clickForceReleaseButtonOnTrafficOrderItemPage(){
        web.scrollToElement(web.findElement(forceReleaseButtonSelector));
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

    public void clickRestoreProxyButtonOnTrafficOrderItemPage(){
        restoreProxyButton.click();
    }

    public void clickEditAssetButtonOnTrafficOrderItemPage(){
        web.findElement(editAssetButtonSelector).click();
    }

    public void clickEditOrderButtonOnTrafficOrderItemPage(){
        web.findElement(editOrderButtonSelector).click();
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
                web.waitUntilElementDisappear(saveChangedMetadataSelector);
            }
        }

    }

    public String verifyHouseNumberGroupingOnOrderDetailsPage(String getdestination) {
        String getHouseNumber=null;
        Common.sleep(5000);
        //int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']/div[@class='panel-default ng-scope ng-isolate-scope panel']")).size();
        int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']//div[@class='panel-default panel']")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span/div[1]/div[1]")).getText();
            if (destinationList.contains(getdestination.trim())) {
                getHouseNumber=web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + "]//house-number-edit-default//span[contains(@class,\"input-group-addon house-number-view\")]")).getText();
                break;
            }
        }
        return getHouseNumber;
    }

    public String verifyHouseNumberSuffixGroupingOnOrderDetailsPage(String getdestination) {
        String getHouseNumberSuffix=null;
        Common.sleep(5000);
        int destinationCount = web.findElements(By.xpath("//div[@class='panel-group']//div[@class='panel-default panel']")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span/div[1]/div[1]")).getText();
            if (destinationList.contains(getdestination.trim())) {
                getHouseNumberSuffix = web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//span[@ng-if=\"$houseNumberEditDefaultCtrl.houseNumberSuffix\"]")).getText();
                break;
            }
        }
        return getHouseNumberSuffix;
    }

    public void clickResetApprovalStatus(){
        web.findElement(By.cssSelector(".pull-right.glyphicon.glyphicon-chevron-right")).click();
        web.findElement(resetApprovalStatus).click();
        web.findElement(By.cssSelector(".btn.btn-success")).click();

    }


    public boolean verifyStateOfResetApprovalStatus(){

        boolean isExist;
        web.findElement(By.cssSelector(".pull-right.glyphicon.glyphicon-chevron-right")).click();
        try {
            isExist = web.findElement(By.xpath("//div[contains(@uib-tooltip,'Button disabled whilst')]/a[@ng-click='destination.resetApprovalStatus()']")).isDisplayed();
        }
        catch(Exception e)
        {
            isExist=false;
        }
        return isExist;

    }


    public void fillParticularField(By locator, String data){
        web.findElement(locator).clear();
        web.findElement(locator).sendKeys(data);
    }

    public String getBroadcasterApprovalStatus() {
        web.sleep(10000);
        web.scrollToElement(web.findElement(broadcasterApprovalStatusSelector));
        return web.findElement(broadcasterApprovalStatusSelector).getText();
    }

    public String getDeliveryStatus() {
        web.sleep(5000);
        return web.isElementVisible(deliveryStatusSelector)?web.findElement(deliveryStatusSelector).getText()
                                                           :web.findElement(deliveryStatusSelector_new).getText();
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
        Common.sleep(2000);
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
            web.click(houseNumberEditIconSelector);
            WebElement elem=web.findElement(houseNumberInputSelector);
            web.scrollToElement(elem);
            Common.sleep(2000);
            elem.sendKeys(value);
            //web.findElement(By.cssSelector("[name='houseNumberForm']")).click();//strange workaround for HN saving
            //  web.findElement(By.cssSelector(".btn.btn-info.btn-sm.ng-scope")).click();
            // To fix the script failing due to unavailability of the button
            //  web.waitUntilElementAppear(By.xpath("//button[contains(@ng-click,'updateHouseNumber')][contains(.,'Save')]"));
            //  web.findElement(By.xpath("//button[contains(@ng-click,'updateHouseNumber')][contains(.,'Save')]")).click();
            web.findElement(By.xpath("//i[contains(@ng-click,'$houseNumberEditDefaultCtrl.form.$valid && $houseNumberEditDefaultCtrl.updateHouseNumber()')]")).click();


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
            Common.sleep(2000);
            web.click(houseNumberEditIconSelector);
            WebElement elem=web.findElement(houseNumberInputSelector);
            web.scrollToElement(elem);
            Common.sleep(2000);
            elem.sendKeys(value);
            web.findElement(By.xpath("//i[contains(@ng-click,'$houseNumberEditDefaultCtrl.form.$valid && $houseNumberEditDefaultCtrl.updateHouseNumber()')]")).click();

        }
    }


    public String verifyHNForSpecificDestination(String destination)
    {
        String getHouseNumber="";
        int rowCount = web.findElements(By.xpath("//div[@class='panel-group']/div[@ng-repeat='destination in $destinationsListCtrl.destinations']")).size();
        for (int row = 1; row <= rowCount; row++) {
            String getDestination=web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//div[contains(@ng-class,'destinationsListCtrl.UserModel')]")).getText();
            if (getDestination.equalsIgnoreCase(destination))
            {
                getHouseNumber=web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//house-number-edit-default//span[contains(@class,\"input-group-addon house-number-view\")]")).getText();
                break;
            }
        }
        return getHouseNumber;
    }






    public String getHouseNumber(String houseNumber){
        //    Common.sleep(5000);
        if(houseNumber.equalsIgnoreCase("NCS")||houseNumber.equalsIgnoreCase("ECS")||houseNumber.equalsIgnoreCase("CS")){
            return web.findElement(houseNumberMenaInputSelector).getText();
        }else{
            return web.findElement(By.xpath("*//div[contains(@class,'house-number-view-wrapper')]/span")).getText();
        }
    }

    public void fillHNForSpecificDestination(String destination,String houseNumber)
    {
        int rowCount = web.findElements(By.xpath("//div[@class='panel-group']/div[@ng-repeat='destination in $destinationsListCtrl.destinations']")).size();
        for (int row = 1; row <= rowCount; row++) {
            String getDestination=web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//div[contains(@ng-class,'destinationsListCtrl.UserModel')]")).getText();
            if (getDestination.equalsIgnoreCase(destination))
            {
                web.scrollToElement(web.findElement(By.xpath("//div[@class=\"panel-group\"]/div[" + row + "]//house-number-wrapper//i[@ng-click=\"$houseNumberEditDefaultCtrl.openEditForm()\"]")));
                web.click(By.xpath("//div[@class=\"panel-group\"]/div[" + row + "]//house-number-wrapper//i[@ng-click=\"$houseNumberEditDefaultCtrl.openEditForm()\"]"));
                Common.sleep(1000);
                web.findElement(By.xpath("//div[@class=\"panel-group\"]/div[\" + row + \"]//house-number-wrapper//input[@ng-model=\"$houseNumberEditDefaultCtrl.editValue\"]")).click();
                Common.sleep(1000);
                web.findElement(By.xpath("//div[@class=\"panel-group\"]/div[\" + row + \"]//house-number-wrapper//input[@ng-model=\"$houseNumberEditDefaultCtrl.editValue\"]")).clear();
                Common.sleep(1000);
                web.findElement(By.xpath("//div[@class=\"panel-group\"]/div[\" + row + \"]//house-number-wrapper//input[@ng-model=\"$houseNumberEditDefaultCtrl.editValue\"]")).sendKeys(houseNumber);
                Common.sleep(1000);
                //    web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//house-number-wrapper//button[@ng-click='$houseNumberEditDefaultCtrl.updateHouseNumber()']")).click();
                web.findElement(By.xpath("//i[contains(@ng-click,'$houseNumberEditDefaultCtrl.form.$valid && $houseNumberEditDefaultCtrl.updateHouseNumber()')]")).click();
                Common.sleep(3000);
                break;
            }
        }
    }



    public void deleteHNForSpecificDestination(String destination)
    {
        int rowCount = web.findElements(By.xpath("//div[@class='panel-group']/div[@ng-repeat='destination in $destinationsListCtrl.destinations']")).size();
        for (int row = 1; row <= rowCount; row++) {
            String getDestination=web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//div[contains(@ng-class,'destinationsListCtrl.UserModel')]")).getText();
            if (getDestination.equalsIgnoreCase(destination))
            {
                web.scrollToElement(web.findElement(By.xpath("//div[@class=\"panel-group\"]/div[" + row + "]//house-number-wrapper//i[@ng-click=\"$houseNumberEditDefaultCtrl.openEditForm()\"]")));
                web.click(By.xpath("//div[@class=\"panel-group\"]/div[" + row + "]//house-number-wrapper//i[@ng-click=\"$houseNumberEditDefaultCtrl.openEditForm()\"]"));
                //   web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//house-number-wrapper//*[@uib-tooltip=\"Edit House Number\"]")).click();
                web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//i[@ng-click=\"$houseNumberEditDefaultCtrl.clearHouseNumber()\"]")).click();
                 /*    web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//house-number-wrapper//input[@ng-model='$houseNumberEditDefaultCtrl.houseNumber']")).click();
                web.findElement(By.xpath("//div[@class='panel-group']/div[" + row + "]//house-number-wrapper//i[@ng-click='$houseNumberEditDefaultCtrl.clearHouseNumber()']")).click();
            */
                break;

            }
        }
    }




    public boolean isHNUniqueValidationMessage()
    {
        boolean isMessageExist=false;
        try
        {
            isMessageExist=web.findElement(By.xpath("//div[@class='toast toast-error']//div[@aria-label='House number must be unique!']")).isDisplayed();
        }
        catch(Exception e)
        {
            isMessageExist=false;
        }
        return isMessageExist;
    }

    public String getComment(String lastComment){
        List<WebElement> commentWeb= web.findElements(commentsSelector);
        for (WebElement comment : commentWeb){
            if(comment.getText().equalsIgnoreCase(lastComment))
                return comment.getText() ;
        }
        return null;
    }

    public String checkWarningMessage()
    {
        String service="";
        try{
            String warning = web.findElement(By.xpath("//warning-message[@services='$tvOrderItemDetailsCtrl.clock.unauthorizedServices']/div[@class='c-warning-message']/div")).getText();
            int rowCount = web.findElements(By.xpath("//warning-message[@services='$tvOrderItemDetailsCtrl.clock.unauthorizedServices']//li[@class='c-warning-message__service']")).size();
            for (int row = 1; row <= rowCount; row++) {
                String text = web.findElement(By.xpath("//warning-message[@services='$tvOrderItemDetailsCtrl.clock.unauthorizedServices']//li[" + row + "]")).getText();
                service = service + " " + text;
            }
            return warning + service.trim();
        }
        catch(Exception e)
        {
            return "";
        }
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
        return web.findElement(houseNumberIsNotUniqIconSelector).isDisplayed();
    }

    public boolean isHouseNumberEditFieldAvailable(){
        return web.isElementPresent(houseNumberEditIconSelector);
    }

    public boolean isHouseNumberSuffixAvailable(){
        return web.isElementVisible(houseNumberSuffixlocator);
    }

    public String getHouseNumberSuffix(){
        return web.findElement(houseNumberSuffixlocator).getText();
    }

    public boolean isPreviewAvailable(){
        Common.sleep(16000);
        web.navigate().refresh();
        Common.sleep(10000);
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
        private String cloned;
        private String format;


        public TrafficOrderItem(ExtendedWebDriver web) {
            ExtendedWebDriver webDriver = web;
            initOrderItem();
        }

        private void initOrderItem() {
            if (web.isElementPresent(getcommonSelector("Order Reference")))
                setOrderReference(web.findElement(getcommonSelector("Order Reference")).getText());
            if (web.isElementPresent(getcommonSelector("Clock Number")))
                setClockNumber(web.findElement(getcommonSelector("Clock Number")).getText());
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
            if (web.isElementPresent(getcommonSelector("Cloned")))
                setCloned(web.findElement(getcommonSelector("Cloned")).getText());
            if (web.isElementPresent(formatSelector))
                setFormat(web.findElement(formatSelector).getAttribute("uib-tooltip"));
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

        public String getCloned() {
            return cloned;
        }

        public String getFormat() {
            return format;
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

        public void setCloned(String cloned) {
            this.cloned = cloned;
        }

        public void setFormat(String format) {
            this.format = format;
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

    public String verifyClkNumberDisplayedASFirstItem() {

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
                web.findElement(By.xpath("//div[@class='panel-group']/div[" + destination + " ]//div[contains(@class,'pull-right')]/i")).click();
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


    public String getLocalMetadata(String key) {
        String columnHeader = "";
        String actualText = "";
        int rowCount = web.findElements(By.xpath("//div[@class='row small metadata-display-container']/div[@ng-switch='definition.name']")).size();
        for (int row = 1; row <= rowCount; row++) {
            columnHeader = web.findElement(By.xpath("//div[@class='row small metadata-display-container']/div[@ng-switch='definition.name'][" + row + "]/div[1]/span")).getText();
            if (columnHeader.contains(key)) {
                actualText = columnHeader;
                break;
            }
        }
        return actualText;
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


    public class DeliveryItem {
        private ExtendedWebDriver web;
        private WebElement currentNode;
        private WebElement tableRow;

        public String getBroadcastApprovalStatus() {
            return broadcastApprovalStatus;
        }

        private String broadcastApprovalStatus;
        private String destinationName;
        private String serviceLevel;
        private String deliveryStatus;

        public String getArrivalDate() {
            return arrivalDate;
        }

        private String arrivalDate;

        public String getDeliveryDate() {
            return deliveryDate;
        }

        private String deliveryDate;

        public String getHouseNumber() {
            return houseNumber;
        }

        private String houseNumber;


        public List<WebElement> getColumnTitles() {
            return web.findElements(columnTitlesSelector);
        }

        private List<WebElement> columnTitles;

        public ExtendedWebDriver getWeb() {
            return web;
        }


        public String getDestinationName() {
            return destinationName;
        }


        public String getDeliveryStatus() {
            return deliveryStatus;
        }

        public String getServiceLevel() {
            return serviceLevel;
        }

        public WebElement getTableRow() {
            return tableRow;
        }


        public DeliveryItem(WebElement destRow, ExtendedWebDriver driver) {
            this.web = driver;
            List<WebElement> cells = destRow.findElements(cellsSelector);
            if (cells.size() == 0) {
                throw new InvalidSelectorException("Selector " + cellsSelector + " is absent");
            }
            initDestinationFields(cells);
        }


        public List getColumnTitlesNames() {
            List<WebElement> list = getColumnTitles();
            List<String> columnTitles = new ArrayList<String>();
            if (list == null || list.size() == 0) return columnTitles;
            for (WebElement webElement : list) {
                columnTitles.add(webElement.getText().trim());
            }
            return columnTitles;
        }

        private void initDestinationFields(List<WebElement> cells) {
            List<String> list = getColumnTitlesNames();
            web.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS);
            for (int i = 0; i < list.size(); i++) {
                String cellValue = cells.get(i).getText();
                switch (list.get(i)) {
                    case "Broadcaster Approval Status":
                        broadcastApprovalStatus = cellValue;
                        break;
                    case "Name":
                        destinationName = cellValue;
                        break;
                    case "House Number":
                        houseNumber = cells.get(i).findElement(By.xpath("*//div[contains(@class,'house-number-view-wrapper')]/span")).getText();
                        break;
                    case "Service Level":
                        serviceLevel = cellValue;
                        break;
                    case "Delivery Status":
                        deliveryStatus = cellValue;
                        break;
                    case "Arrival Date":
                        arrivalDate = cellValue;
                        break;
                    case "Delivery Date":
                        deliveryDate = cellValue;
                        break;
                }

            }
            web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        }
    }


    public DeliveryItem getDeliveryItemByReference(String clockNumber, String destinationName) {
        if (!web.isElementPresent(By.xpath(String.format(destinationRowsSelector,destinationName)))) return null;
        WebElement row = web.findElement(By.xpath(String.format(destinationRowsSelector,destinationName)));
        Common.sleep(3000);
        DeliveryItem delivery = new DeliveryItem(row.findElement(By.xpath("div")), web);
        return delivery;
    }


    public boolean verifyPresenceOfApproveProxyButton(){
        return web.findElement(By.cssSelector("[ng-click=\"$approvalButtonsCtrl.openModal(transition)\"]")).isEnabled();
    }

}
