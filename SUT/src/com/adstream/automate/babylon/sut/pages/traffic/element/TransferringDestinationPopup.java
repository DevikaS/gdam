package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

/**
 * Created by Janaki.Kamat on 28/07/2016.
 */
public class TransferringDestinationPopup extends PopUpWindow {

    private static final By DATEFIELDSELECTOR = By.cssSelector("[data-role='date']");
    private static final By TIMEFIELDSELECTOR = By.cssSelector("[data-role='time']");
    private static final By SAVEBUTTONSELECTOR = By.cssSelector("[data-role='save']");
    private static final By TITLESELECTOR = By.cssSelector("[id='common_Dialog_0_title']");
    private Button save;
    private Edit dateField;
    private Edit selectTime;
    private Span title;



    public TransferringDestinationPopup(String Label,Page parentPage) {
        super(parentPage);
        save = new Button(parentPage, SAVEBUTTONSELECTOR);
        selectTime = new Edit(parentPage, TIMEFIELDSELECTOR);
        dateField = new Edit(parentPage,DATEFIELDSELECTOR);
        title = new Span(parentPage,TITLESELECTOR);
    }

    public void fillTransferringDestinationForm(Map<String, String> data){
        for (Map.Entry<String,String> map : data.entrySet()) {
            switch (map.getKey()) {
                case "Date":
                    dateField.type(map.getValue());
                    Common.sleep(1000);
                    web.findElement(DATEFIELDSELECTOR).click();
                    break;
                case "Time":
                    selectTime.type(map.getValue());
                    Common.sleep(1000);
                    web.findElement(TIMEFIELDSELECTOR).sendKeys(Keys.ENTER);
                    break;
                 }
        }
    }

    public void clickSaveButton(){
        save.click();
        web.sleep(3000);
    }

}
