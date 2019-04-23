package com.adstream.automate.babylon.sut.pages.admin.branding;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.DojoControl;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 27.11.12
 * Time: 11:54

 */
public class AdminSystemBrandingPage extends BaseAdminPage {
    @Override
    public void load() {
        web.waitUntilElementAppear(By.id("brandingCont"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementPresent(By.id("brandingCont")));
    }

    public AdminSystemBrandingPage(ExtendedWebDriver web) {
        super(web);
    }

    public String getLogoSrcAttribute() {
        return web.findElement(By.cssSelector(".logo_img_id")).getAttribute("src");
    }

    public String getFromEmailFieldValue() {
        return new Edit(this, getFromEmailFieldLocator()).getValue();
    }

    public String FromEmailFieldErrorHintText() {
        return web.findElement(By.cssSelector("[name='from-email']+.emailErrorMessage")).getText().trim();
    }

    public boolean isBackgroundColorInputVisible() {
        return web.isElementPresent(By.id("BGcurrentValueSB")) && web.isElementVisible(By.id("BGcurrentValueSB"));
    }

    public boolean isBackgroundColorButtonVisible() {
        return web.isElementPresent(By.cssSelector("[data-role='bgPreviewSB']")) && web.isElementVisible(By.cssSelector("[data-role='bgPreviewSB']"));
    }

    public boolean isLogoVisible() {
        return web.isElementPresent(By.cssSelector(".logo_img_id + img")) && web.isElementVisible(By.cssSelector(".logo_img_id + img"));
    }

    public boolean isBrowseButtonVisible() {
        By locator = By.xpath("//div[contains(@class, 'upload-file-container') and following-sibling::input[@name='logo']]");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isSaveButtonVisible() {
        return web.isElementPresent(By.name("save")) && web.isElementVisible(By.name("save"));
    }

    public boolean isLogoDefault() {
        return getLogoSrcAttribute().contains("documentId=000000000000000000000000");
    }

    public void typeColor(String color) {
        new DojoControl(this, By.name("colorPickerSB")).setAttribute("value", color);
    }

    public void typeFromEmail(String email) {
        web.scrollToElement(web.findElement(By.name("from-email")));
        new Edit(this, getFromEmailFieldLocator()).type(email);
    }

    public void setColorByParams(String params) {
        web.typeClean(By.id("colorPickerSB_0_r"), params.split(",")[0].trim());
        web.typeClean(By.id("colorPickerSB_0_g"), params.split(",")[1].trim());
        web.typeClean(By.id("colorPickerSB_0_b"), params.split(",")[2].trim());
        web.findElement(By.id("colorPickerSB")).click();
    }

    public AdminSystemBrandingPage clickBackgroundColorButton() {
        web.click(By.cssSelector("[data-role='bgPreviewSB']"));
        return new AdminSystemBrandingPage(web);
    }

    public PopUpWindow clickRemoveLink() {
        web.click(By.cssSelector(".remove.mls"));
        return new PopUpWindow(this);
    }

    public void clickSaveButton() {
        Common.sleep(2000);
        web.click(By.name("save"));
    }

    public void uploadLogo(String logo) {
        if (logo != null && !logo.isEmpty()) {
            web.findElement(By.name("file")).sendKeys(logo);
            Common.sleep(1000);
        }
    }

    private By getFromEmailFieldLocator() {
        return By.name("from-email");
    }
}
