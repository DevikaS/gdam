package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: sadikov-o
 * Date: 2/11/13
 * Time: 1:05 PM
 */
public class AddAgencyProjectTeamPopUp extends PopUpWindow {
   // public DojoSelect agencyTeamSelect = new DojoSelect(parentPage, generateLocator(".agencySelector"));

    public Edit agencyTeamSelect = new Edit(parentPage, By.xpath("//input[contains(@placeholder,'Start typing')]"));

    public AddAgencyProjectTeamPopUp(Page parentPage) {
        super(parentPage);
    }

    public List<String> getAgencyProjectTeamsListFromDropdown(){
        List<String> aptList = new ArrayList<>();
        web.click(By.xpath("//td[contains(@class,'dijitArrowButton')]"));
        List<WebElement> optionsList = web.findElements(By.xpath("//td[contains(@id,'_text')]//div[@class='inline-block']"));
        for(WebElement option : optionsList){
            aptList.add(option.getText());
        }
        return aptList;
    }

    public AddAgencyProjectTeamPopUp selectAgencyTeam(String teamName){
       // agencyTeamSelect.selectByVisibleSubString(teamName);
        agencyTeamSelect.type(teamName + Keys.RETURN, 100);
        web.sleep(1000);
        return this;
    }

    public void checkFolder(String folderName){
       // web.click(By.xpath("//a[text()='" + folderName + "']/../input[@type='checkbox']"));
       // web.click(By.xpath("//a[text()='" + folderName + "']/.."));
        web.click(By.xpath("//span[contains(.,'" + folderName + "')]"));
    }


    public AdBankTeamsPage clickSaveButton(){
       // web.click(By.cssSelector(".save"));
        web.click(By.cssSelector("[ng-click=\"modalCtrl.ok()\"]"));
        return new AdBankTeamsPage(web);
    }

    public void clickAddRole() {
        //web.findElement(generateLocator("[data-role='add-role']")).click();
        web.findElement(By.xpath("//button[contains(.,'Add Role')]")).click();
    }

    public AdBankTeamsPage clickSaveButtonOtherMethod(){
        web.click(By.name("Save"));
        return new AdBankTeamsPage(web);
    }
}
