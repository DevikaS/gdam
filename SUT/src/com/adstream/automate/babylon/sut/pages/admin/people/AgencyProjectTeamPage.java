package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: sadikov-o
 * Date: 2/8/13
 * Time: 2:18 PM
 */
public class AgencyProjectTeamPage extends UsersPage {

    public AgencyProjectTeamPage(ExtendedWebDriver web) {
        super(web);
    }

    public List<String> getUsersList(){
        List<String> usersNames = new ArrayList<String>();
        List<WebElement> users = web.findElements(By.cssSelector("[data-role='users-list'] .h5 > a"));
        for(WebElement user : users){
            usersNames.add(user.getText());
        }
        return usersNames;
    }

    public String getUsersRole(String userName){
        return web.findElement(By.xpath(String.format(
                "//a[normalize-space(text())='%s']/ancestor::div[contains(@class,'row')]//li[contains(@class,'role')]", userName))).getText();
    }

    public ConfirmRemoveUserPopUp clickRemoveUserButton(String userName){
        web.click(By.xpath(String.format("//*[contains(@id,'usersListItem')][.//*[normalize-space()='%s']]//*[contains(@id,'Remover')]", userName)));
        return new ConfirmRemoveUserPopUp(this);
    }

    public AgencyProjectTeamPage removeUserFromThisTeam(String userName){
        ConfirmRemoveUserPopUp confirmRemoveUserPopUp = this.clickRemoveUserButton(userName);
        confirmRemoveUserPopUp.confirmRemoving();
        return this;
    }

}
