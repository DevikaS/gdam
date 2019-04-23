package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 22.10.12
 * Time: 19:23
 */
public class DownloadFilePopUpWindow extends PopUpWindow {
    public Checkbox downloadMasters;
    public Checkbox downloadProxies;
    public Button download;
    public Button downloadNverge;
    public Link cancel;

    public DownloadFilePopUpWindow(Page parentPage) {
        super(parentPage);
        web.waitUntilElementAppearVisible(generateLocator());
        downloadMasters = new Checkbox(parentPage, generateLocator("[value='master']"));
        downloadProxies = new Checkbox(parentPage, generateLocator("[value='proxy']"));
        download = new Button(parentPage, generateLocator("[name='download']"));
        downloadNverge = new Button(parentPage, generateLocator(".file-nvergedownload"));
        cancel = new Link(parentPage, generateLocator(".cancel"));
    }

    public String getOriginalFileName() {
        By locator = getOriginalFileNameLocator();
        return web.isElementPresent(locator) ? web.findElement(locator).getText().trim() : "";
    }

    public boolean isDownloadMasterCheckboxVisible() {
        return downloadMasters.isVisible();
    }

    public void selectDownloadMaster(){
        downloadMasters.click();
    }

    public void selectDownloadProxy(){
        downloadProxies.click();
    }

    public void clickDownloadButton(){
        download.click();
    }

    public void clickDownloadBySendPlusButton() {
        downloadNverge.click();
    }

    public boolean isDownloadProxiesCheckboxVisible() {
        return downloadProxies.isVisible();
    }

    public boolean isOriginalFileNameVisible() {
        return web.isElementVisible(getOriginalFileNameLocator());
    }

    public boolean isLinkVisible(String type) {
        if(type.equalsIgnoreCase("original")){
            type="Original";
        }
        By locator = By.xpath(String.format(
                "//div[contains(@class, 'popupWindow')]//div[contains(@class,'clearfix')]/div[contains(text(), '%s')]", type));
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isDownloadButtonEnabled() {
        return !(web.findElement(download.getLocator()).getAttribute("class").contains("disabled"));
    }

    public boolean isDownloadButtonNVergeEnabled() {
        return !(web.findElement(downloadNverge.getLocator()).getAttribute("class").contains("disabled"));
    }

    public int getCountOfDownloadLink() {
        return web.findElements(By.cssSelector(".link.unit-right")).size();
    }

    public void clickDownLoadLinkNextToOriginalFileName(String fileName) {
        web.click(By.xpath(String.format(
                "//*[contains(text(),'original - %s')]/following-sibling::*[contains(@class,'link')]", fileName)));
    }

    public void clickDownLoadLinkNextToProxyFileName(String fileName) {
        web.click(By.xpath(String.format(
                "//*[contains(text(),'proxy - %s')]/following-sibling::*[contains(@class,'link')]", fileName)));
    }

    private By getOriginalFileNameLocator() {
        return generateLocator(".clearfix>.unit");
    }
}
