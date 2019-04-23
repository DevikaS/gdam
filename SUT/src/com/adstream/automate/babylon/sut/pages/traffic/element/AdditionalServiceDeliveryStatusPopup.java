package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Select;
import org.openqa.selenium.By;

/**
 * Created by Janaki.Kamat on 29/11/2018.
 */
public class AdditionalServiceDeliveryStatusPopup extends PopUpWindow {
    private static final By date = By.cssSelector("[datepicker-options=\"$timestampInputCtrl.datepickerOptions\"]");
    private static final By hour = By.cssSelector("[placeholder=\"HH\"]");
    private static final By minute= By.cssSelector("[placeholder=\"MM\"]");
    private static final By saveButtonLocator = By.cssSelector(".btn.btn-primary");
    private Button saveButton;
    private Edit dateField;
    private Edit hourField;
    private Edit minuteField;

    public AdditionalServiceDeliveryStatusPopup(Page parentPage) {
        super(parentPage);
        dateField = new Edit(parentPage,date);
        hourField = new Edit(parentPage,hour);
        minuteField = new Edit(parentPage,minute);
        saveButton = new Button(parentPage,saveButtonLocator);
      }

    public void fillDate(String value){
      dateField.type(value);
    }

    public void fillHour(String value){
       hourField.type(value);
    }

    public void fillMinute(String value){
        minuteField.type(value);
    }

    public void clickSaveButton(){
        saveButton.click();
    }

}
