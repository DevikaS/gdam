package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.List;

/**
 * Created by denysb on 21/06/2016.
 */
public class ReassignOrdersInTraffic extends PopUpWindow {

    private final static By filterByBUFieldSelector = By.xpath("//input[contains(@ng-model,'assignedAgenciesQuery')]");
    private final static By filterByUserFieldSelector = By.cssSelector("[ng-model='aum.selectedUser']");
    private final static By highlateAllBUSelector = By.cssSelector("[ng-click=\"$reassignOrderModal.selectAll('agencies')\"]");
    private final static By highlateAllUsersSelector = By.cssSelector("[ng-click=\"$reassignOrderModal.selectAll('users')\"]");
    private final static By assignSelector = By.cssSelector("[ng-click=\"$reassignOrderModal.assign()\"]");
    private final static By clearAndAssignSelector = By.xpath("//button[contains(.,'Clear & Assign')]");


    public ReassignOrdersInTraffic(Page parentPage) {
        super(parentPage);
    }

    public void enterAgencyDetails(String agency){
        web.findElement(filterByBUFieldSelector).sendKeys(agency);
    }

    public void selectAllUserToAssign(){
        web.click(highlateAllUsersSelector);
    }

    public void selectSeveralUsers(List <String> users){
        Robot robot = null;
        try {
            robot = new Robot();
        } catch (AWTException e) {
            e.printStackTrace();
        }
        robot.keyPress(KeyEvent.VK_CONTROL);
        for (int i = 0; i <users.size() ; i++) {
            web.findElement(By.cssSelector(String.format("option[label='%s']", users.get(i)))).click();
        }
        robot.keyRelease(KeyEvent.VK_CONTROL);
    }

    public void selectParticularAgency(String agency){
        web.click(By.cssSelector(String.format("option[label='%s']",agency)));
    }

    public void clickParticularButton(String buttonName){
        switch (buttonName){
            case "Highlight All Users":
                web.click(highlateAllUsersSelector);
                break;
            case "Highlight All Agencies":
                web.click(highlateAllBUSelector);
                break;
            case "Assign":
                web.click(assignSelector);
                break;
            case "Clear & Assign":
                web.click(clearAndAssignSelector);
                break;
        }
    }
}
