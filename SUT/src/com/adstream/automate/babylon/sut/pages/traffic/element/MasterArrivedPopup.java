package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Select;
import org.openqa.selenium.By;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.Keys;
import org.openqa.selenium.interactions.Actions;

import java.awt.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by denysb on 10/12/2015.
 */
public class MasterArrivedPopup extends PopUpWindow {

    private static final By DATEFIELDSELECTOR = By.cssSelector("[data-role='date']");
    private static final By TIMEFIELDSELECTOR = By.cssSelector("[data-role='time']");
    private static final By TAPENUMBERFIELDSELECTOR = By.cssSelector("[data-role='tape']");
    private static final By COMMENTFIELDSELECTOR = By.cssSelector("[name='comment']");
    private static final By SAVEBUTTONSELECTOR = By.cssSelector("[data-role='save']");
    private Button save;
    private Edit tapeField;
    private Edit dateField;
    private Edit commentsField;
    private Edit selectTime;



    public MasterArrivedPopup(Page parentPage) {
        super(parentPage);
        save = new Button(parentPage, SAVEBUTTONSELECTOR);
        selectTime = new Edit(parentPage, TIMEFIELDSELECTOR);
        tapeField = new Edit(parentPage,TAPENUMBERFIELDSELECTOR);
        dateField = new Edit(parentPage,DATEFIELDSELECTOR);
        commentsField = new Edit(parentPage, COMMENTFIELDSELECTOR);
    }

    public void fillMasterArrivedForm(Map<String, String> data){
        for (Map.Entry<String,String> map : data.entrySet()) {
            switch (map.getKey()) {
                case "Date":
                    dateField.type(map.getValue());
                    web.findElement(DATEFIELDSELECTOR).click();
                    break;
                case "Time":
                    selectTime.type(map.getValue());
                    web.findElement(TIMEFIELDSELECTOR).sendKeys(Keys.ENTER);
                    break;
                case "Tape number":
                    web.findElement(TAPENUMBERFIELDSELECTOR).sendKeys(map.getValue());
                    break;
                case "Comments":
                    web.findElement(COMMENTFIELDSELECTOR).sendKeys(map.getValue());
                    break;
            }
        }
    }

    public void clickSaveButton(){
        save.click();
    }

}
