package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 27.07.12
 * Time: 15:26

 */
public class AdbankTemplateTrashPage extends AdbankFilesPage {

    public AdbankTemplateTrashPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public boolean isFileVisible(String fileName) {
        return web.isElementVisible(By.xpath("//*[@class='file-info']//*[.='" + fileName + "']/ancestor::div[@class='wrapper']"));
    }
}
