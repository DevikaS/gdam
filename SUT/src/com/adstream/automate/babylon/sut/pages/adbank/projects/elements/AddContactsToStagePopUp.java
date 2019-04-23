package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 13.03.13
 * Time: 13:25
 */
public class AddContactsToStagePopUp extends PopUpWindow {

    public AddContactsToStagePopUp(Page<? extends Page> parentPage) {
        super(parentPage);
        setParentElement("[role='dialog']");
        close = new Span(parentPage, generateLocator(".ui-icon-closethick"));
        action = new Button(parentPage, generateLocator("button[role=button]"));
    }

    private By getTabLocator(String name){
        return By.linkText(name);
    }

    private By getSearchFieldLocator(){
        return By.name("SearchTerm");
    }

    private By getUserToggleLocator(String email){
        return By.cssSelector("[email='" + email + "']>*>a");
    }

    public void clickInviteContactsTab(){
        web.click(getTabLocator("Invite Contacts"));
    }

    public void clickTeamMembersTab(){
        web.click(getTabLocator("Team Members"));
    }

    public void clickDefaultTeamsTab(){
        web.click(getTabLocator("Default Teams"));
    }

    public void clickInviteGlobalTab(){
        web.click(getTabLocator("Invite Global"));
    }

    public AddContactsToStagePopUp findUser(String user){

        web.typeClean(getSearchFieldLocator(), user);
        web.click(By.cssSelector("[value='Search']"));
        return this;
    }

    public void clickUserToggle(String userId){
        web.click(getUserToggleLocator(userId));
    }

    public AdbankFileApprovalsPage clickOkButton(){
        action.click();
        Common.sleep(1000);
        web.waitUntilElementDisappear(getSearchFieldLocator());
        return new AdbankFileApprovalsPage(web);
    }


}
