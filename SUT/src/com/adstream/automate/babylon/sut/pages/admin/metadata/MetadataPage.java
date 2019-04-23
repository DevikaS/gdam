package com.adstream.automate.babylon.sut.pages.admin.metadata;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.elements.MetadataFieldSettingsBlock;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AdCodeManager;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;
import static java.util.Arrays.asList;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 29.05.13
 * Time: 12:07
 */
public class MetadataPage extends BaseAdminPage<MetadataPage> {

    public MetadataPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.sleep(4000);
        web.waitUntilElementAppearVisible(By.cssSelector("[id*='admin_metadata_table_setup']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        web.manage().timeouts().implicitlyWait(8, TimeUnit.SECONDS);
//        assertTrue(web.isElementPresent(By.cssSelector("[id*='admin_metadata_table_setup']")));
        assertTrue(web.isElementPresent(By.cssSelector("[id*='admin_metadata_table_setup'] div[data-role='buttonsPlace']")));
    }

    public List<String> getAllCommonMetadataButtonsNames() {
        web.sleep(4000);
        return web.findElementsToStrings(getCommonMetadataButtonsLocator());
    }

    public List<String> getAllEditableMetadataButtonsNames() {
        web.sleep(4000);
        return web.findElementsToStrings(getEditableMetadataButtonsLocator());
    }

    public List<String> getAllCustomMetadataButtonsNames() {
        web.sleep(4000);
        return web.findElementsToStrings(getCustomMetadataButtonsLocator());
    }

    public List<String> getAllFieldsNamesFromActiveMetadataPreviewBlock() {
        return web.findElementsToStrings(By.cssSelector("[data-role='schemedContent'] .schemaDataField:not(.none-display) [data-schema-path]>label,[data-role='schemedContent'] .schemaDataField:not(.none-display) [data-schema-path]>.label"));  // for getting all fields including dates as well
    }

    public List<String> getAllSectionBreakNamesFromActiveMetadataPreviewBlock() {
        return web.findElementsToStrings(By.cssSelector(":not([data-group-name='_default']) > .description-section"));
    }

    public List<String> getAllRequiredFieldsNamesFromActiveMetadataPreviewBlock() {
        return web.findElementsToStrings(By.cssSelector("[data-role='schemedContent'] .required_field"));
    }

    public List<String> getAllVisibleFieldsAndBlocksFromActiveMetadataPreviewBlock() {
        By locator = By.cssSelector("[data-role='schemedContent'] [data-description],[data-role='schemedContent'] .schema_field>label");
        if (web.isElementPresent(locator)) {
            List<String> result = web.findElementsToStrings(locator);
            result.removeAll(asList(""));
            return result;
        } else {
            return new ArrayList<String>();
        }
    }

    public List<String> getAllVisibleBlocksFromActiveMetadataPreviewBlock() {
        By locator = By.xpath("//*[@data-role='schemedContent']//*[@data-role='groupDelimeter'][not(normalize-space()='')]");
        return web.findElementsToStrings(locator);
    }

    public List<String> getAllDropdownFieldsFromActiveMetadataPreviewBlock() {
        By locator = By.xpath("//*[@data-role='schemedContent']//*[contains(@class,'schemaDataField') and not(contains(@class,'none-display'))][.//*[@role='combobox']]");
        return web.findElementsToStrings(locator);
    }

    public List<String> getAllVisibleDateFieldsFromActiveMetadataPreviewBlock() {
        By locator = By.xpath("//*[@data-role='schemedContent']//*[contains(@class,'schemaDataField') and not(contains(@class,'none-display'))][.//*[@role='combobox'][contains(@class,'DateTextBox')]]");
        return web.findElementsToStrings(locator);
    }

    public List<String> getAllVisibleStringFieldsFromActiveMetadataPreviewBlock() {
        By locator = By.xpath("//*[@data-role='schemedContent']//*[contains(@class,'schemaDataField') and not(contains(@class,'none-display'))]//label[*/input[contains(@data-dojo-type,'TextField')]]");
        return web.findElementsToStrings(locator);
    }

    public List<String> getAllMultilineFieldsFromActiveMetadataPreviewBlock() {
        By locator = By.xpath("//*[@data-role='schemedContent']//*[contains(@class,'schemaDataField') and not(contains(@class,'none-display'))][.//textarea]");
        return web.findElementsToStrings(locator);
    }

    public List<String> getAllDropdownChoicesByNameFromActiveMetadataPreviewBlock(String fieldName) {
        By locator = By.xpath(String.format("//*[@data-role='schemedContent']//*[contains(@class,'schemaDataField')][normalize-space()='%s']//*[@role='combobox']", fieldName));
        return new DojoCombo(this, locator).getValues();
    }

    public List<String> getAllRadioButtonsFieldChoicesByNameFromActiveMetadataPreviewBlock(String fieldName) {
        By locator = By.xpath(String.format("//*[@data-dojo-type='common.prop_schema.radioButtons'][label[normalize-space()='%s']]//input", fieldName));
        return web.findElementsToStrings(locator, "value");
    }

    public String getDropdownFieldValueOnActiveMetadataPreviewBlock(String fieldName) {
        By locator = By.xpath(String.format("//*[@data-schema-path][.//*[normalize-space()='%s']]//*[@role='combobox']", fieldName));

        return new DojoCombo(this, locator).getSelectedLabel();
    }

    public String getRadioButtonsFieldValueOnActiveMetadataPreviewBlock(String fieldName) {
        By locator = By.xpath(String.format("//*[@data-schema-path][.//*[normalize-space()='%s']]//*[@checked and not(@value='')]", fieldName));

        return web.isElementPresent(locator) ? web.findElement(locator).getAttribute("value").trim() : "";
    }

    public String getMultilineFieldRowsCount(String fieldName) {
        return web.findElement(By.xpath(String.format("//label[.//*[normalize-space()='%s']]//textarea", fieldName))).getAttribute("rows").trim();
    }

    public MetadataFieldSettingsBlock clickCommonMetadataButtonByName(String buttonName) {
        //web.manage().timeouts().implicitlyWait(60, TimeUnit.SECONDS);
        web.sleep(5000);
        web.waitUntilElementAppearVisible(getCommonMetadataButtonLocator(buttonName));
        web.click(getCommonMetadataButtonLocator(buttonName));

        return new MetadataFieldSettingsBlock(this);
    }

    public void checkIfAvailableMetadataTabIsActive() {
        web.sleep(2000);
        if(!web.isElementPresent(By.cssSelector("[class='active'][data-role='listTab']"))) {
            web.click(By.cssSelector("[data-role='listTab']"));
            web.sleep(2000);
        }
    }

    public boolean checkEditableMetadataButtonByName(String buttonName) {
        return web.isElementPresent(getEditableMetadataButtonLocator(Character.toUpperCase(buttonName.charAt(0)) + buttonName.substring(1)));
    }
    public MetadataFieldSettingsBlock clickEditableMetadataButtonByName(String buttonName) {
        web.sleep(7000);
        web.click(getEditableMetadataButtonLocator(buttonName.toLowerCase()));
        return new MetadataFieldSettingsBlock(this);
    }

    public MetadataFieldSettingsBlock clickCustomMetadataButtonByName(String buttonName) {
        web.sleep(7000);
        web.click(getCustomMetadataButtonLocator(buttonName));
        return new MetadataFieldSettingsBlock(this);
    }

    public void selectFieldOnMetadataPreview(String fieldName) {
        if (!isFieldSelectedOnMetadataPreview(fieldName)) web.click(getMetadataPreviewFieldLocator(fieldName));
    }

    public void selectItemInActiveMetadataPreviewDropdown(String fieldName, String fieldValue) {
        By locator = By.xpath(String.format("//*[@data-role='schemedContent']//*[contains(@class,'schemaDataField')][normalize-space()='%s']//*[@role='combobox']", fieldName));
        new DojoCombo(this, locator).selectByVisibleText(fieldValue);
    }

    public void removeFieldOnMetadataPreview(String fieldName) {
        selectFieldOnMetadataPreview(fieldName);
        web.click(getMetadataFieldRemoveElementLocator(fieldName));
        Common.sleep(3000);
    }

    public void moveFieldsFromGroupToOtherGroup(List<Map<String, String>> fieldsInfo) {
        String script = String.format("var data = dijit.getEnclosingWidget(arguments[0])._prepareReorderData();\n" +
                "var fieldsInfo = " + fieldsInfo.toString().replaceAll("=(\\w*)([,\\}])", ":'$1'$2")) + ".reverse();\n" +
                "\n" +
                "fieldsInfo.forEach(function(fieldInfo) {\n" +
                "    data.items = data.items.map(function(field) {\n" +
                "        if (field.group == fieldInfo.FieldFromGroupId && field.schemaPath.endsWith('.' + fieldInfo.FieldId)) {\n" +
                "            field.order = 1;\n" +
                "            field.group = fieldInfo.FieldToGroupId;\n" +
                "        } else if (field.group == fieldInfo.FieldToGroupId) {\n" +
                "            field.order += 1;\n" +
                "        }\n" +
                "        return field;\n" +
                "    })\n" +
                "})\n" +
                "\n" +
                "dojo.publish('adbank/metadata/reorderPreviewForm', [{groups: data.groups, items: data.items}]);";

        WebElement schemaPreview = web.findElement(By.cssSelector("[id^='admin_metadata_schemaPreview']"));
        web.getJavascriptExecutor().executeScript(script, schemaPreview);
        web.navigate().refresh();
    }


    //Todo: should be reviewed and refactored
    public void reorderFieldsIntoGroup(List<String> orderedFieldNames, String groupName) {
        String group;
        if (groupName.equalsIgnoreCase("default")) {
            group = "_default";
        } else {
            By dataGroupNameLocator = By.xpath(String.format(
                    "//*[@data-role='schemedContent']//*[@data-group-name][normalize-space()='%s']", groupName));
            group = web.findElement(dataGroupNameLocator).getAttribute("data-group-name").trim();
        }

        WebElement previewBlock = web.findElement(By.cssSelector("[data-dojo-type='admin.metadata.schemaPreview']"));

        String schemas = "";
        for (Iterator<String> iterator = orderedFieldNames.iterator(); iterator.hasNext(); ) {
            String fieldName = iterator.next();
            By locator = By.xpath(String.format("//*[@data-role='schemaPreview']//*[contains(@class,'schemaDataField') and not(contains(@class,'none-display'))]//*[@data-schema-path][.//*[normalize-space()='%s']]", fieldName));


            List<String> itemSchemas = web.findElementsToStrings(locator, "data-schema-path");

            if (itemSchemas.size() == 0)
                throw new IllegalStateException(String.format("Cannot find field: '%s'", fieldName));

            String schema;
            schema = itemSchemas.get(0);

            if (itemSchemas.size() > 1) {
                String script = "var data = dijit.getEnclosingWidget(arguments[0])._prepareReorderData();\n" +
                        "var result = {};\n" +
                        "data.items.forEach(function(el) { result[el.schemaPath] = el.group; });\n" +
                        "return result;";

                Map<String, String> schemasByGroups = (Map<String, String>) web.getJavascriptExecutor().executeScript(script, previewBlock);

                for (String itemSchema : itemSchemas) {
                    if (schemasByGroups.get(itemSchema).equals(group)) {
                        schema = itemSchema;
                        break;
                    } else if (schemasByGroups.get(itemSchema).equals("_default")) {
                        schema = itemSchema;
                        break;
                    } else {
                        schema = itemSchema;
                    }
                }


            }

            schemas += iterator.hasNext() ? String.format("\"%s\",", schema) : String.format("\"%s\"", schema);
        }

        String script = String.format("var schemas = [%s];\n" +
                "var group = '%s';\n" +
                "var data = dijit.getEnclosingWidget(arguments[0])._prepareReorderData();\n" +
                "var reorderedItems = [];\n" +
                "var order = 1;\n" +
                "for (var i = 0; i < schemas.length; i++) {\n" +
                "    data.items.forEach(function(item) {\n" +
                "        if (schemas[i] == item.schemaPath) {\n" +
                "            reorderedItems.push({order: order, group: group, schemaPath: schemas[i]});\n" +
                "            order++;\n" +
                "    \t}\n" +
                "    });\n" +
                "}\n" +
                "dojo.publish('adbank/metadata/reorderPreviewForm', [{groups: data.groups, items: reorderedItems}]);", schemas, group);


        web.getJavascriptExecutor().executeScript(script, previewBlock);
        web.navigate().refresh();
    }

    //Todo: should be reviewed and refactored
    public void reorderFieldGroups(List<String> orderedGroupNames) {
        String groups = "";

        for (Iterator<String> iterator = orderedGroupNames.iterator(); iterator.hasNext(); ) {
            String groupName = iterator.next();

            if (groupName.equalsIgnoreCase("default")) {
                groups += "\"_default\"" + (iterator.hasNext() ? "," : "");
            } else {
                By locator = By.xpath(String.format("//*[@data-role='schemaPreview']//*[@data-group-name][normalize-space()='%s']", groupName));
                String group = web.findElement(locator).getAttribute("data-group-name").trim();
                groups += iterator.hasNext() ? String.format("\"%s\",", group) : String.format("\"%s\"", group);
            }
        }

        String script = String.format("var groups = [%s];\n" +
                "var data = dijit.getEnclosingWidget(arguments[0])._prepareReorderData();\n" +
                "var reorderedGroups = {};\n" +
                "var order = 1;\n" +
                "for(var i = 0; i < groups.length; i++) {\n" +
                "\tvar tmpGroup = data.groups[groups[i]];\n" +
                "\ttmpGroup.order = order;\n" +
                "\treorderedGroups[groups[i]] = tmpGroup;\n" +
                "\torder++;\n" +
                "}\n" +
                "for(var groupName in data.groups) {\n" +
                "\tif(!reorderedGroups.hasOwnProperty(groupName)) {\n" +
                "\t\tvar tmpGroup = data.groups[groupName];\n" +
                "\t\ttmpGroup.order = order;\n" +
                "\t\treorderedGroups[groupName] = tmpGroup;\n" +
                "\t\torder++;\n" +
                "\t}\n" +
                "}\n" +
                "dojo.publish('adbank/metadata/reorderPreviewForm', [{groups: reorderedGroups, items: data.items}]);", groups);

        WebElement previewBlock = web.findElement(By.cssSelector("[data-dojo-type='admin.metadata.schemaPreview']"));
        web.getJavascriptExecutor().executeScript(script, previewBlock);
        web.navigate().refresh();
    }

    public boolean isFieldSelectedOnMetadataPreview(String fieldName) {
        return web.findElement(getMetadataPreviewFieldLocator(fieldName)).getAttribute("class").contains("selected");
    }

    public boolean isFieldHaveSize(String fieldName, String fieldSize) {
        if (fieldSize.equalsIgnoreCase("Full Width")) {
            fieldSize = "size1of1";
        } else if (fieldSize.equalsIgnoreCase("Half Width")) {
            fieldSize = "size1of2";
        } else {
            throw new IllegalArgumentException(String.format("Unexpected field size '%s'", fieldSize));
        }

        By fieldLocator = By.xpath(String.format("//*[@data-role='schemedContent']//*[contains(@class,'%s')][normalize-space()='%s']", fieldSize, fieldName));

        return web.isElementPresent(fieldLocator);
    }

    public void typeDescription(String value) {
        web.findElement(getLocatorOfDescriptionField()).clear();
        web.findElement(getLocatorOfDescriptionField()).sendKeys(value);
    }

    public void clickOnPageTab(String page) {
        web.findElement(getPageTabLocator(page)).click();
    }

    public AdCodeManager getAdCodeManager() {
        if (!web.isElementVisible(By.cssSelector(AdCodeManager.ROOT_NODE)))
            throw new NoSuchElementException("There is no AdCode Manager on the custom metadata page");
        return new AdCodeManager(this);
    }

    public void clickCommonMetadataCheckboxLocator(String mark) {
        web.click(getCommonMetadataCheckboxLocator(mark));
    }

    protected By getMetadataPreviewFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[@data-role='schemaPreview']//*[contains(@class,'schemaDataField')][*/*[normalize-space()='%s']]", fieldName));
    }

