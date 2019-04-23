package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 14.03.13
 * Time: 13:59
 */
public class ApprovalCommentPopUp extends PopUpWindow {

    public ApprovalCommentPopUp(Page parentPage) {
        super(parentPage);
        close = new Span(parentPage, generateLocator(".close"));
        action = new Button(parentPage, generateLocator("[name='apply']"));
    }

    private By getCommentFieldLocator(){
        return generateLocator("[name='comment']");
    }

    public void typeComment(String comment) {
        if (web.isElementPresent(getCommentFieldLocator())) {
            web.typeClean(getCommentFieldLocator(), comment);
        }
    }

    public AdbankFileApprovalsPage clickOkButton(){
        action.click();
        Common.sleep(1000);
        web.waitUntilElementDisappear(getCommentFieldLocator());
        return new AdbankFileApprovalsPage(web);
    }

}
