package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.Select;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by sobolev-a on 23.06.2014.
 */
public class AdbankProjectFileRelatedFilesPage extends AdbankFileViewPage {

    private ProjectRelatedFilesPopUp projectRelatedFilesPopUp;

    public AdbankProjectFileRelatedFilesPage(ExtendedWebDriver web) {
        super(web);
        projectRelatedFilesPopUp = new ProjectRelatedFilesPopUp(this);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(By.id("relatedFiles"));
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.id("relatedFiles")));
    }

    public ProjectRelatedFilesPopUp clickLinkToExistingButton() {
        web.click(getLinkToExistButtonLocator());
        Common.sleep(1000);
        return new ProjectRelatedFilesPopUp(this);
    }

    public void typeRelatedFileName(String fileName) {
        projectRelatedFilesPopUp.typeRelatedFileName(fileName);
        Common.sleep(1000);
    }

    public void selectRelatedFiles(String file) {
        projectRelatedFilesPopUp.selectFollowingRelatedFiles(file);
    }

    public int getCountOfRelatedFiles() {
        return web.findElements(By.cssSelector(".ptm .rows-content .pointer")).size();
    }

    public void clickSaveButton() {
        projectRelatedFilesPopUp.clickSaveButton();
    }

    public boolean isLinkToExistButtonExist() {
        return web.isElementPresent(getLinkToExistButtonLocator()) && web.isElementVisible(getLinkToExistButtonLocator());
    }

    public boolean isDestinationType(String destinationName) {
        return web.isElementVisible(By.cssSelector("[title=" + destinationName + "]"));
    }

    public boolean isRelatedType(String destinationName) {
        return web.isElementVisible(By.xpath(".//*[contains(@class, 'rows-content')]//*[@class='unit cell size1of5'][3][contains(.,'" + destinationName +"')]"));
    }

    public void selectFileBecomeAsType(String roleType) {
        Select select = new Select(web.findElement(By.cssSelector("select.angular-ui-select")));
        select.selectByVisibleText(roleType);
    }

    public void deleteRelatedFile(String file) {
        web.click(getRelatedFileDeleteButtonLocator(file));
        new ConfirmRemovePopUp(this).clickAction();
    }

    public boolean isRelatedFileDeleteButtonExist(String file) {
        return web.isElementPresent(getRelatedFileDeleteButtonLocator(file)) && web.isElementVisible(getRelatedFileDeleteButtonLocator(file));
    }

    /**
     * @return all names of related files from table
     */
    public List<String> getRelatedFileNames() { return web.findElementsToStrings(getRelatedFileNameLocator()); }

    /**
     * @return all project names from table
     */
    public List<String> getAllProjectNames() { return web.findElementsToStrings(getProjectNameLocator()); }

    /**
     * @return all related files status such as: Parent, Child, Master, Version, Other
     */
    public List<String> getAllRelatedFilesStatus() { return web.findElementsToStrings(getIsRelatedAsLocator()); }

    private By getRelatedFileNameLocator() { return By.cssSelector(".unit.cell.size1of5 a.no-decoration.ng-isolate-scope"); }

    private By getProjectNameLocator() { return By.cssSelector(".no-decoration.ng-binding"); }

    private By getIsRelatedAsLocator() { return By.xpath(".//*[contains(@class, 'rows-content')]//*[@class='unit cell size1of5'][3]"); }



    private By getLinkToExistButtonLocator() {
        return By.cssSelector("[data-dojo-type='common.buttonlinkToExisting'] button");
    }

    public boolean isRelatedFileNotExist(String fileName) {
        return web.isElementPresent(getRelatedFileLocator(fileName)) && web.isElementVisible(getRelatedFileLocator(fileName));
    }

    private By getRelatedFileDeleteButtonLocator(String fileName) {
        return By.xpath(String.format("//div[contains(class, rows-content)]//span[normalize-space(text())='%s']/ancestor::div[3]//span[@class='icon-remove row-remove ng-scope']", fileName));
    }

    private By getRelatedFileLocator(String fileName) {
        return By.xpath(String.format("//div[contains(class, rows-content)]//span[normalize-space(text())='%s']/ancestor::div[3]", fileName));
    }
}