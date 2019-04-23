package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 18:27
 */
public class AdbankLibraryPresentationsActivityPage extends AdbankLibraryPresentationsPage {

    public AdbankLibraryPresentationsActivityPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.sleep(1000);
        web.waitUntilElementAppearVisible(By.cssSelector(".tree-block"));
//        web.waitUntilElementAppearVisible(By.cssSelector("#reel-card-content .activity"));
        web.waitUntilElementAppearVisible(By.cssSelector("#reel-card-content"));
        web.manage().timeouts().implicitlyWait(1, TimeUnit.SECONDS);
    }

    public void isLoaded() throws Error {
        web.sleep(1000);
        assertTrue(web.isElementVisible(By.cssSelector(".tree-block")));
//        assertTrue(web.isElementVisible(By.cssSelector("#reel-card-content .activity")));
        assertTrue(web.isElementVisible(By.cssSelector("#reel-card-content")));
        web.manage().timeouts().implicitlyWait(1, TimeUnit.SECONDS);
    }

    public String getPresentationLogoFileId() {
        WebElement logo = web.findElement(By.cssSelector(".presentationLogo"));
        String regexp = "fileId=([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})";
        Matcher mather = Pattern.compile(regexp, Pattern.CASE_INSENSITIVE).matcher(logo.getAttribute("STYLE"));
        return mather.find() ? mather.group(1) : "";
    }

    public String getPresentationName() {
        return getPresentationInfo("Presentation Name");
    }

    public String getAssetsCount() {
        return getPresentationInfo("No. Assets");
    }

    public String getViewsCount() {
        return getPresentationInfo("No. Views");
    }

    public String getDownloadsCount() {
        return getPresentationInfo("No. Downloads");
    }

    public String getEmailsSentCount() {
        return getPresentationInfo("Emails Sent");
    }

    public String getTotalDuration(){
        return getPresentationInfo("Total Duration");
    }

    public String getDateCreated() {
        return getPresentationInfo("Date created");
    }

    public String getLastModified() {
        return getPresentationInfo("Last modified");
    }

    public String getPublicURL() {
        return getPresentationInfo("Public URL");
    }

    private String getPresentationInfo(String field) {
        web.waitUntilElementAppearVisible(By.xpath(String.format("//*[span[contains(.,'%s')]]", field)));
        return web.findElement(By.xpath(String.format("//*[span[contains(.,'%s')]]", field))).getText().split(": ")[1].trim();

    }
}