    protected By getMetadataFieldRemoveElementLocator(String fieldName) {
        return By.xpath(String.format("//*[@data-role='schemaPreview']//*[contains(@class,'schemaDataField')][*/*[normalize-space()='%s']]//*[@data-role='remove']", fieldName));
    }

    protected By getCommonMetadataButtonLocator(String buttonName) {
        return By.xpath(String.format("//*[contains(@class,'button')][*[contains(@data-schema-path,'asset_element_project_common')][.='%s']]", buttonName));
    }

    protected By getEditableMetadataButtonLocator(String buttonName) {
        return By.xpath(String.format("//*[contains(@class,'button')][*[not(contains(@data-schema-path,'asset_element_project_common'))][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='%s']]", buttonName));
    }

    protected By getCustomMetadataButtonLocator(String buttonName) {
        return By.xpath(String.format("//*[@data-field-type='%s'][.//*[contains(@class,'%s')]]",getCMDataFieldTypeByName(buttonName), getCMFieldTypeByName(buttonName)));
    }

    protected By getCommonMetadataButtonsLocator() {
        return By.xpath("//*[contains(@class,'button')][*[contains(@data-schema-path,'asset_element_project_common')]]");
    }

    protected By getEditableMetadataButtonsLocator() {
        return By.xpath("//*[contains(@class,'button')][*[@data-schema-path][not(contains(@data-schema-path,'asset_element_project_common'))]]");
    }

