package com.adstream.automate.babylon.sut.pages.login;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.ResetPasswordPopUpWindow;
//import com.adstream.automate.babylon.sut.pages.traffic.element.TrafficWalkMePopup;
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
public class LoginPage extends BasePage {
    private static final By FORM_LOCATOR = By.cssSelector("#externalLoginForm,#login-form");

    private Edit loginEdit;
    private Edit passwordEdit;
    private Button loginButton;
    private By defaultLogoLocator = By.xpath("//*[normalize-space(text())='Sign in to your Adbank']");
    private By customLogoLocator =  By.xpath("//*[normalize-space(text())='Sign in to your Adbank']");

    public LoginPage(ExtendedWebDriver web) {
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
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(FORM_LOCATOR));
        assertTrue(loginEdit.isVisible());
        assertTrue(passwordEdit.isVisible());
        assertTrue(loginButton.isVisible());
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(FORM_LOCATOR);
        loginEdit.visible();
        passwordEdit.visible();
        loginButton.visible();
    }

    public void login(String login, String pass) {
        fill(login,pass);
        loginButton.click();
      /*  if(isTrafficWalkMePopupPresent()){
          TrafficWalkMePopup trafficWalkMePopup= new TrafficWalkMePopup(this);
            trafficWalkMePopup.clickClose();
        }*/
    }

    public void fill(String login, String password) {
        loginEdit.setValue(login);
        passwordEdit.setValue(password);
    }

    public ResetPasswordPopUpWindow clickForgotPasswordLink() {
        web.findElement(By.className("reset")).click();
        return new ResetPasswordPopUpWindow(this);
    }

    @Override
    public String getAlertMessage() {
        return web.findElement(By.cssSelector(".popupWindow .error")).getText();
    }

    public String getNotificationErrorMessage() {
        return web.waitUntilElementAppearVisible(By.cssSelector("#notification.error")).getText();
    }

    public String getNotificationSuccessMessage() {
        return web.waitUntilElementAppearVisible(By.cssSelector("#notification-success")).getText();
    }

    public String getButtonColour() {
        return web.findElement(By.className("signin")).getCssValue("background-color").trim();
    }

    public String getLinkColour() {
        return web.findElement(By.className("reset")).getCssValue("color").trim();
    }

    public String getTextColour() {
        return web.findElement(By.tagName("body")).getCssValue("color").trim();
    }

    public String getFooterColour() {
        return web.findElement(By.className("a5Footer")).getCssValue("background-color").trim();
    }

    public String getWelcomeMessage() {
        return web.findElement(By.className("header")).getText().trim();
    }

    public boolean isNewLogoExist() {
        return !web.isElementPresent(customLogoLocator);
    }
    public boolean isNewBackground() {
        return web.findElement(By.cssSelector(".a5MainViewContainer")).getCssValue("background-image").contains(("documentId=54c26469e4b075ef647eefe8&logoPath=_cm.login.background"));
    }

    public boolean isDefaultLogo() {
       return web.isElementPresent(defaultLogoLocator);
    }

    public boolean isDefaultBackground() {
       return web.findElement(By.cssSelector(".a5MainViewContainer")).getCssValue("background-image").equalsIgnoreCase("none");
    }

    //NGN-18838 GDAM Checklist Automation Code Starts
    public boolean isSchawkBackground() {
        return web.findElement(By.xpath("//*[normalize-space(text())='Log-in to Adbank']")).isDisplayed();
    }

    public boolean isSchawkLogoPresent() {
        if (web.findElement(By.cssSelector(".a5MainView .pane.left")).getCssValue("background-image").contains("url(\"https://a5.adstream.com/agencyLoginStyle/logo?documentType=group&documentId=52d90bb5e4b066490ba028d9&logoPath=_cm.login.logo\")") &&
                web.findElement(By.cssSelector(".a5MainViewContainer")).getCssValue("background-image").contains("url(\"https://a5.adstream.com/agencyLoginStyle/logo?documentType=group&documentId=52d90bb5e4b066490ba028d9&logoPath=_cm.login.background\")")) {
            return true;
        } else {
            return false;
        }
    }
    public boolean isAppleBeamLogo() {
        return web.findElement(By.cssSelector(" .main-logo[src='/cosmos/img/login_a5/apple.png']")).isDisplayed();
    }

    public boolean isBeamBackground() {
        return web.findElement(By.cssSelector(".main-logo[src='/cosmos/img/login_a5/beam.png']")).isDisplayed();
    }
    public boolean isCustomBrandingBackground() {
        if (web.findElement(By.cssSelector(".a5MainViewContainer")).getCssValue("background-image").contains("url(\""+ TestsContext.getInstance().applicationUrl+"/agencyLoginStyle/logo?documentType=group&documentId=54c26469e4b075ef647eefe8&logoPath=_cm.login.background\")")
                && web.findElement(By.cssSelector(".a5MainView .pane.left")).getCssValue("background-image").contains("url(\""+TestsContext.getInstance().applicationUrl+"/agencyLoginStyle/logo?documentType=group&documentId=54c26469e4b075ef647eefe8&logoPath=_cm.login.logo\")")) {
             return true;
        } else {
            return false;
        }
    }
    //NGN-18838 GDAM Checklist Automation Code Ends
}