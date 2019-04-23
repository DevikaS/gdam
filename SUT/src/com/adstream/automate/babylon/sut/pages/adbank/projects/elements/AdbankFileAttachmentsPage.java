package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import java.util.List;

/**
 * Created by sobolev-a on 22.05.2014.
 */
public class AdbankFileAttachmentsPage extends AdbankFileViewPage  {

    public AdbankFileAttachmentsPage(ExtendedWebDriver web) {
        super(web);
    }


    public By getAttachmentsButtonLocator() { return By.cssSelector("[ng-controller='attachedFilesTabUploadWindowController']"); }

    public int getCountOfAttachmentFiles() { return web.findElements(By.cssSelector(".rows-content .row")).size(); }

    public boolean isDownloadButtonExist(String fileName) {
        return web.isElementPresent(By.xpath(String.format("//*[normalize-space(text())='%s']/..//../*[contains(@class,'unit')][5]/..//span[1]", fileName)));
    }

    public AdbankAttachmentsFileEditPopUp clickByEditButton(String fileName) {
        web.click(By.xpath(String.format("//*[normalize-space(text())='%s']/..//../*[contains(@class,'unit')][5]/..//span[2]", fileName)));
        return new AdbankAttachmentsFileEditPopUp(this, "Edit attached file");
    }

    public AdbankAttachmentsFileEditPopUp clickByDeletetButton(String fileName) {
        web.click(By.xpath(String.format("//*[normalize-space(text())='%s']/..//../*[contains(@class,'unit')][5]/..//span[3]", fileName)));
        return new AdbankAttachmentsFileEditPopUp(this, "Confirm");
    }

    public void clickByDownloadButton(String fileName) {
        web.click(By.xpath(String.format("//*[normalize-space(text())='%s']/..//../*[contains(@class,'unit')][5]/..//span[1]", fileName)));

    }

    public List<String> getAttachedFilesListName() {
        if (web.isElementPresent(getCheckAttachedFileLocator())) {
            return web.findElementsToStrings(getCheckAttachedFileLocator());
        }
        return null;
    }

    private By getCheckAttachedFileLocator() {
        return By.xpath("//*[contains(@class, 'rows-content')]//div[contains(@class, 'unit')][1]/div[normalize-space(text())]");
    }

}