    protected By getCustomMetadataButtonsLocator() {
        return By.cssSelector("[data-field-type]");
    }

    protected By getLocatorOfDescriptionField() {
        return By.cssSelector("[data-role='new-field-description']");
    }

    protected By getCommonMetadataCheckboxLocator(String mark) {
        return By.xpath(String.format("//*[contains(@class, 'valign-middle') and normalize-space(.)='%s']//input", mark));
    }

    protected By getPageTabLocator(String page) {
        return By.xpath("//*[contains(@class, 'nav-tabs')]//*[text()='"+ page +"']");
    }

    private String getCMDataFieldTypeByName(String buttonName) {
        if (buttonName.equalsIgnoreCase("string"))
            return "string";
        else if (buttonName.equalsIgnoreCase("date"))
            return "date";
        else if (buttonName.equalsIgnoreCase("multiline"))
            return "textarea";
        else if (buttonName.equalsIgnoreCase("section break"))
            return "section-break";
        else if (buttonName.equalsIgnoreCase("phone"))
            return "phone";
        else if (buttonName.equalsIgnoreCase("dropdown") || buttonName.equalsIgnoreCase("catalogue structure") || buttonName.equalsIgnoreCase("radio buttons"))
            return "dictionary";
        else if (buttonName.equalsIgnoreCase("address") || buttonName.equalsIgnoreCase("hyperlink"))
            return "object";
        else if (buttonName.equalsIgnoreCase("custom code"))
            return "custom_code";
        else
            throw new IllegalArgumentException(String.format("Unknown button name '%s'", buttonName));
    }

