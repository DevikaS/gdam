package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AddNewFrameGrabberPopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.RemovingPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Geethanjali.K on 27.04.2016.
 */
public class AdbankFileFramesPage extends AdbankFileViewPage  {

    public AdbankFileFramesPage(ExtendedWebDriver web) {
        super(web);
    }


    public By getCaptureFrameButtonLocator() { return By.cssSelector(".button.mls.valign-middle.ng-binding"); }

    public AddNewFrameGrabberPopUpWindow clickCaptureFrameButton() {
        web.click(getCaptureFrameButtonLocator());
        Common.sleep(3000);
        return new AddNewFrameGrabberPopUpWindow(this);
    }


    public int grabbedFrameCount(){
        return web.findElements(By.cssSelector(".still.ng-scope")).size();
    }

    public boolean framePreview(){
        int framecount = web.findElements(By.cssSelector(".still.ng-scope")).size();
        ArrayList<WebElement> framePreviews = new ArrayList<WebElement>(web.findElements(By.cssSelector(".still-frame>a>img")));
        if (!framePreviews.isEmpty()) {
            return framePreviews.get(0).isDisplayed();
            }else {
            return false;
        }
        }

    public boolean downloadFrame() {
        ArrayList<WebElement> availableframes = new ArrayList<WebElement>(web.findElements(By.cssSelector(".still.ng-scope")));
        if (!availableframes.isEmpty()) {
            availableframes.get(0).click();
        }
        WebElement downloadFrame = web.findElement(By.cssSelector(".stills-container  div:nth-child(1) ul li:nth-child(2)"));
        downloadFrame.click();
        Common.sleep(1000);
        Robot rb = null;
        try {
            rb = new Robot();
            Common.sleep(1000);
            rb.keyPress(KeyEvent.VK_DOWN);
            rb.keyRelease(KeyEvent.VK_DOWN);
            Common.sleep(1000);
            rb.keyPress(KeyEvent.VK_ENTER);
            rb.keyRelease(KeyEvent.VK_ENTER);
            return true;
        } catch (AWTException e) {
            e.printStackTrace();
            return false;
        }

        }
    public void selectAllFramesCheckbox() {
        web.click(By.cssSelector("#still-selector"));
    }

    public void clickOnDownloadMultipleFramesButton() {
        web.click(By.xpath("//*[@ng-click='downloadStills()']"));
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

    public void removeMultipleFrame(){
        web.click(By.cssSelector(".button.mls.valign-middle.ng-scope"));
        PopUpWindow confirmationPopup = new PopUpWindow(this);
        confirmationPopup.action.click();

    }

    public boolean verifyFrameTimecodeOnHeader(int count){
        String timeCode = web.findElement(By.xpath(String.format("//div[@class='still ng-scope'][" +count+ "]//*[@class='frame-header']/div"))).getText();
        return ((!timeCode.matches(".*[a-zA-Z].*"))&(timeCode.matches("[0-9:]*")));

    }
}
