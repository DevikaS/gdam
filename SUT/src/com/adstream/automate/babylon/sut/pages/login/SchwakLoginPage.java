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
public class SchwakLoginPage extends LoginPage {
    private static final By FORM_LOCATOR = By.cssSelector("#externalLoginForm,#login-form");
    private static final By Logo_LOCATOR = By.cssSelector(".pane.left");
    private Edit loginEdit;
    private Edit passwordEdit;
    private Button loginButton;

    public SchwakLoginPage(ExtendedWebDriver web) {
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
        assertTrue(isClientLogoPresent());
    }
    public boolean isClientBackground() {
            return web.findElement(By.xpath("//*[normalize-space(text())='Log-in to Adbank']")).isDisplayed();
    }
    public boolean isClientLogoPresent() {
        if(web.findElement(By.cssSelector(".a5MainView .pane.left")).getCssValue("background-image").contains("url(\"https://a5.adstream.com/agencyLoginStyle/logo?documentType=group&documentId=52d90bb5e4b066490ba028d9&logoPath=_cm.login.logo\")")&&
 web.findElement(By.cssSelector(".a5MainViewContainer")).getCssValue("background-image").contains("url(\"https://a5.adstream.com/agencyLoginStyle/logo?documentType=group&documentId=52d90bb5e4b066490ba028d9&logoPath=_cm.login.background\")")){
            return true;
        }else{
            return false;
        }
    }

}