    private String getCMFieldTypeByName(String buttonName) {
        if (buttonName.equalsIgnoreCase("string") || buttonName.equalsIgnoreCase("custom code"))
            return "metadata-string-type";
        else if (buttonName.equalsIgnoreCase("date"))
            return "metadata-date-type";
        else if (buttonName.equalsIgnoreCase("multiline"))
            return "metadata-textarea-type";
        else if (buttonName.equalsIgnoreCase("section break"))
            return "metadata-sectionbreak-type";
        else if (buttonName.equalsIgnoreCase("phone"))
            return "metadata-phone-type";
        else if (buttonName.equalsIgnoreCase("dropdown"))
            return "metadata-dictionary-type";
        else if (buttonName.equalsIgnoreCase("catalogue structure"))
            return "metadata-structure-type";
        else if (buttonName.equalsIgnoreCase("address"))
            return "metadata-email-type";
        else if (buttonName.equalsIgnoreCase("radio buttons"))
            return "metadata-radio-type";
        else if (buttonName.equalsIgnoreCase("hyperlink"))
            return "metadata-hyperlink-type";
        else
            throw new IllegalArgumentException(String.format("Unknown button name '%s'", buttonName));
    }


    //Todo: should be reviewed and refactored
    public void reorderCommonOrderingFieldsIntoGroup(List<String> orderedFieldNames, String groupName) {
        String group;
        if (groupName.equalsIgnoreCase("default")) {
            group = "_default";
        } else {
            By dataGroupNameLocator = By.xpath(String.format(
                    "//*[@data-role='schemedContent']//*[@data-group-name][normalize-space()='%s']", groupName));
            group = web.findElement(dataGroupNameLocator).getAttribute("data-group-name").trim();
        }

        WebElement previewBlock = web.findElement(By.cssSelector("[data-dojo-type='admin.metadata.schemaPreviewOrdering']"));

        String schemas = "";
        for (Iterator<String> iterator = orderedFieldNames.iterator(); iterator.hasNext(); ) {
            String fieldName = iterator.next();
            By locator = By.xpath(String.format("//*[@data-role='schemaPreview']//*[contains(@class,'schemaDataField') and not(contains(@class,'none-display'))]//*[@data-schema-path][.//label[normalize-space()='%s']]", fieldName));


            List<String> itemSchemas = web.findElementsToStrings(locator, "data-schema-path");

            if (itemSchemas.size() == 0)
                throw new IllegalStateException(String.format("Cannot find field: '%s'", fieldName));

            String schema;
            schema = itemSchemas.get(0);

            if (itemSchemas.size() > 1) {
                String script = "var data = dijit.getEnclosingWidget(arguments[0])._prepareReorderData();\n" +
                        "var result = {};\n" +
                        "data.items.forEach(function(el) { result[el.schemaPath] = el.group; });\n" +
                        "return result;";

                Map<String, String> schemasByGroups = (Map<String, String>) web.getJavascriptExecutor().executeScript(script, previewBlock);

                for (String itemSchema : itemSchemas) {
                    if (schemasByGroups.get(itemSchema).equals(group)) {
                        schema = itemSchema;
                        break;
                    } else if (schemasByGroups.get(itemSchema).equals("_default")) {
                        schema = itemSchema;
                        break;
                    } else {
                        schema = itemSchema;
                    }
                }


            }

            schemas += iterator.hasNext() ? String.format("\"%s\",", schema) : String.format("\"%s\"", schema);
        }

        String script = String.format("var schemas = [%s];\n" +
                "var group = '%s';\n" +
                "var data = dijit.getEnclosingWidget(arguments[0])._prepareReorderData();\n" +
                "var reorderedItems = [];\n" +
                "var order = 1;\n" +
                "for (var i = 0; i < schemas.length; i++) {\n" +
                "    data.items.forEach(function(item) {\n" +
                "        if (schemas[i] == item.schemaPath) {\n" +
                "            reorderedItems.push({order: order, group: group, schemaPath: schemas[i]});\n" +
                "            order++;\n" +
                "    \t}\n" +
                "    });\n" +
                "}\n" +
                "dojo.publish('adbank/metadata/reorderPreviewForm', [{groups: data.groups, items: reorderedItems}]);", schemas, group);


        web.getJavascriptExecutor().executeScript(script, previewBlock);
        web.navigate().refresh();
    }
}