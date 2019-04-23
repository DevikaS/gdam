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
public class PublishNowOrLaterProjectPopup extends PopUpWindow {
    Button publishNowButton;
    Button PublishLaterButton;

    public PublishNowOrLaterProjectPopup(Page parentPage) {
        super(parentPage);
        publishNowButton = new Button(parentPage, generateLocator("#showPublishNowOpts"));
        PublishLaterButton = new Button(parentPage, generateLocator("#showPublishLaterOpts"));
    }

    public void clickPublishNowButton() {
        publishNowButton.click();
    }

   public void clickPublishLaterButton() {
        PublishLaterButton.click();
    }

}
