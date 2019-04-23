package com.adstream.automate.babylon.sut.pages.admin.branding;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.DojoControl;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: sobolev-a
 * Date: 20.11.13
 * Time: 9:55
 */
public class AdminLoginPage extends BaseAdminPage {

    @Override
    public void load() {
        web.waitUntilElementAppear(By.className("loginPageAdmin"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementPresent(By.className("loginPageAdmin")));
    }

    public AdminLoginPage(ExtendedWebDriver web) {
        super(web);
    }

    /* Getter methods */
    private By getBackgroundColourButtonLocator() {
        return By.cssSelector(".bgColor .bgPreview");
    }

    private By getBackgroundFooterColourButtonLocator() {
        return By.cssSelector(".ftColor .bgPreview");
    }

    private By getButtonColourButtonLocator() {
        return By.cssSelector(".buttonColor .bgPreview");
    }

    private By getLinkColourButtonLocator() {
        return By.cssSelector(".linkColor .bgPreview");
    }

    private By getTextColourButtonLocator() {
        return By.cssSelector(".textColor .bgPreview");
    }

    /* Methods for input background colour  */
    public boolean isBackgroundColourInputVisible() {
        return web.isElementPresent(By.cssSelector(".bgColor .ui-input")) && web.isElementVisible(By.cssSelector(".bgColor .ui-input"));
    }

    public boolean isBackgroundColourButtonVisible() {
        return web.isElementPresent(getBackgroundColourButtonLocator()) && web.isElementVisible(getBackgroundColourButtonLocator());
    }

    public AdminLoginPage clickBackgroundColourButton() {
        web.click(getBackgroundColourButtonLocator());
        return new AdminLoginPage(web);
    }

    /* Methods for  input background footer colour */
    public boolean isBackgroundFooterColourInputVisible() {
        return web.isElementPresent(By.cssSelector(".ftColor .ui-input")) && web.isElementVisible(By.cssSelector(".bgColor .ui-input"));
    }

    public boolean isBackgroundFooterColourButtonVisible() {
        return web.isElementPresent(getBackgroundFooterColourButtonLocator()) && web.isElementVisible(getBackgroundFooterColourButtonLocator());
    }

    public AdminLoginPage clickBackgroundFooterColourButton() {
        web.click(getBackgroundFooterColourButtonLocator());
        return new AdminLoginPage(web);
    }

    /* Methods for background image */
    public boolean isBackgroundImageVisible() {
        By locator = By.cssSelector(".backgroundPreview.uploadFilePreview .imageHolder");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void uploadBackgroundImage(String backgroundImage) {
        if (backgroundImage == null || backgroundImage.isEmpty()) {
            throw new IllegalStateException(String.format("Wrong value of background image: %s", backgroundImage));
        } else {
            web.findElement(By.xpath(".//*[@class='backgroundLoader']//input[@type='file']")).sendKeys(backgroundImage);
            Common.sleep(1000);
        }
    }

    /* Methods for logo */
    public PopUpWindow clickRemoveBackground() {
        web.clickThroughJavascript(By.cssSelector(".backgroundLoader .remove"));
        return new PopUpWindow(this);
    }

    public PopUpWindow clickRemoveLogo() {
        web.clickThroughJavascript(By.cssSelector(".logoLoader .remove"));
        return new PopUpWindow(this);
    }

    public boolean isLogoVisible() {
        return web.isElementPresent(By.cssSelector(".logoPreviewBig")) && web.isElementVisible(By.cssSelector(".logoPreviewBig"));
    }

    public void uploadLogo(String logo) {
        if (logo == null || logo.isEmpty()) {
            throw new IllegalStateException(String.format("Wrong value of logo image: %s", logo));
        } else {
            web.findElement(By.xpath(".//*[@class='logoLoader']//input[@type='file']")).sendKeys(logo);
            Common.sleep(1000);
        }
    }

    /**
     * if length is 0 - it's a default logo
     * if greater then 0 - it's a custom logo
     * @return length of background-mage parameter
     */
    public int checkOnDefaultLogo() {
        return web.findElement(By.cssSelector(".logoPreviewBig .imageHolder")).getAttribute("style").replaceAll(".*base64,(.*)\"\\).*", "$1").length();
    }

    /* Methods for Save button */
    public boolean isSaveButtonVisible() {
        return web.isElementPresent(By.cssSelector(".save")) && web.isElementVisible(By.cssSelector(".save"));
    }

    public void clickSaveButton() {
        if(isSaveButtonVisible())
            web.click(By.cssSelector(".save"));
    }

    /* Methods for button colour */
    public boolean isButtonColourInputVisible() {
        return web.isElementPresent(By.cssSelector(".buttonColor .ui-input")) && web.isElementVisible(By.cssSelector(".buttonColor .ui-input"));
    }

    public boolean isButtonColourButtonVisible() {
        return web.isElementPresent(getButtonColourButtonLocator()) && web.isElementVisible(getButtonColourButtonLocator());
    }

    public AdminLoginPage clickButtonColourButton() {
        web.click(getButtonColourButtonLocator());
        return new AdminLoginPage(web);
    }

    /* Methods for link colour */
    public boolean isLinkColourInputVisible() {
        return web.isElementPresent(By.cssSelector(".linkColor .ui-input")) && web.isElementVisible(By.cssSelector(".linkColor .ui-input"));
    }

    public boolean isLinkColourButtonVisible() {
        return web.isElementPresent(getLinkColourButtonLocator()) && web.isElementVisible(getLinkColourButtonLocator());
    }

    public AdminLoginPage clickLinkColourButton() {
        web.click(getLinkColourButtonLocator());
        return new AdminLoginPage(web);
    }

    /* Methods for text colour */
    public boolean isTextColourInputVisible() {
        return web.isElementPresent(By.cssSelector(".textColor .ui-input")) && web.isElementVisible(By.cssSelector(".textColor .ui-input"));
    }

    public boolean isTextColourButtonVisible() {
        return web.isElementPresent(getTextColourButtonLocator()) && web.isElementVisible(getTextColourButtonLocator());
    }

    public AdminLoginPage clickTextColourButton() {
        web.click(getTextColourButtonLocator());
        return new AdminLoginPage(web);
    }

    /* Methods for 'Welcome message' */
    public boolean isWelcomeMessageTextareaVisible() {
        return web.isElementPresent(By.name("comment")) && web.isElementVisible(By.name("comment"));
    }

    public boolean typeTextWelcomeMessage(String message) {
        if (isWelcomeMessageTextareaVisible() && message != null && !message.isEmpty()) {
            web.findElement(By.name("comment")).clear();
            web.findElement(By.name("comment")).sendKeys(message);
            return true;
        }
        return false;
    }

    /* Methods for set colour */
    public void typeButtonColour(String color) {
        typeColor(".buttonColor", color);
    }

    public void typeLinkColour(String color) {
        typeColor(".linkColor", color);
    }

    public void typeTextColour(String color) {
        typeColor(".textColor", color);
    }

    public void typeBackgroundColour(String color) {
        typeColor(".bgColor", color);
    }

    public void typeFooterColour(String color) {
        typeColor(".ftColor", color);
    }

    protected void typeColor(String parentCSS, String color) {
        new DojoControl(this, By.cssSelector(String.format("%s [widgetid^='dojox_widget_ColorPicker_']", parentCSS))).setAttribute("value", color);
        Common.sleep(1000);
    }
}
