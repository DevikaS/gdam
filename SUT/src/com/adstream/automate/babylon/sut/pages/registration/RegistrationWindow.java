package com.adstream.automate.babylon.sut.pages.registration;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 20.11.12
 * Time: 15:37
 */
public class RegistrationWindow extends Page<RegistrationWindow> {

    public RegistrationWindow(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void setFirstName(String firstName) {
        web.typeClean(By.name("firstName"), firstName);
    }

    public void setLastName(String lastName) {
        web.typeClean(By.name("lastName"), lastName);
    }

    public void clickSignUpButton() {
        web.click(By.xpath("//span[text()='Sign Up']"));
    }

    public void setPassword(String defaultUserPassword) {
        web.typeClean(By.name("password"),defaultUserPassword);
    }

    public void setPasswordConfirm(String defaultUserPassword) {
        web.typeClean(By.name("confirmPassword"),defaultUserPassword);
    }

    @Override
    public void load() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void isLoaded() throws Error {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public String getEmail() {
        return web.findElement(By.name("email")).getAttribute("value");  //To change body of created methods use File | Settings | File Templates.
    }
}
