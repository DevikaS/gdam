package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 29.10.13
 * Time: 19:28
 */
public class ClearSectionConfirmationPopUp extends AbstractPopUp {
    public final static String TITLE = "Are you sure you want to proceed?";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public ClearSectionConfirmationPopUp(OrderItemPage parentPage, String title) {
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
}