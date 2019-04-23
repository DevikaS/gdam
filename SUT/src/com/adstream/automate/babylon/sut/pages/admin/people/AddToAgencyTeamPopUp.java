package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.09.12
 * Time: 8:33

 */
public class AddToAgencyTeamPopUp extends PopUpWindow {
    public Edit teamNameEdit;
    public DojoSelect projectRoleSelect;
    public DojoCombo teamCombo;

    public AddToAgencyTeamPopUp(Page parentPage) {
        super(parentPage);
        waitUntilPopUpAppears();
        teamNameEdit = new Edit(parentPage, generateLocator("[role='textbox']"));
        projectRoleSelect = new DojoSelect(parentPage, generateLocator(".roles"));
        teamCombo = new DojoCombo(parentPage, generateLocator(".teamSelector[role='combobox']"));
    }

    public AddToAgencyTeamPopUp setTeamName(String teamName) {
        web.waitUntilElementAppearVisible(generateLocator());
        teamNameEdit.typeWithInterval(teamName, 500);
        //teamNameEdit.type(teamName);
        web.waitUntilElementAppear(By.className("dijitComboBoxHighlightMatch"));
        web.sleep(1000);
        teamCombo.selectByVisibleText(teamName);
        return this;
    }

    public AddToAgencyTeamPopUp selectProjectRole(String roleName) {
        web.waitUntilElementAppearVisible(generateLocator());
        projectRoleSelect.selectByVisibleText(roleName);
        web.sleep(1000);
        return this;
    }

    public void save() {
        action.click();
        waitUntilAgencyPopUpDisappears();
    }

    private void waitUntilPopUpAppears() {
        web.waitUntilElementAppearVisible(generateLocator());
    }

    private void waitUntilAgencyPopUpDisappears() {
        web.waitUntilElementDisappear(generateLocator());
    }
}