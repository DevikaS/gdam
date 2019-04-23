package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 08.02.12
 * Time: 20:02
 */
public class AdbankTemplatesListPage extends AdbankPaginator {
    public AdbankTemplatesListPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        //web.waitUntilElementAppearVisible(By.xpath("//a[@class='active' and normalize-space(text())='Project Templates']"));
        web.waitUntilElementAppearVisible(By.xpath("//a[@href='#projects/templates']"));
        web.waitUntilElementAppear(By.cssSelector(".itemsList"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        //assertTrue(web.isElementVisible(By.xpath("//a[@class='active' and normalize-space(text())='Project Templates']")));
        assertTrue(web.isElementVisible(By.xpath("//a[@href='#projects/templates']")));
        assertTrue(web.isElementPresent(By.cssSelector(".itemsList")));
    }

    public String getSelectedViewType() {
        return web.findElement(By.cssSelector("[class*='border-left plm prl'] .dijitSelect")).getText();
    }

    public AdbankTemplatesCreatePage clickCreateNewTemplate() {
        web.click(By.cssSelector("[data-dojo-type='common.newTemplate']"));
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankTemplatesCreatePage(web);
    }

    public AdbankWorkRequestTemplateCreatePage clickCreateNewWorkRequestTemplate() {
        web.click(By.cssSelector("[data-dojo-type='common.newTemplate'][data-dojo-props*='adkit_template']"));
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankWorkRequestTemplateCreatePage(web);
    }

    public WebElement getSortFieldByFieldName(String fieldName) {
        return web.findElement(By.cssSelector("[fieldname='" + fieldName + "']"));
    }

    public String getClassOfSortField(String fieldName) {
        WebElement webElement = getSortFieldByFieldName(fieldName);
        return webElement.getAttribute("class") == null ? "" : webElement.getAttribute("class");
    }

    public void clickSortField(String fieldName) {
        WebElement container = web.findElement(By.cssSelector(".itemsList:first-child"));
        web.click(By.cssSelector("*[fieldname='" + fieldName + "']"));
        web.waitUntilElementChanged(container);
    }

    public List<String> getListOfTemplatesFields(String fieldName) {
        String css= "";
        if (fieldName.contains("name")) {
            css = "[data-dojo-type='adbank.templates.templateLocator']";
        }
        else if (fieldName.equalsIgnoreCase("createdBy.fullName")) {
            css = ".row.clearfix.pointer .size1of4.unit.cell .dateCreated";
        }
        else if (fieldName.contains("projectMediaType")) {
            css = ".row.clearfix.pointer > .size1of8.unit.cell";
        }
        return web.findElementsToStrings(By.cssSelector(css));
    }

    public AdbankProjectFromTemplateCreatePage clickUseTemplate(String templateName) {
        String locator = String.format("//*[@data-type='tableRow'][.//a[normalize-space()='%s']]//*[@data-dojo-type='common.newProject']", templateName);
        web.click(By.xpath(locator));
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup [data-role='schemedContent']"));
        return new AdbankProjectFromTemplateCreatePage(web);
    }

    public void clickUseTemplateButton(String templateName) {
        String locator = String.format("//*[@data-type='tableRow'][.//a[normalize-space()='%s']]//*[@data-dojo-type='common.newProject']", templateName);
        web.click(By.xpath(locator));
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup [data-role='schemedContent']"));
    }

    public boolean isCreateNewTemplatePopUpVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow > [title='New Template']"));
    }

    public boolean isCreateNewWorkRequestTemplatePopUpVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow [data-dojo-props*='adkit']"));
    }

    public void selectViewFilter(String type) {
        DojoSelect select = new DojoSelect(this, By.xpath("(//table[descendant::input[@name='View']])[2]"));
        select.selectByVisibleText(type);
        Common.sleep(1000);
    }
}
