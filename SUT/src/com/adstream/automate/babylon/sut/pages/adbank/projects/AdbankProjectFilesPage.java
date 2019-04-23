package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;


/**
 * User: Ruslan Semerenko
 * Date: 04.05.12 17:54
 */
public class AdbankProjectFilesPage extends AdbankFilesPage {
    public AdbankProjectFilesPage(ExtendedWebDriver web) {
        super(web);
    }

    public void enterFolderNameInSearchFoldersField(String folderName) {
        web.findElement(getSearchFoldersFieldByCssSelector()).sendKeys(folderName);
        web.findElement(getSearchFoldersFieldContainerByCssSelector()).click();   // need to data entry
    }

    private By getSearchFoldersFieldByCssSelector() {
        return By.cssSelector("input[id*='adbank_shared_search_folders']");
    }

    private By getSearchFoldersFieldContainerByCssSelector() {
        return By.cssSelector("div[class='search-container']");
    }

    @Override
    public AdbankProjectFilesUploadPage clickUploadButton() {
        super.clickUploadButton();
        return new AdbankProjectFilesUploadPage(web);
    }

    public boolean isShareFilesButtonActive() {
        return web.isElementPresent(By.xpath(".//*[contains(@class, 'share')]/span[text()='Share file(s)']"));
    }

    public int relatedFilesCount() {
        return web.findElements(By.cssSelector("[data-role=\"relatedFilesIcon\"]")).size();
    }

    public boolean isShareFilesButtonDisable() {
        return web.isElementPresent(By.xpath(".//*[contains(@class, 'disabled')]/span[text()='Share file(s)']"));
    }

    public void waitUntillCopyMovePopUpWillBeClosed(){
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(By.xpath("//div[@data-dojo-type='adbank.files.waitingCopyFinish']")));
    }

    public int getCountOfTotalProject() {
        return Integer.parseInt(web.findElement(By.cssSelector("[data-id='total-count']")).getText());
    }

    public FileColumnMode showColumnMode() {
        web.click(By.cssSelector("[data-switch-mode='columns']"));
        return new FileColumnMode();
    }

    public class FileColumnMode {
        public FileColumnMode() {
            web.waitUntilElementAppearVisible(By.className("folderColumns"));
            Common.sleep(1000);
        }

        public void selectFolder(String folderName) {
            web.click(By.cssSelector(String.format(".//*[@title='%s']/../..", folderName)));
        }

        public void selectFile(String fileName) {
            web.click(By.xpath(String.format(".//*[@id='folder.id']//*[@title='%s']/../../..//div[contains(@ng-repeat, '_cm.common.name')]", fileName)));
        }

        public boolean isColumnMode() {
            return web.isElementPresent(By.cssSelector("[id='folder.id']"));
        }
    }
}
