package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.winium.ftp.desktop.WiniumFTPRemote;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.adstream.automate.utils.Common;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.winium.DesktopOptions;
import org.openqa.selenium.winium.WiniumDriver;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;


import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 15.09.12
 * Time: 18:01
 */
public class AdbankFileViewPage extends AdbankFilesPage {

    private DojoSelect selectRevision;
    public AdbankFileViewPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        //web.waitUntilElementAppearVisible(By.cssSelector(".file-view, .pdf-preview"));
        web.waitUntilElementAppear(By.cssSelector(".file-view, .pdf-preview"));
    }

    @Override
    public void isLoaded() throws Error {
        //assertTrue(web.isElementVisible(By.cssSelector(".file-view, .pdf-preview")));
        assertTrue(web.isElementPresent(By.cssSelector(".file-view, .pdf-preview")));
    }

    public FlowPlayerProxy getFlowPlayer() {
        return new FlowPlayerPage(web).getPlayer();
    }

    public List<String> getAllTabLinksNames() {
        return web.findElementsToStrings(By.cssSelector(".nav-tabs a .p"));
    }

    public List<String> getValuesFromSelectVersionComboBox() {
        selectRevision = new DojoSelect(this, By.className("file-info-select"));
        Pattern divTag = Pattern.compile("<span([^>]+)>(.+?)</span>");
        List<String> values = new ArrayList<>();
        String tag = "<span";
        String labelArray =null;
        for (String label : selectRevision.getLabels()) {
            if (label.contains("<span")) {
                labelArray = label.substring(label.lastIndexOf(tag));
                Matcher matcherTag = divTag.matcher(labelArray);
                if (matcherTag.find()) {
                    label = matcherTag.group(2);
                }
            }
            values.add(label);
        }
        return values;
    }

    public String getCurrentFileId() {
        String pageLink = web.getCurrentUrl();
        int start = pageLink.indexOf("/files/") + "/files/".length();
        int end = pageLink.indexOf("/", start);
        return pageLink.substring(start, end);
    }

    public List<String> getAllTabsFromPage() {
        return web.findElementsToStrings(By.cssSelector(".nav-tabs a"));
    }

    //QA-442 Edit Office doc feature
    public boolean isEditDocumentButtonVisible() {
        web.sleep(500);
        return web.isElementPresent(getEditDocumentButtonLocator());
    }

    public void clickEditDocumentButton() {
        web.click(getEditDocumentButtonLocator());
        web.sleep(1000);
    }

    public String getDownloadingFileId(String button)
    {
        String buttonId;
        String script;
        if (button.equalsIgnoreCase("Original")) {
            buttonId = web.findElement(getDownloadOriginalButtonLocator()).getAttribute("id");
            //script = String.format("return dojo.dijit.registry.byId('%s').data.master.fileID;", buttonId);
            script = String.format("return dojo.dijit.registry.byId('%s').data.fileID;", buttonId);
        } else if (button.equalsIgnoreCase("Preview")) {
            buttonId = web.findElement(getDownloadProxyButtonLocator()).getAttribute("id");
            script = String.format("return dojo.dijit.registry.byId('%s').data.fileID;", buttonId);
        } else {
            throw new IllegalArgumentException(String.format("Unknown download button: '%s'", button));
        }

        return (String) web.getJavascriptExecutor().executeScript(script);
    }

    public WebElement getDownloadingLocators(String button) {
        WebElement buttonLoc;

        if (button.equalsIgnoreCase("Original")) {
            buttonLoc = web.findElement(getDownloadOriginalButtonLocator());

        } else if (button.equalsIgnoreCase("Preview")) {
            buttonLoc = web.findElement(getDownloadProxyButtonLocator());

        } else {
            throw new IllegalArgumentException(String.format("Unknown download button: '%s'", button));
        }

        return (buttonLoc);
    }
    public boolean isNavigationTabPresent(String tabName) {
        return web.isElementPresent(getTabLinkLocatorByCssSelector(tabName));
    }

    public boolean isUploadNewVersionButtonVisible() {
        web.sleep(500);
        web.waitUntilElementAppear(By.xpath("//div[@data-dojo-type='adbank.files.top_menu_control']//span[contains(.,'Upload')]"));
        web.findElement(By.xpath("//div[@data-dojo-type='adbank.files.top_menu_control']//span[contains(.,'Upload')]")).click();
        web.waitUntilElementAppear(getUploadNewVersionButtonLocator());
        return web.isElementVisible(getUploadNewVersionButtonLocator());
    }

    public boolean isUploadNewVersionButtonPresent() {
        web.sleep(500);
        return web.isElementPresent(getUploadNewVersionButtonLocator());
    }

    public boolean isButtonVisibleOnUploadDropdownOnProjectsFilesPage(String button) {
        web.waitUntilElementAppear(By.xpath("//div[@data-dojo-type='adbank.files.top_menu_control']//span[contains(.,'Upload')]"));
        web.findElement(By.xpath("//div[@data-dojo-type='adbank.files.top_menu_control']//span[contains(.,'Upload')]")).click();
        web.waitUntilElementAppear(getButtonLocatorOnUploadDropdownOnProjectsFilesPage(button));
        return web.isElementVisible(getButtonLocatorOnUploadDropdownOnProjectsFilesPage(button));
    }

    public boolean isVersionsDropDownVisible() {
        web.sleep(500);
        return web.isElementVisible(getVersionsDropDownVisibleLocator());
    }

    public boolean isProxyForVideoVisible() {
        return web.isElementPresent(By.cssSelector("#player"));
    }

    public boolean isPDFLoaded() {
        return web.isElementVisible(By.cssSelector("#the-canvas"));
    }

    //QA-442 Edit Office doc feature
    private By getEditDocumentButtonLocator() {
        return By.xpath("//*[contains(@class, 'button') and text()='Edit Document']");
    }

    public boolean isDownloadOriginalButtonVisible() {
        web.sleep(500);
        return web.isElementVisible(getDownloadOriginalButtonLocator());
    }

    public boolean isDownloadMasterUsingNVergeButtonVisible() {
        web.sleep(500);
        return web.isElementVisible(getDownloadMasterUsingNVergeButtonLocator());
    }

    public boolean isDownloadDownloadLowResPDFButtonVisible() {
        web.sleep(500);
        return web.isElementVisible(getDownloadLowAsPdfButtonLocator());
    }

    public boolean isDownloadProxyButtonVisible() {
        web.sleep(500);
        return web.isElementVisible(getDownloadProxyButtonLocator());
    }

    public boolean isDownloadStoryBoardButtonVisible() {
        web.sleep(500);
        return web.isElementVisible(getDownloadStoryBoardButtonLocator());
    }

    public boolean isDownloadButtonVisibleOnMenu() {
        web.sleep(500);
        return web.isElementVisible(getDownloadButtonLocator());
    }

    public boolean isActivityTabPresent() {
        return web.isElementVisible(By.cssSelector(".nav-tabs a[href*='activity']"));
    }

    public boolean isUsageRightsTabPresent() {
        return web.isElementVisible(By.cssSelector(".nav-tabs a[href*='rights']"));
    }
    //QA358-Frame Grabber Code changes starts
    public boolean isFramesTabPresent() {
        return web.isElementVisible(By.cssSelector(".nav-tabs a[href*='frames']"));
    }
    //QA358-Frame Grabber Code changes Ends
    public boolean isVersionHistoryTabPresent() {
        return web.isElementVisible(By.cssSelector(".nav-tabs a[href*='history']"));
    }

    public boolean isPlayerAvailable() {
        return new FlowPlayerPage(web).isPlayerReady();
    }

    public boolean isPreviewAvailable(String name) {
        boolean condition = false;
        if (name.contains(".mov") || name.contains(".wmv") || name.contains(".mp4")) {
            condition = new FlowPlayerPage(web).isPlayerReady();
        } else if (name.contains(".png")||name.contains(".gif")||name.contains(".jpg")||name.contains(".ai")||name.contains(".psd")){
            condition = web.isElementPresent(By.cssSelector("[src*='/media/preview?']"));
    } else {
            condition = web.findElement(By.cssSelector("#loading")).getAttribute("style").contains("display: none;");
        }
        return condition;
    }

    public boolean isUsageExpiredLabelAvailable() {
        return web.isElementVisible(By.cssSelector("[data-role='fileInformBlock'] .usage_term"));
    }

    public void selectNavigationTab(String tabName) {
        web.findElement(getTabLinkLocatorByCssSelector(tabName)).click();
        web.sleep(1000);
    }

    public void setFileVersion(String version) {
        selectRevision = new DojoSelect(this, By.className("file-info-select"));
        selectRevision.selectByVisibleText(version);
    }

    public void triggerDownloadEventWithoutDownloading(String fileId, boolean isMaster) {
        JavascriptExecutor js = web.getJavascriptExecutor();
        String downloadAs = isMaster ? "master" : "preview";
        String s = String.format("dojo.publish('/babylon/file/download', [{files: [{_id:'%s'}], downloadedAs: '%s'}]);", fileId, downloadAs);
        js.executeScript(s);
        // wait for indexing
        web.sleep(5000);
    }

    @Deprecated
    public void clickDownloadOriginalButton() {
        web.click(getDownloadOriginalButtonLocator());
        web.sleep(1000);
    }

    @Deprecated
    public void clickDownloadProxyButton() {
        web.click(getDownloadProxyButtonLocator());
        web.sleep(1000);
    }

    public void clickImageButtonForExpandDropdown() {
        web.click(By.cssSelector(".relative.file-dropdown"));
    }

    public ApprovalCommentPopUp clickApprovalButton(String buttonName) {
        if (buttonName.equalsIgnoreCase("approve")) {
            web.click(By.cssSelector(".button.green"));
        } else if (buttonName.equalsIgnoreCase("reject")) {
            web.click(By.cssSelector(".button.orange"));
        }
        return new ApprovalCommentPopUp(this);
    }

    public boolean isApprovalsButtonsVisible() {
        return web.isElementVisible(By.cssSelector(".files_check_approval .button.green"))
                && web.isElementVisible(By.cssSelector(".files_check_approval .button.orange"));
    }

    public boolean isAnnotationButtonVisible(){
        return web.isElementPresent(getAnnotationButtonLocator())
                && web.isElementVisible(getAnnotationButtonLocator());
    }

    public void clickAnnotationButton() {
        web.click(getAnnotationButtonLocator());
        web.sleep(3000);
    }

    public boolean isMessagePresentInApprovalsStage(String message) {
        By locator = By.xpath(String.format("//*[@data-dojo-type='adbank.files.approvals'][normalize-space()='%s']", message));
        return web.isElementVisible(locator) && web.isElementVisible(locator);
    }

    public AdbankFileApprovalsPage selectApprovalsTab() {
        web.click(By.className("approvals-tab"));
        Common.sleep(1000);
        return new AdbankFileApprovalsPage(web);
    }

    public boolean isCancelButtonVisible() {
        web.sleep(500);
        return web.isElementVisible(getCancelButtonLocator());
    }

    public String getDefaultProxyText(){
        return  web.findElement(By.cssSelector(".file-info-download div[data-dojo-props*='downloadedAs:\\'proxy\\'']")).getText();
    }

    public String getCustomProxyText(){
        return  web.findElement(By.cssSelector(".file-info-download div[data-dojo-props*='downloadedAs:\\'preview\\'']")).getText();
    }

    private By getDownloadOriginalButtonLocator() {
        return By.cssSelector(".file-info-download div[data-dojo-props*='downloadedAs:\\'master\\'']");
    }

    private By getDownloadProxyButtonLocator() {
        return By.cssSelector(".file-info-download div[data-dojo-props*='downloadedAs:\\'preview\\''],.file-info-download div[data-dojo-props*='downloadedAs:\\'proxy\\'']");
    }

    private By getDownloadMasterUsingNVergeButtonLocator() {
        return By.cssSelector("[data-dojo-type='common.nVergeDownload']");
    }

    private By getDownloadLowAsPdfButtonLocator() {
        return By.cssSelector("[data-dojo-props*=\"downloadedAs:'filePdf'\"]");
    }

    private By getTabLinkLocatorByCssSelector(String tabName) {
        return By.cssSelector(".nav-tabs>a[href*='" + tabName + "']>span");
    }

    private By getUploadNewVersionButtonLocator() {
        return By.xpath("//tbody[@data-dojo-attach-point='containerNode']/tr[@role='menuitem']//span[contains(.,'Upload new version')]");

    }

    private By getButtonLocatorOnUploadDropdownOnProjectsFilesPage(String button) {
         return By.xpath("//tbody[@data-dojo-attach-point='containerNode']/tr[@role='menuitem']//span[contains(.,'" + button + "')]");
    }

    private By getVersionsDropDownVisibleLocator() {
        return By.cssSelector(".file-info-select.undefined");
    }

    private By getAnnotationButtonLocator() { return By.cssSelector("[data-dojo-type='adbank.files.appnotate']");}


    private By getCancelButtonLocator() {
        return By.cssSelector("button[data-dojo-type='library.library.cancelAsset']");
    }

    private By getDownloadStoryBoardButtonLocator() {
        return By.cssSelector("[data-dojo-type='common.downloadStoryboards']");
    }
}