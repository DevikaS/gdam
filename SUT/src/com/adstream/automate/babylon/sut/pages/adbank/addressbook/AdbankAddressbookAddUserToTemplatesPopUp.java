package com.adstream.automate.babylon.sut.pages.adbank.addressbook;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10.07.12
 * Time: 14:12
 */
public class AdbankAddressbookAddUserToTemplatesPopUp extends PopUpWindow {
    public AdbankAddressbookAddUserToTemplatesPopUp(Page parentPage) {
        super(parentPage);
    }

    public void typeNewTemplateName(String name) {
        web.typeClean(By.cssSelector(".ui-input.relative"), name);
    }

    public AdbankAddressbookPage clickAddButton() {
        web.findElement(By.cssSelector(".ui-input.relative")).sendKeys(Keys.TAB);
        web.click(By.name("Save"));
        return new AdbankAddressbookPage(web);
    }

    public AdbankAddressbookPage clickCancelLink() {
        web.findElement(By.cssSelector(".ui-input.small.relative")).sendKeys(Keys.TAB);
        web.click(By.linkText("Cancel"));
        return new AdbankAddressbookPage(web);
    }

    public void clickTeamTemplateCheckBox(String value) {
        web.click(By.xpath("//input[@type='checkbox' and @value='" + value + "']"));
        if (!web.findElement(By.xpath("//input[@type='checkbox' and @value='" + value + "']")).isSelected()) {
            web.click(By.xpath("//input[@type='checkbox' and @value='" + value + "']"));
        }
    }

    public WebElement getConfirmExistTemplatePopup() {
        return web.findElement(By.xpath("//div[normalize-space()='Confirm']/parent::div"));
    }

    public String getTextOfConfirmPopup() {
        return getConfirmExistTemplatePopup().getText();
    }

    public WebElement getUpdateExistingButton() {
        return web.findElement(By.cssSelector(".confirm.button.secondary.mrs"));
    }

    public boolean isUpdateExistingButtonVisible() {
        return web.isElementVisible(By.cssSelector(".confirm.button.secondary.mrs"));
    }

    public AdbankAddressbookPage clickUpdateExistingButton() {
        web.click(By.cssSelector(".confirm.button.secondary.mrs"));
        return new AdbankAddressbookPage(web);
    }

    public void clickRenameCurrentLink() {
        web.click(By.linkText("Rename Current"));
    }

    public WebElement getRenameCurrentLink() {
        return web.findElement(By.linkText("Rename Current"));
    }

    public boolean isRenameCurrentLinkVisible() {
        return web.isElementVisible(By.linkText("Rename Current"));
    }
}
