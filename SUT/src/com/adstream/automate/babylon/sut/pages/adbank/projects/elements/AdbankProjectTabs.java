package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 15.09.12 16:15
 */
public class AdbankProjectTabs extends BaseAdBankPage<AdbankProjectTabs> {
    public AdbankProjectTabs(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
    }

    public List<String> getLastActivities() {
        By locator = By.cssSelector(".itemsList.activities-list .row,[data-dojo-type='common.table.virtualScroll'] .files_activities_item");
        List<String> activities = new ArrayList<>();
        web.scrollToElement(web.findElement(By.cssSelector(".footer.clearfix")));
        web.sleep(1000);
        for (WebElement element : web.findElements(locator))
            activities.add(element.getText().replaceAll("\n.*$", "").replaceAll("\n", " "));
        return activities;
    }

    public int getFilesCount(String fileName) {
        By locator = By.xpath(String.format("//div[contains(@class, 'file-item') or @data-type='tableRow']//a[normalize-space(text())='%s']", fileName));
        return web.findElements(locator).size();
    }

    public int getFilesCount() {
        By locator = By.xpath("//*[@class='file-info']");
        return web.isElementPresent(locator) ? web.findElements(locator).size() : 0;
    }

    public boolean isFileVisible(String fileName) {
       // return web.isElementVisible(By.xpath("//*[@class='file-info']//*[normalize-space(text())='" + fileName + "']/ancestor::div[@class='wrapper']"));
        //1096 Merge
        return web.isElementVisible(By.xpath("//*[@class='file-info']//a[@title='" + fileName + "']/ancestor::node()[5]/../div[contains(@class,'wrapper')]"));
        //1096 Merge
    }

// 1096 Merge
public boolean isFileVisibleonoverview(String fileName) {
        //return web.isElementVisible(By.xpath("//*[@class='file-info']//*[normalize-space(text())='" + fileName + "']/ancestor::div[@class='wrapper']"));
        return web.isElementVisible(By.xpath("//*[@class='file-info']//a[text()='" + fileName + "']/ancestor::node()[5]/../div[contains(@class,'wrapper')]"));
    }
    //1096 Merge


    public void clickUserInActivities(User user) {
        web.click(By.xpath(String.format("//*[contains(@class,'activities-list') or @data-dojo-type='adbank.files.activity']//a[normalize-space(text())='%s']", user.getFullName())));
    }

    public void clickFileInActivities(String fileName) {
        web.findElement(By.linkText("logo.png")).click();
    }

    public boolean isThumbnailForRevisionVisible(String fileId){
        By thumbnailLocator = By.xpath("//*[contains(@src,'" + fileId + "')]");
        return web.isElementPresent(thumbnailLocator);
    }

    public String getCurrentProjectId() {
        String url = web.getCurrentUrl();
        if (!url.contains("/projects/")) {
            return null;
        }
        int start = url.indexOf("/projects/") + "/projects/".length();
        int end = url.indexOf("/", start);
        return url.substring(start, end);
    }

    public byte[] getLastActivityLogo(String message) {
        String locator = "//*[@class='clearfix bottom row']";
        for (int i=1;i<=web.findElements(By.xpath(locator)).size();i++){
            String text = web.findElement(By.xpath(String.format(locator.concat("["+i+"]")))).getText().replaceAll("\n.*$", "").replaceAll("\n", " ");
            if (text.contains(message)){
               String locator1 = String.format("//*[@class='clearfix bottom row']["+i+"]//*[@class='preview clickable  backgroundNone']/img");
               return  getDataByUrl(getLogoSrc(locator1));
            }
        }
        return null;
    }


    public String getLogoSrc(String locator) {
        return web.findElement(By.xpath("//*[@class='clearfix bottom row'][1]//*[@class='preview clickable  backgroundNone']/img")).getAttribute("src");
    }
}
