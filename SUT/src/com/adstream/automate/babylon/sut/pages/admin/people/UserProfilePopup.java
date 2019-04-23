package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.09.12
 * Time: 8:33

 */
public class UserProfilePopup extends PopUpWindow {
    public Button resetPassword;

    public WebElement logoSrc;
    public WebElement username;
    public WebElement agency;

    public WebElement jobTitle;
    public WebElement emailAddress;
    public WebElement officeNumber;
    public WebElement mobileNumber;
    public WebElement skype;
    public WebElement googleTalk;

    public UserProfilePopup(Page<? extends Page> parentPage) {
        super(parentPage);

        this.resetPassword = new Button(parentPage, generateLocator(".button.reset"));

        this.logoSrc = web.findElement(generateLocator(".avatar img"));
        this.username = web.findElement(generateLocator(".unit .h4[style]"));
        this.agency = web.findElement(generateLocator(".unit .h4.mtxs"));

        this.jobTitle = getInfoFieldElementByName("Job Title");
        this.emailAddress = getInfoFieldElementByName("Email Address");
        this.officeNumber = getInfoFieldElementByName("Office Number");
        this.mobileNumber = getInfoFieldElementByName("Mobile Number");
        this.skype = getInfoFieldElementByName("Skype");
        this.googleTalk = getInfoFieldElementByName("Google Talk Contact");
    }

    public String getLogoSrc() {
        return logoSrc.getAttribute("SRC").trim();
    }

    public String getUsername() {
        return username.getText().trim();
    }

    public String getAgency() {
        return agency.getText().trim();
    }

    public String getJobTitle() {
        return jobTitle.getText().trim();
    }

    public String getEmailAddress() {
        return emailAddress.getText().trim();
    }

    public String getOfficeNumber() {
        return officeNumber.getText().trim();
    }

    public String getMobileNumber() {
        return mobileNumber.getText().trim();
    }

    public String getSkype() {
        return skype.getText().trim();
    }

    public String getGoogleTalk() {
        return googleTalk.getText().trim();
    }

    private WebElement getInfoFieldElementByName(String name) {
        String parentXpath = "//*[contains(@class,'popupWindow')][not(contains(@style,'display: none'))][*[normalize-space()='User Profile']]";
        return web.findElement(By.xpath(parentXpath + String.format("//*[*[normalize-space(text())='%s:']]/span", name)));
    }

}
