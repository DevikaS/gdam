package com.adstream.automate.babylon.sut.pages.admin.categories;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 12.09.12
 * Time: 18:24
 */
public class ManagePermissionsPopUp extends PopUpWindow {
    private Edit userInputField;
    private DojoCombo userName;
    public Span emptyDropDownUserList;
    public DojoCombo rolesSelect;

    public ManagePermissionsPopUp(Page parentPage) {
        super(parentPage);
        userName = new DojoCombo(parentPage, By.className("suggestor"));
        userInputField = new Edit(parentPage, By.cssSelector(".popupWindow [role='autosuggest'] [role='textbox']"));
        emptyDropDownUserList = new Span(parentPage, By.cssSelector("[role='option'] span.bold"));
        rolesSelect = new DojoCombo(parentPage, By.cssSelector(".select_roles"));
    }

    public void add() {
        action.click();
        if (web.isElementPresent(generateLocator()))
        web.waitUntilElementDisappear(generateLocator());
    }

    public void selectUser(String email) {
        setUser(email);
        userName.selectByVisibleText(email);
    }

    public void setUser(String userName) {
        userInputField.type(userName);
        web.sleep(1000);
    }

    public void setUserWithSleep(String userName, int sleep) {
        userInputField.type(userName, sleep);
    }

    public void selectUserByNameAndEmail(String userName, String userEmail) {
        By locator = By.xpath(String.format("//*[contains(@id,'Autocomplete')]//span[not(@class)][contains(.,'%s')][contains(.,'%s')]", userName, userEmail));
        web.waitUntilElementAppear(locator);
        web.click(locator);
        web.waitUntilElementDisappear(locator);
    }

    public List<String> getUsersDropDownListItems() {
        return web.findElementsToStrings(By.cssSelector(".dijitReset[id*='Autocomplete'][role='option']"));
    }

    public List<String> getSelectedUsersList() {
        return web.findElementsToStrings(By.className("as-selection-item"));
    }

    public List<String> getRolesList() {
        return rolesSelect.getValues();
    }

    public void selectRole(String role) {
        rolesSelect.selectByVisibleText(role);
    }
}