package com.adstream.automate.babylon.sut.pages.adbank.notifications;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFilesPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.google.common.collect.Lists;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 15.08.12
 * Time: 20:03
 * To change this template use File | Settings | File Templates.
 */
public class AdBankNotificationsPage extends BaseAdBankPage<AdBankNotificationsPage> {
    public  AdBankNotificationsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("#app-menu"));
        web.waitUntilElementAppearVisible(By.cssSelector("#app-main"));
        //web.waitUntilElementAppearVisible(By.cssSelector("[id*='adbank_notifications_notifications']"));
        web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("#app-menu")));
        assertTrue(web.isElementVisible(By.cssSelector("#app-main")));
        assertTrue(web.isElementVisible(By.cssSelector("[id*='adbank_notifications_notifications']")));
    }

    public int getNotificationsAllCounter() {
        WebElement counter = web.findElement(getNotificationsAllCounterLocatorByCss());
        return Integer.parseInt(counter.getText());
    }

    public List<Map<String,String>> getListOfNotificationsAboutFileSharing(String type) {
        List<Map<String,String>> notifications = new ArrayList<Map<String, String>>();
        String baseXpath = String.format("//*[contains(@id,'notifications_item')][.//*[contains(.,'shared the %s')]]", type);
        List<String> userNames = web.findElementsToStrings(By.xpath(String.format("%s//a[contains(@class,'user_link')]", baseXpath)));
        List<String> fileNames = web.findElementsToStrings(By.xpath(String.format("%s//a[contains(@class,'folder_link')]", baseXpath)));

        for (int i = 0; i < fileNames.size(); i++) {
            Map<String,String> notification = new HashMap<String,String>();
            notification.put("UserName", userNames.get(i));
            notification.put("FileName", fileNames.get(i));

            notifications.add(notification);
        }

        return notifications;
    }

    public int getNotificationsSubCounter() {
        WebElement subCounter = web.findElement(getNotificationsSubCounterLocatorByCss());
        return Integer.parseInt(subCounter.getText());
    }

    public int getCountNotificationsItemsOnPage() {
        List<WebElement> items = web.findElements(getNotificationsItemLocatorByCss());
        return items.size();
    }

    public List<String> getUsersNameLink(boolean isReversedList) {
        List<WebElement> elements =web.findElements(getUsersNameLocatorByCss());
        List<String> userNames = new ArrayList<String>();
        for (int i=0; i< elements.size(); i++) {
            userNames.add(elements.get(i).getText());
        }
        return isReversedList ? Lists.reverse(userNames) : userNames ;
    }

    public List<String> getFoldersLink(boolean isReversedList) {
        List<WebElement> elements = web.findElements(getFoldersNameLocatorByCss());
        List<String> foldersLink = new ArrayList<String>();
        for (int i=0; i< elements.size(); i++) {
            foldersLink.add(elements.get(i).getText());
        }
        return isReversedList ? Lists.reverse(foldersLink) : foldersLink ;
    }

    public List<String> getDateTimeNotifications() {
        List<WebElement> elements = web.findElements(getDateTimeLocatorByCss());
        List<String> dateTimeList = new ArrayList<String>();
        for (int i=0; i< elements.size(); i++) {
            dateTimeList.add(elements.get(i).getText());
        }
        return dateTimeList ;
    }

    public AdbankProjectFilesPage clickFoldersLinkOnNotificationsPage(String path, String userName) {
        WebElement foldersLink = web.findElement(getFoldersLinkOnNotificationsPageLocatorByXpath(userName, path));
        if (foldersLink.isDisplayed()) {
            foldersLink.click();
            foldersLink.click();
            return new AdbankProjectFilesPage(web);
        }
        throw new IllegalArgumentException("Unknown share folder link " + path + " on notifications page!!!");
    }

    public void clickSharedFileLinkByName(String type, String fileName) {
        //String xpath = String.format("//*[contains(@id,'notifications_item')][.//*[contains(.,'shared the %s')]]//a[normalize-space()='%s']", type, fileName);
        //web.click(By.xpath(xpath));
        web.click(By.xpath(String.format("//*[contains(@id,'notifications_item')][.//*[contains(.,'shared the %s')]]//a[normalize-space()='%s']", type, fileName)));
        web.click(By.xpath(String.format("//*[contains(@id,'notifications_item')][.//*[contains(.,'shared the %s')]]//a[normalize-space()='%s']", type, fileName)));
        web.sleep(500);
    }

    public void clickSelectAllCheckBox() {
        web.findElement(getSelectAllCheckBoxLocatorByCss()).click();
        web.sleep(500);
    }

    public void selectNotification(String user, String action, String folder){
        web.click(By.xpath(
                "//p[contains(.,'" + user + " " + action + "')]/a[text()='" + folder + "']/ancestor::div[contains(@id,'notifications_item')]"));
    }

    public void removeNotification(String user, String action, String folder){
        this.selectNotification(user, action, folder);
        this.clickRemoveButton();
    }

    public void clickRemoveButton() {
        web.findElement(getRemoveButtonLocatorByCss()).click();
        web.sleep(500);
    }

    public void clickNextButtonForBottomPagination(){
        web.click(By.cssSelector("span[class='icon-right valign-middle']"));
        web.sleep(500);
    }

    public void clickNextButtonForUpperPagination(){
        web.click(By.cssSelector(".p.valign-middle.mls"));
        web.sleep(500);
    }

    public void clickRemoveLink(String userName, String path) {
        web.findElement(getRemoveLinkLocatorByXpath(userName, path)).click();
        web.sleep(500);
    }

    public boolean isRemoveButtonEnabled() {
        return web.findElement(getRemoveButtonLocatorByCss()).isEnabled();
    }

    private By getNotificationsSubCounterLocatorByCss() {
        return By.cssSelector("span[data-dojo-attach-point='counterTodayNode']");
    }

    private By getNotificationsAllCounterLocatorByCss() {
        return By.cssSelector("[data-id='all-items']");
    }

    private By getNotificationsItemLocatorByCss() {
        return By.cssSelector("[id*='adbank_notifications_notifications_item']");
    }

    private By getTodayLocatorByXPath(String tabName) {
        return By.xpath("//span[contains(@class,'valign-middle p') and contains(text(),'"+ tabName + "')]");
    }

    private By getUsersNameLocatorByCss() {
        return By.cssSelector(".notification-item .user_link.no-decoration");
    }

    private By getFoldersNameLocatorByCss() {
        return By.cssSelector(".notification-item .folder_link.no-decoration");
    }

    private By getFoldersLinkOnNotificationsPageLocatorByXpath(String userName, String path) {
        return By.xpath("//div[contains(@class,'notification-item')]//a[contains(@class,'user_link no-decoration') and .='" + userName + "']/following-sibling::a[contains(.,'" + path + "')]");
    }

    private By getSelectAllCheckBoxLocatorByCss() {
        return By.cssSelector(".selectAll");
    }

    private By getRemoveButtonLocatorByCss() {
        return By.cssSelector("[data-dojo-attach-point='delBtn']");
    }

    private By getRemoveLinkLocatorByXpath(String userName, String path) {
        return By.xpath("//a[contains(@class,'user_link no-decoration') and .='" + userName + "']/following-sibling::a[contains(.,'" + path + "')]/../following-sibling::p/a[.='Remove']");
    }

    private By getDateTimeLocatorByCss() {
        return By.cssSelector(".notification-item .gray");
    }

    public String getUpperPageLabel(){
        return web.findElement(By.cssSelector(".h5.bold")).getText();
    }

    public String getBottomPageLabel(){
        return web.findElement(By.cssSelector(".current.phxs")).getText();
    }

    public AdBankNotificationsPage selectFilterTab(String tabName){
        web.click(By.xpath("//a[text()='" + tabName + "']"));
        return this;
    }

    public boolean isFilterTabSelected(String tabName){
        String filterClass = web.findElement(By.xpath("//a[text()='" + tabName + "']/ancestor::li")).getAttribute("class");
        if(filterClass.contains("selected"))
            return true;
        else return false;
    }
}
