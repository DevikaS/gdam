package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 27.07.12
 * Time: 10:13

 */
public class AdbankProjectTrashPage extends AdbankFilesPage {

    public AdbankProjectTrashPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-type='tableRowsContent']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("[data-type='tableRowsContent']")));
    }

    @Override
    public boolean isFileVisible(String fileName) {
        return web.isElementVisible(By.xpath("//*[@class='file-info']//*[.='" + fileName + "']/ancestor::div[@class='wrapper']"));
    }
}
