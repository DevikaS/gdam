package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesInfoPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 27.07.12
 * Time: 12:34
 */
public class AdbankTemplateFileInfoPage extends AdbankFilesInfoPage {
    public AdbankTemplateFileInfoPage(ExtendedWebDriver web) {
        super(web);
    }

    public String getTemplateNameText() {
        return web.findElement(By.cssSelector(".line.plm.clearfix .title.h3")).getText();
    }

    public String getTemplateNameOnDropdownTreeContainer() {
        return web.findElement(By.cssSelector(".overflow-hidden.size1of1")).getText();
    }

}
