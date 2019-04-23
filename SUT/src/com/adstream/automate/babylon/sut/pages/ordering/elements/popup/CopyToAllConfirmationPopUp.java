package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;

/*
 * Created by demidovskiy-r on 10.01.14.
 */
public class CopyToAllConfirmationPopUp extends AbstractPopUp {
    public final static String TITLE = "Are you sure you want to proceed?";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public CopyToAllConfirmationPopUp(OrderItemPage parentPage, String title) {
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