package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 13.03.13
 * Time: 17:51
 */
public class RemoveStageConfirmationPopUp extends PopUpWindow {

    public RemoveStageConfirmationPopUp(Page<? extends Page> parentPage) {
        super(parentPage);
        close = new Span(parentPage, generateLocator(".close"));
        action = new Button(parentPage, generateLocator("button:first-child"));
        cancel = new Link(parentPage, generateLocator("button:last-child"));
    }

    public String getHeaderText(){
        return web.findElement(By.cssSelector(".ui-dialog-title")).getText();
    }

    public String getBodyText(){
        return web.findElement(By.cssSelector(".ui-dialog-content")).getText();
    }
}
