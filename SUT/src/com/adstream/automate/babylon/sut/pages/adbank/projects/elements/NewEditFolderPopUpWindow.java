package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 10.05.12
 * Time: 13:27
 */
public class NewEditFolderPopUpWindow extends PopUpWindow {
    public Edit folderNameEdit = new Edit(parentPage, generateLocator("[name=folderName]"));


    public NewEditFolderPopUpWindow(Page parentPage) {
        super(parentPage);
    }

    public PopUpWindow setFolderName(String folderName) {
        folderNameEdit.type(folderName);
        return this;
    }
}
