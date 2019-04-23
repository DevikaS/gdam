package com.adstream.automate.babylon.sut.pages.file.preview;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 25.12.13
 * Time: 12:00
 */
public class FilePreviewPage extends BasePage {

    public FilePreviewPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("body.file .file-view,body.file .pdf-preview"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector("body.file .file-view,body.file .pdf-preview")));
    }

    public boolean isDownloadOriginalButtonVisible() {
        return web.isElementPresent(getDownloadOriginalButtonLocator()) && web.isElementPresent(getDownloadOriginalButtonLocator());
    }

    public boolean isDownloadProxyButtonVisible() {
        return web.isElementPresent(getDownloadProxyButtonLocator()) && web.isElementPresent(getDownloadProxyButtonLocator());
    }

    public List<String> getTabNames() {
        return web.findElementsToStrings(By.cssSelector(".nav-tabs a:not(.none)"));
    }

    public FilePreviewCommentsPage clickCommentsTab() {
        web.click(generateTabLocator("comments"));
        return new FilePreviewCommentsPage(web);
    }

    public void triggerDownloadOriginalEventWithoutDownloading() {
        JavascriptExecutor js = web.getJavascriptExecutor();
        String script = "var widget = dijit.getEnclosingWidget(arguments[0]);\n" +
                "dojo.publish('/babylon/file/download', [ {\n" +
                "\tfiles: [widget.entity],\n" +
                "\tdownloadedAs: widget.downloadedAs,\n" +
                "\tfileType: widget.entity._documentType"+
                "}])";
        js.executeScript(script, web.findElement(getDownloadOriginalButtonLocator()));
        web.sleep(5000);
    }

    public void triggerDownloadProxyEventWithoutDownloading() {
        JavascriptExecutor js = web.getJavascriptExecutor();
        String script = "var widget = dijit.getEnclosingWidget(arguments[0]);\n" +
                "dojo.publish('/babylon/file/download', [ {\n" +
                "\tfiles: [widget.entity],\n" +
                "\tdownloadedAs: widget.downloadedAs,\n" +
                "\tfileType: widget.entity._documentType" +
                "}])";
        js.executeScript(script, web.findElement(getDownloadProxyButtonLocator()));
        web.sleep(5000);
    }

    protected By generateTabLocator(String tabName) {
        return By.cssSelector("a[href$='" + tabName + "']");
    }

    private By getDownloadOriginalButtonLocator() {
        return By.xpath("//*[@data-dojo-type='common.download'][contains(.,'Download Original')]");
    }

    private By getDownloadProxyButtonLocator() {
        return By.xpath("//*[@data-dojo-type='common.download'][contains(.,'Download Proxy')]");
    }
}