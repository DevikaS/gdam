package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.awt.*;
import java.util.*;

/**
 * Created by denysb on 09/03/2016.
 */
public class ApprovePopUp extends PopUpWindow {

    private static final By EMAILFIELDSELECTOR = By.cssSelector("[name='customEmail']");
    private static final By COMMENTFIELDSELECTOR = By.cssSelector("[name='emailMessage']");
    private static final By ADDEMAILBUTTONSELECTOR = By.cssSelector("[title='Add Email']");
    private static final By SAVEBUTTONSELECTOR = By.cssSelector("#orderApprovalModalConfirm");
    private static final By destinationsLocator =By.cssSelector("[name=\"destinationsForm\"] [ng-click=\"$destinationsSelectorCtrl.toggleSelect(item)\"]");
    private static final By destinationsCheckboxLocator = By.cssSelector("[name=\"destinationsForm\"] [ng-click=\"$destinationsSelectorCtrl.toggleSelect(item)\"] :first-child");
    private Button saveButton;
    private Button addEmailButton;
    private Edit emailfield;
    private Edit commentField;
    private java.util.List<WebElement>  destinations;
    private java.util.List<WebElement> destinationCheckBox;

    public ApprovePopUp(Page parentPage) {
        super(parentPage);
        saveButton = new Button(parentPage,SAVEBUTTONSELECTOR);
        addEmailButton = new Button(parentPage,ADDEMAILBUTTONSELECTOR);
        emailfield = new Edit(parentPage, EMAILFIELDSELECTOR);
        commentField = new Edit(parentPage, COMMENTFIELDSELECTOR);
        destinations = web.findElements(destinationsLocator);
        destinationCheckBox = web.findElements(destinationsCheckboxLocator);
    }

    public void fillApprovalForm(Map <String,String> data){
        for(Map.Entry <String,String> map : data.entrySet()){
            switch (map.getKey()){
                case "Email":
                    emailfield.type(map.getValue());
                    addEmailButton.click();
                    break;
                case "Comment":
                    if(!map.getValue().equals(""))
                    commentField.type(map.getValue());
                    break;
            }
        }
    }

    public void fillApprovalFormSpecDestn(Map <String,String> data){
        for(Map.Entry <String,String> map : data.entrySet()) {
            switch (map.getKey()) {
                case "Email":
                    emailfield.type(map.getValue());
                    addEmailButton.click();
                    break;
                case "Comment":
                    if (!map.getValue().equals(""))
                        commentField.type(map.getValue());
                    break;
                case "Destination":
                    if (!map.getValue().equals("")) {
                        for (String value : map.getValue().split(";")) {
                            for (int i = 0; i < destinations.size(); i++) {
                                if (value.equalsIgnoreCase(destinations.get(i).getText())) {
                                    if (destinationCheckBox.get(i).getAttribute("class").contains("icon-Rejected"))
                                        destinationCheckBox.get(i).click();
                                } else {
                                    if (destinationCheckBox.get(i).getAttribute("class").contains("icon-tick"))
                                        destinationCheckBox.get(i).click();
                                }
                            }
                        }
                    }
                }    break;

        }
    }


    public boolean isChecked( String destinationName,String value) {
        if (destinationName != null && value != null) {
            if (value.equalsIgnoreCase("ON")) {
                value = "icon-tick";
            } else {
                value = "icon-Rejected";
            }
          for(int i=0;i<destinations.size();i++) {
              if (destinations.get(i).getText().contains(destinationName)) {
                  return destinationCheckBox.get(i).getAttribute("class").contains(value);
              }
          }
            }
        return false;
        }


    public void clickSaveButton(){
        saveButton.click();
    }

    public void unSelectDestination(String destinationName)
    {
        int itemCount = web.findElements(By.xpath("//form[@name='destinationsForm']//ul[@ng-repeat='item in $destinationsSelectorCtrl.destinationItems']")).size();
        for (int item = 2; item <= itemCount+1; item++) {
            String destinationList = web.findElement(By.xpath("//form[@name='destinationsForm']//ul[" + item + "]/li")).getText();
            if (destinationList.contains(destinationName.trim())) {
                web.findElement(By.xpath("//form[@name='destinationsForm']//ul[" + item + "]/li/span")).click();
                break;
            }
        }
    }

    public boolean verifyIsDestinationUnselected(String destinationName)
    {
        boolean flag= false;
        int itemCount = web.findElements(By.xpath("//form[@name='destinationsForm']//ul[@ng-repeat='item in $destinationsSelectorCtrl.destinationItems']")).size();
        for (int item = 2; item <= itemCount+1; item++) {
            String destinationList = web.findElement(By.xpath("//form[@name='destinationsForm']//ul[" + item + "]/li")).getText();
            if (destinationList.contains(destinationName.trim())) {
                flag=web.findElement(By.xpath("//form[@name='destinationsForm']//ul[" + item + "]/li/span[contains(@class,'glyphicon-ban-circle')]")).isDisplayed();
                break;
            }
        }
        return flag;
    }

    public boolean verifyDestinationWithClock(String destinationName,String clockNumber) {
        int itemCount = web.findElements(By.xpath("//form[@name='destinationsForm']//ul[@ng-repeat='item in $destinationsSelectorCtrl.destinationItems']")).size();
        boolean flag= false;
        for (int item = 2; item <= itemCount + 1; item++) {
            String destinationList = web.findElement(By.xpath("//form[@name='destinationsForm']//ul[" + item + "]/li")).getText();
            if (destinationList.contains(destinationName.concat(" - ").concat(clockNumber).trim())) {
                flag=web.findElement(By.xpath("//form[@name='destinationsForm']//ul[" + item + "]/li/span[contains(@class,'glyphicon')]")).isDisplayed();
                break;
            }
        }
        return flag;
    }

}
