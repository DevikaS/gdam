package com.adstream.automate.babylon.sut.pages.login;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: Geethanjali.K
 * Date: 26.05.16
 * Time: 13:21
 */
public class ElizabethArdenLoginPage extends LoginPage {

    private Button loginButton;

    public ElizabethArdenLoginPage(ExtendedWebDriver web) {
        super(web);
    }
    @Override
    public void init() {
        loginButton = new Button(this,  By.cssSelector(".button.red-style"));
    }
    @Override
    public void load() {
        loginButton.visible();
    }
    @Override
    public void isLoaded() throws Error {
        assertTrue(loginButton.isVisible());
    }

    public boolean isClientBackground() {
            return web.findElement(By.cssSelector(".main-logo[src='/cosmos/img/login_a5/elizabethArden.png']")).isDisplayed();
    }

 }