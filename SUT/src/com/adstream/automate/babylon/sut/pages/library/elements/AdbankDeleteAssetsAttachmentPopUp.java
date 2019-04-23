package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUp;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

public class AdbankDeleteAssetsAttachmentPopUp extends AbstractPopUp {
    public final static String TITLE = "Confirm";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public AdbankDeleteAssetsAttachmentPopUp(Page parentPage, String title) {
        super(parentPage, title);
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }
}