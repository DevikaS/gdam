package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * User: ruslan.semerenko
 * Date: 07.05.12 16:53
 */
public class AdbankTemplateFilesPage extends AdbankTemplateFilesWithFoldersPage {
    public AdbankTemplateFilesPage(ExtendedWebDriver web) {
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
    public AdbankTemplateFilesUploadPage clickUploadButton() {
        super.clickUploadButton();
        return new AdbankTemplateFilesUploadPage(web);
    }



}
