package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 19.09.12
 * Time: 15:00
 */
public class RenameCollectionPopUp extends PopUpWindow {
    public Edit collectionNameEdit = new Edit(parentPage, generateLocator("[name=Name]"));

    public RenameCollectionPopUp(Page parentPage) {
        super(parentPage);
    }

    public PopUpWindow setCollectionName(String collectionName) {
        collectionNameEdit.type(collectionName);
        return this;
    }
}
