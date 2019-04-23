package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUp;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/**
 * Created by sobolev-a on 22.05.2014.
 */
public class AdbankAttachmentsFileEditPopUp extends AbstractPopUp {

    public AdbankAttachmentsFileEditPopUp(Page parentPage, String title) {
        super(parentPage, title);
        this.parentElement = generatePopUpElement("> .windowHead", false);
        this.action = new Button(parentPage, generateLocator("+ * .button"));
        this.close = new Span(parentPage, generateLocator(".close"));
        this.cancel = new Link(parentPage, generateLocator("+ * .cancel"));
        loadPopUp();
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(generateLocator());
    }

    @Override
    protected void unloadPopUp() {
    }

    public void typeName(String name) {
        web.findElement(getFieldNameLocator()).clear();
        web.findElement(getFieldNameLocator()).sendKeys(name);
    }

    public void typeDescription(String descr) {
        web.findElement(getFieldDescriptionLocator()).clear();
        web.findElement(getFieldDescriptionLocator()).sendKeys(descr);
    }

    private By getFieldNameLocator() {
        return By.cssSelector("[ng-model='attachment.file.name']");
    }
    private By getFieldDescriptionLocator() {
        return By.cssSelector("[ng-model='attachment.file.description']");
    }
}
