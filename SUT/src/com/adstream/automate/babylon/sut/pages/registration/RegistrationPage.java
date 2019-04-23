package com.adstream.automate.babylon.sut.pages.registration;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 10.02.14
 * Time: 12:00
 */
public class RegistrationPage extends BasePage {
    private static final String FIRST_NAME = "FirstName";
    private static final String LAST_NAME = "LastName";
    private static final String EMAIL = "Email";
    private static final String PASSWORD = "Password";
    private static final String CONFIRM_PASSWORD = "ConfirmPassword";

    private static final By FORM_LOCATOR = By.cssSelector("[id*='registration']");

    private Edit firstNameField;
    private Edit lastNameField;
    private Edit emailField;
    private Edit passwordField;
    private Edit confirmPasswordField;
    private Button signUpButton;

    public RegistrationPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
        firstNameField = new Edit(this, By.name("firstName"));
        lastNameField = new Edit(this, By.name("lastName"));
        emailField = new Edit(this, By.name("email"));
        passwordField = new Edit(this, By.name("password"));
        confirmPasswordField = new Edit(this, By.name("confirmPassword"));
        signUpButton = new Button(this,  By.cssSelector("[data-role='save']"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(FORM_LOCATOR));
        assertTrue(firstNameField.isVisible());
        assertTrue(lastNameField.isVisible());
        assertTrue(emailField.isVisible());
        assertTrue(passwordField.isVisible());
        assertTrue(confirmPasswordField.isVisible());
        assertTrue(signUpButton.isVisible());
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(FORM_LOCATOR);
        firstNameField.isVisible();
        lastNameField.isVisible();
        emailField.isVisible();
        passwordField.isVisible();
        confirmPasswordField.isVisible();
        signUpButton.isVisible();
    }

    public String getTextColor() {
        return convertColorRGBToHash(web.findElement(By.className("registration-body")).getCssValue("color"));
    }

    public String getFooterTextColor() {
        return convertColorRGBToHash(web.findElement(By.cssSelector(".footer .content")).getCssValue("color"));
    }

    public String getButtonColor() {
        return convertColorRGBToHash(web.findElement(By.cssSelector("button")).getCssValue("background-color"));
    }

    public String getLinkColor() {
        return convertColorRGBToHash(web.findElement(By.cssSelector("a")).getCssValue("color"));
    }

    public String getBackgroundColor() {
        return convertColorRGBToHash(web.findElement(By.className("registration-body")).getCssValue("background-color"));
    }

    public String getFooterColor() {
        return convertColorRGBToHash(web.findElement(By.className("footer")).getCssValue("background-color"));
    }

    public String getFooterText() {
        return web.findElement(By.cssSelector(".footer .content")).getText();
    }

    public String getMessage() {
        return web.findElement(By.className("font22")).getText().trim();
    }

    public String getBackgroundAlign() {
        return web.findElement(By.className("registration-body")).getCssValue("background-image").contains("center") ? "full" : "left";
    }

    public String getLogoBase64String() {
        return web.findElement(By.className("logo-block")).getCssValue("background-image").replaceFirst(".*url\\(\".*base64,(.+)\"\\)","$1");
    }

    public String getBackgroundBase64String() {
        return web.findElement(By.className("registration-body")).getCssValue("background-image").replaceFirst(".*url\\(\".*base64,(.+)\"\\)","$1");
    }

    public String getRegistrationFormText() {
        return web.findElement(By.cssSelector("[id*=registration]")).getText().trim();
    }

    public void register(Map<String,String> fields) {
        fill(fields);
        signUpButton.click();
    }

    public void fill(Map<String,String> fields) {
        if (fields.get(FIRST_NAME) != null) firstNameField.type(fields.get(FIRST_NAME));
        if (fields.get(LAST_NAME) != null) lastNameField.type(fields.get(LAST_NAME));
        if (fields.get(EMAIL) != null) emailField.type(fields.get(EMAIL));
        if (fields.get(PASSWORD) != null) passwordField.type(fields.get(PASSWORD));
        if (fields.get(CONFIRM_PASSWORD) != null) confirmPasswordField.type(fields.get(CONFIRM_PASSWORD));
    }

    private String convertColorRGBToHash(String rgb) {
        Matcher m = Pattern.compile("rgba?.*?(?<r>\\d+).*?(?<g>\\d+).*?(?<b>\\d+)", Pattern.CASE_INSENSITIVE).matcher(rgb);

        if (m.find()) {
            return String.format("#%s%s%s",
                    Integer.toHexString(Integer.parseInt(m.group("r"))),
                    Integer.toHexString(Integer.parseInt(m.group("g"))),
                    Integer.toHexString(Integer.parseInt(m.group("b"))));
        } else {
            throw new IllegalStateException(String.format("Invalid rgb color given: '%s'", rgb));
        }
    }
}