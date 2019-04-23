package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AbstractMovePopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 30.10.12
 * Time: 17:36
 */
public class AddAssetToProjectPopUpWindow extends AbstractMovePopUpWindow {
    public AddAssetToProjectPopUpWindow(Page parentPage) {
        super(parentPage);
        action = new Button(parentPage, generateLocator(".action"));
        web.waitUntilElementAppearVisible(generateLocator());
    }
}
