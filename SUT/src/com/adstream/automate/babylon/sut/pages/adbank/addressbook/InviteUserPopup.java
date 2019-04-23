package com.adstream.automate.babylon.sut.pages.adbank.addressbook;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 20.11.12
 * Time: 17:09
 */
public class InviteUserPopup extends PopUpWindow {
    public Edit emailEdit;

    public InviteUserPopup(Page parentPage) {
        super(parentPage);
        emailEdit = new Edit(parentPage, By.cssSelector(".popupWindow [role=textbox]"));
    }

    public boolean isInviteButtonDisabled() {
        return web.findElement(By.cssSelector(".popupWindow [name=Save]")).getAttribute("class").contains("disabled");
    }

    public void startTypeUserEmail(String email) {
        emailEdit.type(email, 1000);
    }

    public void startTypeUserEmail(String email, int sleep) {
        emailEdit.type(email,sleep);
    }

    public String getInviteValues() {
        WebElement webElement = web.findElement(By.cssSelector(".as-selections"));
        return webElement.getText();
    }

    public String getInviteDropdownListItemText() {
        WebElement webElement = web.findElement(By.xpath("//span[@class='dijitComboBoxHighlightMatch']/parent::div"));
        return webElement.getText();
    }

    public String getTest() {
        WebElement webElement = web.findElement(By.xpath("//span[@class='dijitComboBoxHighlightMatch']/following-sibling::span"));
        return webElement.getText();
    }




}
