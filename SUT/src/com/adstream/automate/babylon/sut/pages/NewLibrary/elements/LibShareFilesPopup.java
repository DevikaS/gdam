package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Janaki.Kamat on 24/04/2017.
 */
public class LibShareFilesPopup extends LibPopUpWindow {
    // locators for User Dropdown , Proxy Download and Original Download
    private static final By sharingUser = By.cssSelector("md-autocomplete-wrap [ng-model=\"$mdAutocompleteCtrl.scope.searchText\"]");
    private static final String dateNeverExpLocator = "ads-md-datepicker ads-md-input[on-click-icon=\"$ctrl.openCalendar()\"] input";
    private static final String allowProxyDownloadLocator = "ads-md-checkbox[on-click=\"$ctrl.toggleShareProxy()\"] md-checkbox";
    private static final String allowOriginalDownloadLocator = "ads-md-checkbox[on-click=\"$ctrl.toggleShareMaster()\"] md-checkbox";

    // Controls for proxy Download, Original Download and User dropdown
    private Edit sharingUserControl;
    private MdCheckbox proxyDownloadCheckbox;
    private MdCheckbox originalDownloadCheckbox;
    private static final By md_switch = By.xpath("//md-switch[contains(@class,\"md-checked\")]");
    //action
    private static final String secureShareButtonLocator = "ads-md-button[click=\"$ctrl.secureShare()\"] button";
    private static final String publicLinKLocator = "//span[.='PUBLIC LINK']";
    private static final String publicLinKAccessLocator = "//span[contains(.,'PUBLIC LINK ACCESS')]";
    // Message Locators
    private static final String messageLocator = "[model=\"$ctrl.personalMessage\"] textarea[placeholder='Add a message']"; // textArea
    private static final String addAMessageLocator = "ads-ui-secure-share ads-md-button[click=\"$ctrl.isMessageFieldVisible = !$ctrl.isMessageFieldVisible\"] button.md-button";
    private static final By textMsg = By.cssSelector("[class^=\"ads-md-textarea-input\"]");
    private static final String publicAddMessageLocator = "ads-md-button[click=\"$ctrl.setMessageFieldState(true)\"]"; // Add a message for Public Link

    public List<WebElement> getAllTabLinksNames() {
        return web.findElements(By.cssSelector("md-tab-item"));
    }

    public LibShareFilesPopup selectTab(String tabName) {
        if (web.isElementVisible(By.xpath(String.format("//md-tab-item[.//span[text() = '%s']]", tabName)))) {
            Common.sleep(1000);
            web.findElement(By.xpath(String.format("//md-tab-item[.//span[text() = '%s']]", tabName))).click();
            return openPopup(tabName);
        }
        else if(web.isElementVisible(By.cssSelector(".ads-md-dialog-title [translate=\"SHARE_MULTIPLE_TITLE\"]")))
            return openPopup(tabName);
        else
          throw new IllegalArgumentException(tabName + "does not exist");
     }

    public boolean isTabVisible(String tabName){
        return web.isElementVisible(By.xpath(String.format("//md-tab-item[.//span[text() = '%s']]", tabName)));
    }

    public LibShareFilesPopup openPopup(final String tabName) {
        By saveButtonLocator=null;
        switch (tabName) {
            case "SHARE":
            case "SECURE SHARE (0)":
                saveButtonLocator = generateLocator(secureShareButtonLocator);
                parentElement = parentElement + " " + "ads-ui-secure-share";
                break;
            case "PUBLIC LINK":
                saveButtonLocator = generateLocator(publicLinKLocator);
                parentElement = parentElement + " " + "div[ng-if=\"$ctrl.isSelectedTabEqualTo($ctrl.tabIndexes.PublicShare)\"]";
                break;
            case "PUBLIC LINK ACCESS (0)":
                parentElement = parentElement + " " + "div[ng-if=\"$ctrl.isSelectedTabEqualTo($ctrl.tabIndexes.PublicShareList)\"]";
                break;

        }
        return new LibShareFilesPopup(parentPage,parentElement,saveButtonLocator);

    }

    public boolean isPublicLinkTabPresent() {
        return web.isElementVisible(By.xpath(publicLinKLocator));
    }

    public boolean isPublicLinkAccessTabPresent() {
        return web.isElementVisible(By.xpath(publicLinKAccessLocator));
    }

