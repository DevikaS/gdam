package com.adstream.automate.babylon.sut.elements.controls.complex;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import java.util.Iterator;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 10.05.12
 * Time: 12:54
 */
public class PopUpWindow {
    protected ExtendedWebDriver web;
    protected Page parentPage;
    public Span close;
    public Button action;
    public Link cancel;
    protected String parentElement;

    //only css locators alloved
    public PopUpWindow(Page parentPage) {
        this.parentPage = parentPage;
        web = parentPage.getDriver();
        this.parentElement = ".popupWindow.dijitDialog:not([style*='display: none'])";
        this.close = new Span(parentPage, generateLocator(".close"));
        this.action = new Button(parentPage, generateLocator(".button"));
        this.cancel = new Link(parentPage, generateLocator(".cancel"));
    }

    public PopUpWindow(Page parentPage, String title) {
        this.parentPage = parentPage;
        web = parentPage.getDriver();
        this.parentElement = String.format(".popupWindow.dijitFocused:not([style*='display: none']) > .windowHead[title*='%s']", title);
        this.close = new Span(parentPage, generateLocator(".close"));
        this.action = new Button(parentPage, generateLocator("+ * .button"));
        this.cancel = new Link(parentPage, generateLocator("+ * .cancel"));
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
        return By.cssSelector(parentElement + " " + particalLocator);
    }

    public boolean isPopUpVisible(){

        return parentPage.getDriver().isElementVisible(generateLocator());
    }

    public void clickAction() {
        action.click();
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
