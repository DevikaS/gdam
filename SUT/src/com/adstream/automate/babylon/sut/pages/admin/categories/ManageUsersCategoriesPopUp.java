package com.adstream.automate.babylon.sut.pages.admin.categories;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoSelect;
import org.openqa.selenium.By;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 22.02.13
 * Time: 10:19
 */
public class ManageUsersCategoriesPopUp extends PopUpWindow {

    private DojoSelect rolesSelect;
    private Button saveBtn;

    public ManageUsersCategoriesPopUp(Page parentPage) {
        super(parentPage);
        saveBtn = new Button(parentPage, By.className("save"));
        rolesSelect = new DojoSelect(parentPage, By.cssSelector("[id*='admin_people_SelectRoles']"));
    }

    public void selectRole(String role) {
        rolesSelect.selectByVisibleText(role);
    }

    public List<String> getUsersList() {
        return web.findElementsToStrings(By.cssSelector(".managecategory .prxs"));
    }

    public void save() {
        web.findElement(By.className("save")).click();
    }

    public String getSelectedRole() {
        return rolesSelect.getSelectedLabel();
    }

    public boolean isRoleVisible() {
        return rolesSelect.isVisible();
    }
}