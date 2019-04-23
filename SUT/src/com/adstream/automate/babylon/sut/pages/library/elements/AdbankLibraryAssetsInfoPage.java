package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.ShareFilesPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 12.10.12
 * Time: 16:28
 */
public class AdbankLibraryAssetsInfoPage extends AdbankFilesInfoPage {
    private static final By reingestNotificationMessage = By.xpath("//div[contains(text(),'The re-ingest message has been sent')]");
    private static final By retranscodeNotificationMessage = By.xpath("//div[contains(text(),'The retranscode message has been sent')]");

    public AdbankLibraryAssetsInfoPage(ExtendedWebDriver web) {
        super(web);
    }

    public AddAssetToProjectPopUpWindow selectAddToProjectOption() {
        web.click(getAddToProjectOptionLocator());
        web.sleep(1000);
        return new AddAssetToProjectPopUpWindow(this);
    }

    public boolean isAddToProjectOptionVisible() {
        return web.isElementVisible(getAddToProjectOptionLocator());
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code starts
    public boolean isAddToWorkRequesttOptionVisible() {
        return web.isElementVisible(getAddToWorkRequestOptionLocator());
    }
    public boolean isAddToPresentationOptionVisible() {
        return web.isElementVisible(getAddToPresentationOptionLocator());
    }

    public boolean isSendToDeliveryOptionVisible() {
        return web.isElementVisible(getSendToDeliveryOptionLocator());
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends
    public boolean isAddAssetToProjectPopUpVisible() {
        return web.isElementVisible(getAddAssetToProjectPopUpTitleLocator());
    }

    public boolean isAddToProjectLinkVisible(String projectName) {
        return web.isElementVisible(getAddToProjectLinkLocator(projectName));
    }

    public void clickAddedToProjectLink(String projectName) {
        web.click(getAddToProjectLinkLocator(projectName));
        web.sleep(1000);
    }

    public PopUpWindow clickCancelButtom(){
        web.waitUntilElementAppearVisible(By.cssSelector("button[data-dojo-type='library.library.cancelAsset']"));
        web.findElement(By.cssSelector("button[data-dojo-type='library.library.cancelAsset']")).click();
        return new PopUpWindow(this);
    }

    public void triggerDownloadOriginalEventWithoutDownloading() {
        String linkId = web.findElement(By.cssSelector("[id*='download'][data-dojo-props*='master']")).getAttribute("id").trim();
        String script = String.format("var widjet = dijit.byId('%s');\n" +
                "dojo.publish(\"/babylon/file/download\", [{\n" +
                "\tfiles: [widjet.entity],\n" +
                "\tdownloadedAs: widjet.downloadedAs,\n" +
                "\tfileType: widjet.entity._documentType" +
                "}]);", linkId);

        web.getJavascriptExecutor().executeScript(script);
        web.sleep(2000);
    }

    public void triggerDownloadProxyEventWithoutDownloading() {
        String linkId = web.findElement(By.cssSelector("[id*='download'][data-dojo-props*='proxy']")).getAttribute("id").trim();
        String script = String.format("var widjet = dijit.byId('%s');\n" +
                "dojo.publish(\"/babylon/file/download\", [{\n" +
                "\tfiles: [widjet.entity],\n" +
                "\tdownloadedAs: widjet.downloadedAs,\n" +
                "\tfileType: widjet.entity._documentType" +
                "}]);", linkId);

        web.getJavascriptExecutor().executeScript(script);
        web.sleep(2000);
    }

    private By getAddToProjectLinkLocator(String projectName) {
        return By.linkText("Added to project " + projectName);
    }

    private By getAddAssetToProjectPopUpTitleLocator() {
        return By.xpath("//*[contains(@class,'popupWindow')][*[contains(@class,'windowHead')]//*[contains(text(),'Add Asset to Project')]]");
    }

    private By getAddToProjectOptionLocator() {
        return By.xpath("//span[.='Add to a project']");
    }

    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code starts
    private By getAddToWorkRequestOptionLocator() {
        return By.xpath("//span[.='Add to Work Request']");
    }
    private By getAddToPresentationOptionLocator() {
        return By.xpath("//span[.='Add to presentation']");
    }
    private By getSendToDeliveryOptionLocator() {
        return By.xpath("//span[.='Send to Delivery']");
    }
    // NGN-16213 -QAA: Global Admin defines Applications available to BU- By Geethanjali- code start

    public ShareFilesPopup clickShareFilesButton(){
        web.waitUntilElementAppearVisible(By.cssSelector(".button[id*='shareAsset']:not(.disabled)"));
        web.click(By.cssSelector(".button[id*='shareAsset']:not(.disabled)"));
        return new ShareFilesPopup(this);
    }

    public boolean presenceOfButton(String button){
        return web.isElementPresent(By.cssSelector(".button[id*='"+button+"']:not(.disabled)"));
    }

    public boolean isVideoVisible(){
        return web.isElementPresent(By.cssSelector("[id='player']"));
    }


    public void clickReingestButton(){
        web.waitUntilElementAppearVisible(By.cssSelector(".button[id*='reingest']:not(.disabled)"));
        web.click(By.cssSelector(".button[id*='reingest']:not(.disabled)"));
        web.click(By.xpath("//button[contains(text(),\"Yes\")]"));
    }

    public void clickRetranscodeButton(){
        web.waitUntilElementAppearVisible(By.cssSelector(".button[id*='retranscode']:not(.disabled)"));
        web.click(By.cssSelector(".button[id*='retranscode']:not(.disabled)"));
    }

    public boolean verifyMessage(String button){
        boolean found = false;
        try{
            if("reingest".equalsIgnoreCase(button))
               found= web.findElement(reingestNotificationMessage).isDisplayed();
            if("retranscode".equalsIgnoreCase(button))
                found= web.findElement(retranscodeNotificationMessage).isDisplayed();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return found;
    }

}
