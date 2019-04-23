package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 08.02.12
 * Time: 20:02
 */
public class AdbankProjectsCreatePage extends AdbankTemplatesCreatePage {
    public DojoCombo templateTextBox;
    public Checkbox includeFolders;
    public Checkbox includeTeam;
    public Checkbox includeFiles;

    public AdbankProjectsCreatePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
        this.templateTextBox = new DojoCombo(this, By.className("templateSelector"));
        this.includeFolders = new Checkbox(this, By.name("cloneFolders"));
        this.includeTeam = new Checkbox(this, By.name("cloneTeam"));
        this.includeFiles = new Checkbox(this, By.name("cloneFiles"));
    }

    public void setTemplateName(String templateName) {
        templateTextBox.selectByVisibleText(templateName);
    }

    public void typeTemplateName(String templateName) {
        web.typeClean(getTemplateNameTextBoxLocator(), templateName);
        web.waitUntilElementAppearVisible(By.cssSelector(".dijitComboBoxMenu"));
    }

    public String getTemplateName() {
        return new DojoCombo(this, By.className("templateSelector")).getDisplayedValue();
    }

    public AdbankProjectsCreatePage fill(Map<String,String> fields) {
        super.fill(fields);
        return this;
    }

    public AdbankProjectsCreatePage fillClientProject(Map<String,String> fields) {
        super.fillClientProject(fields);
        return this;
    }
    public boolean isPublishImmediatelyCheckboxSelected() {
        return new Checkbox(this, By.name("publishImmediately")).isSelected();
    }

    public boolean isTemplateFieldVisible() {
        By locator = By.className("templateSelector");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void selectPublishImmediatelyCheckbox() {
        new Checkbox(this, By.name("publishImmediately")).select();
    }

    private By getTemplateNameTextBoxLocator() {
        return By.cssSelector(".templateSelector [role='textbox']");
    }
}
