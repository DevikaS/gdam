package com.adstream.automate.babylon.sut.pages.adbank;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFilesPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.time.StopWatch;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:57
 */
public class BaseAdBankPage<T> extends BasePage<T> {
    protected Control container;

    public BaseAdBankPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        container.visible();
    }

    public void isLoaded() throws Error {
        web.sleep(4000);
        super.isLoaded();
        assertTrue(container.isVisible());
        web.manage().timeouts().implicitlyWait(1, TimeUnit.SECONDS);
    }

    @Override
    public void init() {
        container = new Control(this, By.cssSelector(".adbank, .library"));
    }

    public void searchObject(String objectName) {
        //web.typeClean(By.cssSelector("[data-dojo-type='common.menu.search'] input"), objectName);
        Common.sleep(2000);
        web.typeClean(By.cssSelector("[data-dojo-type='common.menu.search'] .ui-input"), objectName);
       Common.sleep(4000);
    }

    public List<String> getDropdownListOfLinks() {
        return web.findElementsToStrings(By.cssSelector(".search_tooltip.search_tooltip_container a.no-decoration"));
    }

    public List<String> getSearchResultNumItems() {
        return web.findElementsToStrings(By.cssSelector(".unit-right .result-item"));
    }

    public List<String> getHeadersOverShowAllResultsLink() {
        return web.findElementsToStrings(By.cssSelector(".result-block .mls.mtxs"));
    }

    // type can be one of: Projects, Assets, Files & Folders
    public List<String> getGlobalSearchResultItems(String type) {
        String locator = String.format("//div[contains(@class, 'result-block') and descendant::span[text()='%s']]/following-sibling::div//a", type);
        return web.findElementsToStrings(By.xpath(locator));
    }

    public int getCountOfFoundedItems(String item) {
        int result= 0;
        List<String> list = getDropdownListOfLinks();
        for (String str: list) {
            if (str.contains(item)) {
                result++;
            }
        }
        return result;
    }

    public void clickSearchInCurrentProject() {
        web.click(By.xpath("//*[text()='Search in Current Project']"));
        Common.sleep(1000);
    }

    public void clickMatchAllWords(boolean check) {
        if((!web.findElement(By.xpath("//input[contains(@class,'search-type')][@type='checkbox']")).isSelected())&& check) {
            web.click(By.xpath("//input[contains(@class,'search-type')][@type='checkbox']"));
        }else if(!check){
            web.click(By.xpath("//input[contains(@class,'search-type')][@type='checkbox']"));
        }
    }

    public void clickShowAllResults() {
        web.waitUntilElementAppear(By.xpath("//a[contains(text(),'Show all results')]"));
        web.click(By.xpath("//a[contains(text(),'Show all results')]"));
    }

    public void clickShowAllResults(int num) {
        web.click(By.xpath("(//*[contains(text(),'Show all results')])[" + num + "]"));
    }

    public long getFileLoadingTime(String name) {
        StopWatch pageLoad = new StopWatch();
        pageLoad.start();
        clickFileLinkOnSearchResultsDropdown(name);
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".button[id*='share_file']:not(.disabled)")));
        pageLoad.stop();
        //Get the time
        Long pageLoadTime_Seconds = pageLoad.getTime() / 1000;
        return pageLoadTime_Seconds;
    }

    public long openLinkInNewTab(String type,String name){
        String parentWindow = web.getWindowHandle();
        StopWatch pageLoad = new StopWatch();
        pageLoad.start();
        web.findElement(By.linkText(name)).sendKeys(Keys.CONTROL,Keys.RETURN);
        Set<String> windows = web.getWindowHandles();
        Iterator<String> iter = windows.iterator();
        // Set Parent windowhandle
        String parent = iter.next();
        // Switch to new window
        web.switchTo().window(iter.next());
        if(type.equals("project")) {
            web.sleep(50000);
            web.waitUntil(ExpectedConditions.presenceOfElementLocated(By.linkText("Delete project")));
        }else if(type.equals("file")){
            web.waitUntil(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".button[id*='share_file']:not(.disabled)")));
        }
        pageLoad.stop();
        //Get the time
        long pageLoadTime_Seconds = pageLoad.getTime() / 1000;
        return pageLoadTime_Seconds;
    }

    public boolean isShowAllResultsLinkVisible() {
        By locator = By.xpath("//*[contains(text(),'Show all results')]");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public int getNotificationsCounter() {
        return Integer.parseInt(web.findElement(getNotificationsCounterLocatorByCss()).getText());
    }

    public int getCountNotReadNotificationsInDropDown() {
        List<WebElement> elementList = web.findElements(getNotReadNotificationsListLocatorByCss());
        return elementList.size();
    }

    public void clickFileLinkOnSearchResultsDropdown(String fileName) {
        web.findElement(By.xpath(String.format("//*[contains(@class,'search-results')]//a[normalize-space()='%s']", fileName))).click();
    }

    public AdbankProjectFilesPage clickFolderLinkInNotificationsDropDown(String projectId, String folderName) {
        web.waitUntilElementAppearVisible(getFoldersLinkInNotificationsDropDownLocatorByCss());
        WebElement foldersLink = web.findElement(getFoldersLinkInNotificationsDropDownLocatorByXpath(projectId, folderName));
        if (foldersLink.isDisplayed()) {
            foldersLink.click();
            foldersLink.click();
            return new AdbankProjectFilesPage(web);
        }
        throw new IllegalArgumentException("Unknown share folder link " + folderName + " " + "\\" + " for project " + projectId + " in notifications dropdown!!!");
    }

    public void clickNotificationsMenuInHeader() {
        web.waitUntilElementDisappear(By.cssSelector(".message-wrapper .message"));
        web.sleep(500);
        web.click(By.cssSelector("[id*='common_menu_top_menu_notification'] >.vmiddle"));
    }

    public void clickNotificationsCounter() {
        web.click(getNotificationsCounterLocatorByCss());
    }

    public String getNotificationDropdownText() {
        return web.findElement(By.cssSelector(".lastUnit.break-words")).getText();
    }

    public void scrollDown() {
        String script =
                "var w = window,\n" +
                "    d = document,\n" +
                "    e = d.documentElement,\n" +
                "    g = d.getElementsByTagName('body')[0],\n" +
                "    x = w.innerWidth || e.clientWidth || g.clientWidth,\n" +
                "    y = w.innerHeight|| e.clientHeight|| g.clientHeight;" +
                "window.scrollBy(0, y);";
        web.getJavascriptExecutor().executeScript(script);
    }

    private By getNotificationsCounterLocatorByCss() {
        return By.cssSelector(".ui-counter.special");
    }

    private By getFoldersLinkInNotificationsDropDownLocatorByCss() {
        return By.cssSelector(".folder_link");
    }

    private By getFoldersLinkInNotificationsDropDownLocatorByXpath(String projectId, String folderName) {
        return By.xpath(String.format("//a[contains(@href,'%s')][normalize-space()='%s']", projectId, folderName));
    }

    private By getNotReadNotificationsListLocatorByCss() {
        return By.cssSelector("[id*='common_menu_notifications_list_item']");
    }

    public List<String> getListResultAssetFromGlobalSearch() {
        return web.findElementsToStrings(getListResultAssetFromGlobalSearchLocator());
    }

    private By getListResultAssetFromGlobalSearchLocator() {
        return By.xpath("//*[contains(@class,'bold')][text()='Assets']/../../..//*[contains(@class, 'result-item')]/div[2]//a");
    }
}
