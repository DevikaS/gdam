package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

//import com.adstream.automate.babylon.sut.pages.library.elements.LibEditAssetClosePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created by Janaki.Kamat on 24/04/2017.
 */
public class LibPopUpWindow {
    protected ExtendedWebDriver web;
    protected Page parentPage;
    public Span close;
    public Button action;
    public Link cancel;
    protected String parentElement;

    //only css locators alloved
    public LibPopUpWindow(Page parentPage,String section) {
        this.parentPage = parentPage;
        web = parentPage.getDriver();
        this.parentElement=section;
        this.close = new Span(parentPage, generateLocator("span[click=\"$ctrl.cancel()\"]"));
        this.action = new Button(parentPage, generateLocator("ads-md-button[state=\"primary\"] button"));
        this.cancel = new Link(parentPage, generateLocator("ads-md-button[click=\"$ctrl.cancel()\"] button"));
    }

    protected void setParentElement(String parentElement){
        this.parentElement = parentElement;
    }

    protected String getParentElement(){
        return this.parentElement;
    }

    protected By generateLocator() {
        return By.cssSelector(parentElement);
    }

    protected By generateLocator(String particalLocator) {
        return By.cssSelector(parentElement +  " " + particalLocator);
    }

    protected By generateXpathLocator(String particalLocator) {
        return By.xpath("//"+parentElement  + particalLocator);
    }
    public boolean isPopUpVisible(){

        return parentPage.getDriver().isElementVisible(generateLocator());
    }

    public void clickAction() {
        action.click();
        Common.sleep(2000);
    }

    public LibEditAssetClosePopup cancel(){
        cancel.click();
        Common.sleep(2000);
        return new LibEditAssetClosePopup(this.parentPage);
    }

    public void close(){
        cancel.click();
        Common.sleep(2000);
    }

    public boolean getText(String message)
    {
        boolean flag = false;
        if (web.getPageSource().contains(message))
        {
            flag = true;
        }
        return flag;
    }




}