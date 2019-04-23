package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by devika on 16/04/2018.
 */
public class AddToPresentationPopUp extends LibPopUpWindow {

    private By searchForPresentation = By.xpath("//input[@aria-label='Search for a presentation']");
    private By addNewPresentation = By.xpath("//span[.='(Add new presentation)']");
    private By description = By.xpath("//textarea[@placeholder='Enter a description for the presentation']");
    private By cancel = By.xpath("//md-content//footer//span[.='cancel']");
    private static final By parentDialog = By.xpath("//md-dialog[@role='dialog']//copy-assets-to-presentation");

    public AddToPresentationPopUp(Page parentPage) {
        super(parentPage, "copy-assets-to-presentation[assets='$ctrl.locals.selected']");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));

    }

    public void addTonewPresentation(String presentationName) {
        web.findElement(searchForPresentation).sendKeys(presentationName);
        web.waitUntilElementAppear(addNewPresentation);
        web.findElement(addNewPresentation).click();
        web.findElement(description).sendKeys(presentationName);
        action.click();

    }

    public void addToExistingPresentation(String presentationName) {

        web.findElement(searchForPresentation).sendKeys(presentationName.substring(0,1));
        Common.sleep(2000);
        web.findElement(By.xpath("//span[contains(.,'"+presentationName+"')]")).click();
    }

    public void cancelPopup()
    {
        WebElement element = web.findElement(cancel);
        web.clickThroughJavascript(element);
    }

    public void enterSearchText(String serachText) {

        web.findElement(searchForPresentation).sendKeys(serachText);
        Common.sleep(2000);
    }

    public List<String> getAvailableForSearchProjectsListAsText() {
        ArrayList<String> result = new ArrayList<String>();
        return web.findElementsToStrings(By.xpath("//ul[contains(@id,'ui-select-choices')]//li"));

    }
    public void clickAdd()
    {
        action.click();
    }

    public boolean verifyMessage(String message)
    {
        return web.isElementVisible(By.xpath("//ads-md-toast//*[contains(.,'" + message +"')]"));
    }

    public boolean isPopUpVisible()
    {
        return web.isElementVisible(parentDialog);
    }

}
