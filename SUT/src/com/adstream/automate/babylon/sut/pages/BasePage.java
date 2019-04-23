package com.adstream.automate.babylon.sut.pages;

import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.ChangeBUOnBehalf;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.Cookie;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 18.06.12
 * Time: 14:48
 */
public class BasePage<T> extends Page<T> {
    protected static final By applicationBodyLocator = By.cssSelector("body[id^='adstream_navigator_Controller'],.registration-body,[ng-app]");
    protected static final By applicationBodyLocatorForTraffic = By.cssSelector("body[class='ng-scope']");
    private static final By FORM_LOCATOR = By.cssSelector("body[id^='adstream_navigator_Controller'],.registration-body,[ng-app],body[class='ng-scope'],.ui");
    protected static final By applicationBodyLocatorForAdcost = By.cssSelector(".layout-row");
    protected static final By getApplicationBodyLocatorForAdcostPopUps=By.cssSelector("._md.md-transition-in");
    protected static final By getApplicationBodyLocatorForLibrary=By.cssSelector("library-wrapper");
    protected static final By getApplicationBodyLocatorForMediaManager=By.cssSelector(".ui");

    public BasePage(ExtendedWebDriver web) {
        super(web);
    }

    public String getNotificationMessage() {
        return web.waitUntilElementAppearVisible(By.cssSelector("#notification")).getText();
    }

    public String getPopUpNotificationMessage() {
        try {
            return web.waitUntilElementAppearVisible(getPopUpMessageWarningLocator()).getText();
        } catch (Exception e) {
            throw new RuntimeException("There is no any warning message on the page!");
        }
    }

    // For NGN-14650
    public String getPopUpNotificationMessage_GlobalRolesPage() {
        try {
            return web.waitUntilElementAppearVisible(By.cssSelector(".messenger.shown.warning")).getText();
        } catch (Exception e) {
            throw new RuntimeException("There is no any warning message on the page!");
        }
    }

    public String getPopUpNotificationMessage_withoutWait() {
        try {
            return web.findElement(getPopUpMessageWarningLocator()).getText();
        } catch (Exception e) {
            throw new RuntimeException("There is no any warning message on the page!");
        }
    }

    public String getErrorMessageOnThePage() {
        try {
            return web.findElement(By.cssSelector("#app-view .error, #app-main .error, [ng-app='resetPassword'] .error")).getText();
        } catch (Exception e) {
            return "";
        }
    }

