package com.adstream.automate.babylon.sut.pages.login;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 13:21
 */
public class BeamLoginPage extends LoginPage {
    private static final By FORM_LOCATOR = By.cssSelector("#externalLoginForm,#login-form");
    private static final By Logo_LOCATOR = By.cssSelector(".size8of15.logo-block");
    private Edit loginEdit;
    private Edit passwordEdit;
    private Button loginButton;

    public BeamLoginPage(ExtendedWebDriver web) {
        super(web);
    }
    @Override
    public void init() {
        super.init();
        loginEdit = new Edit(this, By.name("username"));
        passwordEdit = new Edit(this, By.name("password"));
        loginButton = new Button(this,  By.cssSelector(".signin,.button[value='Login']"));
    }
    @Override
    public void load() {
        web.waitUntilElementAppearVisible(FORM_LOCATOR);
        web.waitUntilElementAppearVisible(Logo_LOCATOR);
        loginEdit.visible();
        passwordEdit.visible();
        loginButton.visible();
    }

    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(FORM_LOCATOR));
        assertTrue(loginEdit.isVisible());
        assertTrue(passwordEdit.isVisible());
        assertTrue(loginButton.isVisible());
        assertTrue(isClientBackground());
    }
    public boolean isClientBackground() {
        return web.findElement(By.cssSelector(".main-logo[src='/cosmos/img/login_a5/beam.png']")).isDisplayed();
    }

}

