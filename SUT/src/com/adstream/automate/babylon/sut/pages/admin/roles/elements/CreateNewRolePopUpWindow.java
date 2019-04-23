package com.adstream.automate.babylon.sut.pages.admin.roles.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.controls.Edit;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 10.05.12
 * Time: 13:27
 */
public class CreateNewRolePopUpWindow extends PopUpWindow {
    public Edit roleNameEdit = new Edit(parentPage, generateLocator("[name=roleName]"));
    public DojoSelect roleType = new DojoSelect(parentPage,generateLocator(".role_type"));

    public CreateNewRolePopUpWindow(Page parentPage) {
        super(parentPage);
        parentPage.getDriver().waitUntilElementAppearVisible(generateLocator());
    }
    public CreateNewRolePopUpWindow(ExtendedWebDriver webDriver) {
        this(new BaseAdminPage(webDriver));
    }

    public void setRoleName(String name) {
        roleNameEdit.type(name);
    }

    public void setRoleType(String type) {
        roleType.selectByValue(type);
    }
}
