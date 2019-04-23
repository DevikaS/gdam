package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 10.05.12
 * Time: 13:27
 * To change this template use File | Settings | File Templates.
 */
public class DeleteProjectPopUpWindow extends PopUpWindow {
    public DeleteProjectPopUpWindow(Page<? extends Page> parentPage) {
        super(parentPage);
    }

    public PopUpWindow setFolderName(String folderName){
        return this;
    }
}
