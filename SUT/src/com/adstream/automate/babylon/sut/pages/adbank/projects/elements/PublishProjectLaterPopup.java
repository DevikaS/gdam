package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.DojoDateTextBox;
import com.adstream.automate.page.controls.DojoEdit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: sadikov-o
 * Date: 2/11/13
 * Time: 1:05 PM
 */
public class PublishProjectLaterPopup extends PopUpWindow {
    Button save;
    public DojoDateTextBox publishDateBox;
    public DojoDateTextBox publishTimeBox;
    public DojoCombo publishDateTimeZoneBox;
    public DojoEdit message;

    public PublishProjectLaterPopup(Page parentPage) {
        super(parentPage);
        save = new Button(parentPage, generateLocator("#publishLaterBtn"));
        publishDateBox = new DojoDateTextBox(parentPage, By.xpath("//div[contains(@id,'DateTextBox')]"));
        publishTimeBox = new DojoDateTextBox(parentPage, By.xpath("//div[contains(@id,'TimeTextBox')]"));
        publishDateTimeZoneBox = new DojoCombo(parentPage, By.xpath("//div[contains(@id,'timezone')]"));
        message = new DojoEdit(parentPage, By.xpath("//input[@id='publishMessageInput']"));
    }


    public void clickSaveButton() {
        save.click();
    }

    public void fillPopup(String publishDate, String publishTime, String publishDateTimeZone, String publishMessage)
    {

        if(publishDate.contains("Tomorrow"))
        {
            DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            Date date = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            cal.add(Calendar.DATE, 1);
            date = cal.getTime();
            publishDate = dateFormat.format(date);
            publishDateBox.setDisplayedValue(publishDate);
        }
        publishTimeBox.setDisplayedValue(publishTime);
        publishDateTimeZoneBox.selectByVisibleText(publishDateTimeZone);
        web.findElement(By.xpath("//input[@id='publishMessageInput']")).sendKeys(publishMessage);

    }

}
