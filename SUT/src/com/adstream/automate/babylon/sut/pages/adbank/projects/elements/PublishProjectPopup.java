package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;

/**
 * Created with IntelliJ IDEA.
 * User: sadikov-o
 * Date: 2/11/13
 * Time: 1:05 PM
 */
public class PublishProjectPopup extends PopUpWindow {
    Button notifyButton;
    Button doNotNotifyButton;

    public PublishProjectPopup(Page parentPage) {
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
