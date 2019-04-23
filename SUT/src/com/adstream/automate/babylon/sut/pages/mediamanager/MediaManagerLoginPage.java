package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
/**
 * Created by Saritha.Dhanala on 14/11/2017.
 */
public class MediaManagerLoginPage  {
    ExtendedWebDriver web;

    private By loginField = By.xpath("//input[@name='username']");
    private By passwordField = By.xpath("//input[@name='password']");
    private By loginButton = By.xpath("//input[@type='submit']");
    private By registerLink = By.xpath("//a[contains(text(),'Sign up')]");

    public MediaManagerLoginPage(ExtendedWebDriver web){this.web = web;
    }

    public boolean isLoginButtonVisible(){
        boolean loginDisplay = false;
        try {
            loginDisplay = web.findElement(loginButton).isDisplayed();
        }catch(Exception e){
            e.getMessage();
        }
        return loginDisplay;
    }

    public void clickLoginButton() {
        web.findElement(loginButton).click();
    }

    public void enterUserName(String uName){
        web.findElement(loginField).sendKeys(uName);
    }

    public void enterPassword(String password){
        web.findElement(passwordField).sendKeys(password);
    }

    public MediaManagerRegistrationForm clickRegisterLink(){
         web.findElement(registerLink).click();
        return new MediaManagerRegistrationForm(web);
    }

    public boolean isLogoutVisible(){return web.isElementVisible(By.xpath("//a[@href='/logout']"));}

    public boolean isErrorMessageExists(){
        return web.isElementVisible(By.xpath("//div[@class='ui error message']"));
    }
}
