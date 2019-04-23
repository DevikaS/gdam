package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesInfoPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import com.thoughtworks.selenium.webdriven.JavascriptLibrary;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 26.07.12
 * Time: 19:23
 */
public class AdbankProjectFileInfoPage extends AdbankFilesInfoPage {

    public AdbankProjectFileInfoPage(ExtendedWebDriver web) {
        super(web);
    }

    public String getProjectNameText() {
        String projectName = web.findElement(By.cssSelector(".line.plm.clearfix .title.h3")).getAttribute("innerHTML");
        return projectName.substring(0, projectName.indexOf("<")).trim();
    }

    public boolean isTabVisible(String tab) {
        return web.isElementVisible(By.xpath("//a/span[text()='" + tab + "']"));
    }
    public void clickOnTab(String tab) {
        web.click(By.xpath("//a/span[text()='" + tab + "']"));
    }
    public boolean isPreviewVisible() {
        return web.isElementVisible(By.cssSelector("[data-dojo-type='common.imageResizer'],[data-dojo-type='common.flowPlayer'],[data-dojo-type='common.pdfjs']"));
    }


}

