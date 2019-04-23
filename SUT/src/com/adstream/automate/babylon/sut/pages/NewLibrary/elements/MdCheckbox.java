package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/**
 * Created by Janaki.Kamat on 15/05/2017.
 */
public class MdCheckbox extends Control{
    public MdCheckbox(Page parentPage,By locator){
        super(parentPage,locator);
    }

    public MdCheckbox(Page parent, WebElement element){
        super(parent,element);
    }


    public void selectBylocator() {
        if (!this.parent.getDriver().findElement(locator).getAttribute("class").contains("md-checked"))
            this.parent.getDriver().findElement(locator).click();
    }


    public void selectByElement()
    {
        if(!webElement.getAttribute("class").contains("md-checked"))
            webElement.click();
    }



    public void deSelectByLocator(){
        if (this.parent.getDriver().findElement(locator).getAttribute("class").contains("md-checked"))
            this.parent.getDriver().findElement(locator).click();
    }

    public void deSelectByElement()
    {
        if(webElement.getAttribute("class").contains("md-checked"))
            webElement.click();
    }


    public boolean isSelected(){
        if(locator!=null)
            return this.parent.getDriver().findElement(locator).getAttribute("class").contains("md-checked");
        else
            return webElement.getAttribute("class").contains("md-checked");
    }

}
