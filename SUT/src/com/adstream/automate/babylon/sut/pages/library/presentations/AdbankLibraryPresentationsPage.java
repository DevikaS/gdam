package com.adstream.automate.babylon.sut.pages.library.presentations;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddNewPresentationPopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.SendPresentationPopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.BaseLibraryPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 18:14

 */
public class AdbankLibraryPresentationsPage extends BaseLibraryPage {

    public AdbankLibraryPresentationsPage(ExtendedWebDriver web) {
        super(web);
    }

    public List<String> getReelsItemsList() {
        if (!web.isElementPresent(By.cssSelector(".tree-item.reel-item"))) return new ArrayList<>();
        return web.findElementsToStrings(By.cssSelector(".tree-item.reel-item"));
    }

    public AddNewPresentationPopUpWindow clickAddToPresentationButton() {
        web.click(By.cssSelector(".button.valign-middle.mrs[data-dojo-type*='addNewPresentationButton']"));
        return new AddNewPresentationPopUpWindow(this);
    }

    public AdbankLibraryPresentationsPage clickSendPresentationButton() {
        web.click(getSendPresentationButtonLocator());
        web.sleep(500);
        return this;
    }

    public SendPresentationPopUpWindow clickSendToUserButton() {
        web.click(getSendToUserButtonLocator());
        return new SendPresentationPopUpWindow(this);
    }

    public SendPresentationPopUpWindow clickSendToLibraryTeamButton() {
        web.click(getSendToLibraryTeamButtonLocator());
        return new SendPresentationPopUpWindow(this);
    }

    public void scrollDownToFooter() {
        web.scrollToElement(web.findElement(By.cssSelector(".footer.clearfix")));
        web.sleep(2000);
    }

    public int getItemsCount() {
        return web.findElementsToStrings(By.cssSelector("[id*='library_presentations_reelListItem_']")).size();
    }

    public void clickLinkActivity(String link) {
        web.click(By.linkText(link));
    }

    public boolean isSendToUserButtonVisible() {
        By locator = getSendToUserButtonLocator();
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isSendToLibraryTeamButtonVisible() {
        By locator = getSendToLibraryTeamButtonLocator();
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public PopUpWindow clickDeleteButton() {
        web.click(By.cssSelector(".button[data-role='delete']"));
        return new PopUpWindow(this);
    }

    public void clickAllPresentations() {
        web.click(By.cssSelector(".tree-node-head span"));
    }

    public void selectPresentationFromSearchPopup(String presentationPage) {
        web.click(By.xpath(String.format("//div[contains(@class, 'dijitComboBoxMenuPopup')]//div[@item and .=\"%s\"]", presentationPage)));
    }

    public List<String> getPresentationsList() {
        return web.findElementsToStrings(By.cssSelector(".cell-content a"));
    }

    public List<String> getPresentationsList(String presentationState) {
        if (presentationState.equalsIgnoreCase("selected")) {
            return web.findElementsToStrings(By.xpath("//*[contains(@id,'reelListItem')][contains(@class,'selected')]"));
        } else {
            return web.findElementsToStrings(By.xpath("//*[contains(@id,'reelListItem')][not(contains(@class,'selected'))]"));
        }
    }

    public List<String> getPresentationSearchResultItems() {
        By locator = By.cssSelector(".dijitComboBoxMenuPopup [item]");
        if (web.isElementPresent(locator))
            return web.findElementsToStrings(locator);
        return new ArrayList<>();
    }

    public String getActiveTabName() {
        return web.findElement(By.cssSelector(".tab .active .p")).getText().trim();
    }

    public String getPresentationName() {
        return web.findElement(By.cssSelector(".icon-reels.breadcrumb")).getText().trim();
    }

    public String getPresentationDateCreated(String presentationName) {
        return getPresentationFieldValue(presentationName, "_created");
    }

    public String getPresentationDuration(String presentationName) {
        return getPresentationFieldValue(presentationName, "assets.duration");
    }

    public String getPresentationViews(String presentationName) {
        return getPresentationFieldValue(presentationName, "counter.view.views");
    }

    public void switchTab(String tabName) {
        if (!getActiveTabName().equalsIgnoreCase(tabName)) {
            web.click(By.xpath(String.format("//*[contains(@class,'tab')]//*[contains(@class,'p')][normalize-space(text())='%s']", tabName)));
            web.sleep(2000);
        } else {
            web.navigate().refresh();
        }
    }

    protected By getSendPresentationButtonLocator() {
        return By.xpath("//*[normalize-space(text())='Send presentation']");
    }

    protected By getSendToUserButtonLocator() {
        return By.xpath("//*[normalize-space(text())='Send to User']");
    }

    protected By getSendToLibraryTeamButtonLocator() {
        return By.xpath("//*[normalize-space(text())='Send to Library team']");
    }

    protected String getColumnClass(String columnName) {
        String headerClass = web.findElement(By.cssSelector(String.format("[fieldname='%s']", columnName))).getAttribute("class");
        return headerClass.replaceAll(".+(column-\\d+).+", "$1");
    }

    private String getPresentationFieldValue(String presentationName, String fieldName) {
        String locator = String.format("//div[@data-type='tableRow' and descendant::a[normalize-space(text())='%s']]/div[contains(@class, '%s')]",
            presentationName, getColumnClass(fieldName));
        return web.findElement(By.xpath(locator)).getText().trim();
    }
}
