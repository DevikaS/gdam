package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

/**
 * Created by Saritha.Dhanala on 23/01/2018.
 */
public class MediaManagerRegistrationForm  {
    ExtendedWebDriver web;

    private By firstName = By.xpath("//input[@id='firstName']");
    private By lastName = By.xpath("//input[@id='lastName']");
    private By email = By.xpath("//input[@id='email']");
    private By password = By.xpath("//input[@id='password']");
    private By confirmPassword = By.xpath("//input[@id='password-confirm']");
    private By backToLogin = By.linkText("Back to Login");
    private By registerButton = By.xpath("//input[@type='submit']");

    public MediaManagerRegistrationForm(ExtendedWebDriver web){this.web = web;
    }

    public void fillRegisterForm(String fieldName, String fieldValues) {
        switch(fieldName){
            case "First name":  web.findElement(firstName).sendKeys(fieldValues);
                  break;
            case "Last name":  web.findElement(lastName).sendKeys(fieldValues);
                break;
            case "Email":  web.findElement(email).sendKeys(fieldValues);
                break;
            case "Password":  web.findElement(password).sendKeys(fieldValues);
                break;
            case "Confirm password":  web.findElement(confirmPassword).sendKeys(fieldValues);
                break;
        }
    }

    public void clickRegisterButton(){
         web.findElement(registerButton).click();
    }

    public void clickBackToLoginLink(){
        web.findElement(backToLogin).click();
    }

    public String getVerifyWrongEmailMessage(){
        return web.findElement(By.cssSelector(".kc-feedback-text")).getText();
    }

    public String getEmailMessage(){
        return web.findElement(By.cssSelector(".kc-feedback-text")).getText();
    }

    public boolean isErrorMessageExists(){
        return web.isElementVisible(By.xpath("//div[@class='ui error message']"));
    }

    public void acceptPrivacyCondition(){
        web.findElement(By.xpath("//input[@name = 'accept']")).click();
        web.findElement(By.xpath("//input[@id = 'kc-accept']")).click();
    }
}
