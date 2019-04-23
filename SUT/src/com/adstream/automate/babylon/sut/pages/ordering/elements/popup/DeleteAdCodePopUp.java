package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.admin.metadata.MetadataPage;

/*
 * Created by demidovskiy-r on 20.06.2014.
 */
public class DeleteAdCodePopUp extends AbstractPopUp {
    public final static String TITLE = "Are you sure you want to proceed?";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public DeleteAdCodePopUp(MetadataPage parentPage, String title) {
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