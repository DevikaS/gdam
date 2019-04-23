package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileViewPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 12.12.12
 * Time: 12:38
 */
public class AdbankFileVersionHistoryPage extends AdbankFileViewPage {
    public AdbankFileVersionHistoryPage(ExtendedWebDriver web) {
        super(web);
    }

    public String getFileTitleOnTheVersionHistorePage() {
        return web.findElement(By.cssSelector(".unit.plm .h4")).getText();
    }

    public String getVersionOnTheVersionHistoryPage() {
        return web.findElement(By.xpath("//*[@class='file-history-item clearfix size1of1 current']//*[@class='h5 inline-display version-number']")).getText();
    }

    public boolean isDownloadOriginalLinkVisible() {
        return web.isElementPresent(By.xpath("//a[contains(text(),'Download Original')]")) && web.isElementVisible(By.xpath("//a[contains(text(),'Download Original')]"));
    }

    private String getRevisionContainer(int versionNumber) {
        return String.format("//div[contains(@data-dojo-props, 'versionNumber:%s')]", versionNumber - 1);
    }

    public boolean isDownloadProxyLinkVisibleForRevision(int versionNumber) {
        By downloadPreviewlocator = By.xpath(getRevisionContainer(versionNumber) + "//a[contains(text(), 'Download Proxy')]");
        return web.isElementPresent(downloadPreviewlocator) && web.isElementVisible(downloadPreviewlocator);
    }

    public boolean isDownloadOriginalLinkVisibleForRevision(int versionNumber) {
        By downloadOriginalLocator = By.xpath(getRevisionContainer(versionNumber) + "//a[contains(text(), 'Download Original')]");
        return web.isElementPresent(downloadOriginalLocator) && web.isElementVisible(downloadOriginalLocator);
    }

    public void clickDownloadOriginalButton(int versionNumber) {
        By downloadOriginalLocator = By.xpath(getRevisionContainer(versionNumber) + "//a[contains(text(), 'Download Original')]");
        web.click(downloadOriginalLocator);
    }

    public void clickDownloadProxyButton(int versionNumber) {
        By downloadPreviewlocator = By.xpath(getRevisionContainer(versionNumber) + "//a[contains(text(), 'Download Proxy')]");
        web.click(downloadPreviewlocator);
    }

    public boolean isPreviewForRevisionVisible(String fileId) {
        By previewRevisionLocator = By.xpath("//img[contains(@src,'fileId=" + fileId + "')]");
        return web.isElementPresent(previewRevisionLocator);
    }

    public String getRevisionOriginatorUsername(int versionNumber) {
        By originatorUsernameLocator = By.xpath(getRevisionContainer(versionNumber) + "//a[contains(@class,'no-decoration p')]");
        return web.findElement(originatorUsernameLocator).getText();
    }

    public void clickOnRevisionButton(String revision) {
        web.findElement(By.xpath("//*[text()='V" + revision + "']")).click();
    }

    public String getRevisionOriginatorAgency(int versionNumber) {
        By originatorAgencyLocator = By.xpath(getRevisionContainer(versionNumber) + "//span[@class='h5 bold']");
        return web.findElement(originatorAgencyLocator).getText();
    }

    public boolean isFileMarkedAsCurrentVersion(int versionNumber) {
        By currentVersionLocator = By.xpath(getRevisionContainer(versionNumber) + "//span[text()='Current version']");
        return web.isElementPresent(currentVersionLocator) && web.isElementVisible(currentVersionLocator);
    }

    public String getRevisionApprovalStatusMessage(int versionNumber) {
        By locator = By.xpath(String.format("%s//*[contains(@class, 'message-status')]", getRevisionContainer(versionNumber)));
        return web.findElement(locator).getText().trim();
    }
}