    public List<String> getPopUpNotificationMessages() {
        try {
//            web.waitUntilElementAppearVisible(getPopUpMessageWarningLocator());
            return web.findElementsToStrings(getPopUpMessageWarningLocator());
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    public String getPopUpExclamationMessage() {
        try {
            return web.waitUntilElementAppearVisible(getPopUpMessageExclamationLocator()).getText().trim();
        } catch (Exception e) {
            throw new RuntimeException("There is no any exclamation message on the page!");
        }
    }

    public void waitUntilPopUpNotificationMessageDisappeared() {
        web.waitUntilElementDisappear(getPopUpMessageWarningLocator());
    }

    private By getPopUpMessageExclamationLocator() {
        return By.cssSelector(".message.exclamation");
    }

    private By getPopUpMessageWarningLocator() {
        return By.cssSelector(".message-wrapper .message");
    }

    public String getStandardPopUpMessage() {
        return web.getAlertMessage();
    }

    public String getAlertMessage() {
        return web.waitUntilElementAppearVisible(By.cssSelector(".message .alert")).getText();
    }

    public boolean isAlertMessageVisible() {
        return web.isElementVisible(By.cssSelector(".message .alert"));
    }

    public void actionOnAlert(String action) {
        if (action.equalsIgnoreCase("OK"))
            web.switchTo().alert().accept();
        else if (action.equalsIgnoreCase("Cancel"))
            web.switchTo().alert().dismiss();
    }

    public String getErrorMessage() {
        return web.waitUntilElementAppearVisible(By.cssSelector(".message.error")).getText();
    }

    public boolean isErrorMessageVisible() {
        return web.isElementVisible(By.cssSelector(".message.error"));
    }

    public String getHeaderLogoSrcAttribute() {
        return web.findElement(By.cssSelector(".headerLogo")).getAttribute("src");
    }

    public String getHeaderStyleAttributeValue() {
        return web.findElement(By.cssSelector(".header.clearfix")).getAttribute("style");
    }

    public String getHeaderBGColorValue() {
        return web.findElement(By.cssSelector(".header.clearfix")).getCssValue("background-color");
    }


    public boolean isAnyErrorsOnPage() {
        //   boolean errorComboElements = web.isElementVisible(By.cssSelector(".dijitError,.error"));
        boolean errorComboElements = web.isElementVisible(By.cssSelector(".error"))|| web.isElementVisible(By.cssSelector(".dijitError"));
        boolean errorInputElements = web.isElementVisible(By.cssSelector(".ui-input.error"));
        return errorComboElements || errorInputElements;
    }

    public boolean isSaveButtonActive(){
        return !Boolean.parseBoolean(web.findElement(By.name("save")).getAttribute("disabled"));
    }

    public Cookie getSessionCookie(){
        for (Cookie cookie : web.manage().getCookies()) {
            if (cookie.getName().startsWith("access")) {
                return cookie;
            }
        }
        return null;
    }

    public byte[] getDataByUrl(String url){
        // workaround for httpClient. it throws exception for modified parameter
        if (url.contains("&modified")) url = url.substring(0, url.indexOf("&modified"));

        CloseableHttpClient client = HttpClients.createDefault();

        Cookie sessionCookie = getSessionCookie();
        HttpRequestBase request = new HttpGet(url);
        request.setHeader("Cookie", sessionCookie.toString());
        byte[] logoArray = null;
        try {
            HttpResponse response = client.execute(request);
            logoArray = EntityUtils.toByteArray(response.getEntity());
        } catch (IOException e) {
            e.printStackTrace();    //todo add logger
        }
        return logoArray;
    }

    public boolean isEmpty() {
        return web.isElementPresent(By.xpath("//*[@id='app-view'][not(*)]"));
    }

    public List<String> getAccountMenuItems() {
        return web.findElementsToStrings(By.cssSelector(".user-menu-content a"));
    }

    public String getCurrentUserEmail() {
        return web.getJavascriptExecutor().executeScript("return app.root.current.user._cm.common.email;").toString();
    }

    public String getCurrentScrollPosition() {
        return web.getJavascriptExecutor().executeScript("return document.documentElement.scrollTop;").toString();
    }

    public void expandAccountMenu() {
        if (web.isElementPresent(By.cssSelector("[id*='accountMenu'] .dijit:not(.dijitOpened)")))
            web.click(By.cssSelector("[id*='accountMenu'] .dijit:not(.dijitOpened) img"));
    }

    public void collapseAccountMenu() {
        if (web.isElementPresent(By.cssSelector("[id*='accountMenu'] .dijit.dijitOpened")))
            web.click(By.cssSelector("[id*='accountMenu'] .dijit.dijitOpened img"));
    }

    /*public boolean isTrafficWalkMePopupPresent() {
        return web.isElementVisible(By.cssSelector("[id='walkme-overlay-all']"));
    }*/

    public void selectAccountMenuItemByName(String itemName) {
        //web.click(By.xpath("//*[@id='dijit_MenuItem_0_text']"));
        web.click(By.xpath(String.format("//*[contains(@class,'user-menu-content')]//a[normalize-space()=normalize-space('%s')]", itemName)));
    }

    @Override
    public void load() {
        web.sleep(3000);
        web.waitUntilElementAppear(FORM_LOCATOR);
        assertTrue(web.isElementVisible(applicationBodyLocator) || web.isElementVisible(applicationBodyLocatorForTraffic)|| web.isElementVisible(applicationBodyLocatorForAdcost) || web.isElementVisible(getApplicationBodyLocatorForAdcostPopUps) || web.isElementVisible(getApplicationBodyLocatorForLibrary));
    }

    @Override
    public void isLoaded() throws Error {
        web.sleep(3000);
        assertTrue(web.isElementVisible(applicationBodyLocator) || web.isElementVisible(applicationBodyLocatorForTraffic) || web.isElementVisible(applicationBodyLocatorForAdcost) || web.isElementVisible(getApplicationBodyLocatorForAdcostPopUps) || web.isElementVisible(getApplicationBodyLocatorForLibrary) || web.isElementVisible(getApplicationBodyLocatorForMediaManager));
    }

    @Override
    public void init() {
    }

    public ChangeBUOnBehalf getBUChangeOnBehalfOfPopUp() {
        return new ChangeBUOnBehalf(this, "Select Client");
    }
}