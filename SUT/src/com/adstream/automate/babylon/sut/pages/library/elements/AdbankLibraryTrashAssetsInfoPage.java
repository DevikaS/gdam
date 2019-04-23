package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.FlowPlayerPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

public class AdbankLibraryTrashAssetsInfoPage extends AdbankFilesInfoPage {

    public AdbankLibraryTrashAssetsInfoPage(ExtendedWebDriver web) {
        super(web);
    }

    public boolean isEditLinkPresent() {
        return web.isElementPresent(By.cssSelector(".icon-edit-folder + .editButton"));
    }

    public PopUpWindow clickRestoreButton() {
        web.click(By.xpath("//span[text()='Restore asset']"));
        web.sleep(500);
        return new PopUpWindow(this);
    }
}