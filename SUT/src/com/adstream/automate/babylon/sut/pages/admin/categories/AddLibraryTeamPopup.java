package com.adstream.automate.babylon.sut.pages.admin.categories;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 01.02.13
 * Time: 8:01
 */
public class AddLibraryTeamPopup extends PopUpWindow {
    public Edit nameField;
    public DojoCombo rolesSelect;

    public AddLibraryTeamPopup(Page parentPage) {
        super(parentPage);
        waitUntilPopUpAppears();
        nameField = new Edit(parentPage, By.cssSelector(".popupWindow [role='autosuggest'] [role='textbox']"));
        rolesSelect = new DojoCombo(parentPage, By.cssSelector(".select_roles"));
    }

    public void selectLibraryTeam(String text) {
        nameField.typeWithInterval(text, 150);
        web.sleep(1000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')]//*[contains(@class,'Highlight')][text()='%s']", text)));
    }

    public void selectRole(String role) {
        rolesSelect.selectByVisibleText(role);
    }

    public void save() {
        action.click();
        waitUntilPopUpDisappears();
    }

    public void cancel() {
        cancel.click();
        waitUntilPopUpDisappears();
    }

    public void close() {
        close.click();
        waitUntilPopUpDisappears();
    }

    private void waitUntilPopUpAppears() {
        web.waitUntilElementAppearVisible(generateLocator());
    }

    private void waitUntilPopUpDisappears() {
        web.waitUntilElementDisappear(generateLocator());
    }
}