   /* public void typeUserEmails(String email) {
        String comboBoxValueFormat = "//li/*//*[contains(@class,\"md-contact-email ng-binding\")]";
        web.typeClean(sharingUser,email);
        List<WebElement> el=web.findElements(By.xpath(comboBoxValueFormat));
        for(WebElement web:el){
            if(web.getText().contains("Add new contact")) {
                web.click();
                return;
            }
        }
    }*/

    public void typeUserEmails(String email) {
        String comboBoxValueFormat = "//div[@class='md-contact-suggestion']/span[@class='md-contact-name']/span";
        web.typeClean(sharingUser,email);
        Common.sleep(2000);
        web.clickThroughJavascript(By.xpath(comboBoxValueFormat));
    }

    public void setExpirationDate(String attValue) {
       // web.getJavascriptExecutor().executeScript("arguments[0].setAttribute(arguments[1], arguments[2]);",
                //web.findElement(generateLocator(dateNeverExpLocator)), "value", attValue);
        web.findElement(By.xpath("//ads-md-datepicker//ads-md-input[@placeholder='Never expire']//input")).clear();
        web.findElement(By.xpath("//ads-md-datepicker//ads-md-input[@placeholder='Never expire']//input")).sendKeys(attValue+ Keys.ENTER);
    }

    public String getPublicLinkFieldValue() {
        return new Edit(parentPage, By.xpath(".//md-input-container/input[@id='link']")).getValue();
    }

    public void activatePublicLink() {
        if (!web.isElementVisible(md_switch))
            web.click(By.xpath("//md-switch[not(contains(@class,\"md-checked\"))]"));
    }

    public void clickSave()
    {
        WebElement ele = web.findElement(By.xpath("//ads-md-button[@click='$ctrl.notifyLink()']/button"));
        web.scrollToElement(ele);
        web.findElement(By.xpath("//ads-md-button[@click='$ctrl.notifyLink()']/button")).click();

    }

    public void deactivatePublicLink() {
        if (web.isElementVisible(md_switch))
            web.click(By.xpath("//md-switch[contains(@class,\"md-checked\")]"));
    }

