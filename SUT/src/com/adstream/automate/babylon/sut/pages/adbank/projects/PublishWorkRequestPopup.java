package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;

/**
 * Created by sobolev-a on 17.11.2014.
 */
public class PublishWorkRequestPopup extends PopUpWindow {
    Button notifyButton;
    Button doNotNotifyButton;

    public PublishWorkRequestPopup(Page parentPage) {
        super(parentPage);
        notifyButton = new Button(parentPage, generateLocator(".notify"));
        doNotNotifyButton = new Button(parentPage, generateLocator(".dnnotify"));
    }

    public void clickNotifyButton() {
        notifyButton.click();
    }

    public void clickDoNotNotifyButton() {
        doNotNotifyButton.click();
    }


}