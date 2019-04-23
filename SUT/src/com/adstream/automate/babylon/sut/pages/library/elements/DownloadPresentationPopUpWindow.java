package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 23.11.12
 * Time: 17:07
 * To change this template use File | Settings | File Templates.
 */
public class DownloadPresentationPopUpWindow extends PopUpWindow {
    public DownloadPresentationPopUpWindow(Page<? extends Page> parentPage) {
        super(parentPage);
        web.waitUntilElementAppearVisible(getDownloadPresentationPopUpTitleLocator());
    }

    public boolean isOriginalFilesButtonVisible() {
        return web.isElementVisible(getOriginalFilesButtonLocator());
    }

    public boolean isProxyFilesButtonVisible() {
        return web.isElementVisible(getProxyFilesButtonLocator());
    }

    private By getDownloadPresentationPopUpTitleLocator() {
        return By.xpath("//*[contains(@class,'popupWindow')][*[contains(@class,'windowHead')]//*[contains(text(),'Download')]]");
    }

    private By getOriginalFilesButtonLocator() {
        return By.cssSelector("[data-dojo-props*='master']");
    }

    private By getProxyFilesButtonLocator() {
        return By.cssSelector("[data-dojo-props*='preview']");
    }

    public void clickDownloadOriginalButton() {
        web.click(getOriginalFilesButtonLocator());
    }

    public void clickProxyFileButton() {
        web.click(getProxyFilesButtonLocator());
    }
}
