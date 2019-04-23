package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 14.03.13
 * Time: 12:56
 */
public class ConfirmApprovalActionPopUp extends PopUpWindow {
    public Button apply;
    public Button cancel;

    public ConfirmApprovalActionPopUp(Page<? extends Page> parentPage) {
        super(parentPage);
        close = new Span(parentPage, generateLocator("[title='Cancel']"));
        apply = new Button(parentPage, generateLocator("[name='apply']"));
        cancel = new Button(parentPage, generateLocator("[name='cancel']"));
    }
}
