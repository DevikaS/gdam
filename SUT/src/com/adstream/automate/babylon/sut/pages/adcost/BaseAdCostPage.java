package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.StepsAdCostType;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.*;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Raja.Gone on 21/04/2017.
 */
public class BaseAdCostPage<T> extends BasePage<T> {

    private static String userId;

    private static final By wakeMeUpPopUpLocator = By.cssSelector(".wm-close-button.walkme-x-button");
    protected String buttonNameFormat = "//button//span[contains(text(),'%s')]";
    private String isButtonEnabledFormat = "//button//span[contains(text(),'%s')]/../..";

    public BaseAdCostPage(ExtendedWebDriver web) { super(web); }

    @Override
    public void load() { isLoaded(); }

    @Override
    public void isLoaded() throws Error {
        web.sleep(3000);
        assertTrue(web.isElementVisible(applicationBodyLocator) || web.isElementVisible(applicationBodyLocatorForAdcost) || web.isElementVisible(getApplicationBodyLocatorForAdcostPopUps));
    }

    public void closeWakeMePopUp(){
        while(web.isElementVisible(wakeMeUpPopUpLocator)){
            for (WebElement popup : web.findElements(wakeMeUpPopUpLocator)) {
                popup.click();
            }
        }
    }

    public String getAdCostType(String costType) {
        if (costType.equalsIgnoreCase(StepsAdCostType.PRODUCTION.toString()))
            return "New Production Cost";
        else if (costType.equalsIgnoreCase(StepsAdCostType.BUYOUT.toString()))
            return "New Usage/Buyout/Contract Cost";
        else if (costType.equalsIgnoreCase(StepsAdCostType.TRAFFICKINGDISTRIBUTION.toString()))
            return "New Trafficking/Distribution Cost";
        else
            throw new IllegalArgumentException("Unknown AdCost type: " + costType);
    }

    public void scrollToFieldName(WebElement element){
        JavascriptExecutor executor =web.getJavascriptExecutor();
        executor.executeScript("arguments[0].scrollIntoView(true);", element);
    }

    private By getButtonLocator(String btnName){
        return By.xpath(String.format(isButtonEnabledFormat, btnName));
    }

    public void clickBtnByName(String btnName){
        By isButtonEnabledLocator = getButtonLocator(btnName);
        web.waitUntilElementAppearVisible(isButtonEnabledLocator);
        if(web.findElement(isButtonEnabledLocator).isEnabled()){
            By buttonToClickLocator = By.xpath(String.format(buttonNameFormat, btnName));
            new Button(this, buttonToClickLocator).click();
        }
        else
            throw new ElementNotVisibleException("Check if all mandatory fields are filled or buttonName: "+btnName);
    }

    public void clickBtnByName(String btnName, String parentFormLocator) {
        By isButtonEnabledLocator = By.xpath(String.format(parentFormLocator+isButtonEnabledFormat, btnName));
        if (web.findElement(isButtonEnabledLocator).isEnabled()) {
            By buttonToClickLocator = By.xpath(String.format(parentFormLocator+buttonNameFormat, btnName));
            web.findElement(buttonToClickLocator).click();
        } else
            throw new ElementNotVisibleException("Check if all mandatory fields are filled or buttonName: " + btnName);
    }

    public void clickBtnByNameOnFormPage(String btnName){
        String locatorFormat = "//md-dialog//button//span[contains(text(),'%s')]";
        By buttonLocator = By.xpath(String.format(locatorFormat,btnName));
        web.waitUntilElementAppearVisible(buttonLocator);
        web.findElement(buttonLocator).click();
    }

    public void clickBtnByNameOnFormReviewPage(String btnName){
        String locatorFormat = "//md-dialog//button//span[contains(text(),'%s')]";
        By buttonLocator = By.xpath(String.format(locatorFormat,btnName));
        web.findElement(buttonLocator).click();
    }

    public void enterRejectionReasonOnFormReviewPage(String msg){
        By buttonLocator = By.xpath("//ads-md-textarea//textarea[@placeholder='Add your comments']");
        web.typeClean(buttonLocator,msg);
        web.sleep(500);
    }

    // btnName = {Recall | Delete | Duplicate |}
    public void clickBtnInMenuItem(String btnName){
        web.findElement(By.xpath(String.format("//div[@class='_md md-open-menu-container md-whiteframe-z2 md-active md-clickable']//button//span[contains(text(),\"%s\")]",btnName))).click();
    }

    public boolean isAdminTabPresent(){
        if (web.isElementPresent(By.xpath("//ads-md-nav-item//span[contains(text(),'Admin')]")))
            return true;
        return false;
    }

    public void clickTabOnToolBar(String tabName){
        String tabNameLocator = "//ads-md-nav-item//span[contains(text(),'%s')]";
        if(web.isElementPresent(By.xpath(String.format(tabNameLocator, tabName))))
           web.findElement(By.xpath(String.format(tabNameLocator, tabName))).click();
    }

    public String getUserId() {
        return userId; }

    protected void setUserId(String userId) { this.userId = userId; }

    public void waitUntilFormPageDisappears(){
        web.waitUntilElementDisappear(By.xpath("//md-dialog[contains(@class,'_md md-transition-in')][@role='dialog']"));
    }

    public void selectLHSNav(String sectionName){
        String locator = String.format("//div[.='%s']",sectionName);
        web.click(By.xpath(locator));
    }

    public boolean isPageLoaded(String pageLocator, long timeout){
        final long globalTimeout= 3 * 60 * 1000; // 3 mins
        long start = System.currentTimeMillis();
            do{
                Common.sleep(timeout * 1);
            }while(!web.isElementVisible(By.xpath(pageLocator)) && System.currentTimeMillis() - start < globalTimeout);
            if (System.currentTimeMillis() - start > globalTimeout)
                return false;
        return web.waitUntilElementAppearVisible(By.xpath(pageLocator)).isDisplayed();
    }

    public String getToastMessage(){
        By locator = By.xpath("//span[@class='md-toast-text ng-binding'][@role='alert']");
        web.waitUntilElementAppearVisible(locator);
        return web.findElement(locator).getText();
    }

    public boolean isToastMessageVisible(String message){
        By locator = By.xpath("//span[@class='md-toast-text ng-binding'][@role='alert']");
        if(web.isElementVisible(locator))
            return web.findElement(locator).getText().equalsIgnoreCase(message);
        return false;
    }
}