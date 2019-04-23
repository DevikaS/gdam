package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import com.google.common.base.Function;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import java.io.File;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 19.06.14
 * Time: 20:02
 */
public class AdbankWorkRequestCreatePage extends AdbankTemplatesCreatePage {
    public AdbankWorkRequestCreatePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    public void load() {
        super.load();
        web.waitUntilElementAppear(By.cssSelector(".popupWindow [data-dojo-props*='adkit']"));
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector(".popupWindow [data-dojo-props*='adkit']")));
    }

    public void setTemplateName(String templateName) {
        new DojoCombo(this, By.className("templateSelector")).selectByVisibleText(templateName);
    }

    public AdbankWorkRequestCreatePage fill(Map<String,String> fields) {
        super.fill(fields);
        return this;
    }

    public void uploadBrief(final String path) {
        if (path != null && !path.isEmpty()) {
            web.findElement(By.cssSelector("#brief_uploader [type='file']")).sendKeys(path);
            Common.sleep(100);
            web.waitUntil(new Function<WebDriver, Object>() {
                @Override
                public Object apply(WebDriver webDriver) {
                    return web.findElement(By.id("upload_progress")).getText()
                            .matches(".*" + new File(path).getName() + ".*");
                }
            });
        }
    }

    public boolean isRemoveButtonPresentNextToUploadedBrief() {
        By locator = By.cssSelector("[data-role='remove_file']");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void setTemplateInheritanceOption(String option, boolean state) {
        By locator;
        if (option.equalsIgnoreCase("IncludeFolders")) {
            locator = By.name("cloneFolders");
        } else if (option.equalsIgnoreCase("IncludeTeam")) {
            locator = By.name("cloneTeam");
        } else if (option.equalsIgnoreCase("IncludeFiles")) {
            locator = By.name("cloneFiles");
        } else {
            throw new IllegalArgumentException(String.format("Unknown template inheritance ontion: '%s' on create new work request popup", option));
        }

        if (state) {
            new Checkbox(this, locator).select();
        } else {
            new Checkbox(this, locator).deselect();
        }
    }

    public boolean isTemplateInheritanceOptionSelected(String option) {
        By locator;
        if (option.equalsIgnoreCase("IncludeFolders")) {
            locator = By.name("cloneFolders");
        } else if (option.equalsIgnoreCase("IncludeTeam")) {
            locator = By.name("cloneTeam");
        } else if (option.equalsIgnoreCase("IncludeFiles")) {
            locator = By.name("cloneFiles");
        } else {
            throw new IllegalArgumentException(String.format("Unknown template inheritance ontion: '%s' on create new work request popup", option));
        }
        return web.isElementPresent(locator) && web.isElementVisible(locator) && new Checkbox(this, locator).isSelected();
    }

    public void selectPublishImmediatelyCheckbox() {
        new Checkbox(this, By.name("publishImmediately")).select();
    }

    public boolean isPublishImmediatelyCheckboxSelected() {
        return new Checkbox(this, By.name("publishImmediately")).isSelected();
    }

    public boolean isTemplateFieldVisible() {
        By locator = By.className("templateSelector");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }
}