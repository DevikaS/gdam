package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AddNewFrameGrabberPopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileUsageRightsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.ArrayList;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public class AdbankLibraryAssetFramesPage extends AdbankLibraryAssetsInfoPage {
    public AdbankLibraryAssetFramesPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(
                By.cssSelector("[data-dojo-type=\"common.initAngular\"]"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(
                By.cssSelector("[data-dojo-type=\"common.initAngular\"]")));
    }

    public By getCaptureFrameButtonLocator() {
        return By.cssSelector(".button.mls.valign-middle.ng-binding");
    }

    public AddNewFrameGrabberPopUpWindow clickCaptureFrameButton() {
        web.click(getCaptureFrameButtonLocator());
        Common.sleep(3000);
        return new AddNewFrameGrabberPopUpWindow(this);
    }


    public int grabbedFrameCount() {
        return web.findElements(By.cssSelector(".still.ng-scope")).size();
    }

    public boolean framePreview() {
        int framecount = web.findElements(By.cssSelector(".still.ng-scope")).size();
        ArrayList<WebElement> framePreviews = new ArrayList<WebElement>(web.findElements(By.cssSelector(".still-frame>a>img")));
        if (!framePreviews.isEmpty()) {
            return framePreviews.get(0).isDisplayed();
        } else {
            return false;
        }
    }

    public boolean downloadFrame() {
        ArrayList<WebElement> availableframes = new ArrayList<WebElement>(web.findElements(By.cssSelector(".still.ng-scope")));
        if (!availableframes.isEmpty()) {
            availableframes.get(0).click(

            );
        }
        WebElement downloadFrame = web.findElement(By.cssSelector(".stills-container  div:nth-child(1) ul li:nth-child(2)"));
        downloadFrame.click();
        Common.sleep(1000);
        Robot rb = null;
        try {
            rb = new Robot();
            rb.keyPress(KeyEvent.VK_DOWN);
            rb.keyRelease(KeyEvent.VK_DOWN);
            rb.keyPress(KeyEvent.VK_ENTER);
            rb.keyRelease(KeyEvent.VK_ENTER);
            return true;
        } catch (AWTException e) {
            e.printStackTrace();
            return false;
        }

    }
    public void removeFrame(){
        ArrayList<WebElement> availableframes = new ArrayList<WebElement>(web.findElements(By.cssSelector(".still.ng-scope")));
        if (!availableframes.isEmpty()) {
            availableframes.get(0).click(

            );
        }
        WebElement removeFrame = web.findElement(By.cssSelector(".stills-container  div:nth-child(1) ul li:nth-child(3)"));
        removeFrame.click();
        PopUpWindow confirmationPopup = new PopUpWindow(this);
        confirmationPopup.action.click();
    }

    public boolean verifyFrameTimecodeOnHeader(int count){
        String timeCode = web.findElement(By.xpath(String.format("//div[@class='still ng-scope'][" +count+ "]//*[@class='frame-header']/div"))).getText();
        return ((!timeCode.matches(".*[a-zA-Z].*"))&(timeCode.matches("[0-9:]*")));
    }
}
