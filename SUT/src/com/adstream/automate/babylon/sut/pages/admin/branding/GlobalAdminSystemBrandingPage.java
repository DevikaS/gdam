package com.adstream.automate.babylon.sut.pages.admin.branding;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: Geethanjali.K
 * Date: 12.09.16
 * Time: 10:18

 */
public class GlobalAdminSystemBrandingPage extends BaseAdminPage {
    @Override
    public void load() {
        web.waitUntilElementAppear(By.cssSelector(".pts.phm.size1of1 [data-dojo-type=\"admin.branding.formSB\"]"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementPresent(By.cssSelector(".pts.phm.size1of1 [data-dojo-type=\"admin.branding.formSB\"]")));
    }

    public GlobalAdminSystemBrandingPage(ExtendedWebDriver web) {
        super(web);
    }


    public boolean isSaveButtonVisible() {
        return web.isElementPresent(By.name("save")) && web.isElementVisible(By.name("save"));
    }


    public void typeCustomUrl(String email) {
        new Edit(this, getCustomURLFieldLocator()).type(email);
    }

    public void typeEmailUrl(String email) {
        new Edit(this, getEmaiURLFieldLocator()).type(email);
    }

    public GlobalAdminSystemBrandingPage clickBackgroundColorButton() {
        web.click(By.cssSelector("[data-role='bgPreviewSB']"));
        return new GlobalAdminSystemBrandingPage(web);
    }


    public void clickSaveButton() {
        WebElement element = getDriver().findElement(By.cssSelector(".button.secondary.mrs"));
        getDriver().getJavascriptExecutor().executeScript("arguments[0].scrollIntoView(true);", element);
        Common.sleep(1000);
        web.click(By.cssSelector(".button.secondary.mrs"));
    }



    private By getCustomURLFieldLocator() {
        return By.xpath(".//*[@name=\"app-link\"]");
    }

    private By getEmaiURLFieldLocator() {
        return By.xpath(".//*[@name=\"notify-link\"]");
    }
}