    public LibShareFilesPopup(Page parentPage) {
        super(parentPage, "ads-ui-share");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public LibShareFilesPopup(Page parentPage,String parentElement,By saveButtonLocator) {
        super(parentPage, parentElement);
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
        action=new Button(parentPage,saveButtonLocator);
    }

    private void addMessageShareSecure(String message) {
        if (!web.isElementVisible(generateLocator(messageLocator)))
            web.findElement(generateLocator(addAMessageLocator)).click();
        web.typeClean(generateLocator(messageLocator), message);
    }

    private void addMessagePulicShare(String message) {
        if (web.isElementVisible(generateLocator(publicAddMessageLocator + ":not(.ng-hide)")))
            web.findElement(generateLocator(publicAddMessageLocator + " " + "button")).click();
        web.typeClean(generateLocator(messageLocator), message);
    }


    public void typeMessage(String message, boolean secure) {
        if (message != null) {
            if (secure)
                addMessageShareSecure(message);
            else
                addMessagePulicShare(message);
        }
        Common.sleep(2000);
    }


    public WebElement getDateExpiresLocator(String value) {
        return web.findElement(generateLocator(String.format(dateNeverExpLocator, value)));
    }

    public void checkAllDownloadProxyCheckbox() {
        proxyDownloadCheckbox = new MdCheckbox(parentPage, generateLocator(allowProxyDownloadLocator));
        proxyDownloadCheckbox.selectBylocator();
    }

    public void uncheckAllDownloadProxyCheckbox() {
        proxyDownloadCheckbox = new MdCheckbox(parentPage, generateLocator(allowProxyDownloadLocator));
        proxyDownloadCheckbox.deSelectByLocator();
    }


    public void checkDownloadOriginalCheckbox() {
        originalDownloadCheckbox = new MdCheckbox(parentPage, generateLocator(allowOriginalDownloadLocator));
        originalDownloadCheckbox.selectBylocator();
    }

    public void uncheckDownloadOriginalCheckbox() {
        originalDownloadCheckbox = new MdCheckbox(parentPage, generateLocator(allowOriginalDownloadLocator));
        originalDownloadCheckbox.deSelectByLocator();
    }


    public List<Map<String, String>> getUsersList() {
        List<Map<String, String>> fields = new ArrayList<Map<String, String>>();
        for (String userName : web.findElementsToStrings(generateLocator("[ng-repeat=\"row in $ctrl.rows\"] [class=\"ng-binding ng-scope email\"]\""))) {
            Map<String, String> field = new HashMap<String, String>();
            field.put("UserName", userName);
            field.put("DownloadMaster", "");
            field.put("DownloadProxy", "");
            fields.add(field);
        }

        return fields;
    }

    public void selectAssetToDownload(Map<String, String> fields) {
        List<WebElement> assetList = web.findElements(generateLocator("[class=\"download-list-item ng-scope layout-align-space-between-center layout-row flex\"]"));
        for (WebElement elem : assetList) {
            {
                if (elem.findElement(By.cssSelector("[class=\"download-list-item-name flex-50\"]")).getText().contains(fields.get("AssetName"))) {
                    WebElement asset = elem.findElement(By.cssSelector("[class=\"download-list-item-name flex-50\"]"));
                    if (Boolean.parseBoolean(fields.get("AssetDownloadProxy"))) {
                        new MdCheckbox(parentPage, asset.findElement(By.xpath("following-sibling::div//*[@on-click=\"wrapper.__allowProxy = !wrapper.__allowProxy\"]/md-checkbox"))).selectByElement();
                    }
                    if (Boolean.parseBoolean(fields.get("AssetDownloadOriginal"))) {
                        new MdCheckbox(parentPage, asset.findElement(By.xpath("following-sibling::div//*[@on-click=\"wrapper.__allowMaster = !wrapper.__allowMaster\"]/md-checkbox"))).selectByElement();
                    }
                }
            }
        }
    }


    public List<Map<String, String>> getPublicShareUserList() {
        HashMap map = new HashMap<String, String>();
        List<Map<String, String>> userList = new ArrayList<Map<String, String>>();
        for (String user : web.findElementsToStrings(By.cssSelector("[ng-repeat=\"column in $ctrl.columns\"][ng-class=\"column.key\"][class$=\"email\"]"))) {
            map.put("UserName", user);
            userList.add(map);
        }
        return userList;
    }

    public List<Map<String, String>> getSecurehareUserList() {
        HashMap map = new HashMap<String, String>();
        List<Map<String, String>> userList = new ArrayList<Map<String, String>>();
        for (String user : web.findElementsToStrings(By.xpath("//div[@ng-hide='!$ctrl.isSecureShareListLoaded']//div[@class='ads-truncate']"))) {
            map.put("UserName", user);
            userList.add(map);
        }
        return userList;
    }


    public String getShareTabLabel(){
        return web.findElements(generateLocator("md-tab-item .ng-binding.ng-scope")).get(0).getText();
    }

    public String getSecureShareTabLabel(){
        return web.findElements(generateLocator("md-tab-item .ng-binding.ng-scope")).get(1).getText();
    }

    public String getPublicLinkLabel(){
        return web.findElements(generateLocator("md-tab-item .ng-binding.ng-scope")).get(2).getText();
    }

    public String getPublicLinkAccessLabel(){
        return web.findElements(generateLocator("md-tab-item .ng-binding.ng-scope")).get(3).getText();
    }

    public String getSharingOptionsLabel(){
        return web.findElements(generateLocator("ads-ui-secure-share .content-title")).get(0).getText();
    }

    public String getDownloadOptionsLabel(){
        return web.findElements(generateLocator("ads-ui-secure-share .content-title")).get(1).getText();
    }

    public String getAddMessageLabel(){
        return web.findElement(generateLocator(addAMessageLocator)).findElement(By.cssSelector("span[class=\"valign-middle ng-scope\"]")).getText();
    }

    public String getDownloadProxyLabel(){
        return web.findElement(generateLocator(allowProxyDownloadLocator)).getText();
    }

    public String getDownloadMasterLabel(){
        return web.findElement(generateLocator(allowOriginalDownloadLocator)).getText();
    }

    public String dateNeverExpriresLabel(){
        return web.findElement(generateLocator(dateNeverExpLocator)).getAttribute("placeholder");
    }
}
