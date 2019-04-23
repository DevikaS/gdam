package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.utils.Common;

/**
 * User: ruslan.semerenko
 * Date: 18.02.14 14:57
 */
public class SendForApprovalPopUp extends PopUpWindow {
    private Button createNewApprovalButton;
    private Link applyTemplateLink;

    public SendForApprovalPopUp(Page parentPage) {
        super(parentPage);
        createNewApprovalButton = new Button(parentPage, generateLocator("[data-role='createNew']"));
        applyTemplateLink = new Link(parentPage, generateLocator("[data-role='applyTemplate']"));
    }

    public StagePopUp clickCreateNewApproval() {
        createNewApprovalButton.click();
        Common.sleep(1000);
        return new StagePopUp(parentPage);
    }

    public SelectApprovalTemplatePopup clickApplyTemplate() {
        applyTemplateLink.click();
        Common.sleep(1000);
        return new SelectApprovalTemplatePopup(parentPage);
    }

}
