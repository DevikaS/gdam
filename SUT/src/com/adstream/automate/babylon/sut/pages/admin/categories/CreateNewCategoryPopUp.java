package com.adstream.automate.babylon.sut.pages.admin.categories;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.09.12
 * Time: 8:33

 */
public class CreateNewCategoryPopUp extends PopUpWindow {
    public Edit categoryNameEdit = new Edit(parentPage, generateLocator("[name=categoryName]"));

    public CreateNewCategoryPopUp(Page parentPage) {
        super(parentPage);
    }

    public PopUpWindow setCategoryName(String categoryName) {
        web.waitUntilElementAppearVisible(generateLocator());
        categoryNameEdit.type(categoryName);
        web.sleep(1000);
        return this;
    }
}
