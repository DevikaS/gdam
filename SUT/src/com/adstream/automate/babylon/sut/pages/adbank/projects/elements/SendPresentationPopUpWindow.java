package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.elements.ConfirmationPopup;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 25.10.12
 * Time: 14:09

 */
public class SendPresentationPopUpWindow extends PopUpWindow {
    private DojoCombo emailComboSecureShare;
    private Edit emailEditSecureShare;
    private DojoCombo emailComboPublicShare;
    private Edit emailEditPublicShare;
    private DojoCombo expirationDate;

    public SendPresentationPopUpWindow(Page parentPage) {
        super(parentPage);
        emailEditSecureShare = new Edit(parentPage, generateLocator("[role=textbox]"));
        emailComboSecureShare = new DojoCombo(parentPage, generateLocator(".suggestor[role='combobox']"));
        emailEditPublicShare = new Edit(parentPage, generateLocator(".default_theme .as-original [widgetid*='adbank_shared_Autocomplete'] [id*='adbank_shared_Autocomplete_']"));
        emailComboPublicShare = new DojoCombo(parentPage, generateLocator(".default_theme .as-original [widgetid*='adbank_shared_Autocomplete']"));
        expirationDate = isPublicShare() ?
                new DojoCombo(parentPage, By.cssSelector(getParent(TypeOfShare.PUBLIC) + ".date")) :
                new DojoCombo(parentPage, By.cssSelector(".date"));
        web.waitUntilElementAppearVisible(generateLocator());
    }

    public boolean isPublicShare() {
        return web.isElementVisible(By.cssSelector(".selected[data-name=\"public-share\"]"));
    }

    public void selectRecipients(String emails) {
        for (String email : emails.split(",")){
            emailEditSecureShare.type(email);
            emailComboSecureShare.selectByVisibleText(email);
        }
        web.sleep(1000);
    }

    public void typeTextIntoUserEmailField(String text) {
        emailEditSecureShare.type(text);
        web.sleep(1000);
    }

    public void typeMessage(String value) {
        web.typeClean(By.name("message"), value);
    }

    public void typeMessagePublicShare(String value) {
        web.typeClean(By.cssSelector("[id*='common_form_Textarea_']"), value);
    }

    public void openUsersViewingThisPresentationTab() {
        web.click(By.xpath("//*[@class='tabs']/*[contains(.,'Users viewing this presentation')]"));
    }

    public PopUpWindow removeUser(String firstName, String lastName) {
        web.click(By.xpath(String.format("//*[contains(@class,'row')][normalize-space()=normalize-space('%s %s')]//*[contains(@id,'removeSubscriber')]", firstName, lastName)));
        return new ConfirmationPopup(this.parentPage);
    }

    public boolean isUserPresentInAddUserSearchResults(String userEmail) {
        String locator = String.format("//*[contains(@id,'Autocomplete')]//span[not(@class)][contains(.,'%s')]", userEmail);
        return web.isElementVisible(By.xpath(locator));
    }

    public boolean isLibraryTeamPresentInAddUserSearchResults(String teamName) {
        String locator = String.format("//*[contains(@id,'Autocomplete')]//*[@role='option'][contains(.,'%s')][last()]", teamName);
        return web.isElementVisible(By.xpath(locator));
    }

    public void selectPublicShareUser(String emails) {
        for (String email : emails.split(",")){
            emailEditPublicShare.type(email);
            emailComboPublicShare.selectByVisibleText(email);
        }
        web.sleep(1000);
    }

    public void switchBetweenTab(String tab) {
        switch (tab) {
            case "Secure share":
                web.click(By.cssSelector("[data-name=\"secure\"]"));
                break;
            case "Users viewing this presentation":
                web.click(By.cssSelector("[data-name=\"secure-info\"]"));
                break;
            case "Public share":
                web.click(By.cssSelector("[data-name=\"public-share\"]"));
                break;
            case "Public Link Access":
                web.click(By.cssSelector("[data-name=\"public-info\"]"));
                break;
            default:
                throw new IllegalArgumentException("Wrong argument " + tab);
        }
        Common.sleep(500);
    }

    public String getFieldValue(String fieldName) {
        if (fieldName.equalsIgnoreCase("name")) {
            return web.findElement(By.cssSelector(".settings [name='name']")).getAttribute("value").trim();
        } else if (fieldName.equalsIgnoreCase("description")) {
            return web.findElement(By.cssSelector(".settings [name='description']")).getText().trim();
        } else {
            throw new IllegalArgumentException(String.format("Unexpected field name '%s'", fieldName));
        }
    }

    public String getPublicUrl() {
        return new Edit(parentPage, By.cssSelector("[name='publicLink']")).getValue().trim();
    }

    public void clickActivateButton() {
        web.click(By.cssSelector(".activateBtn"));
    }

    public void setExpirationDate(String value) {
        expirationDate.selectByVisibleText(value);
    }

    public void setAllowPresentationDownloadByState(boolean state){
        if (state) {
            if (!web.findElement(getAllowPresentationDownloadLocator()).isSelected()) web.click(getAllowPresentationDownloadLocator());
        }  else {
            if (web.findElement(getAllowPresentationDownloadLocator()).isSelected()) web.click(getAllowPresentationDownloadLocator());
        }
    }

    public void setDownloadOption(String option, TypeOfShare shareType) {
        Checkbox downloadOriginal =
                new Checkbox(parentPage, By.cssSelector(getParent(shareType) + "[name='downloadOriginalChk']"));
        Checkbox downloadProxy =
                new Checkbox(parentPage, By.cssSelector(getParent(shareType) + "[name='downloadProxyChk']"));
        downloadOriginal.setSelected(option.matches("Originals|Original \\+ Proxy"));
        downloadProxy.setSelected(option.matches("Proxies|Original \\+ Proxy"));
    }

    public void clickSendButton() {
        web.click(By.name("send"));
        web.waitUntilElementDisappear(generateLocator());
    }

    private By getAllowPresentationDownloadLocator() {
        return By.name("allowDownload");
    }

    public String getParent(TypeOfShare typeOfShare) {
        return (typeOfShare.equals(TypeOfShare.PUBLIC)) ? "[id*='adbank_shared_publicSharedPanel_'] " : "";
    }

    public enum TypeOfShare {
        SECURE, PUBLIC
    }
}