package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;

import javax.swing.*;

/**
 * Created by denysb on 30/11/2015.
 */
public class TrafficOrderSummaryPage extends BaseTrafficPage {

    public static final By isLoaded = By.cssSelector("[data-dojo-type='ordering.proceed.Manager']");
    public static final By confirmButtonSelector = By.cssSelector("[data-role='confirm']");
    public static final By doneButtonSelector = By.cssSelector("[data-role='done']");
    public Button confirmButton;
    public Button doneButton;

    private By orderCompleted = By.cssSelector("[data-name='notificationEmails.completed']");
    private By orderIngested = By.cssSelector("[data-name='notificationEmails.ingested']");
    private By orderDeliveredNotificationCheckBox = By.name("notifyAboutDelivery");
    private By qcNotificationCheckBox = By.name("notifyAboutQc");


    public TrafficOrderSummaryPage(ExtendedWebDriver web) {
        super(web);
        confirmButton = new Button(this,confirmButtonSelector);
        doneButton = new Button(this,doneButtonSelector);
    }

    @Override
    public void isLoaded(){
        web.isElementVisible(isLoaded);
    }

    public void clickConfirmButtonOnTrafficOrderSummaryPage(){
      //  web.waitUntilElementAppearVisible(confirmButtonSelector);
        long start = System.currentTimeMillis();
        long timeOut=2000;
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 1);
            if (System.currentTimeMillis() - start > 20000) {
                throw new TimeoutException("Timeout during waiting for Confirm button");
            }
        } while (!web.isElementVisible(By.cssSelector("[data-role='confirm']")));
        confirmButton.click();
    }

    public void clickDoneButtonOnTrafficOrderSummaryPage(){
     //   web.waitUntilElementAppearVisible(doneButtonSelector);
    //    doneButton.click();
        long start = System.currentTimeMillis();
        long timeOut=2000;
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 1);
            if (System.currentTimeMillis() - start > 20000) {
                throw new TimeoutException("Timeout during waiting for Done button");
            }
        } while (!web.isElementVisible(By.cssSelector("[data-role='done']")));
        doneButton.click();
    }

    public void enterOrderRecipientEmail(String orderStatus, String email){
       if(orderStatus.equals("completed")) {
           if (web.findElement(orderCompleted).getText() != null) {
               web.findElement(orderCompleted).sendKeys("," + email);
           } else {
               web.findElement(orderCompleted).sendKeys(email);
           }
       }
        else if(orderStatus.equals("ingested")) {
           if (web.findElement(orderIngested).getText() != null) {
               web.findElement(orderIngested).sendKeys("," + email);
           } else {
               web.findElement(orderIngested).sendKeys(email);
           }
           }
    }

    public void clickOrderNotificationsByEmail(String orderStatus){
        if(orderStatus.equals("delivered")) {
            web.findElement(orderDeliveredNotificationCheckBox).click();
        }
        else if(orderStatus.equals("passedQC")){
            web.findElement(qcNotificationCheckBox).click();
        }
    }


}
