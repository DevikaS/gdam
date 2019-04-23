package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.*;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: lynda-k
 * Date: 16.12.13
 * Time: 12:00
 */
public class ShareFilesPopup extends PopUpWindow {
    public ShareFilesPopup(Page parentPage) {
        super(parentPage);
    }

    public List<Map<String, String>> getUsersList() {
        List<Map<String,String>> fields = new ArrayList<Map<String, String>>();

        for (String userName : web.findElementsToStrings(generateLocator(".users_list [title]"), "title")) {
            String baseLocator = String.format("//*[contains(@class,'users_list')]//*[contains(@class,'row')][.//*[@title='%s']]", userName);
            Map<String,String> field = new HashMap<String,String>();
            field.put("UserName", userName);
            field.put("DownloadMaster", Boolean.toString(web.isElementPresent(By.xpath(String.format("%s/*[2]//input[@checked]", baseLocator)))));
            field.put("DownloadProxy", Boolean.toString(web.isElementPresent(By.xpath(String.format("%s/*[3]//input[@checked]", baseLocator)))));
            fields.add(field);
        }

        return fields;
    }

    public String getPublicLinkFieldValue() {
        return new DojoEdit(parentPage, generateLocator("[widgetid*='ValidationTextBox']")).getDisplayedValue();
    }

    public boolean isPublicShareTabPresent() {
        return web.isElementPresent(generateLocator(".publicShareTab")) && web.isElementVisible(generateLocator(".publicShareTab"));
    }

    public boolean isPublicLinkAccessTabPresent() {
        return web.isElementPresent(generateLocator(".publicLinkAccessTab")) && web.isElementVisible(generateLocator(".publicLinkAccessTab"));
    }

    public ShareFilesPopup selectStareTab() {
        return selectTab(".addUserTab");
    }

    public ShareFilesPopup selectSecureSharesTab() {
        return selectTab(".sharedUsersTab");
    }

    public ShareFilesPopup selectPublicShareTab() {
        return selectTab(".publicShareTab");
    }

    public void removeUserFromShare(String userDetails){
        web.click(By.xpath("//*[contains(@class, 'users_item')][div/span[text()='" + userDetails + "']]//a"));
        web.switchTo().alert().accept();
    }

    public void setExpirationDate(String date) {
        By locator = generateLocator("[widgetid*='DateTextBox']");
        new DojoCombo(parentPage, locator).selectByVisibleText(date);
    }

    public void typeMessage(String message) {
        if (message != null) web.typeClean(generateLocator("[name='message']"), message);
    }

    public void typeUserEmails(String email) {
        new Edit(parentPage, generateLocator("[id*='shared'][role='textbox']")).typeWithInterval(email, 100);
        web.sleep(500);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", email)));
    }

    public ShareFilesPopup activatePublicLink() {
        Common.sleep(2000);
        By locator = generateLocator(".activateBtn.secondary");
        if (web.isElementPresent(locator))
        {
            web.click(locator);
        }
        return this;
    }

    public ShareFilesPopup deactivatePublicLink() {
        By locator = generateLocator(".activateBtn:not(.secondary)");
        if (web.isElementPresent(locator)) web.click(locator);
        return this;
    }

    public void checkNeverExpiresCheckbox() {
        getNeverExpiresCheckbox().select();
    }

    public void uncheckNeverExpiresCheckbox() {
        getNeverExpiresCheckbox().deselect();
    }

    public void checkNeverPublicExpiresCheckbox() {
        getNeverPublicExpiresCheckbox().select();
    }

    public void uncheckNeverPublicExpiresCheckbox() {
        getNeverPublicExpiresCheckbox().deselect();
    }

    public void checkDownloadProxyCheckbox() {
        getDownloadProxyCheckbox().select();
    }


    public boolean isDownloadProxyCheckboxVisible() {
        return getDownloadProxyCheckbox().isVisible();
    }

    public boolean isDownloadOriginalCheckboxVisible() {
        return getDownloadOriginalCheckbox().isVisible();
    }

    public void uncheckDownloadProxyCheckbox() {
        getDownloadProxyCheckbox().deselect();
    }

    public void checkDownloadOriginalCheckbox() {
        getDownloadOriginalCheckbox().select();
    }

    public void uncheckDownloadOriginalCheckbox() {
        getDownloadOriginalCheckbox().deselect();
    }

    public void clickOKButton() {
        new Button(parentPage, generateLocator("[name='share']")).click();
        web.waitUntilElementDisappear(generateLocator());
    }

    private Checkbox getDownloadProxyCheckbox() {
        return new Checkbox(parentPage, generateLocator("[name='downloadProxyChk']"));
    }

    private Checkbox getDownloadOriginalCheckbox() {
        return new Checkbox(parentPage, generateLocator("[name='downloadOriginalChk']"));
    }

    private Checkbox getNeverExpiresCheckbox() {
        return new Checkbox(parentPage, generateLocator("[name='neverExpires']"));
    }

    private Checkbox getNeverPublicExpiresCheckbox() {
        return new Checkbox(parentPage, generateLocator("[name='neverPublicExpires']"));
    }

    private ShareFilesPopup selectTab(String tabClass) {
        By locator = generateLocator(String.format(".tabs %s", tabClass));
        if (!web.findElement(locator).getAttribute("class").contains("selected")) web.click(locator);
        return this;
    }
}